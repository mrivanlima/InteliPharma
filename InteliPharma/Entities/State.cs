using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class State
    {
        public State() { }
        public byte StateId { get; set; }
        public string StateName { get; set; } = string.Empty;
        public string StateAbbreviation { get; set; } = string.Empty;
        public decimal Longitude { get; set; }
        public decimal Latitude { get; set; }
    }
}
