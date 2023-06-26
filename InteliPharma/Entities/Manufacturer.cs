using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class Manufacturer
    {
        public Manufacturer() { }
        public short ManufacturerId { get; set; }
        public string ManufacturerName { get; set; } = string.Empty;
        public string ManufacturerPhoneNumer { get; set; } = string.Empty;
    }
}
