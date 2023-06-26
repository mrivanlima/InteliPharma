using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class Drug
    {
        public Drug() { }
        public int DrugId { get; set; }
        public string DrugName { get; set; } = string.Empty;
    }
}
