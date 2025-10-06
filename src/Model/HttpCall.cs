using Azure.Bicep.Types.Concrete;
using Bicep.Local.Extension.Types.Attributes;
using System.Text.Json.Serialization;

namespace Bicep.Ext.Http.Model {
    [ResourceType("httpcall")]
    public class HttpCall : HttpCallIdentifiers {

        [TypeProperty("The Http Call Url", ObjectTypePropertyFlags.Required)]
        [JsonPropertyName("url")]
        public required string Url { get; set; }

        [TypeProperty("The HTTP method to use", ObjectTypePropertyFlags.Required)]
        [JsonConverter(typeof(JsonStringEnumConverter))]
        [JsonPropertyName("method")]
        public Method? Method { get; set; }

        [TypeProperty("The body to include in the request")]
        [JsonPropertyName("body")]
        public string? Body { get; set; }

        [TypeProperty("The http call headers")]
        [JsonPropertyName("headers")]
        public Header[]? Headers { get; set; }

        [TypeProperty("The http call result")]
        [JsonPropertyName("result")]
        public string? Result { get; set; }

        [TypeProperty("The http call status code")]
        [JsonPropertyName("statuscode")]
        public int StatusCode { get; set; }
    }
}
