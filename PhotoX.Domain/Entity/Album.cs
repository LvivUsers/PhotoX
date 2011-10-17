using System;
using System.Collections.Generic;

namespace PhotoX.Domain.Entity
{
    public class Album : DomainEntity
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public DateTime Date { get; set; }
        public IEnumerable<Photo> Photos { get; set; }
    }
}