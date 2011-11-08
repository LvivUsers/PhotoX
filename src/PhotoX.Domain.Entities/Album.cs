using System;
using System.Collections.Generic;

namespace PhotoX.Domain.Entities
{
    public class Album : DomainEntity
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public DateTime Date { get; set; }
        public IEnumerable<Photo> Photos { get; set; }
    }
}