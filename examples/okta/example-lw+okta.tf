terraform {
  required_providers {
    okta = {
      source = "okta/okta"
      version = "~> 3.14"
    }
    # TODO - Add this when Auth is supported
    # lacework = {
    #   source = "lacework/lacework"
    # }
  }
}

# Configure the Okta Provider
# export OKTA_ORG_NAME="lacework-org-abc123"
# export OKTA_BASE_URL="https://laceworkdemo.okta.com"
# export OKTA_API_TOKEN="abc123abc123abc123-abc123"
# export LW_ORGANIZATION_PROFILE = lwintdiana
provider "okta" { 
  api_token = "abc123abc123abc123-abc123"
  base_url = "okta.com"
  org_name = "laceworkdemo"
  log_level = 2
}

resource "okta_app_saml" "dianademo-tfapp" {
  lifecycle {
  ignore_changes = [users]
}
  label                    = "dianademo-tfapp"
  status                   = "ACTIVE"
  sso_url                  = "https://lwintdiana.lacework.net/sso/saml/login"
  recipient                = "https://lwintdiana.lacework.net/sso/saml/login"
  destination              = "https://lwintdiana.lacework.net/sso/saml/login"
  audience                 = "https://lacework.net"
  subject_name_id_template = "$${user.userName}"
  subject_name_id_format   = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
  response_signed          = true
  signature_algorithm      = "RSA_SHA256"
  digest_algorithm         = "SHA256"
  honor_force_authn        = false
  authn_context_class_ref  = "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport"

  user_name_template = "$${source.email}"
  user_name_template_type = "BUILT_IN"

  attribute_statements {
    
    type         = "EXPRESSION"
    name         = "First Name"
    namespace = "urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified"
    values = [ "user.firstName" ]
  }
  attribute_statements {
    type         = "EXPRESSION"
    name         = "Last Name"
    namespace = "urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified"
    values = [ "user.lastName" ]
  }
  attribute_statements {
    type         = "EXPRESSION"
    name         = "Company Name"
    namespace = "urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified"
    values = [ "user.company" ]
  }
  attribute_statements {
    type         = "EXPRESSION"
    name         = "Lacework Admin Role Accounts"
    namespace = "urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified"
    values = [ "user.laceworkAdminRoleAccounts" ]
  }
  attribute_statements {
    type         = "EXPRESSION"
    name         = "Lacework User Role Accounts"
    namespace = "urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified"
    values = [ "user.laceworkUserRoleAccounts" ]
  }
  attribute_statements {
    type         = "EXPRESSION"
    name         = "Lacework Organization Admin Role"
    namespace = "urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified"
    values = [ "user.laceworkOrgAdminRole" ]
  }
  attribute_statements {
    type         = "EXPRESSION"
    name         = "Lacework Organization User Role"
    namespace = "urn:oasis:names:tc:SAML:2.0:attrname-format:unspecified"
    values = [ "user.laceworkOrgUserRole" ]
  }
}

data "okta_app_metadata_saml" "dianademo" {
  app_id = "abc123abc123abc123"
}

output "dianademo" {
  value = data.okta_app_metadata_saml.dianademo.metadata
}


# App user schema custom attributes
resource "okta_app_user_schema_property" "company" {
  app_id      = "abc123abc123abc123"
  index       = "company"
  title       = "Company"
  type        = "string"
  master      = "PROFILE_MASTER"
  scope       = "NONE"
}
resource "okta_app_user_schema_property" "laceworkAdminRoleAccounts" {
  app_id      = "abc123abc123abc123"
  index       = "laceworkAdminRoleAccounts"
  title       = "Lacework Admin Role Accounts"
  type        = "string"
  master      = "PROFILE_MASTER"
  scope       = "NONE"
}
resource "okta_app_user_schema_property" "laceworkUserRoleAccounts" {
  app_id      = "abc123abc123abc123"
  index       = "laceworkUserRoleAccounts"
  title       = "Lacework User Role Accounts"
  type        = "string"
  master      = "PROFILE_MASTER"
  scope       = "NONE"
}
resource "okta_app_user_schema_property" "laceworkOrgAdminRole" {
  app_id      = "abc123abc123abc123"
  index       = "laceworkOrgAdminRole"
  title       = "Lacework Organization Admin Role"
  type        = "boolean"
  master      = "PROFILE_MASTER"
  scope       = "NONE"
}
resource "okta_app_user_schema_property" "laceworkOrgUserRole" {
  app_id      = "abc123abc123abc123"
  index       = "laceworkOrgUserRole"
  title       = "Lacework Organization User Role"
  type        = "boolean"
  master      = "PROFILE_MASTER"
  scope       = "NONE"
}


# Okta user schema custom attributes
resource "okta_user_schema_property" "company" {
  index       = "company"
  title       = "Company"
  type        = "string"
  master      = "PROFILE_MASTER"
  scope       = "NONE"
}
resource "okta_user_schema_property" "laceworkAdminRoleAccounts" {
  index       = "laceworkAdminRoleAccounts"
  title       = "Lacework Admin Role Accounts"
  type        = "string"
  master      = "PROFILE_MASTER"
  scope       = "NONE"
}
resource "okta_user_schema_property" "laceworkUserRoleAccounts" {
  index       = "laceworkUserRoleAccounts"
  title       = "Lacework User Role Accounts"
  type        = "string"
  master      = "PROFILE_MASTER"
  scope       = "NONE"
}
resource "okta_user_schema_property" "laceworkOrgAdminRole" {
  index       = "laceworkOrgAdminRole"
  title       = "Lacework Organization Admin Role"
  type        = "boolean"
  master      = "PROFILE_MASTER"
  scope       = "NONE"
}
resource "okta_user_schema_property" "laceworkOrgUserRole" {
  index       = "laceworkOrgUserRole"
  title       = "Lacework Organization User Role"
  type        = "boolean"
  master      = "PROFILE_MASTER"
  scope       = "NONE"
}



# Add dummy Okta User for testing later - id=abc123abc123abc123abc123
resource "okta_user" "dummy_user" {
  first_name         = "Ash"
  last_name          = "Ketchum"
  login              = "diana@lacework.net"
  email              = "diana@lacework.net"
  custom_profile_attributes = "{ \"company\" : \"Cerise Laboratory\", \"laceworkOrgAdminRole\" : true }"
}

# Save profile to send to the LW App
data "okta_user" "dummy_user" {
  user_id = "abc123abc123abc123abc123"
}


# Grant dummy user access to the LW App 
resource "okta_app_user" "dummy_lw_user" {
  app_id   = "abc123abc123abc123"
  user_id  = "abc123abc123abc123abc123"
  username = "diana@lacework.net"
  # TODO - Add from the dummy_user data
  profile =  "{\"company\":\"Cerise Laboratory\",\"laceworkOrgAdminRole\":true,\"firstName\":\"Ash\",\"lastName\":\"Ketchum\"}"
}

# Grant dummy user access to the LW App - id=abc123abc123abc123abc123
resource "okta_app_user" "dummy_lw_user_og" {
  app_id   = "abc123abc123abc123"
  user_id  = "abc123abc123abc123abc123"
  username = "diana@lacework.net"
   # TODO - Add from the dummy_user data
  profile =  "{\"company\":\"Cerise Laboratory\",\"laceworkOrgAdminRole\":true,\"firstName\":\"Ash\",\"lastName\":\"Ketchum\"}"

}

# abc123abc123abc123abc123abc123abc123abc123abc123
# TODO - Add this when Auth is supported
# Configure the Lacework Provider
# $ export LW_PROFILE = lwintdiana 
# default profile location is $HOME/.lacework.toml (Mac/Linux)
# provider "lacework" {
#   profile = "lwintdiana"
# }