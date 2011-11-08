using System.Collections.Generic;

namespace PhotoX.Domain.Entities
{
    public class Keywords : DomainEntity
    {
        public IEnumerable<string> Keyword { get; set; }
    }
}