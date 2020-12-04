using BookStroreDB.Domain.Reponse;
using BookStroreDB.Domain.Request;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace BookStroreDB.BAL.Interface
{
    public interface IBookService
    {
        Task<IEnumerable<Book>> Gets();
        Task<CreateBookResult> CreateBook(CreateBookRequest request);
        Task<DeleteBookResult> DeleteBook(DeleteBookRequest request);
        Task<ShowBookResult> ShowBook(ShowBookRequest request);
    }
}
