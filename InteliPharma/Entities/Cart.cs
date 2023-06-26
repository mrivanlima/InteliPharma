using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class Cart
    {
        public Cart() { }
        public long CartId { get; set; }
        public DateTime CreationDate { get; set; }
    }
}
