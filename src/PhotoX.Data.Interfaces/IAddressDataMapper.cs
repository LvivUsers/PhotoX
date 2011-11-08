using System.Collections.Generic;

using PhotoX.Domain.Entities;

namespace PhotoX.Data.Interfaces
{
    public interface IAddressDataMapper
    {
        IEnumerable<Address> GetAll();
        Address GetBy(long id);
        long Save(Address address);
    }
}
