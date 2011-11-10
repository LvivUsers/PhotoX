using System;
using System.Collections.Generic;
using System.Linq;

using PhotoX.Data.Interfaces;
using PhotoX.Domain.Entities;
using Dapper;

namespace PhotoX.Data.AdoImplementation
{
    public class AlbumDataMapper : DataMapperBase, IAlbumDataMapper
    {
        public AlbumDataMapper(string connectionString) : base(connectionString) { }

        public IEnumerable<Album> GetAll()
        {
            return Query<Album>("select * from Album");
        }

        public Album GetBy(int id)
        {
            return Query<Album>("select * from Album where Id = @id", new {Id = id}).SingleOrDefault();
        }

        private bool Exists(int id)
        {
            return GetBy(id) != null;
        }

        public int Save(Album entity)
        {
            using (var connection = CreateConnection())
            {
                connection.Open();
                int savedId = entity.Id;
                if(Exists(entity.Id))
                {
                    connection.Execute("update Album set Name=@Name, Description=@Description, PhotographerId=@PhotographerId where Id=@Id", entity);
                }
                else
                {
                    savedId = Convert.ToInt32(connection.Query<decimal>("insert into Album (Name,Description,PhotographerId,DateCreated) values (@Name,@Description,@PhotographerId,GETDATE()); select SCOPE_IDENTITY()", entity).SingleOrDefault());
                }
                return savedId;
            }
        }
    }    
}
