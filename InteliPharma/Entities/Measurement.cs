using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class Measurement
    {
        public Measurement() { }
        public int MeasurementId { get; set; }
        public string MeasurementName { get; set; } = string.Empty;
    }
}
