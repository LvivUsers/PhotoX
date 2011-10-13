using System.Collections.Generic;

namespace PhotoX.Domain.Entity
{
    public class KeyWords : DomainEntity
    {
        public IEnumerable<string> KeyWord { get; set; }
    }
}