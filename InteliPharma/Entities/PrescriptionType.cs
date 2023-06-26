using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class PrescriptionType
    {
        public PrescriptionType() { }
        public byte PrescriptionTypeId { get; set; }
        public string PrescriptionTypeName { get; set; } = string.Empty;
    }
}
