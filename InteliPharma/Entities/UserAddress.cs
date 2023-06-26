using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class UserAddress
    {
        public UserAddress() { }
        public int UserAddressId { get; set; }
        public int AddressId { get; set; }
        public int UserId { get; set; }
        public short AdressTypeId { get; set; }
        public bool Active { get; set; }
        public bool Default { get; set; }

    }
}
