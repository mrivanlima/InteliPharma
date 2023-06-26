using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class PharmaceuticalForm
    {
        public PharmaceuticalForm() { }
        public int PharmaceuticalFormId { get; set; }
        public string PharmaceuticalFormDescription { get; set; } = string.Empty;
    }
}
