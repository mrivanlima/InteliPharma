using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class Order
    {
        public Order() { }
        public long OrderId { get; set; }
        public long CartId { get; set; }
        public decimal TotalPrice { get; set; }
    }
}
