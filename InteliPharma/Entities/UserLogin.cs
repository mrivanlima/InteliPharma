using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class UserLogin
    {
        public UserLogin() { }

        public int UserId { get; set; }
        public string LoginName { get; set; } = string.Empty;
        public string PasswordHash { get; set; } = string.Empty;
        public string PasswordSalt { get; set; } = string.Empty;
        public string ConfirmationToken { get; set; } = string.Empty;
        public DateTime TokenGenerationTime { get; set; }
        public bool EmailValidation { get; set; }
        public string PasswordRecoveryToken { get; set; } = string.Empty;
        public DateTime RecoveryTokenTime { get; set; }


    }
}
