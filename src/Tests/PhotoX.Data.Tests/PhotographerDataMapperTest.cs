using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NUnit.Framework;
using PhotoX.Data.AdoImplementation;
using PhotoX.Data.Interfaces;

namespace PhotoX.Data.Tests
{
    [TestFixture]
    public class PhotographerDataMapperTest: BaseTest
    {

        private IPhotographerDataMapper mapper;

        [TestFixtureSetUp]
        public override void Init()
        {
            base.Init();
            mapper = new PhotographerDataMapper(GetConnectionString());
        }
        [Test]
        public void GetAll_ReturnsSomeData()
        {
            var photographers = mapper.GetAll();
            Assert.GreaterOrEqual(photographers.Count(), 1);
        }
    }
}
