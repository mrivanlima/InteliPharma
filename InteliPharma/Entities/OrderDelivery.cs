using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class OrderDelivery
    {
        public OrderDelivery() { }
        public long OrderDeliveryId { get; set; }
        public long DeliveryId { get; set; }
        public int OrderId { get; set; }
        public int DriverId { get; set; }
        public int AddressId { get; set; }
        public long ProductCartUserId { get; set; }
        public DateTime DeliveryStartDate { get; set; }
        public DateTime DeliveryEndDate { get; set; }
        public bool Completed { get; set; }
    }
}
