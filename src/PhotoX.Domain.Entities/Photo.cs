using System;

namespace PhotoX.Domain.Entities
{
    public class Photo : DomainEntity
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public DateTime Date { get; set; }
        public byte[] Image { get; set; }
    }
}