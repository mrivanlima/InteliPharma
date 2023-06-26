using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class Specialty
    {
        public Specialty() { }
        public short SpecialtyId { get; set; }
        public string SpecialtyName { get; set; } = string.Empty;
    }
}
