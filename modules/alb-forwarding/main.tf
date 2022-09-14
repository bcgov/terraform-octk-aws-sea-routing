data "aws_vpc" "perimeter" {
  filter {
    name   = "tag:Name"
    values = ["Perimeter_vpc"]
  }
}
data "aws_lb" "perimeter" {
  name = var.public_lb_name
}

data "aws_lb_listener" "perimeter" {
  load_balancer_arn = data.aws_lb.perimeter.arn
  port              = 443
}

resource "random_integer" "priority" {
  min = var.route_type == "default" ? 25001 : 1
  max = var.route_type == "default" ? 50000 : 25000
}

data "aws_dynamodb_table" "tableName" {
  name = "PBMMAccel-Alb-Ip-Forwarding-${data.aws_vpc.perimeter.id}"
}

resource "aws_dynamodb_table_item" "alb_ip_forwarding" {
  table_name = data.aws_dynamodb_table.tableName.name
  hash_key   = data.aws_dynamodb_table.tableName.hash_key
  range_key  = data.aws_dynamodb_table.tableName.range_key

  item = <<ITEM
{
  "id": {
    "S": "${replace(replace(var.subdomain, "*", "wildcard"), ".", "-")}-${var.identifier}-${var.environment}"
  },
  "targetAlbDnsName": {
    "S": "${var.target_dns_name}"
  },
  "targetGroupDestinationPort": {
    "N": "${var.target_port}"
  },
  "targetGroupProtocol": {
    "S": "HTTPS"
  },
  "vpcId": {
    "S": "${data.aws_vpc.perimeter.id}"
  },
  "rule": {
    "M": {
      "sourceListenerArn": {
        "S": "${data.aws_lb_listener.perimeter.arn}"
      },
      "condition": {
        "M": {
          "hosts": {
            "L": [
              {
                "S": "${var.subdomain}.${var.identifier}-${var.environment}.${var.parent_domain}"
              }
            ]
          },
          "priority": {
            "N": "${random_integer.priority.result}"
          }
        }
      }
    }
  }
}
ITEM

  lifecycle {
    replace_triggered_by = [
      null_resource.alb_listenter,
    ]
  }
}

# This is used to trigger the dynamodb table item replacement so that the rule is updated by the lambda
resource "null_resource" "alb_listenter" {
  triggers = {
    listener_arn = data.aws_lb_listener.perimeter.arn
  }
}
