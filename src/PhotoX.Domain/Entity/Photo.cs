using System;
using System.Text;

namespace PhotoX.Domain.Entity
{
    public class Photo : DomainEntity
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public DateTime Date { get; set; }
        public byte[] Image { get; set; }

        public string DoSomething1()
        {
            string s1 = "Hello 1";
            string result = null;

            foreach (var character in s1)
            {
                char a = character;
                char b = 'x';
                result += a + b;
            }

            return result;
        }

        public string DoSKLSDJKDJUISDHSDTYFSTYVJHDSFGHDF()
        {
            StringBuilder s1 = new  StringBuilder("Hello 1");
            string result;
            string s2 = s1.ToString();


            result = "12232";

            foreach (var character in s2)
            {
                char a = character;
                char y = 'p';
                char r = 'x';
                result += a + r;
            }

            return result;
        }
    }
}