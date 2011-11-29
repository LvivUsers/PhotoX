using System;
using System.Linq;

using NUnit.Framework;

using PhotoX.Data.AdoImplementation;
using PhotoX.Data.Interfaces;
using PhotoX.Domain.Entities;

namespace PhotoX.Data.Tests
{
    [TestFixture]
    public class PhotoDataMapperTest: BaseTest
    {
        private IPhotoDataMapper mapper;

        [TestFixtureSetUp]
        public override void Init()
        {
            base.Init();
            mapper = new PhotoDataMapper(GetConnectionString());
        }

        [Test]
        public void GetAll_ReturnsSomedata()
        {
            var photos = mapper.GetAll();
            Assert.NotNull(photos);
            Assert.GreaterOrEqual(photos.Count(), 3);
            var photo = photos.Where(p => p.Id == 3000000).SingleOrDefault();
            VerifyPhoto(photo);
        }        

        [Test]
        public void GetById_ExistingPhoto_ReturnsCorrectData()
        {
            var photo = mapper.GetBy(id: 3000000);
            VerifyPhoto(photo);
        }

        [Test]
        public void GetById_NotExistingPhoto_ReturnsNull()
        {
            var photo = mapper.GetBy(id: 2999999);
            Assert.Null(photo);
        }

        [Test]
        public void Save_NewPhoto_ReturnNewId()
        {
            var photo = new Photo
            {
                Description = "Test photo description",
                Name = "Test photo",
                AlbumId = 2000001,
                Image = new byte[] { 1, 2, 3 }
            };
            var newId = mapper.Save(photo);
            Assert.Greater(newId, default(int));
        }

        [Test]
        public void Save_ExistingPhoto_ReturnTheExistingId()
        {
            var photo = new Photo
            {
                Id = 3000001,
                Description = "Me photo 1 update description",
                Name = "Me photo 1 update name",                
                AlbumId = 2000001,
                Image = new byte[] { 1, 2, 3 }
            };
            var newId = mapper.Save(photo);
            Assert.AreEqual(3000001, newId);
        }

        [Test]
        public void Save_InsertReadUpdateFlow_WorksCorrectly()
        {
            var photo = new Photo
            {
                Description = "My photo description",
                Name = "My photo name",
                Image = new byte[] {3,6,7},
                AlbumId = 2000001
            };
            //insert photo
            var newId = mapper.Save(photo);
            var insertedPhoto = mapper.GetBy(newId);
            var dateCreated = insertedPhoto.DateCreated;
            Assert.AreEqual("My photo description", insertedPhoto.Description);
            Assert.AreEqual("My photo name", insertedPhoto.Name);
            Assert.AreEqual(2000001, insertedPhoto.AlbumId);
            Assert.AreEqual(newId, insertedPhoto.Id);
            Assert.IsTrue(insertedPhoto.Image.SequenceEqual(new byte[] {3,6,7}));

            //update album
            insertedPhoto.Description = "Updated photo description";
            insertedPhoto.Name = "Updated photo name";

            var insertedId = mapper.Save(insertedPhoto);
            var updatedPhoto = mapper.GetBy(insertedId);
            Assert.AreEqual("Updated photo description", updatedPhoto.Description);
            Assert.AreEqual("Updated photo name", updatedPhoto.Name);
            Assert.AreEqual(2000001, updatedPhoto.AlbumId);
            Assert.AreEqual(insertedId, updatedPhoto.Id);
            Assert.AreEqual(dateCreated, updatedPhoto.DateCreated);
            Assert.IsTrue(updatedPhoto.Image.SequenceEqual(new byte[] { 3, 6, 7 }));
        }

        private void VerifyPhoto(Photo photo)
        {
            Assert.NotNull(photo);
            Assert.AreEqual(3000000, photo.Id);
            Assert.AreEqual("Me1", photo.Name);
            Assert.AreEqual("This is me 1", photo.Description);
            Assert.AreEqual(2000000, photo.AlbumId);
            Assert.NotNull(photo.Image);
            Assert.AreNotEqual(default(DateTime), photo.DateCreated);
        }

        [TestFixtureTearDown]
        public override void Clear()
        {
            base.Clear();
        }
    }
}
