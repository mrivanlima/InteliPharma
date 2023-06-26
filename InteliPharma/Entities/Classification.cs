using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class Classification
    {
        public Classification() { }
        public byte ClassificationId { get; set; }
        public string ClassificationName { get; set; } = string.Empty;
    }
}
