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
            Assert.NotNull(albums);
            Assert.GreaterOrEqual(albums.Count(), 2);
            var album = albums.Where(a => a.Id == 2000000).SingleOrDefault();
            VerifyAlbum(album);
        }        

        [Test]
        public void GetById_ExistingAlbum_ReturnsCorrectData()
        {
            var album = mapper.GetBy(id: 2000000);
            VerifyAlbum(album);
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
            Assert.AreEqual(2000001, newId);
        }

        [Test]
        public void Save_InsertReadUpdateFlow_WorksCorrectly()
        {
            var album = new Album
            {                
                Description = "My album description",
                Name = "My album name",
                PhotographerId = 1000001
            };
            //insert album
            var newId = mapper.Save(album);
            var insertedAlbum = mapper.GetBy(newId);
            var dateCreated = insertedAlbum.DateCreated;
            Assert.AreEqual("My album description", insertedAlbum.Description);
            Assert.AreEqual("My album name", insertedAlbum.Name);
            Assert.AreEqual(1000001, insertedAlbum.PhotographerId);
            Assert.AreEqual(newId, insertedAlbum.Id);

            //update album
            insertedAlbum.Description = "Updated description";
            insertedAlbum.Name = "Updated name";

            var insertedId = mapper.Save(insertedAlbum);
            var updatedAlbum = mapper.GetBy(insertedId);
            Assert.AreEqual("Updated description", updatedAlbum.Description);
            Assert.AreEqual("Updated name", updatedAlbum.Name);
            Assert.AreEqual(1000001, updatedAlbum.PhotographerId);
            Assert.AreEqual(insertedId, updatedAlbum.Id);
            Assert.AreEqual(dateCreated, updatedAlbum.DateCreated);
        }

        private void VerifyAlbum(Album album)
        {
            Assert.NotNull(album);
            Assert.AreEqual(2000000, album.Id);
            Assert.AreEqual("My photos", album.Name);
            Assert.AreEqual("These are my photos", album.Description);
            Assert.AreNotEqual(default(DateTime), album.DateCreated);
        }

        [TestFixtureTearDown]
        public override void Clear()
        {
            base.Clear();
        }
    }
}
