using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class ProfessionalSpecialty
    {
        public ProfessionalSpecialty() { }
        public int ProfessionalSpecialtyId { get; set; }
        public short SpecialtyId { get; set; }
        public string ProfessionalId { get; set; } = string.Empty;
    }
}
