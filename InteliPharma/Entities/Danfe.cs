using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class Danfe
    {
        public Danfe() { }
        public long DanfeId { get; set; }
        public short DanfeTypeId { get; set; }
        public string Serial { get; set; } = string.Empty;
        public string Page { get; set; } = string.Empty;
    }
}
