using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PhotoX.Domain.Entity
{    
    public class PhotoDuplication : DomainEntity
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public DateTime Date { get; set; }
        public byte[] Image { get; set; }
    }
}
