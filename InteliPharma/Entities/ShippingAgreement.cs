using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class ShippingAgreement
    {
        public ShippingAgreement() { }
        public byte ShippingAgreementId { get; set; }
        public string ShippingName { get; set; } = string.Empty;
    }
}
