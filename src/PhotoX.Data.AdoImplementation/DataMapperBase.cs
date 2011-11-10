using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

using Dapper;

namespace PhotoX.Data.AdoImplementation
{
    public abstract class DataMapperBase
    {
        private readonly string connectionString;

        public DataMapperBase(string connectionString)
        {
            this.connectionString = connectionString;
        }

        protected IDbConnection CreateConnection()
        {
            return new SqlConnection(connectionString);
        }

        protected IEnumerable<T> Query<T>(string sql, dynamic param = null)
        {
            using (var connection = CreateConnection())
            {
                connection.Open();
                return connection.Query<T>(sql, (object)param);
            }
        }
    }
}
