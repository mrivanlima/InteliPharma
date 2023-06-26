using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class PharmaceuticalAdministration
    {
        public PharmaceuticalAdministration() { }
        public int PharmaceuticalAdministartionId { get; set; }
        public string PharmaceuticalAdministrationDesctiption { get; set; } = string.Empty;
    }
}
