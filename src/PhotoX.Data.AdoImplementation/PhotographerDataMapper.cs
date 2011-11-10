using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using PhotoX.Data.Interfaces;
using PhotoX.Domain.Entities;
using Dapper;

namespace PhotoX.Data.AdoImplementation
{
    public class PhotographerDataMapper : IPhotographerDataMapper
    {
        public IEnumerable<Photographer> GetAll()
        {
            using (IDbConnection connection = new SqlConnection())
            {
                //connection.Query<Photographer>("sql", );
            }
            return null;
        }

        public Photographer GetBy(int id)
        {
            throw new NotImplementedException();
        }

        public int Save(Photographer entity)
        {
            throw new NotImplementedException();
        }
    }
}
