using System;

namespace PhotoX.Domain.Entities
{
    public abstract class User : DomainEntity
    {
        public string Login { get; set; }
        public string Password { get; set; }

        public DateTime LastLoginDate { get; set; }

        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string MiddleName { get; set; }
        public DateTime DateOfBirth { get; set; }        
    }
}