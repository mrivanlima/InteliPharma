using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class ActivePrinciple
    {
        public ActivePrinciple() { }
        public int ActivePrincipleId { get; set; }
        public string ActivePrincipleName { get; set; } = string.Empty;
    }
}
