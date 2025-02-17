# 8 == 8
# 7 != 8
# 5 > 7
# 5 < 7
# 5 <= 7
# 8 > 7 && 8 < 9
# ture || false
# ! var.mybool


# condition ? true_val : false_val

resource "random_password" "password-generator" {
  length = var.length < 8 ? 8 : var.length
}

output "password" {
  value = random_password.password-generator.result
}
