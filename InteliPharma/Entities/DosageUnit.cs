using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class DosageUnit
    {
        public DosageUnit() { }
        public short DosageUnitId { get; set; }
        public string UnitName { get; set; } = string.Empty;
        public string UnitAbbrev { get; set; } = string.Empty;
    }
}
