using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

using Dapper;

using PhotoX.Data.Interfaces;
using PhotoX.Domain.Entities;

namespace PhotoX.Data.AdoImplementation
{
    public class PhotoDataMapper : DataMapperBase<Photo>, IPhotoDataMapper
    {
        public PhotoDataMapper(string connectionString) : base(connectionString) { }

        public override IEnumerable<Photo> GetAll()
        {
            return Query("select * from Photo");
        }

        public override Photo GetBy(int id)
        {
            return Query("select * from Photo where Id = @Id", new {Id = id}).SingleOrDefault();
        }

        protected override int Insert(Photo photo, IDbConnection connection)
        {
            return Convert.ToInt32(connection.Query<decimal>("insert into Photo (AlbumId,Name,Description,DateCreated,Image) values (@AlbumId,@Name,@Description,GETDATE(),@Image); select SCOPE_IDENTITY()", photo).SingleOrDefault());
        }

        protected override void Update(Photo photo, IDbConnection connection)
        {
            connection.Execute("update Photo set AlbumId=@AlbumId, Name=@Name, Description=@Description, Image=@Image where Id=@Id", photo);
        }
    }
}
