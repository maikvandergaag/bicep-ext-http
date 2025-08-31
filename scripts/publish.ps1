<#
.SYNOPSIS
This script publishes a Bicep extension to a specified target, with options for container registry publishing.

.DESCRIPTION
This script automates the process of publishing a Bicep extension, including building the extension for multiple platforms and publishing it to a specified target or container registry.

.PARAMETER Target
The target to publish the extension to. (locally on the machine by default: ./extension-publish/[$ExtensionName])

.PARAMETER ExtensionName
The name of the extension to publish. (default: bicep-ext-http)

.PARAMETER SourceFolder
The source folder for the extension. (default: /src)

.PARAMETER Registry
The name of the container registry to publish the extension to.

.PARAMETER RegistryUrl
The URL of the container registry to publish the extension to.

.PARAMETER Tag
The tag for the bicep extension.

.PARAMETER Repository
The repository for the container image. (default: bicep-ext-http)

#>

[CmdletBinding(DefaultParameterSetName = 'Default')]
param(
  [Parameter(ParameterSetName = 'Default', HelpMessage = "The target to publish the extension to.", Mandatory = $false)]
  [string]$Target,
  [Parameter(ParameterSetName = 'Default', HelpMessage = "The name of the extension.", Mandatory = $false)]
  [string]$ExtensionName = "bicep-ext-http",
  [Parameter(ParameterSetName = 'Default', HelpMessage = "The source folder for the extension.", Mandatory = $false)]
  [string]$SourceFolder = "/src",
  [Parameter(ParameterSetName = 'Registry', HelpMessage = "Whether to publish to a container registry.", Mandatory = $false)]
  [bool]$Registry = $false,
  [Parameter(ParameterSetName = 'Registry', HelpMessage = "The URL of the container registry.", Mandatory = $true)]
  [string]$RegistryUrl,
  [Parameter(ParameterSetName = 'Registry', HelpMessage = "The tag for the container image.", Mandatory = $true)]
  [string]$Tag,
  [Parameter(ParameterSetName = 'Registry', HelpMessage = "The repository for the container image.", Mandatory = $true)]
  [string]$Repository

)

BEGIN {
  $ErrorActionPreference = "Stop"

  # Check if bicep CLI is installed
  if (-not (Get-Command "bicep" -ErrorAction SilentlyContinue)) {
    Write-Host "Bicep CLI is not installed. Please install it from https://aka.ms/bicep/install"
    exit 1
  }
  Write-Host "######################################################################"
  Write-Host "##"
  $scriptFolder = Split-Path -Path $MyInvocation.MyCommand.Path -Parent
  $projectFolder = Split-Path -Path $scriptFolder -Parent
  
  Write-Host "## Using the following project folder: $projectFolder"

  if ($Target) {
    Write-Host "## Using the following target: $Target"
  }
  else {
    Write-Host "## No target specified, using default (extension-publish)."
    $Target = Join-Path $projectFolder "/extension-publish/$ExtensionName"
    Write-Host "## Using the following target: $Target"
  }

  if($Registry){
    Write-Host "## !!! Publishing to container registry enabled. Make sure your session is logged in to $RegistryUrl"
    $Target = "br:$($RegistryUrl)/$($Repository):$($Tag)"
    Write-Host "## Publishing the extension to the container registry: $Target"
  }

  $root = Join-Path $projectFolder $SourceFolder
  Write-Host "## Using the following source folder to build extension: $root"
  Write-Host "## Using the following extension name: $ExtensionName"
  Write-Host "##"
  Write-Host "######################################################################"
  Write-Host ""
}
PROCESS {

  Write-Host "# Starting the publish process for the Bicep extension."

  Write-Host "# Building the extensions for multiple platforms."
  dotnet publish --configuration release -r osx-arm64 $root
  dotnet publish --configuration release -r linux-x64 $root
  dotnet publish --configuration release -r win-x64 $root

  Write-Host "# Publishing the extension to the specified target."
  D:\bicep-install\bicep.exe publish-extension --bin-osx-arm64 $root/bin/release/net9.0/osx-arm64/publish/$ExtensionName `
    --bin-linux-x64 $root/bin/release/net9.0/linux-x64/publish/$ExtensionName `
    --bin-win-x64 $root/bin/release/net9.0/win-x64/publish/$ExtensionName.exe `
    --target $Target `
    --force
}
END {
  Write-Host ""
  Write-Host "######################################################################"
  Write-Host "##"
  Write-Host "## Publish process completed."
  Write-Host "##"
  Write-Host "######################################################################"
}

