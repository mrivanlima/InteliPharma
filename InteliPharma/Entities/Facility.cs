using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class Facility
    {
        public Facility() { }
        public int FacilityId { get; set; }
        public string FacilityName { get; set; } = string.Empty;
        public int AddressId { get; set; }
    }
}
