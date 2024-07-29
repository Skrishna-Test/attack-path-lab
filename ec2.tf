#IAM Role
resource "aws_iam_role" "ebilling-ec2-role" {
  name               = "ebilling-ec2-role-${random_string.bucket_suffix.result}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
  tags = {
    Name      = "ebilling-ec2-role-${random_string.bucket_suffix.result}"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    yor_name  = "ebilling-ec2-role"
    yor_trace = "240c756f-4a0d-4f00-a884-a06189cc4bc8"
  }
}

#Iam Role Policy
resource "aws_iam_policy" "ebilling-ec2-role-policy" {
  name        = "ebilling-ec2-role-policy-${random_string.bucket_suffix.result}"
  description = "ebilling-ec2-role-policy-${random_string.bucket_suffix.result}"
  policy      = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
              "s3:*",
              "cloudwatch:*",
              "ecr:GetAuthorizationToken",
              "ecr:BatchCheckLayerAvailability",
              "ecr:GetDownloadUrlForLayer",
              "ecr:BatchGetImage",
              "logs:CreateLogStream",
              "logs:PutLogEvents",
              "iam:PassRole",
              "iam:ListAttachedUserPolicies",
              "iam:GetRole",
              "iam:GetRolePolicy",
              "ec2:DescribeInstances",
              "ec2:CreateKeyPair",
              "ec2:RunInstances",
              "ec2:TerminateInstances",
              "iam:ListRoles",
              "iam:ListInstanceProfiles",
              "iam:ListAttachedRolePolicies",
              "iam:GetPolicyVersion",
              "iam:GetPolicy",
              "ec2:AssociateIamInstanceProfile"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "lambda:ListProvisionedConcurrencyConfigs",
                "lambda:ListFunctionEventInvokeConfigs",
                "lambda:ListFunctions",
                "lambda:ListFunctionsByCodeSigningConfig",
                "lambda:InvokeFunction",
                "lambda:ListVersionsByFunction",
                "lambda:ListAliases",
                "lambda:ListEventSourceMappings",
                "lambda:ListFunctionUrlConfigs",
                "lambda:ListLayerVersions",
                "lambda:ListLayers",
                "lambda:ListCodeSigningConfigs"
            ],
            "Resource": "*"
        }
    ]
}
POLICY
  tags = {
    yor_name  = "ebilling-ec2-role-policy"
    yor_trace = "b161fe05-6983-46b4-a80d-19801d1f0abe"
  }
}


resource "aws_iam_policy" "s3_ap_policy" {
  name = "s3_ap_policy_${random_string.bucket_suffix.result}"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "iam:PassRole",
          "sagemaker:CreateNotebookInstance",
          "sagemaker:CreateProcessingJob",
          "sagemaker:CreateTrainingJob",
          "ec2:*",
          "elasticloadbalancing:*",
          "cloudwatch:*",
          "autoscaling:*",
          "iam:CreateServiceLinkedRole",
          "s3:GetObject",
          "s3:GetObjectVersionTagging",
          "s3:GetStorageLensConfigurationTagging",
          "s3:GetObjectAcl",
          "s3:GetBucketObjectLockConfiguration",
          "s3:GetIntelligentTieringConfiguration",
          "s3:DeleteAccessPointPolicyForObjectLambda",
          "s3:DeleteJobTagging",
          "s3:GetObjectVersionAcl",
          "s3:PutBucketAcl",
          "s3:PutObjectTagging",
          "s3:DeleteObjectTagging",
          "s3:PutAccessPointPolicyForObjectLambda",
          "s3:GetBucketPolicyStatus",
          "s3:GetObjectRetention",
          "s3:GetBucketWebsite",
          "s3:PutMultiRegionAccessPointPolicy",
          "s3:GetJobTagging",
          "s3:DeleteStorageLensConfigurationTagging",
          "s3:GetMultiRegionAccessPoint",
          "s3:GetObjectAttributes",
          "s3:DeleteObjectVersionTagging",
          "s3:GetObjectLegalHold",
          "s3:GetBucketNotification",
          "s3:DeleteBucketPolicy",
          "s3:DescribeMultiRegionAccessPointOperation",
          "s3:GetReplicationConfiguration",
          "s3:ListMultipartUploadParts",
          "s3:GetObject",
          "s3:DescribeJob",
          "s3:PutObjectVersionAcl",
          "s3:GetAnalyticsConfiguration",
          "s3:GetObjectVersionForReplication",
          "s3:PutAccessPointPolicy",
          "s3:GetAccessPointForObjectLambda",
          "s3:GetStorageLensDashboard",
          "s3:GetLifecycleConfiguration",
          "s3:GetInventoryConfiguration",
          "s3:GetBucketTagging",
          "s3:GetAccessPointPolicyForObjectLambda",
          "s3:GetBucketLogging",
          "s3:ListBucketVersions",
          "s3:ReplicateTags",
          "s3:ListBucket",
          "s3:GetAccelerateConfiguration",
          "s3:GetObjectVersionAttributes",
          "s3:GetBucketPolicy",
          "s3:GetEncryptionConfiguration",
          "s3:GetObjectVersionTorrent",
          "s3:PutBucketTagging",
          "s3:GetBucketRequestPayment",
          "s3:GetAccessPointPolicyStatus",
          "s3:GetObjectTagging",
          "s3:GetMetricsConfiguration",
          "s3:GetBucketOwnershipControls",
          "s3:PutObjectAcl",
          "s3:GetBucketPublicAccessBlock",
          "s3:GetMultiRegionAccessPointPolicyStatus",
          "s3:ListBucketMultipartUploads",
          "s3:PutBucketPublicAccessBlock",
          "s3:GetMultiRegionAccessPointPolicy",
          "s3:GetAccessPointPolicyStatusForObjectLambda",
          "s3:PutStorageLensConfigurationTagging",
          "s3:PutObjectVersionTagging",
          "s3:PutJobTagging",
          "s3:GetBucketVersioning",
          "s3:GetBucketAcl",
          "s3:GetAccessPointConfigurationForObjectLambda",
          "s3:BypassGovernanceRetention",
          "s3:GetObjectTorrent",
          "s3:ObjectOwnerOverrideToBucketOwner",
          "s3:GetMultiRegionAccessPointRoutes",
          "s3:GetStorageLensConfiguration",
          "s3:GetBucketCORS",
          "s3:PutBucketPolicy",
          "s3:DeleteAccessPointPolicy",
          "s3:GetBucketLocation",
          "s3:GetAccessPointPolicy",
          "s3:GetObjectVersion",
          "ec2:RunInstances",
          "lambda:InvokeFunction"
        ],
        "Resource" : "${aws_s3_bucket.pc-national-bank-bucket.arn}"
      },
      {
        "Effect" : "Allow",
        "Action" : "s3:GetObject",
        "Resource" : "arn:aws:s3:::*/*"
      }
    ]
  })
  tags = {
    yor_name  = "s3_ap_policy"
    yor_trace = "e21cc8d6-c5d5-4ff7-9cf7-5f49aa83de08"
  }
}


#IAM Role Policy Attachment
resource "aws_iam_policy_attachment" "ebilling-ec2-role-policy-attachment" {
  name = "ebilling-ec2-role-policy-attachment-${random_string.bucket_suffix.result}"
  roles = [
    "${aws_iam_role.ebilling-ec2-role.name}"
  ]
  policy_arn = "${aws_iam_policy.ebilling-ec2-role-policy.arn}"
}

#IAM Role Policy Attachment
resource "aws_iam_policy_attachment" "s3_ap_policy-attachment" {
  name = "s3_ap_policy-attachment-${random_string.bucket_suffix.result}"
  roles = [
    "${aws_iam_role.ebilling-ec2-role.name}"
  ]
  policy_arn = "${aws_iam_policy.s3_ap_policy.arn}"
}

#IAM Instance Profile
resource "aws_iam_instance_profile" "ebilling-ec2-instance-profile" {
  name = "ebilling-ec2-instance-profile-${random_string.bucket_suffix.result}"
  role = "${aws_iam_role.ebilling-ec2-role.name}"
  tags = {
    yor_name  = "ebilling-ec2-instance-profile"
    yor_trace = "90f3e5e1-57ea-493b-89bf-2cacdb60d1df"
  }
}

#AWS Key Pair
resource "aws_key_pair" "ebilling-ec2-key-pair" {
  key_name   = "ebilling-ec2-key-pair-${random_string.bucket_suffix.result}"
  public_key = "${file(var.ssh-public-key-for-ec2)}"
  tags = {
    yor_name  = "ebilling-ec2-key-pair"
    yor_trace = "e1681862-2665-4bc4-988f-195c6a958357"
  }
}

#EC2 Instance
resource "aws_instance" "ebilling-ubuntu-ec2" {
  ami                         = "ami-053b0d53c279acc90"
  instance_type               = "t2.micro"
  iam_instance_profile        = "${aws_iam_instance_profile.ebilling-ec2-instance-profile.name}"
  subnet_id                   = "${aws_subnet.ebilling-public-subnet-1.id}"
  associate_public_ip_address = true
  private_ip                  = "10.10.10.103"
  vpc_security_group_ids = [
    "${aws_security_group.ebilling-ec2-ssh-security-group.id}",
    "${aws_security_group.ebilling-ec2-http-security-group.id}"
  ]
  key_name = "${aws_key_pair.ebilling-ec2-key-pair.key_name}"
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 60
    delete_on_termination = true
  }
  provisioner "file" {
    source      = "./app"
    destination = "/home/ubuntu/app"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file(var.ssh-private-key-for-ec2)}"
      host        = self.public_ip
    }
  }

  provisioner "file" {
    source      = "./scripts/script.sh"
    destination = "/home/ubuntu/script.sh"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file(var.ssh-private-key-for-ec2)}"
      host        = self.public_ip
    }
  }

  provisioner "file" {
    source      = "./scripts/initial_setup.sh"
    destination = "/home/ubuntu/initial_setup.sh"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file(var.ssh-private-key-for-ec2)}"
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/initial_setup.sh",
      "chmod +x /home/ubuntu/script.sh",
      "/home/ubuntu/initial_setup.sh",
      "/home/ubuntu/script.sh",
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file(var.ssh-private-key-for-ec2)}"
      host        = self.public_ip
    }
  }
  tags = {
    Name      = "ebilling-ubuntu-ec2-${random_string.bucket_suffix.result}"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    yor_name  = "ebilling-ubuntu-ec2"
    yor_trace = "1b07512b-3cfc-4ce7-9021-e2c8721f5808"
  }
}

output "ebilling-ec2-public-ip" {
  value = aws_instance.ebilling-ubuntu-ec2.public_ip
}

output "ebilling-ec2-private-ip" {
  value = aws_instance.ebilling-ubuntu-ec2.private_ip
}

output "ebilling-ec2-key-pair" {
  value = aws_key_pair.ebilling-ec2-key-pair.key_name
}
