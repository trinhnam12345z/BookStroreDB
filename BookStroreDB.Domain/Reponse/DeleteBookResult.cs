using System;
using System.Collections.Generic;
using System.Text;

namespace BookStroreDB.Domain.Reponse
{
    public class DeleteBookResult
    {
        public int BookId { get; set; }
        public string Message { get; set; }
    }
}
