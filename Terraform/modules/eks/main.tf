resource "aws_iam_role" "cluster" {
    name = "${var.project}-${var.environment}-eks-cluster-role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Effect = "Allow"
            Principal = {
                Service = "eks.amazonaws.com"
            }
            Action = "sts:AssumeRole"
        }]
    })
}

resource "aws_iam_role_policy_attachment" "cluster" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role       = aws_iam_role.cluster.name
}

resource "aws_iam_role" "node" {
    name = "${var.project}-${var.environment}-eks-node-role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Effect = "Allow"
            Principal = {
                Service = "ec2.amazonaws.com"
            }
            Action = "sts:AssumeRole"
        }]
    })
}

resource "aws_iam_role_policy_attachment" "node_worker" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "node_cni" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "node_registry" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly"
    role       = aws_iam_role.node.name
}

resource "aws_eks_cluster" "main" {
    name     = "${var.project}-${var.environment}-cluster"
    role_arn = aws_iam_role.cluster.arn
    version  = "1.30"

    vpc_config {
        subnet_ids = var.private_subnets
        endpoint_private_access = true
        endpoint_public_access  = true
    }

    tags = {
        Name = "${var.project}-eks"
    }
}

resource "aws_eks_node_group" "main" {
    cluster_name    = aws_eks_cluster.main.name
    node_group_name = "${var.project}-node-group"
    node_role_arn   = aws_iam_role.node.arn
    subnet_ids      = var.private_subnets
    ami_type        = "AL2023_x86_64_STANDARD"
    capacity_type   = "ON_DEMAND"
    disk_size       = 20

    scaling_config {
        desired_size = 2
        max_size     = 4
        min_size     = 1
    }

    update_config {
        max_unavailable = 1
    }

    instance_types = ["t3.medium"]

    tags = {
        Name = "${var.project}-nodes"
    }
}