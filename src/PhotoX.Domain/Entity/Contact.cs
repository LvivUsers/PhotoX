using System.Collections.Generic;

namespace PhotoX.Domain.Entity
{
    public class Contact : DomainEntity
    {
        public string Email { get; set; }
        public IEnumerable<Phone> Phones { get; set; }        
    }
}