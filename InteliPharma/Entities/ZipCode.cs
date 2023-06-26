using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class ZipCode
    {
        public ZipCode() { }
        public int ZipCodeId { get; set; }
        public string ZipCodeCode { get; set; } = string.Empty;
        public int StreetId { get; set; }
        public string ZipCodeFrom { get; set; } = string.Empty;
        public string ZipCodeTo { get; set; } = string.Empty;

    }
}
