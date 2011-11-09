using System.Collections.Generic;

namespace PhotoX.Data.Interfaces
{
    public interface IDataMapper<T>
    {
        IEnumerable<T> GetAll();
        T GetBy(int id);
        int Save(T entity);
    }
}
