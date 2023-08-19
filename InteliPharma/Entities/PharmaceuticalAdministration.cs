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
        public int PharmaceuticalAdministrationId { get; set; }
        public string PharmaceuticalAdministrationDescription { get; set; } = string.Empty;
    }
}
