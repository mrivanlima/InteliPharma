using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class UserStore
    {
        public UserStore() { }
        public long UserStoreId { get; set; }
        public int UserId { get; set; }
        public int StoreId { get; set; }
        public bool IsDefault { get; set; }

    }
}
