using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Transactions;

namespace PhotoX.Data.Tests
{    
    public abstract class BaseTest
    {
        private TransactionScope transacton;

        #region Database Helpers        
        private IDbConnection CreateConnection()
        {            
            return new SqlConnection(GetConnectionString());
        }

        protected string GetConnectionString()
        {
            const string connectionStringName = "PhotoXCon";
            if (ConfigurationManager.ConnectionStrings[connectionStringName] == null)
            {
                throw new ConfigurationErrorsException("Connection string not found");
            }
            return ConfigurationManager.ConnectionStrings[connectionStringName].ConnectionString;            
        }

        private IDbCommand CreateCommand()
        {
            return new SqlCommand();
        }

        protected int ExecuteScalar(string sql)
        {
            using (var connection = CreateConnection())
            {
                using (var command = CreateCommand())
                {
                    SetupCommand(sql, connection, command);
                    var result = command.ExecuteScalar();
                    return Convert.ToInt32(result);
                }
            }
        }

        protected void ExecuteNonQuery(string sql)
        {
            using (var connection = CreateConnection())
            {
                using (var command = CreateCommand())
                {
                    SetupCommand(sql, connection, command);
                    command.ExecuteNonQuery();
                }
            }
        }

        private void SetupCommand(string sql, IDbConnection connection, IDbCommand command)
        {
            command.Connection = connection;
            command.CommandType = CommandType.Text;
            connection.Open();
            command.CommandText = sql;
        }

        #endregion

        public virtual void Init()
        {
            transacton = new TransactionScope();
            var initSql = ReadSqlSetupScript();
            ExecuteNonQuery(initSql);
        }

        private string ReadSqlSetupScript()
        {
            using (var stream = GetType().Assembly.GetManifestResourceStream("PhotoX.Data.Tests.sql.TestSetup.sql"))
            {
                using (var reader = new StreamReader(stream))
                {
                    return reader.ReadToEnd();
                }
            }
        }

        public virtual void Clear()
        {
            //rollaback
            if (transacton != null)
            {
                transacton.Dispose();
            }
        }
    }
}
