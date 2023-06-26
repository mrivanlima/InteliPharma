using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class ActivePrincipleDrug
    {
        public ActivePrincipleDrug() { }
        public int ActivePrincipleDrugId { get; set; }
        public int DrugId { get; set; }
        public int ActivePrincipleId { get; set; }
    }
}
