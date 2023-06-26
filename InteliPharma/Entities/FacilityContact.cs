using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class FacilityContact
    {
        public FacilityContact() { }
        public long FacilityContactId { get; set; }
        public int FacilityId { get; set; }
        public long ContactId { get; set; }
    }
}
