using System;
using System.Collections.Generic;

using PhotoX.Data.Interfaces;
using PhotoX.Domain.Entities;

namespace PhotoX.Data.AdoImplementation
{
    public class PhotoDataMapper : IPhotoDataMapper
    {
        public IEnumerable<Photo> GetAll()
        {
            throw new NotImplementedException();
        }

        public Photo GetBy(int id)
        {
            throw new NotImplementedException();
        }

        public int Save(Photo entity)
        {
            throw new NotImplementedException();
        }
    }
}
