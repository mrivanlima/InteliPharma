using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class Indication
    {
        public Indication() { }
        public int IndicationId { get; set; }
        public string IndicationDescription { get; set; } = string.Empty;
    }
}
