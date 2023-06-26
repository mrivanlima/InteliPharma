using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class ProfessionalType
    {
        public ProfessionalType() { }
        public byte ProfessionalTypeId { get; set; }
        public string ProfessionalTypeName { get; set; } = string.Empty;
    }
}
