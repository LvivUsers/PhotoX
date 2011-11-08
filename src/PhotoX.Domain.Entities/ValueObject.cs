using System;

namespace PhotoX.Domain.Entities
{
    public abstract class ValueObject: IEquatable<ValueObject>
    {
        public abstract bool Equals(ValueObject other);
    }
}
