namespace PhotoX.Domain.Entities
{
    public class Photographer : ContactUser
    {
        public string Summary { get; set; }
        public Location Location { get; set; }
        public Keywords Keywords { get; set; }
    }
}