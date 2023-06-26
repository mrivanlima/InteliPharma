using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class DanfeType
    {
        public DanfeType() { }
        public short DanfeTypeId { get; set; }
        public string DanfeTypeName { get; set; } = string.Empty;
        public byte DanfeTypeCode { get; set; }
    }
}
