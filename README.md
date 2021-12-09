# Lacework Auth: Just-In-Time Provisioning Guide
<!-- Keep track of the current Edition -->
**December 2021**

<!-- Add a Table of Contents, in VS Code add the plugin -->
## Contents

- [Lacework Auth: Just-In-Time Provisioning Guide](#lacework-auth-just-in-time-provisioning-guide)
  - [Contents](#contents)
  - [Change Log :notebook:](#change-log-notebook)
  - [Overview](#overview)
  - [General Best Practices](#general-best-practices)
  - [General Requirements](#general-requirements)
  - [Installation Steps](#installation-steps)
    - [**Okta Identity Provider**](#okta-identity-provider)
  - [Additional Resources](#additional-resources)
  - [Lacework RBAC](#lacework-rbac)
    - [Terms](#terms)
    - [Chart](#chart)
  - [Got Feedback?](#got-feedback)

<!-- Add a Changelog to help customers understand new changes etc -->
## Change Log :notebook: 

#### 2022 - What's coming? <!-- omit in toc -->

* Stay Tuned! 

#### December 2021 <!-- omit in toc -->

* Initial public release for this guide :)
* Thank you to all the amazing Lacers who providing valuable feedback!
  
## Overview

Lacework’s authentication via Security Assertion Markup Language (SAML) supports Just-in-Time (JIT) user provisioning. Enabling this option allows for on-the-fly creation of a Lacework user account upon the first successful login to Lacework. This eliminates the need to create users in advance. For example, a new employee added to your company’s identity provider wouldn’t need to manually create an account to access Lacework.

SAML JIT user provisioning is achieved via attribute definitions in the SAML identity provider. This guide currently includes guidelines for the Okta identity provider; G Suite (Google) and Azure AD identity provider guidelines will be added soon. 


## General Best Practices

* Follow the [Principle of Least Privilege](https://us-cert.cisa.gov/bsi/articles/knowledge/principles/least-privilege#:~:text=The%20Principle%20of%20Least%20Privilege%20states%20that%20a%20subject%20should,control%20the%20assignment%20of%20rights) (PoLP). Review the [Lacework role-based access control (RBAC)](Lacework RBAC).


## General Requirements

* One auth method is allowed. Any existing auth will have to be either disabled or converted to JIT.
* If the account being configured belongs to an organization, the authentication must be set at the organization level. 
* The Lacework platform does not currently offer an application programming interface (API) resource; therefore, there is no Terraform module or Lacework command-line interface (CLI) command to conduct auth configurations programmatically. 

## Installation Steps

TO VIEW THE INSTALLATION STEPS, NAVIGATE TO YOUR CORRESPONDING CONFIGURATION BELOW.

### **[Okta Identity Provider](examples/okta/README.md)**


---


## Additional Resources

* [Lacework Docs SAML configuration](https://docs.lacework.com/saml-configuration)
* [SAML JIT Overview](https://docs.lacework.com/saml-jit-overview) 
* [SAML Configuration](https://docs.lacework.com/saml-configuration) 

<!-- Hoping this will be a PR and available in our docs pronto! -->
## Lacework RBAC 

### Terms

* **Organization** is a top-level logical grouping. This is typically a company; however, within fairly large companies, this could also represent an entire business unit.
* **Account** is one level below an organization. An organization can contain multiple accounts. An account typically represents a business unit and/or team within a company, e.g., Sales, Engineering, Marketing.
* A **resource** within the Lacework platform is a feature, e.g., API keys.

### Chart

* `R = Read access`
* `W = Write access`
* `- = Not available`

<table>
  <tr>
   <td colspan="2" >
<p style="text-align: right">
<strong><code>Role:</code></strong></p>

   </td>
   <td><code>Account User</code>
   </td>
   <td><code>Account Admin</code>
   </td>
   <td><code>Org User</code>
   </td>
   <td><code>Org Admin</code>
   </td>
  </tr>
  <tr>
   <td><strong><code>Scope</code></strong>
   </td>
   <td><strong><code>Resource</code></strong>
   </td>
   <td colspan="4" ><strong><code>Actions</code></strong>
   </td>
  </tr>
  <tr>
   <td rowspan="10" ><code>Account Settings</code>
   </td>
   <td><p style="text-align: right">
<code><a href="https://docs.lacework.com/generate-api-access-keys-and-tokens#api-keys">API Keys</a></code></p>

   </td>
   <td><code>-</code>
   </td>
   <td><code>RW</code>
   </td>
   <td><code>-</code>
   </td>
   <td><code>RW</code>
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
<code><a href="https://docs.lacework.com/agent-administration">Agents</a></code></p>

   </td>
   <td><code>R</code>
   </td>
   <td><code>RW</code>
   </td>
   <td><code>R</code>
   </td>
   <td><code>RW</code>
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
<code><a href="https://docs.lacework.com/victorops#create-a-lacework-alert-channel">Alert Routing</a></code></p>

   </td>
   <td><code>R</code>
   </td>
   <td><code>RW</code>
   </td>
   <td><code>R</code>
   </td>
   <td><code>RW</code>
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
<code><a href="https://docs.lacework.com/audit-logs">Audit Logs</a></code></p>

   </td>
   <td><code>R</code>
   </td>
   <td><code>RW</code>
   </td>
   <td><code>R</code>
   </td>
   <td><code>RW</code>
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
<code><a href="https://docs.lacework.com/authentication-overview">Authentication</a></code></p>

   </td>
   <td><code>R</code>
   </td>
   <td><code>RW</code>
   </td>
   <td><code>R</code>
   </td>
   <td><code>RW</code>
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
<code><a href="https://docs.lacework.com/general-settings">General Settings</a></code></p>

   </td>
   <td><code>R</code>
   </td>
   <td><code>RW</code>
   </td>
   <td><code>R</code>
   </td>
   <td><code>RW</code>
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
<code><a href="https://docs.lacework.com/aws-config-and-cloudtrail-integration-with-terraform#">Integrations</a></code></p>

   </td>
   <td><code>R</code>
   </td>
   <td><code>RW</code>
   </td>
   <td><code>R</code>
   </td>
   <td><code>RW</code>
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
<code><a href="https://docs.lacework.com/resource-groups">Resource Groups</a></code></p>

   </td>
   <td><code>R</code>
   </td>
   <td><code>RW</code>
   </td>
   <td><code>R</code>
   </td>
   <td><code>RW</code>
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
<code><a href="https://docs.lacework.com/team-members">Team Members</a></code></p>

   </td>
   <td><code>R</code>
   </td>
   <td><code>RW</code>
   </td>
   <td><code>R</code>
   </td>
   <td><code>RW</code>
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
<code><a href="https://docs.lacework.com/usage">Usage</a></code></p>

   </td>
   <td><code>R</code>
   </td>
   <td><code>R</code>
   </td>
   <td><code>R</code>
   </td>
   <td><code>R</code>
   </td>
  </tr>
  <tr>
   <td rowspan="8" ><code>Organization Settings</code>
   </td>
   <td><p style="text-align: right">
<code><a href="https://docs.lacework.com/create-new-account-in-an-organization">Account Management</a></code></p>

   </td>
   <td><code>-</code>
   </td>
   <td><code>-</code>
   </td>
   <td><code>R</code>
   </td>
   <td><code>RW</code>
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
<code><a href="https://docs.lacework.com/victorops#create-a-lacework-alert-channel">Alert Routing</a></code></p>

   </td>
   <td><code>-</code>
   </td>
   <td><code>-</code>
   </td>
   <td><code>R</code>
   </td>
   <td><code>RW</code>
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
<code><a href="https://docs.lacework.com/audit-logs">Audit Logs</a></code></p>

   </td>
   <td><code>-</code>
   </td>
   <td><code>-</code>
   </td>
   <td><code>R</code>
   </td>
   <td><code>RW</code>
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
<code><a href="https://docs.lacework.com/authentication-overview">Authentication</a></code></p>

   </td>
   <td><code>-</code>
   </td>
   <td><code>-</code>
   </td>
   <td><code>R</code>
   </td>
   <td><code>RW</code>
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
<code><a href="https://docs.lacework.com/aws-config-and-cloudtrail-integration-with-terraform">Integrations</a></code></p>

   </td>
   <td><code>-</code>
   </td>
   <td><code>-</code>
   </td>
   <td><code>R</code>
   </td>
   <td><code>RW</code>
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
<code><a href="https://docs.lacework.com/configure-lacework">Configurations -> General Settings</a></code></p>

   </td>
   <td><code>-</code>
   </td>
   <td><code>-</code>
   </td>
   <td><code>R</code>
   </td>
   <td><code>RW</code>
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
<code><a href="https://docs.lacework.com/resource-groups">Resource Groups</a></code></p>

   </td>
   <td><code>-</code>
   </td>
   <td><code>-</code>
   </td>
   <td><code>R</code>
   </td>
   <td><code>RW</code>
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
<code><a href="https://docs.lacework.com/usage">Usage</a></code></p>

   </td>
   <td><code>-</code>
   </td>
   <td><code>-</code>
   </td>
   <td><code>R</code>
   </td>
   <td><code>R</code>
   </td>
  </tr>
</table>

<!-- Add section at the end for Feedback -->
## Got Feedback?

- Please submit a PR
