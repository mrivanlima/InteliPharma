using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class ActivePrincipleIndication
    {
        public ActivePrincipleIndication() { }
        public int ActivePrincipleIndicationId { get; set; }
        public int ActivePrincipleId { get; set; }
        public int IndicationId { get; set; }
    }
}
