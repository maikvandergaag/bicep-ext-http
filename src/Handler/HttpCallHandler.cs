using Bicep.Ext.Http.Model;
using Bicep.Local.Extension.Host.Handlers;
using System.Reflection;

namespace Bicep.Ext.Http.Handler {
    public class HttpCallHandler : TypedResourceHandler<HttpCall, HttpCallIdentifiers> {
        protected override async Task<ResourceResponse> Preview(ResourceRequest request, CancellationToken cancellationToken) {
            await Task.CompletedTask;

            return GetResponse(request);
        }

        protected override async Task<ResourceResponse> CreateOrUpdate(ResourceRequest request, CancellationToken cancellationToken) {
            await Task.CompletedTask;

            using (var client = new HttpClient()) {
                var httpRequest = new HttpRequestMessage {
                    Method = request.Properties.Method switch {
                        Method.Get => HttpMethod.Get,
                        Method.Post => HttpMethod.Post,
                        Method.Delete => HttpMethod.Delete,
                        Method.Put => HttpMethod.Put,
                        Method.Patch => HttpMethod.Patch,
                        _ => throw new InvalidOperationException($"Unsupported HTTP method: {request.Properties.Method}"),
                    },
                    RequestUri = new Uri(request.Properties.Url),
                    Content = request.Properties.Body != null ? new StringContent(request.Properties.Body) : null
                };

                if (request.Properties.Headers != null) {
                    foreach (var header in request.Properties.Headers) {
                        if (header.Name != null && header.Value != null) {
                            if (header.Name.Equals("Content-Type", StringComparison.OrdinalIgnoreCase) && httpRequest.Content != null) {
                                httpRequest.Content.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue(header.Value);
                            } else {
                                httpRequest.Headers.Add(header.Name, header.Value);
                            }
                        }
                    }
                }

                var response = await client.SendAsync(httpRequest, cancellationToken);
                response.EnsureSuccessStatusCode();

                request.Properties.StatusCode = (int)response.StatusCode;
                request.Properties.Result = await response.Content.ReadAsStringAsync(cancellationToken);
            }

            return GetResponse(request);
        }

        protected override HttpCallIdentifiers GetIdentifiers(HttpCall properties)
            => new() {
                Url = properties.Url,
            };
    }
}