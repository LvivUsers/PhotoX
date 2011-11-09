using System.Collections.Generic;
using System.Collections.ObjectModel;

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
    }
}