namespace PhotoX.Domain.Entity
{
    public class Photographer : User
    {
        public string Summary { get; set; }
        public Template Template { get; set; }
        public Keywords Keywords { get; set; }
    }
}