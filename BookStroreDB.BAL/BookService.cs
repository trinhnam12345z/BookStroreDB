using BookStroreDB.BAL.Interface;
using BookStroreDB.DAL.Interface;
using BookStroreDB.Domain.Reponse;
using BookStroreDB.Domain.Request;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace BookStroreDB.BAL
{
    public class BookService : IBookService
    {
        private readonly IBookRepository bookRepository;
        public BookService(IBookRepository bookRepository)
        {
            this.bookRepository = bookRepository;
        }

        public async Task<CreateBookResult> CreateBook(CreateBookRequest request)
        {
            return await bookRepository.CreateBook(request);
        }

        public async Task<DeleteBookResult> DeleteBook(DeleteBookRequest request)
        {
            return await bookRepository.DeleteBook(request);
        }
        public async Task<ShowBookResult> ShowBook(ShowBookRequest request)
        {
            return await bookRepository.ShowBook(request);
        }

        public async Task<IEnumerable<Book>> Gets()
        {
            return await bookRepository.Gets();
        }


    }
}
