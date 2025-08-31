# Scripts Folder

This folder contains utility scripts for building, publishing, and managing the bicep-ext-http extension.

## Files

- `publish.ps1` — PowerShell script to build and publish the bicep-ext-http extension locally or to a container registry.

---

## `publish.ps1` Documentation

### Purpose
Automates the process of building and publishing the bicep-ext-http extension for multiple platforms (Windows, Linux, macOS). It supports publishing locally or to a container registry.

### Parameters
- **Target**: The target path or registry reference to publish the extension to. Defaults to `./extension-publish/[ExtensionName]` if not specified.
- **ExtensionName**: The name of the extension to publish. Default is `bicep-ext-http`.
- **SourceFolder**: The source folder for the extension project. Default is `/src`.
- **Registry**: Boolean flag to enable publishing to a container registry. Default is `$false`.
- **RegistryUrl**: The URL of the container registry (e.g., `https://myregistry.azurecr.io`). Required if publishing to registry.
- **Tag**: The tag for the container image (e.g., `latest`, `v1.0.0`). Required if publishing to registry.
- **Repository**: The repository name for the container image. Default is `bicep-ext-http`. Required if publishing to registry.

### Usage Examples

Publish locally:
```powershell
.\publish.ps1
```

Publish to a container registry:
```powershell
.\publish.ps1 -Registry $true -RegistryUrl "https://myregistry.azurecr.io" -Tag "v1.0.0" -Repository "bicep-ext-http"
```

### Notes
- Requires Bicep CLI and .NET SDK installed.
- Builds the extension for Windows, Linux, and macOS.
- Uses the Bicep CLI to publish the extension binaries.
