using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class Address
    {
        public Address() { }
        public int AddressId { get; set; }
        public int ZipCodeId { get; set; }
        public string Number { get; set; } = string.Empty;
        public string Block { get; set; } = string.Empty;
        public string Lote { get; set; } = string.Empty;
        public decimal Longitude { get; set; }
        public decimal Latitude { get; set; }
    }
}
