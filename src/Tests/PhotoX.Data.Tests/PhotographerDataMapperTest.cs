using System;
using System.Linq;

using NUnit.Framework;

using PhotoX.Data.AdoImplementation;
using PhotoX.Data.Interfaces;
using PhotoX.Domain.Entities;

namespace PhotoX.Data.Tests
{
    [TestFixture]
    public class PhotographerDataMapperTest: BaseTest
    {

        private IPhotographerDataMapper mapper;

        [TestFixtureSetUp]
        public override void Init()
        {
            base.Init();
            mapper = new PhotographerDataMapper(GetConnectionString());
        }
        [Test]
        public void GetAll_ReturnsSomeData()
        {
            var photographers = mapper.GetAll();
            Assert.GreaterOrEqual(photographers.Count(), 1);
            var photographer = photographers.Where(p => p.Id == 1000001).SingleOrDefault();
            VerifyPhotographer(photographer);
        }

        [Test]
        public void GetById_ExistingPhotographer_ReturnsCorrectData()
        {
            var photographer = mapper.GetBy(id: 1000001);
            VerifyPhotographer(photographer);
        }

        [Test]
        public void GetById_NotExistingPhotographer_ReturnsNull()
        {
            var photographer = mapper.GetBy(id: 999999);
            Assert.Null(photographer);            
        }

        [Test]
        public void Save_NewPhotographer_ReturnNewId()
        {
            Photographer photographer = CreatePhotographer(0);
            var newId = mapper.Save(photographer);
            Assert.Greater(newId, default(int));
        }

        [Test]
        public void Save_ExistingPhotographer_ReturnTheExistingId()
        {
            Photographer photographer = CreatePhotographer(1000001);
            var newId = mapper.Save(photographer);
            Assert.AreEqual(1000001, newId);
        }

        [Test]
        public void Save_InsertReadUpdateFlow_WorksCorrectly()
        {
            var photographer = CreatePhotographer(0);

            //insert photographer
            var newId = mapper.Save(photographer);
            var insertedPhotographer = mapper.GetBy(newId);            
            Assert.NotNull(insertedPhotographer);
            var insertedPhotographerDateOfBirth = insertedPhotographer.DateOfBirth;
            var insertedPhotographerlastLoginDate = insertedPhotographer.LastLoginDate;
            Assert.AreEqual(newId, insertedPhotographer.Id);
            Assert.AreEqual("save@mail.ua", insertedPhotographer.ContactInfo.Email);
            Assert.AreEqual("87654543", insertedPhotographer.ContactInfo.Phone);
            Assert.AreNotEqual(default(DateTime), insertedPhotographer.DateOfBirth);
            Assert.AreEqual("Photographer new", insertedPhotographer.FirstName);
            Assert.AreEqual(new Keywords("key1", "word"), insertedPhotographer.Keywords);
            Assert.AreNotEqual(default(DateTime), insertedPhotographer.LastLoginDate);
            Assert.AreEqual("Photographer last", insertedPhotographer.LastName);
            Assert.AreEqual("New city", insertedPhotographer.Location.City);
            Assert.AreEqual(2000, insertedPhotographer.Location.Country.Id);
            Assert.AreEqual("USA", insertedPhotographer.Location.Country.Name);
            Assert.AreEqual("new login", insertedPhotographer.Login);
            Assert.AreEqual("Photographer middle", insertedPhotographer.MiddleName);
            Assert.AreEqual("new password", insertedPhotographer.Password);
            Assert.AreEqual("Some new wxiting photographer summary", insertedPhotographer.Summary);

            //update photographer
            insertedPhotographer.ContactInfo.Email = "UpdatedEmail@mail.com";
            insertedPhotographer.ContactInfo.Phone = "55466578";
            insertedPhotographer.FirstName = "Updated name";
            insertedPhotographer.Keywords = new Keywords("ggg", "fff", "ddd");
            insertedPhotographer.LastName = "Updated last name";
            insertedPhotographer.Location.City = "Updated city";
            insertedPhotographer.Location.Country = new Country {Id = 1000, Name = "Ukraine"};
            insertedPhotographer.Login = "Updated login";
            insertedPhotographer.MiddleName = "Updated middle name";
            insertedPhotographer.Password = "Updated password";
            insertedPhotographer.Summary = "Updated summary for photographer";

            var insertedId = mapper.Save(insertedPhotographer);
            var updatedPhoto = mapper.GetBy(insertedId);

            Assert.NotNull(updatedPhoto);
            Assert.AreEqual(newId, updatedPhoto.Id);
            Assert.AreEqual("UpdatedEmail@mail.com", updatedPhoto.ContactInfo.Email);
            Assert.AreEqual("55466578", updatedPhoto.ContactInfo.Phone);
            Assert.AreEqual(insertedPhotographerDateOfBirth, updatedPhoto.DateOfBirth);
            Assert.AreEqual("Updated name", updatedPhoto.FirstName);
            Assert.AreEqual(new Keywords("ggg", "fff", "ddd"), updatedPhoto.Keywords);
            Assert.AreEqual(insertedPhotographerlastLoginDate, updatedPhoto.LastLoginDate);
            Assert.AreEqual("Updated last name", updatedPhoto.LastName);
            Assert.AreEqual("Updated city", updatedPhoto.Location.City);
            Assert.AreEqual(1000, updatedPhoto.Location.Country.Id);
            Assert.AreEqual("Ukraine", updatedPhoto.Location.Country.Name);
            Assert.AreEqual("Updated login", updatedPhoto.Login);
            Assert.AreEqual("Updated middle name", updatedPhoto.MiddleName);
            Assert.AreEqual("Updated password", updatedPhoto.Password);
            Assert.AreEqual("Updated summary for photographer", updatedPhoto.Summary);
        }

        private void VerifyPhotographer(Photographer photographer)
        {
            Assert.NotNull(photographer);
            Assert.AreEqual(1000001, photographer.Id);
            Assert.AreEqual("photo.test@mail.net", photographer.ContactInfo.Email);
            Assert.AreEqual("0603570479", photographer.ContactInfo.Phone);
            Assert.AreNotEqual(default(DateTime), photographer.DateOfBirth);
            Assert.AreEqual("Ivan", photographer.FirstName);
            Assert.AreEqual(new Keywords("children", "wedding", "photo"), photographer.Keywords);
            Assert.AreNotEqual(default(DateTime), photographer.LastLoginDate);
            Assert.AreEqual("Photograph", photographer.LastName);
            Assert.AreEqual("Lviv", photographer.Location.City);
            Assert.AreEqual(1000, photographer.Location.Country.Id);
            Assert.AreEqual("Ukraine", photographer.Location.Country.Name);
            Assert.AreEqual("Ivan_Login", photographer.Login);
            Assert.AreEqual("MidPhotograph", photographer.MiddleName);
            Assert.AreEqual("pass2", photographer.Password);
            Assert.AreEqual("I am very good photographer", photographer.Summary);
        }

        private Photographer CreatePhotographer(int id)
        {
            return new Photographer
            {
                Id = id,
                Login = "new login",
                MiddleName = "Photographer middle",
                DateOfBirth = DateTime.Now,
                FirstName = "Photographer new",
                Keywords = new Keywords("key1", "word"),
                LastLoginDate = DateTime.Now,
                LastName = "Photographer last",
                Password = "new password",
                Summary = "Some new wxiting photographer summary",
                ContactInfo = new Contact
                {
                    Email = "save@mail.ua",
                    Phone = "87654543"
                },
                Location = new Location
                {
                    City = "New city",
                    Country = new Country
                    {
                        Id = 2000,
                        Name = "USA"
                    }
                }
            };
        }
    }
}
