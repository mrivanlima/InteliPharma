using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class Payment
    {
        public Payment() { }
        public byte PaymentId { get; set; }
        public byte PaymentMethodId { get; set; }
    }
}
