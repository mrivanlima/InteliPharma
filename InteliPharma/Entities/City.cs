using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class City
    {
        public City() { }
        public short CityId { get; set; }
        public string CityName { get; set; } = string.Empty;
        public byte StateId { get; set; }
        public decimal Longitude { get; set; }
        public decimal Latitude { get; set; }
    }
}
