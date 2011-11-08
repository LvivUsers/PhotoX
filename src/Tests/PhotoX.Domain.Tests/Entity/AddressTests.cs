using NUnit.Framework;
using PhotoX.Domain.Entities;

namespace PhotoX.Tests.Entity
{
    [TestFixture]
    public class AddressTests
    {
        [Test]
        public void City_SetSimpleValue_ReturnTheSame()
        {
            var address = new Address {City = "Lviv"};
            Assert.AreEqual("Lviv", address.City);
        }
    }
}
