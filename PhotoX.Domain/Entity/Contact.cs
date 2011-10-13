using System.Collections.Generic;

namespace PhotoX.Domain.Entity
{
    public class Contact
    {
        public string EMail { get; set; }
        public IEnumerable<Phone> Phones { get; set; }        
    }
}