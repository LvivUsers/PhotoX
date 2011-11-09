using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using PhotoX.Data.Interfaces;
using PhotoX.Domain.Entities;
using Dapper;

namespace PhotoX.Data.AdoImplementation
{
    public class AlbumDataMapper : IAlbumDataMapper
    {
        public IEnumerable<Album> GetAll()
        {
            using (var connection = GetConnection())
            {
                connection.Open();
                return connection.Query<Album>("select * from Album");
            }
        }

        public Album GetBy(int id)
        {
            using (var connection = GetConnection())
            {
                connection.Open();
                return connection.Query<Album>("select * from Album where Id = @id", new {Id = id}).SingleOrDefault();
            }
        }

        public int Save(Album entity)
        {
            throw new NotImplementedException();
        }

        private IDbConnection GetConnection()
        {
            return new SqlConnection(ConfigurationManager.ConnectionStrings["PhotoXCon"].ConnectionString);
        }
    }
}
