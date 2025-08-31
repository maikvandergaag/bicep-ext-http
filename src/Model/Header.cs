using Azure.Bicep.Types.Concrete;
using Bicep.Local.Extension.Types.Attributes;

namespace Bicep.Ext.Http.Model {
    public class Header {
        [TypeProperty("The name.", ObjectTypePropertyFlags.Required)]
        public string? Name { get; set; }

        [TypeProperty("The value.", ObjectTypePropertyFlags.Required)]
        public string? Value { get; set; }
    }
}
