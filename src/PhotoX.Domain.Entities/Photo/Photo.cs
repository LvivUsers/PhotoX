using System;

namespace PhotoX.Domain.Entities
{
    public class Photo : DomainEntity
    {
        public int AlbumId { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public DateTime DateCreated { get; set; }
        public byte[] Image { get; set; }        
    }
}