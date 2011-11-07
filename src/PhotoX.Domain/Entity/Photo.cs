using System;

namespace PhotoX.Domain.Entity
{
    public class Photo : DomainEntity
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public DateTime Date { get; set; }
        public byte[] Image { get; set; }
    }
}