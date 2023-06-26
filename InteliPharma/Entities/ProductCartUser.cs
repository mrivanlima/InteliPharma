using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class ProductCartUser
    {
        public ProductCartUser() { }
        public long ProductCartUserId { get; set; }
        public long ProductId { get; set; }
        public long CartId { get; set; }
        public int UserId { get; set; }
        public DateTime AddedOn { get; set; }
        public bool Active { get; set; }
    }
}
