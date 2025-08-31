# Simple HTTP Calls Sample

This sample demonstrates how to use the bicep-ext-http extension to perform basic HTTP operations (GET, POST, DELETE) from a Bicep template.

## Files

- `main.bicep`: The main Bicep template showing GET, POST, and DELETE requests.
- `main.bicepparam`: Parameters file for deployment (no parameters required for this sample).
- `sample/body.json`: Example JSON payload used in the POST request.

## How It Works

- **GET Request**: Fetches data from a sample endpoint and outputs the response and status code.
- **POST Request**: Sends a JSON payload to the endpoint, with custom headers, and outputs the response and status code.
- **DELETE Request**: Sends a DELETE request to the endpoint and outputs the status code.

## Usage

To deploy and test the sample, run:

```powershell
bicep local-deploy .\main.bicepparam
```

## Outputs

- `getResponse`: The parsed JSON response from the GET request.
- `getStatusCode`: The HTTP status code from the GET request.
- `postResponse`: The parsed JSON response from the POST request.
- `postStatusCode`: The HTTP status code from the POST request.
- `deleteStatusCode`: The HTTP status code from the DELETE request.

## Customization

- Edit `sample/body.json` to change the POST request payload.
- Change URLs or add headers in `main.bicep` to test other endpoints or authentication scenarios.
