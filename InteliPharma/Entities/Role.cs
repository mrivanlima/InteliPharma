using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class Role
    {
        public Role() { }
        public byte RoleId { get; set; }
        public string RoleDescription { get; set; } = string.Empty;
    }
}
