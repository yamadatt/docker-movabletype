resource "aws_ecr_repository" "main" {
  name = "docker-mt-lamp-web"
  #force_delete = true
}


resource "aws_ecr_lifecycle_policy" "main" {
  policy = jsonencode(
    {
      "rules" : [
        {
          "rulePriority" : 1,
          "description" : "Hold only 3 images, expire all others",
          "selection" : {
            "tagStatus" : "any",
            "countType" : "imageCountMoreThan",
            "countNumber" : 3,
          },
          "action" : {
            "type" : "expire"
          }
        }
      ]
    }
  )

  repository = aws_ecr_repository.main.name
}

output "repository_url" {
  value = aws_ecr_repository.main.repository_url
}