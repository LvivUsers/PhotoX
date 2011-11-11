using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

using Dapper;

using PhotoX.Domain.Entities;

namespace PhotoX.Data.AdoImplementation
{
    public abstract class DataMapperBase<T> where T : DomainEntity
    {
        private readonly string connectionString;

        protected DataMapperBase(string connectionString)
        {
            this.connectionString = connectionString;
        }

        public abstract IEnumerable<T> GetAll();
        public abstract T GetBy(int id);

        protected abstract int Insert(T entity, IDbConnection connection);
        protected abstract void Update(T entity, IDbConnection connection);

        protected IDbConnection CreateConnection()
        {
            return new SqlConnection(connectionString);
        }

        protected IEnumerable<T> Query(string sql, dynamic param = null)
        {
            using (var connection = CreateConnection())
            {
                connection.Open();
                return connection.Query<T>(sql, (object)param);
            }
        }

        protected bool Exists(int id)
        {
            return GetBy(id) != null;
        }

        public int Save(T entity)
        {
            using (var connection = CreateConnection())
            {
                connection.Open();
                int savedId = entity.Id;
                if (Exists(entity.Id))
                {
                    Update(entity, connection);
                }
                else
                {
                    savedId = Insert(entity, connection);
                }
                return savedId;
            }
        }        
    }
}
