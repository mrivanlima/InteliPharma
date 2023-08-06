using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class AddressType
    {
        public AddressType () { }
        public short AddressTypeId { get; set; }
        public string AddressTypeDescription { get; set; } = string.Empty;
    }
}
