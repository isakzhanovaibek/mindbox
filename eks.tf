resource "aws_iam_role" "eks_cluster" {
  name = "eks-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}
resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

  role = aws_iam_role.eks_cluster.name
}

resource "aws_eks_cluster" "eks" {
  name = "eks"

  role_arn = aws_iam_role.eks_cluster.arn

  version = "1.23"

  vpc_config {
    endpoint_private_access = false

    endpoint_public_access = true

    subnet_ids = [
      aws_subnet.private-eu-central-1a.id,
      aws_subnet.private-eu-central-1b.id,
      aws_subnet.private-eu-central-1c.id,
      aws_subnet.public-eu-central-1a.id,
      aws_subnet.public-eu-central-1b.id,
      aws_subnet.public-eu-central-1c.id
    ]
  }


  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_cluster_policy
  ]
}

############################################################################

resource "aws_iam_role" "nodes_general" {

  name = "eks-node-group-general"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }, 
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy_general" {

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

  role = aws_iam_role.nodes_general.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy_general" {

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

  role = aws_iam_role.nodes_general.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

  role = aws_iam_role.nodes_general.name
}

resource "aws_eks_node_group" "nodes_general" {
  cluster_name = aws_eks_cluster.eks.name

  node_group_name = "nodes-general"

  node_role_arn = aws_iam_role.nodes_general.arn

  subnet_ids = [
    aws_subnet.private-eu-central-1a.id,
    aws_subnet.private-eu-central-1b.id,
    aws_subnet.private-eu-central-1c.id,
    aws_subnet.public-eu-central-1a.id,
    aws_subnet.public-eu-central-1b.id,
    aws_subnet.public-eu-central-1c.id
  ]

  scaling_config {
    # create 5 nodes in 3 availability zones 
    desired_size = 5

    max_size = 5

    min_size = 5
  }

  ami_type = "AL2_x86_64"

  capacity_type = "SPOT"

  disk_size = 20

  force_update_version = false

  instance_types = ["t2.micro"]

  labels = {
    role = "nodes-general"
  }

  version = "1.23"

  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy_general,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy_general,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
  ]
}
