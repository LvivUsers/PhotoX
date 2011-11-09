using NUnit.Framework;

using PhotoX.Domain.Entities;

namespace PhotoX.Domain.Tests.Entity
{
    [TestFixture]
    public class KeywordsTest
    {
        [Test]
        public void ToList_SimpleValues_ReturnAllKeyword()
        {
            var keywords = new Keywords("Photo", "best", "wedding");
            var list = keywords.List;

            Assert.NotNull(list);
            Assert.AreEqual(3, list.Count);
            Assert.IsTrue(list.Contains("Photo"));
            Assert.IsTrue(list.Contains("best"));
            Assert.IsTrue(list.Contains("wedding"));
        }

        [Test]
        public void ToList_NullConstructor_DontReturnNull()
        {
            var keywords = new Keywords(null);
            var list = keywords.List;

            Assert.NotNull(list);            
        }
    }
}
