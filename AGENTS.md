# bicep-ext-http

## Project

- This repository is a .NET 9 Bicep local extension that exposes an `httpcall` resource for GET, POST, PUT, DELETE, and PATCH requests.
- The executable is hosted through the Bicep local extension SDK. Keep the extension name, resource type, property names, and serialized output names compatible with the Bicep schema unless the task explicitly changes the public contract.
- `src/Program.cs` configures the extension host and registers `HttpCallHandler`.
- `src/Handler/HttpCallHandler.cs` owns HTTP request construction and the Bicep resource lifecycle (`Preview`, `CreateOrUpdate`, and identifiers).
- `src/Model/` defines the Bicep-facing schema. Preserve `ResourceType`, `TypeProperty`, JSON naming, enum serialization, and required-property attributes when changing models.

## Development

- Build from the repository root with `dotnet build` or `dotnet build src/bicep-ext-http.csproj`.
- Run the repository validation command with `dotnet test`; report clearly if no test project is present or if the command has no tests to execute.
- Validate user-facing behavior with the sample deployment when Bicep extensibility support is available: `bicep local-deploy ./samples/simple-http-calls/main.bicepparam`.
- The project publishes self-contained single-file binaries for `osx-arm64`, `linux-x64`, and `win-x64`; keep runtime-specific output paths aligned with the project file and publish script.
- Use nullable-aware C# and the existing implicit-usings style. Keep edits focused and avoid changing generated `bin/` or `obj/` output.

## Publishing

- `scripts/publish.ps1` builds all three runtime binaries and invokes `bicep publish-extension`.
- A local publish defaults to `extension-publish/bicep-ext-http`; registry publishing requires the registry URL, tag, and repository parameters. See [scripts/README.MD](scripts/README.MD).
- The publish script currently invokes a Windows-specific Bicep path (`D:\bicep-install\bicep.exe`). On macOS/Linux, use an available `bicep` command or update the script as part of the task before relying on local publishing.
- Releases are manually dispatched from `main` through [.github/workflows/main.yml](.github/workflows/main.yml); versions must be semantic versions without a leading `v`, and the workflow publishes the OCI artifact before tagging the release.

## Documentation and Samples

- Start with [README.md](README.md) for installation, resource properties, and supported features.
- Use [samples/simple-http-calls/README.MD](samples/simple-http-calls/README.MD) for basic request examples and [samples/entra-token/README.mD](samples/entra-token/README.mD) for OAuth2 client-credential usage.
- Treat sample endpoints and credentials as demonstration inputs only; do not add real secrets to Bicep parameter files or documentation.