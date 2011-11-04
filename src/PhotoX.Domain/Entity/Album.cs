using System.Collections.Generic;

namespace PhotoX.Domain.Entity
{
    public class Album : DomainEntity
    {
        public IEnumerable<Photo> Photos { get; set; }
    }
}