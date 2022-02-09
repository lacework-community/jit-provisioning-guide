terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "~> 3.20"
    }
  }
}

provider "okta" {
  api_token = var.okta_api_token
  base_url  = var.okta_base_url
  org_name  = var.okta_org_name
}

resource "okta_app_saml" "lacework-okta-demo" {
  lifecycle {
    ignore_changes = [users]
  }
  label                    = "lacework-okta-demo"
  status                   = "ACTIVE"
  sso_url                  = format("https://%s.lacework.net/sso/saml/login", var.lw_org_name)
  recipient                = format("https://%s.lacework.net/sso/saml/login", var.lw_org_name)
  destination              = format("https://%s.lacework.net/sso/saml/login", var.lw_org_name)
  audience                 = "https://lacework.net"
  subject_name_id_template = "$${user.userName}"
  subject_name_id_format   = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
  response_signed          = true
  signature_algorithm      = "RSA_SHA256"
  digest_algorithm         = "SHA256"
  honor_force_authn        = true
  authn_context_class_ref  = "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport"

  user_name_template      = "$${source.email}"
  user_name_template_type = "BUILT_IN"

  attribute_statements {

    type      = "EXPRESSION"
    name      = "First Name"
    namespace = "urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified"
    values    = ["user.firstName"]
  }
  attribute_statements {
    type      = "EXPRESSION"
    name      = "Last Name"
    namespace = "urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified"
    values    = ["user.lastName"]
  }
  attribute_statements {
    type      = "EXPRESSION"
    name      = "Company Name"
    namespace = "urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified"
    values    = ["appuser.company"]
  }
  attribute_statements {
    type      = "EXPRESSION"
    name      = "Lacework Admin Role Accounts"
    namespace = "urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified"
    values    = ["appuser.laceworkAdminRoleAccounts"]
  }
  attribute_statements {
    type      = "EXPRESSION"
    name      = "Lacework User Role Accounts"
    namespace = "urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified"
    values    = ["appuser.laceworkUserRoleAccounts"]
  }
  attribute_statements {
    type      = "EXPRESSION"
    name      = "Lacework Organization Admin Role"
    namespace = "urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified"
    values    = ["appuser.laceworkOrgAdminRole"]
  }
  attribute_statements {
    type      = "EXPRESSION"
    name      = "Lacework Organization User Role"
    namespace = "urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified"
    values    = ["appuser.laceworkOrgUserRole"]
  }
}

# App user schema custom attributes
# # Comment if using the Okta profile instead
resource "okta_app_user_schema_property" "company" {
  app_id = okta_app_saml.lacework-okta-demo.id
  index  = "company"
  title  = "Company"
  type   = "string"
  master = "PROFILE_MASTER"
  scope  = "NONE"
}
resource "okta_app_user_schema_property" "laceworkAdminRoleAccounts" {
  app_id = okta_app_saml.lacework-okta-demo.id
  index  = "laceworkAdminRoleAccounts"
  title  = "Lacework Admin Role Accounts"
  type   = "string"
  master = "PROFILE_MASTER"
  scope  = "NONE"
}
resource "okta_app_user_schema_property" "laceworkUserRoleAccounts" {
  app_id = okta_app_saml.lacework-okta-demo.id
  index  = "laceworkUserRoleAccounts"
  title  = "Lacework User Role Accounts"
  type   = "string"
  master = "PROFILE_MASTER"
  scope  = "NONE"
}
resource "okta_app_user_schema_property" "laceworkOrgAdminRole" {
  app_id = okta_app_saml.lacework-okta-demo.id
  index  = "laceworkOrgAdminRole"
  title  = "Lacework Organization Admin Role"
  type   = "boolean"
  master = "PROFILE_MASTER"
  scope  = "NONE"
}
resource "okta_app_user_schema_property" "laceworkOrgUserRole" {
  app_id = okta_app_saml.lacework-okta-demo.id
  index  = "laceworkOrgUserRole"
  title  = "Lacework Organization User Role"
  type   = "boolean"
  master = "PROFILE_MASTER"
  scope  = "NONE"
}

# # Okta user schema custom attributes
# # Uncomment if using the Okta profile
# resource "okta_user_schema_property" "company" {
#   index       = "company"
#   title       = "Company"
#   type        = "string"
#   master      = "PROFILE_MASTER"
#   scope       = "NONE"
# }
# resource "okta_user_schema_property" "laceworkAdminRoleAccounts" {
#   index       = "laceworkAdminRoleAccounts"
#   title       = "Lacework Admin Role Accounts"
#   type        = "string"
#   master      = "PROFILE_MASTER"
#   scope       = "NONE"
# }
# resource "okta_user_schema_property" "laceworkUserRoleAccounts" {
#   index       = "laceworkUserRoleAccounts"
#   title       = "Lacework User Role Accounts"
#   type        = "string"
#   master      = "PROFILE_MASTER"
#   scope       = "NONE"
# }
# resource "okta_user_schema_property" "laceworkOrgAdminRole" {
#   index       = "laceworkOrgAdminRole"
#   title       = "Lacework Organization Admin Role"
#   type        = "boolean"
#   master      = "PROFILE_MASTER"
#   scope       = "NONE"
# }
# resource "okta_user_schema_property" "laceworkOrgUserRole" {
#   index       = "laceworkOrgUserRole"
#   title       = "Lacework Organization User Role"
#   type        = "boolean"
#   master      = "PROFILE_MASTER"
#   scope       = "NONE"
# }

# [OPTIONAL] ##################################################################
# Add a Okta User for testing 
resource "okta_user" "demo_okta_user" {
  first_name = "Ash"
  last_name  = "Ketchum"
  login      = "diana@lacework.com"
  email      = "diana@lacework.com"
}

#  Grant the test user access to the Lacework Application
resource "okta_app_user" "demo_lw_user" {
  app_id   = okta_app_saml.lacework-okta-demo.id
  user_id  = okta_user.demo_okta_user.id
  username = "diana@lacework.com"
  # Set appropiate priviliges here! Follow PoLP
  profile = <<-EOL
{ 
    "company"                   : "Oak's Laboratory",
    "laceworkOrgAdminRole"      : false, 
    "laceworkOrgUserRole"       : false,
    "laceworkUserRoleAccounts"  : "lwintdiana",
    "laceworkAdminRoleAccounts" : "lwintdiana"
}   
EOL
}
###############################################################################


# Obtain the IdP metadata programmatically
output "xml" {
  value = okta_app_saml.lacework-okta-demo.metadata
}
