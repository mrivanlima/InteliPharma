using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class Dosage
    {
        public Dosage() { }
        public int DosageId { get; set; }
        public string DosageValue { get; set; } = string.Empty;
    }
}
