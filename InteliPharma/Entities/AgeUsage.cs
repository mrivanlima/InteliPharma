using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class AgeUsage
    {
        public AgeUsage() { }
        public int AgeUsageId { get; set; }
        public string AgeUsageDescription { get; set; } = string.Empty;
        public string Threshold { get; set; } = string.Empty;
    }
}
