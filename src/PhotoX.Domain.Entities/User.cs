using System;

namespace PhotoX.Domain.Entity
{
    public class User : DomainEntity
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string MiddleName { get; set; }
        public string Password { get; set; }
        public Photo Photo { get; set; }
        public DateTime DateOfBirth { get; set; }
        public Address Address { get; set; }
        public Contact Contact { get; set; }
    }
}