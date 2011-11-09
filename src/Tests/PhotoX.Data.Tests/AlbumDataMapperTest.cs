using System.Linq;
using NUnit.Framework;
using PhotoX.Data.AdoImplementation;
using PhotoX.Data.Interfaces;

namespace PhotoX.Data.Tests
{
    [TestFixture]
    public class AlbumDataMapperTest
    {
        private IAlbumDataMapper mapper;

        [SetUp]
        public void Init()
        {
            mapper = new AlbumDataMapper();            
        }

        [Test]
        public void GetAll_LoadsSomeData()
        {            
        }
    }
}
