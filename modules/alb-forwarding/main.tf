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
  min = 1
  max = 50000
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
    "S": "${replace(var.subdomain, "*", "wildcard")}-${var.identifier}-${var.environment}"
  },
  "targetAlbDnsName": {
    "S": "${var.target_dns_name}"
  },
  "targetGroupDestinationPort": {
    "N": "443"
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
                "S": "${var.subdomain}.${var.identifier}-${var.environment}.lz1.nimbus.cloud.gov.bc.ca"
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
}
