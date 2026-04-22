using System;
using System.Collections.Generic;
using System.Text;

namespace Common.Exceptions.Lica
{
    public class ImportLiceException : Exception
    {
        public ImportLiceException()
        {

        }

        public ImportLiceException(string name)
            : base(name)
        {

        }
    }
}
