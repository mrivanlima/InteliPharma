using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class Product
    {
        public Product() { }
        public int ProductId { get; set; }
        public String ProductBarCode { get; set; } = String.Empty;
        public decimal Price { get; set; }
        public bool Active { get; set; }
    }
}
