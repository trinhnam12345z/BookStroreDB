using BookStroreDB.Domain.Reponse;
using BookStroreDB.Domain.Request;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace BookStroreDB.DAL.Interface
{
   public interface IBookRepository
    {
        Task<IEnumerable<Book>> Gets();
        Task<CreateBookResult> CreateBook(CreateBookRequest request);
        Task<DeleteBookResult> DeleteBook(DeleteBookRequest request);
        Task<ShowBookResult> ShowBook(ShowBookRequest request);
    }
}
