using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class Disease
    {
        public Disease() { }
        public int DiseaseId { get; set; }
        public string DiseaseName { get; set; } = string.Empty;
    }
}
