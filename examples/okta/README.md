# **Okta Identity Pprovider** <!-- omit in toc -->

The provider is responsible for most of the effort in this guide. This section describes the Okta requirements to achieve JIT auth with Lacework.

## Contents

- [Recommendations](#recommendations)
- [Steps](#steps)
- [Additional Resources](#additional-resources)

# Recommendations

* Use the [Okta Terraform provider](https://registry.terraform.io/providers/okta/okta/latest/docs).
* Use the identity provider metadata XML file to minimize human error. See [example-metadata.xml](example-metadata.xml).

# Steps

## Step 0: Review [General Best Practices](../../README.md#general-best-practices) & [General Requirements](../../README.md#general-requirements) <!-- omit in toc -->

## Step 1: Configure Okta (via Terraform) <!-- omit in toc -->

1. Gather the Lacework organization name. This is typically the company name, e.g., MongoDB.
2. Add a Security Assertion Markup Language (SAML) application by creating a `okta_app_saml` resource. The name and label of the resource are flexible. In the example below, we use `dianademo-tfapp` and the Lacework organization name is `lwintdiana`.

  ```json
  provider "okta" { 
    api_token = "000000000000nabkfg37j2oj2c9eklR1xx-w7naX3A"
    base_url = "okta.com"
    org_name = "laceworkdemo"
    log_level = 2
  }

  resource "okta_app_saml" "dianademo-tfapp" {
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
  ```

3. In the terminal, run `terraform apply`. Example output:

  ```bash
  okta_app_saml.dianademo-tfapp: Creating...
  okta_app_saml.dianademo-tfapp: Creation complete after 2s [id=0oa4cr8udw13tOrQE696]
  ```

4. Save the application ID (`0oa4cr8udw13tOrQE696`).
5. Obtain the metadata by calling the `okta_app_metadata_saml` data source and outputting it:

  ```json
  data "okta_app_metadata_saml" "dianademo" {
    app_id = "0oa4cr8udw13tOrQE696"
  }

  output "dianademo" {
    value = data.okta_app_metadata_saml.dianademo.metadata
  }
  ```

6. Download the metadata locally. Once the Lacework Terraform provider supports auth, we will pass the data directly. However, we currently need to locally store this file. This example uses [jq](https://stedolan.github.io/jq/) to obtain the XML file:

  ```bash
  terraform refresh
  terraform output -json | jq  .dianademo.value -r > example-metadata.xml
  ```
7. Add custom Lacework attributes to a profile. If you have a specific profile attached to each application, add the attributes to the application user profile as shown  below. 

  ```json
  App user schema custom attributes
  resource "okta_app_user_schema_property" "company" {
    app_id      = "0oa4cr8udw13tOrQE696"
    index       = "company"
    title       = "Company"
    type        = "string"
    master      = "PROFILE_MASTER"
    scope       = "NONE"
  }
  resource "okta_app_user_schema_property" "laceworkAdminRoleAccounts" {
    app_id      = "0oa4cr8udw13tOrQE696"
    index       = "laceworkAdminRoleAccounts"
    title       = "Lacework Admin Role Accounts"
    type        = "string"
    master      = "PROFILE_MASTER"
    scope       = "NONE"
  }
  resource "okta_app_user_schema_property" "laceworkUserRoleAccounts" {
    app_id      = "0oa4cr8udw13tOrQE696"
    index       = "laceworkUserRoleAccounts"
    title       = "Lacework User Role Accounts"
    type        = "string"
    master      = "PROFILE_MASTER"
    scope       = "NONE"
  }
  resource "okta_app_user_schema_property" "laceworkOrgAdminRole" {
    app_id      = "0oa4cr8udw13tOrQE696"
    index       = "laceworkOrgAdminRole"
    title       = "Lacework Organization Admin Role"
    type        = "boolean"
    master      = "PROFILE_MASTER"
    scope       = "NONE"
  }
  resource "okta_app_user_schema_property" "laceworkOrgUserRole" {
    app_id      = "0oa4cr8udw13tOrQE696"
    index       = "laceworkOrgUserRole"
    title       = "Lacework Organization User Role"
    type        = "boolean"
    master      = "PROFILE_MASTER"
    scope       = "NONE"
  }
  ```
If you do not have a specific profile attached, add the Lacework attributes to the Okta profile as shown below. 

  ```json
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
  ```

8. [Optional] Prepare to test the configuration. We’ll add a dummy person to Okta and grant them access to the Lacework application. Make sure to use a valid email because we’ll need to activate this user. The test occurs at the end of step 2 as it requires the Lacework platform to be configured.
* Add a user using the `okta_user` resource. 
    
  ```  json
  resource "okta_user" "dummy_user" {
    first_name         = "Ash"
    last_name          = "Ketchum"
    login              = "diana@lacework.net"
    email              = "diana@lacework.net"
    custom_profile_attributes = "{ \"company\" : \"Cerise Laboratory\", \"laceworkOrgAdminRole\" : true }"
  }
  ```

* Apply the changes to obtain the id. This is used in the next step as the user_id.
* Grant the user access to the Lacework app.

  ```json
  # Save profile to send to the LW App
  data "okta_user" "dummy_user" {
    user_id = "00u4dn1ovygOcDmn1696"
  }

  resource "okta_app_user" "dummy_lw_user" {
    app_id   = "0oa4cr8udw13tOrQE696"
    user_id  = "00u4dn1ovygOcDmn1696"
    username = "diana@lacework.net"
    # TODO - Add from the dummy_user data
    profile =  "{\"company\":\"Cerise Laboratory\",\"laceworkOrgAdminRole\":true,\"firstName\":\"Ash\",\"lastName\":\"Ketchum\"}"
  }
  ```
* Activate the Okta Account. To do this, open the dummy user’s inbox and select the **Welcome to Okta!** email. Click the **activation** button. This will redirect you to create a password.

9. Apply all the changes:
    * In the terminal, run `terraform apply`.
    * Confirm with `yes`. 

### Step 3: Configure Lacework (via the user interface) <!-- omit in toc -->
As per the current limitations, only one auth mode can be enabled. Ensure you’ve disabled all auth configurations before continuing.  

1. Open https://YOUR-ORG.lacework.net/ui/investigation/settings 
2. Navigate to the “Authentication” page.
3. If you have an existing Okta SAML auth configured and want to change it to allow for JIT, follow these instructions:

* To update: 
  * Check existing SAML.
  * Click **Edit.**
  * Select **Upload identity provider data.**
  * Name it **Okta**.
  * Browse and upload metadata file.
  * Enable **Just-In-Time User Provisioning**.
  * Click **Save.**
    
* To create:
  * Click **Create New.**
  * **Select** SAML.
  * Select **Upload identity provider data.**
  * Name it **Okta_._**
  * Browse and upload metadata file.
  * Enable **Just-In-Time User Provisioning**.
  * Click **Save.**
    
4. [Optional] Test Okta SAML JIT
* If you created a dummy user, you can now attempt to login to the Lacework platform with their credentials. It may take a few seconds for the profile to create, but once that completes, our dummy user has access to the platform. 

![Example screenshot](screenshots/JIT-screenshot-1.png)
![Example profile](screenshots/JIT-screenshot-2.png)

# Additional Resources

* [Lacework Docs on Okta SAML IDP](https://docs.lacework.com/okta-as-a-saml-idp)
* [Lacework Docs SAML configuration](https://docs.lacework.com/saml-configuration)
* [SAML JIT Overview](https://docs.lacework.com/saml-jit-overview) 
* [SAML Configuration](https://docs.lacework.com/saml-configuration) 
