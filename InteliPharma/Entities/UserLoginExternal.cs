using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class UserLoginExternal
    {
        public UserLoginExternal() { }
        public int UserId { get; set; }
        public short ExternalProviderID { get; set; }
        public string ExternalProviderToken { get; set; } = string.Empty;
    }
}
