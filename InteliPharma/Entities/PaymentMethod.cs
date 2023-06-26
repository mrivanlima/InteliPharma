using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class PaymentMethod
    {
        public PaymentMethod() { }
        public byte PaymentmethodId { get; set; }
        public string PaymenthMethodName { get; set; } = string.Empty;
    }
}
