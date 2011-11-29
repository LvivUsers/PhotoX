using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;

namespace PhotoX.Domain.Entities
{
    public class Keywords
    {        
        private IList<string> KeywordList { get; set; }

        public Keywords(params string[] words)
        {
            KeywordList = new List<string>(words ?? new string[]{});
        }      

        public IList<string> List
        {
            get 
            { 
                return new ReadOnlyCollection<string>(KeywordList);
            }
        }

        public override bool Equals(object obj)
        {
            Keywords other = obj as Keywords;
            if(other == null)
            {
                return false;
            }
            return KeywordList.OrderBy(k => k).SequenceEqual(other.KeywordList.OrderBy(k => k));
        }

        public override string ToString()
        {
            return string.Join("; ", KeywordList);
        }

        public override int GetHashCode()
        {
            return ToString().GetHashCode();
        }
    }
}