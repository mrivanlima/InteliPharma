using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class Purchase
    {
        public Purchase() { }
        public int PurchaseId { get; set; }
        public int DistributorId { get; set; }
        public short OperationNatureId { get; set; }
        public short TaxCalculationId { get; set; }
        public short TransporterId { get; set; }
        public byte ShippingAgreementId { get; set; }
        public DateTime PurchaseDate { get; set; }
        public string PurchaseFiscalNote { get; set; } = string.Empty;
        public string DanfeBarCode { get; set; } = string.Empty;
        public string AccessKey { get; set; } = string.Empty;
        public string AuthorizationProtocol { get; set; } = string.Empty;
        public string StateSubscription { get; set; } = string.Empty;
        public string StateSubscriptionTribute { get; set; } = string.Empty;
        public string CNPJ { get; set; } = string.Empty;
        public DateTime EmissionDate { get; set; }
        public DateTime OperationDate { get; set; }
        public TimeSpan OperationTime { get; set; }

    }
}
