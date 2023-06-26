using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class ContactType
    {
        public ContactType() { }
        public byte ContactTypeId { get; set; }
        public string ContactTypeName { get; set; } = string.Empty;
        public string ContactTypeDescription { get; set; } = string.Empty;
    }
}
