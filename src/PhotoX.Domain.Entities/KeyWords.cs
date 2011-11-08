using System.Collections.Generic;

namespace PhotoX.Domain.Entity
{
    public class Keywords : DomainEntity
    {
        public IEnumerable<string> Keyword { get; set; }
    }
}