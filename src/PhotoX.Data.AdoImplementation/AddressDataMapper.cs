using System;
using System.Collections.Generic;

using PhotoX.Data.Interfaces;
using PhotoX.Domain.Entities;

namespace PhotoX.Data.AdoImplementation
{
    public class AddressDataMapper: IAddressDataMapper
    {
        public IEnumerable<Address> GetAll()
        {
            throw new NotImplementedException();
        }

        public Address GetBy(long id)
        {
            throw new NotImplementedException();
        }

        public long Save(Address address)
        {
            throw new NotImplementedException();
        }
    }
}
