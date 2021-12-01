# Appendix
## Additional resources



* [Lacework Docs on Okta SAML IDP](https://docs.lacework.com/okta-as-a-saml-idp )
* [Lacework Docs SAML configuration](https://docs.lacework.com/saml-configuration )
* [https://lacework.zendesk.com/agent/search/1?type=ticket&q=JIT](https://lacework.zendesk.com/agent/search/1?type=ticket&q=JIT) 
* [https://docs.lacework.com/saml-jit-overview](https://docs.lacework.com/saml-jit-overview) 
* [https://support.lacework.com/hc/en-us/articles/360041774074-SAML-JIT-Overview](https://support.lacework.com/hc/en-us/articles/360041774074-SAML-JIT-Overview)
* [https://docs.lacework.com/saml-configuration](https://docs.lacework.com/saml-configuration) 


## Example of Okta provider Terraform file


```
// TODO
```



## Okta `example-okta-idp-metadata.xml`


```
<?xml version="1.0" encoding="UTF-8"?><md:EntityDescriptor entityID="http://www.okta.com/exk4c49uaIMvKMSKH696" xmlns:md="urn:oasis:names:tc:SAML:2.0:metadata"><md:IDPSSODescriptor WantAuthnRequestsSigned="false" protocolSupportEnumeration="urn:oasis:names:tc:SAML:2.0:protocol"><md:KeyDescriptor use="signing"><ds:KeyInfo xmlns:ds="http://www.w3.org/2000/09/xmldsig#"><ds:X509Data><ds:X509Certificate>MIIDqDCCApCgAwIBAgIGAXyK4LUGMA0GCSqGSIb3DQEBCwUAMIGUMQswCQYDVQQGEwJVUzETMBEG
A1UECAwKQ2FsaWZvcm5pYTEWMBQGA1UEBwwNU2FuIEZyYW5jaXNjbzENMAsGA1UECgwET2t0YTEU
MBIGA1UECwwLU1NPUHJvdmlkZXIxFTATBgNVBAMMDGxhY2V3b3JrZGVtbzEcMBoGCSqGSIb3DQEJ
ARYNaW5mb0Bva3RhLmNvbTAeFw0yMTEwMTYyMDUxMzRaFw0zMTEwMTYyMDUyMzRaMIGUMQswCQYD
VQQGEwJVUzETMBEGA1UECAwKQ2FsaWZvcm5pYTEWMBQGA1UEBwwNU2FuIEZyYW5jaXNjbzENMAsG
A1UECgwET2t0YTEUMBIGA1UECwwLU1NPUHJvdmlkZXIxFTATBgNVBAMMDGxhY2V3b3JrZGVtbzEc
MBoGCSqGSIb3DQEJARYNaW5mb0Bva3RhLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAIZjTYG56EXQ/QrLyQM9npMI+0nwxY6PzO0F3MPO5AMbAa6L4oPOV5hP2Zn1iAqtfw7Lnk39
u77/0EpZYJRtpXxNxKWHEgq/bpyeULXQQ9sAsqkyzTclfuq3aIVmjq902VHSldrnD563KofCLu96
rVuo4rbZEL0i/vMSS1VWpSQn6Gizz0Z3/VFnw2bc2Q72bvjO3PnfV32GZ0kX69BdHcekKv31hj98
MBcDtkUCdcHA3FDUldkU33vxDTYd8vIHwnrhL7wqZOZr5S7+9Zn138wL4Mdvz2SXWU+m8FyKFIY8
0A3yDQho/tF1PNBbNFtHaDpiYCM77Qr7lARdRGlZOsMCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEA
KJO2quJTV5pV1E2sZFvuJJuQhYbHRT1iZ+jGpcbP1uNTgwNc0poK5L3MRwHSXR27QrgdixfB9gya
JUqjr/xzbcHv8T2cR9jpZUwETd7PfACCYEzsWzwOD7re54Fk/OUNUVHvclGB5LhCKezeQwa+TGrM
lHwRKeRwPC1B/CMnGTyG0oNP4zwOJm6hhzHZlRa0Iukhi6+zGuNsOlp/7HJ8ukEMAGUg9auM7BB5
Sb9lcbTeBNjRkabY7uMplJ5l9OGEoWGIzUVk/yjY5MjuLeyAFvQ+PUSTM/ImTZcL7OCR38zcdeyW
WGpb78GFZ2RzWv4hr22vQDgnqsDiyGMw/dSp2w==</ds:X509Certificate></ds:X509Data></ds:KeyInfo></md:KeyDescriptor><md:NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress</md:NameIDFormat><md:SingleSignOnService Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST" Location="https://laceworkdemo.okta.com/app/laceworkdemo_dianademoapp_1/exk4c49uaIMvKMSKH696/sso/saml"/><md:SingleSignOnService Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect" Location="https://laceworkdemo.okta.com/app/laceworkdemo_dianademoapp_1/exk4c49uaIMvKMSKH696/sso/saml"/></md:IDPSSODescriptor></md:EntityDescriptor>
```



## Lacework screenshots

![Lacework screenshot 1](https://github.com/lacework-community/jit-provisioning-guide/blob/main/Lacework-screenshot-1.png)

![Lacework screenshot 2](https://github.com/lacework-community/jit-provisioning-guide/blob/main/Lacework-screenshot-2.png)



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
