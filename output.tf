output "account_id" {
  description = "The ID of the Macie account."
  value       = join("", aws_macie2_account.default[*].id)
}