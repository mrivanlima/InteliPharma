using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class Prescription
    {
        public Prescription() { }
        public long PrescriptionId { get; set; }
        public int ProfessionalId { get; set; }
        public int PatientId { get; set; }
        public DateTime PrescriptionDate { get; set; }
    }
}
