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
            if(!string.IsNullOrWhiteSpace(whereClause))
            {
                whereClause = string.Format("where {0}", whereClause);
            }
            using (IDbConnection connection = CreateConnection())
            {
                const string sql = 
                    @"select u.Id, u.FirstName, u.LastName, u.MiddleName, u.Login,
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

        protected override int Insert(Photographer photographer, IDbConnection connection)
        {
            return connection.Query<int>
                (@"insert into [User] (FirstName,LastName,MiddleName,[Password],DateOfBirth,LastLoginDate,[Login])
                    values (@FirstName,@LastName,@MiddleName,@Password,@DateOfBirth,@LastLoginDate,@Login)
                    declare @userId int
                    set @userId = SCOPE_IDENTITY()
                   insert into Photographer (UserId,Summary,Keywords,Phone,Email,City,CountryId)
                    values (@userId,@Summary,@Keywords,@Phone,@Email,@City,@CountryId)
                    select @userId",
                    ToMapObject(photographer)).SingleOrDefault();
        }

        protected override void Update(Photographer photographer, IDbConnection connection)
        {
            connection.Execute
                (@"update [User] set FirstName=@FirstName,LastName=@LastName,MiddleName=@MiddleName,
	                DateOfBirth=@DateOfBirth,[Password]=@Password,LastLoginDate=@LastLoginDate,[Login]=@Login
                    where Id=@Id
                   update Photographer set UserId=@Id,Summary=@Summary,Keywords=@Keywords,
	                Phone=@Phone,Email=@Email,City=@City,CountryId=@CountryId
                    where UserId=@Id",
                    ToMapObject(photographer));
        }

        private object ToMapObject(Photographer photographer)
        {
            return new
            {
                photographer.Id,
                photographer.FirstName,
                photographer.LastName,
                photographer.MiddleName,
                photographer.Password,
                photographer.DateOfBirth,
                photographer.LastLoginDate,
                photographer.Login,
                photographer.Summary,
                Keywords = photographer.Keywords.ToString(),
                photographer.ContactInfo.Phone,
                photographer.ContactInfo.Email,
                photographer.Location.City,
                CountryId = photographer.Location.Country.Id
            };
        }
    }
}
