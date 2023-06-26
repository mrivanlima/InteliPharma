using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class MedicationPrescriptionType
    {
        public MedicationPrescriptionType() { }
        public long MedicationPrescriptionTypeId { get; set; }
        public int MedicationId { get; set; }
        public long PrescriptionId { get; set; }
        public byte PrescriptionTypeId { get; set; }
        public byte Quantity { get; set; }
    }
}
