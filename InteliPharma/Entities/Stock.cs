using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class Stock
    {
        public Stock() { }
        public long StockId { get; set; }
        public int ProductId { get; set; }
        public string Lote { get; set; } = string.Empty;
        public DateTime FabricationDate { get; set; }
        public DateTime ExpirationDate { get; set; }
        public int Quantity { get; set; }

    }
}
