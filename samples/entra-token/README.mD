# Entra Token Sample

This sample demonstrates how to use the bicep-ext-http extension to request an OAuth2 access token from Microsoft Entra ID (Azure AD) using client credentials.

## Files

- `main.bicep`: Bicep template that performs an HTTP POST to the Microsoft identity platform token endpoint to retrieve an access token.
- `main.bicepparam`: Parameters file containing the required tenant ID, client ID, and client secret.

## How It Works

- The template constructs a token request to the Entra ID (Azure AD) endpoint using the provided credentials and scope.
- It sends a POST request with the required form data to obtain an access token.
- The access token and HTTP status code are returned as outputs.

## Usage

To deploy and test the sample, run:

```powershell
bicep local-deploy .\main.bicepparam
```

## Parameters

- `tenantId`: The Azure AD tenant ID.
- `clientId`: The application (client) ID registered in Azure AD.
- `clientSecret`: The client secret for the application.
- `scope`: The resource scope for the token (default: Microsoft Graph).
- `grantType`: The OAuth2 grant type (default: `client_credentials`).

## Outputs

- `accessToken`: The OAuth2 access token returned from Entra ID.
- `statusCode`: The HTTP status code from the token request.

## Customization

- Change the `scope` parameter to request tokens for other APIs.
- Use different credentials for other Entra applications.
