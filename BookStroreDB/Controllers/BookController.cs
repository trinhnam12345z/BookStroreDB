using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using BookStroreDB.BAL.Interface;
using BookStroreDB.Domain.Request;
using Microsoft.AspNetCore.Mvc;

namespace BookStroreDB.API.Controllers
{
    [ApiController]
    public class BookController : Controller
    {
        private readonly IBookService bookService;

        public BookController(IBookService bookService)
        {
            this.bookService = bookService;
        }
        [HttpGet]
        [Route("/api/book/gets")]
        public async Task<OkObjectResult> Gets()
        {
            return Ok(await bookService.Gets());
        }
        [HttpPost]
        [Route("/api/category/create")]
        public async Task<OkObjectResult> Create(CreateBookRequest request)
        {
            return Ok(await bookService.CreateBook(request));
        }
        [HttpPost]
        [Route("/api/category/delete")]
        public async Task<OkObjectResult> Delete(DeleteBookRequest request)
        {
            return Ok(await bookService.DeleteBook(request));
        }
        [HttpPost]
        [Route("/api/category/showbook")]
        public async Task<OkObjectResult> ShowBook(ShowBookRequest request)
        {
            return Ok(await bookService.ShowBook(request));
        }
    }
}
