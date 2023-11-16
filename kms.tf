# # Create KMS Key for RDS Encryption
# resource "aws_kms_key" "rds_kms_key" {
#   description         = "KMS key for RDS encryption"
#   enable_key_rotation = true
#   policy              = <<-POLICY
# {
#   "Version": "2012-10-17",
#   "Id": "key-default-1",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "rds.amazonaws.com"
#       },
#       "Action": [
#         "kms:Encrypt",
#         "kms:Decrypt",
#         "kms:ReEncrypt*",
#         "kms:GenerateDataKey*",
#         "kms:DescribeKey"
#       ],
#       "Resource": "*"
#     }
#   ]
# }
# POLICY
# }