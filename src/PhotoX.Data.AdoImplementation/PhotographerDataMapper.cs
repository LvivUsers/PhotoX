using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

using PhotoX.Data.Interfaces;
using PhotoX.Domain.Entities;

using Dapper;

namespace PhotoX.Data.AdoImplementation
{
    public class PhotographerDataMapper : DataMapperBase<Photographer>, IPhotographerDataMapper
    {
        public PhotographerDataMapper(string connectionString) : base(connectionString) {}

        public override IEnumerable<Photographer> GetAll()
        {
            return GetPhotographers();
        }

        public override Photographer GetBy(int id)
        {
            return GetPhotographers("u.Id = @Id", new {Id = id}).SingleOrDefault();
        }

        private IEnumerable<Photographer> GetPhotographers(string whereClause = "", dynamic param = null)
        {
            using (IDbConnection connection = CreateConnection())
            {
                const string sql = @"select u.Id, u.FirstName, u.LastName, u.MiddleName, u.Login,
                                        u.DateOfBirth, u.[Password], u.LastLoginDate, p.Summary, 
                                        p.Email, p.Phone,
                                        p.City, 
                                        c.Id, c.Name,
                                        p.Keywords
                                        from [User] u join Photographer p
                                        on u.Id = p.UserId
                                        join Country c
                                        on p.CountryId = c.Id";
                connection.Open();
                return connection.Query<Photographer, Contact, Location, Country, string, Photographer>(
                    string.Format("{0} {1}", sql, whereClause),
                    (photographer, contact, location, country, keywords) =>
                    {
                        photographer.ContactInfo = contact;
                        location.Country = country;
                        photographer.Location = location;
                        photographer.Keywords = new Keywords(keywords.Split(new[] { ';', ' ' }, StringSplitOptions.RemoveEmptyEntries));
                        return photographer;
                    }, 
                    splitOn: "Email,City,Id,Keywords",
                    param: (object) param);
            }
        }

        protected override int Insert(Photographer entity, IDbConnection connection)
        {
            throw new NotImplementedException();
        }

        protected override void Update(Photographer entity, IDbConnection connection)
        {
            throw new NotImplementedException();
        }
    }
}
