# Bicep HTTP Extension

A custom Bicep extension that enables HTTP calls directly within Bicep templates. This extension allows you to make HTTP requests during template deployment and use the responses in your Bicep code.

This extension was build based on idea's and examples from @anthony-c-martin that create a 'GO' http extension. As that extension did not had any options to perform 'POST' requests I created my own C# implementation that supports multiple requests types.

## Overview

The `bicep-ext-http` extension provides a new resource type `HttpCall` that can perform HTTP requests (GET, POST, PUT, DELETE, PATCH) and capture the response for use in your Bicep templates. This is useful for scenarios like:

- Calling external APIs during deployment. (Adding items to your CMDB)
- Fetching configuration data from external services
- Triggering webhooks as part of your infrastructure deployment
- Integrating with third-party services that don't have native Azure Resource Manager support

## Features

- **Multiple HTTP Methods**: Supports GET, POST, PUT, DELETE, and PATCH requests
- **Custom Headers**: Add custom headers to your HTTP requests
- **Request Body**: Include JSON or other content in request bodies
- **Response Capture**: Access both the response body and HTTP status code
- **Type Safety**: Full IntelliSense support and type checking in Bicep

## Samples

The sample folder contains two samples:

- **Simple HTTP Calls**: Simple example to perform different types of HTTP calls. To a Beeceptor endpoint.
- **Entra token**: Example to be able to retrieve Entra accesstokens. That can be used when you need to make a authenticated api call.

## Installation

### Prerequisites

- Bicep CLI with extensibility support (make sure that you have the preview feature enabled)
- .NET 9.0 runtime (for local development)

### Setup

1. Clone this repository:

   ```bash
   git clone https://github.com/maikvandergaag/bicep-ext-http.git
   cd bicep-ext-http
   ```

2. Build the extension:

   ```powershell
   dotnet build src/bicep-ext-http.csproj
   ```

3. Publish the extension:

   ```powershell
   .\scripts\publish.ps1
   ```

4. Configure your `bicepconfig.json` to use the extension:

   ```json
   {
     "experimentalFeaturesEnabled": {
       "localDeploy": true,
       "extensibility": true
     },
     "extensions": {
       "http": "./extension-publish/bicep-ext-http"
     }
   }
   ```

## Resource Properties

### HttpCall Resource

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `url` | string | Yes | The target URL for the HTTP request |
| `method` | string | Yes | HTTP method: 'Get', 'Post', 'Put', 'Delete', or 'Patch' |
| `headers` | array | No | Array of header objects with `name` and `value` properties |
| `body` | string | No | Request body content (typically JSON) |

### Output Properties

| Property | Type | Description |
|----------|------|-------------|
| `result` | string | The response body from the HTTP call |
| `statusCode` | int | The HTTP status code returned |

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the terms specified in the LICENSE file.

## Disclaimer

This extension is provided as-is and should be thoroughly tested before use in production environments. Always validate HTTP responses and handle errors appropriately in your Bicep templates.