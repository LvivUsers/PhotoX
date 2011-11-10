using System;
using System.Linq;

using NUnit.Framework;

using PhotoX.Data.AdoImplementation;
using PhotoX.Data.Interfaces;
using PhotoX.Domain.Entities;

namespace PhotoX.Data.Tests
{
    [TestFixture]
    public class AlbumDataMapperTest: BaseTest
    {
        private IAlbumDataMapper mapper;

        [TestFixtureSetUp]
        public override void Init()
        {
            base.Init();
            mapper = new AlbumDataMapper(GetConnectionString());
        }

        [Test]
        public void GetAll_ReturnsSomedata()
        {
            var albums = mapper.GetAll();
            Assert.GreaterOrEqual(albums.Count(), 2);
        }

        [Test]
        public void GetById_ExistingAlbum_ReturnsCorrectData()
        {
            var album = mapper.GetBy(id: 2000000);
            Assert.NotNull(album);
            Assert.AreEqual(2000000, album.Id);
            Assert.AreEqual("My photos", album.Name);
            Assert.AreEqual("These are my photos", album.Description);
            Assert.AreNotEqual(default(DateTime), album.DateCreated);
        }

        [Test]
        public void GetById_NotExistingAlbum_ReturnsNull()
        {
            var album = mapper.GetBy(id: 1999999);
            Assert.Null(album);
        }

        [Test]
        public void Save_NewAlbum_ReturnNewId()
        {
            var album = new Album
                            {                                
                                Description = "Test description",
                                Name = "Test album",                                
                                PhotographerId = 1000001
                            };
            var newId = mapper.Save(album);
            Assert.Greater(newId, default(int));
        }

        [Test]
        public void Save_ExistingAlbum_ReturnTheExistingId()
        {
            var album = new Album
            {
                Id = 2000001,
                Description = "My weddings Update",
                Name = "Weddings Update",
                PhotographerId = 1000001
            };
            var newId = mapper.Save(album);
            Assert.AreEqual(newId, 2000001);
        }

        [TestFixtureTearDown]
        public override void Clear()
        {
            base.Clear();
        }
    }
}
