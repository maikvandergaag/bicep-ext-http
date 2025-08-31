using Microsoft.AspNetCore.Builder;
using Bicep.Local.Extension.Host.Extensions;
using Microsoft.Extensions.DependencyInjection;
using Bicep.Ext.Http.Handler;

var builder = WebApplication.CreateBuilder();

builder.AddBicepExtensionHost(args);
builder.Services
    .AddBicepExtension(
        name: "bicep-ext-http",
        version: "1.0.0",
        isSingleton: true,
        typeAssembly: typeof(Program).Assembly)
    .WithResourceHandler<HttpCallHandler>();

var app = builder.Build();

app.MapBicepExtension();

await app.RunAsync();