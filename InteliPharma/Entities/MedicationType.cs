using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class MedicationType
    {
        public MedicationType() { }
        public byte MedicationTypeId { get; set; }
        public string MedicationTypeName { get; set; } = string.Empty;
    }
}
