# Lacework Auth: Just-In-Time Provisioning Guide

<!-- Add a Table of Contents, in VS Code add the plugin -->
## Table of contents

  - [Change log](#change-log)
  - [Overview](#overview)
  - [Best practices](#best-practices)
  - [Prerequisites](#prerequisites)
  - [Installation steps](#installation-steps)
  - [Additional resources](#additional-resources)
  - [Lacework RBAC](#lacework-rbac)
    - [Terms](#terms)
    - [Chart](#chart)
  - [Provide feedback](#provide-feedback)

<!-- Add a Changelog to help customers understand new changes etc -->
## Change log

| **Date**  | **Author** | **Comment** | 
| ------------- | ------------- | ------------- |
| January 2022  | Allie Fick  | <ul><li>Revised to align with Lacework's best practice guide template.</li></ul>  |
| December 2021  |  Diana Esteves  | <ul><li>Initial public release for this guide :)</li><li>Thank you to all the amazing Lacers who provided valuable feedback!</li></ul> |
  
## Overview

Lacework’s authentication via Security Assertion Markup Language (SAML) supports Just-in-Time (JIT) user provisioning. Enabling this option allows for on-the-fly creation of a Lacework user account upon the first successful login to Lacework. This eliminates the need to create users in advance. For example, a new employee added to your company’s identity provider wouldn’t need to manually create an account to access Lacework.

SAML JIT user provisioning is achieved via attribute definitions in the SAML identity provider. This guide currently includes guidelines for the Okta identity provider; G Suite (Google) and Azure AD identity provider guidelines will be added soon. 


## Best practices

* Follow the [Principle of Least Privilege](https://us-cert.cisa.gov/bsi/articles/knowledge/principles/least-privilege#:~:text=The%20Principle%20of%20Least%20Privilege%20states%20that%20a%20subject%20should,control%20the%20assignment%20of%20rights) (PoLP). Review the [Lacework role-based access control (RBAC)](https://github.com/lacework-community/jit-provisioning-guide/blob/main/README.md#lacework-rbac).


## Prerequisites

* One auth method is allowed. Any existing auth will have to be either disabled or converted to JIT.
* If the account being configured belongs to an organization, the authentication must be set at the organization level. 
* The Lacework platform does not currently offer an application programming interface (API) resource; therefore, there is no Terraform module or Lacework command-line interface (CLI) command to conduct auth configurations programmatically. 

## Installation steps

To view the installation steps, navigate to the corresponding configuration below. 

* [Okta Identity Provider](examples/okta/README.md)


---

## Appendix
### Additional resources

* [SAML Configuration](https://docs.lacework.com/saml-configuration)
* [SAML JIT Overview](https://docs.lacework.com/saml-jit-overview) 

<!-- Hoping this will be a PR and available in our docs pronto! -->
### Lacework RBAC 

#### Terms

* **Organization** is a top-level logical grouping. This is typically a company; however, within fairly large companies, this could also represent an entire business unit.
* **Account** is one level below an organization. An organization can contain multiple accounts. An account typically represents a business unit and/or team within a company, e.g., Sales, Engineering, Marketing.
* A **resource** within the Lacework platform is a feature, e.g., API keys.

#### Chart

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
## Provide feedback

- Submit a pull request with your suggestions. 
