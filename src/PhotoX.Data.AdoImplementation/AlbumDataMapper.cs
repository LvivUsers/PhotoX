using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

using PhotoX.Data.Interfaces;
using PhotoX.Domain.Entities;

using Dapper;

namespace PhotoX.Data.AdoImplementation
{
    public class AlbumDataMapper : DataMapperBase<Album>, IAlbumDataMapper
    {
        public AlbumDataMapper(string connectionString) : base(connectionString) { }

        public override IEnumerable<Album> GetAll()
        {
            return Query("select * from Album");
        }

        public override Album GetBy(int id)
        {
            return Query("select * from Album where Id = @id", new {Id = id}).SingleOrDefault();
        }

        protected override int Insert(Album album, IDbConnection connection)
        {
            return Convert.ToInt32(connection.Query<decimal>("insert into Album (Name,Description,PhotographerId,DateCreated) values (@Name,@Description,@PhotographerId,GETDATE()); select SCOPE_IDENTITY()", album).SingleOrDefault());
        }

        protected override void Update(Album album, IDbConnection connection)
        {
            connection.Execute("update Album set Name=@Name, Description=@Description, PhotographerId=@PhotographerId where Id=@Id", album);
        }
    }
}
