using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class Contact
    {
        public Contact() { }
        public long ContactId { get; set; }
        public string ContactName { get; set; } = string.Empty;
    }
}
