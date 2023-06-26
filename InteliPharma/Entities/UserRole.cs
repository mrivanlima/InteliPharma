using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class UserRole
    {
        public UserRole() { }
        public int UserRoleId { get; set; }
        public int UserId { get; set; }
        public byte RoleId { get; set; }
        public bool Active { get; set; }
    }
}
