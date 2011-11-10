using System;

namespace PhotoX.Domain.Entities
{
    public class Album : DomainEntity
    {
        public int PhotographerId { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public DateTime DateCreated { get; set; }
    }
}