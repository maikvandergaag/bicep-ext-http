using Azure.Bicep.Types.Concrete;
using Bicep.Local.Extension.Types.Attributes;

namespace Bicep.Ext.Http.Model {
    public class HttpCallIdentifiers {
        [TypeProperty("The Http Call Url", ObjectTypePropertyFlags.Identifier | ObjectTypePropertyFlags.Required)]
        public required string Url { get; set; }
    }
}
