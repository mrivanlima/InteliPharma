using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class Professional
    {
        public Professional() { }
        public int ProfessionalId { get; set; }
        public string ProfessionalName { get; set; } = string.Empty;
        public string ProfessionalAssociationNumber { get; set; } = string.Empty;
    }
}
