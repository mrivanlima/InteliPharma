using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class Store
    {
        public Store() { }
        public int StoreId { get; set; }
        public string StoreName { get; set; } = string.Empty;
        public int AddressId { get; set; }

    }
}
