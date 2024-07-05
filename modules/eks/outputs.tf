

output "eks-cluster-arn" {
  value = element(concat(aws_eks_cluster.eks-cluster.*.arn, [""]), 0)
}

output "eks-cluster-name" {
  value = aws_eks_cluster.eks-cluster.name
}






