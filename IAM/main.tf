# get value from YAML
locals {
  user_data = yamldecode(file("./users.yaml")).users
}

##faltten the list
locals {
  flatten_data = flatten([for users in local.user_data : [for role in users.roles: {
    username = users.username
    role = role
  }]])
}

# output "flatten_data" {
#   value = local.flatten_data
# }

# #IAM User create

resource "aws_iam_user" "iam_users" {
  for_each = toset(local.flatten_data[*].username)
  name = each.value
}

# #password

resource "aws_iam_user_login_profile" "main" {
  for_each = aws_iam_user.iam_users
  user    = each.value.name
  password_length = 8

  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key,
    ]
  }
}

# #attaching policies
resource "aws_iam_user_policy_attachment" "main" {
  for_each = {
    for pair in local.flatten_data :
    "${pair.username}-${pair.role}" => pair
  }

  user = aws_iam_user.iam_users[each.value.username].name
  policy_arn = "arn:aws:iam::aws:policy/${each.value.role}"
}

# resource "aws_iam_user_policy_attachment" "main" {
#   for_each = {
#     for pair in local.flatten_data :
#     "${pair.username}-${pair.role}" => pair
#   }

#   user       = aws_iam_user.users[each.value.username].name
#   policy_arn = "arn:aws:iam::aws:policy/${each.value.role}"
# }