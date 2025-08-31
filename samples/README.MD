# Samples

This folder contains example Bicep templates demonstrating how to use the bicep-ext-http extension for HTTP calls in Bicep deployments.

## Structure

- **entra-token/**
  - `main.bicep`: Example template for making HTTP calls to retrieve an Entra ID token or interact with an authentication endpoint.
  - `main.bicepparam`: Parameters file for the Entra token sample.

- **simple-http-calls/**
  - `main.bicep`: Example template for making basic HTTP requests (GET, POST, etc.) using the extension.
  - `main.bicepparam`: Parameters file for the simple HTTP calls sample.
  - `sample/body.json`: Example JSON payload used in POST requests.

## Usage

These samples show how to:
- Make HTTP requests from Bicep templates
- Pass custom headers and request bodies
- Capture and use HTTP responses in outputs

To test a sample, navigate to the sample folder and run:

```powershell
bicep local-deploy .\main.bicepparam
```

Refer to each sample's `main.bicep` for specific usage and customization details.
