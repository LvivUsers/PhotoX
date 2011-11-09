namespace PhotoX.Domain.Entities
{
    public abstract class ContactUser: User
    {
        public Contact ContactInfo { get; set; }
    }
}
