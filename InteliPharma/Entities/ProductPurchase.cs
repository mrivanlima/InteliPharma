using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class ProductPurchase
    {
        public ProductPurchase() { }
        public int ProductPurchaseId { get; set; }
        public int ProductId { get; set; }
        public int PurchaseId { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }
        public DateTime PurchaseDate { get; set; }
        public string Serial { get; set; } = string.Empty;
        public string ProductBarCode { get; set; } = string.Empty;
        public string ProductCode { get; set; } = string.Empty;
        public string NCMSH { get; set; } = string.Empty;
        public string CMCST { get; set; } = string.Empty;
        public string CFOP { get; set; } = string.Empty;
        public short UN { get; set; }
        public decimal UnitValue { get; set; }
        public decimal TotalValue { get; set; }
        public decimal ICMSBaseCalculation { get; set; }
        public decimal ICMSValue { get; set; }
        public decimal IPIValue { get; set; }
        public decimal ICMSPercent { get; set; }
        public decimal IPIPercent { get; set; }
    }
}
