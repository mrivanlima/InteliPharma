using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class Medication
    {
        public Medication() { }
        public int MedicationId { get; set; }
        public int DrugId { get; set; }
        public byte ClassificationId { get; set; }
        public short ManufacturerId { get; set; }
        public byte MedicationTypeId { get; set; }
        public int AgeUsageId { get; set; }
        public int PharmaceuticalAdministrationId { get; set; }
        public int PharmaceuticalFormId { get; set; }
        public int ActivePrincipleId { get; set; }
        public int IndicationId { get; set; }
        public string AgeUsageDescription { get; set; } = string.Empty;
        public string Threshold { get; set; } = string.Empty;
    }
}
