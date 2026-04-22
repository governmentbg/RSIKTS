using System;
using System.Collections.Generic;
using System.Text;

namespace Common.Exceptions.Sik
{
    public class DeleteSikException : Exception
    {
        public DeleteSikException()
        {

        }

        public DeleteSikException(string message) : base(message)
        {
            
        }
    }
}
