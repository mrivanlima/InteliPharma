using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class OrderPayment
    {
        public OrderPayment() { }
        public long OrderPaymentId { get; set; }
        public long OrderId { get; set; }
        public byte PaymentId { get; set; }
    }
}
