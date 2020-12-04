using BookStroreDB.DAL.Interface;
using BookStroreDB.Domain.Reponse;
using BookStroreDB.Domain.Request;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Threading.Tasks;

namespace BookStroreDB.DAL
{
    public class BookRepository : BaseRepository, IBookRepository
    {
        public async Task<CreateBookResult> CreateBook(CreateBookRequest request)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@BookName", request.BookName);
                parameters.Add("@Author", request.Author);
                parameters.Add("@Publisher ", request.Publisher);
                parameters.Add("@PublishYear", request.PublishYear);
                parameters.Add("@Price", request.Price);
                return await SqlMapper.QueryFirstOrDefaultAsync<CreateBookResult>(cnn: connect,
                                                    sql: "sp_CreateBook",
                                                    param: parameters,
                                                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        public async Task<DeleteBookResult> DeleteBook(DeleteBookRequest request)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@BookId", request.BookId);
                return await SqlMapper.QueryFirstOrDefaultAsync<DeleteBookResult>(cnn: connect,
                                                    sql: "sp_DeleteBook",
                                                    param: parameters,
                                                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        public async Task<ShowBookResult> ShowBook(ShowBookRequest request)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@BookId", request.BookId);
                return await SqlMapper.QueryFirstOrDefaultAsync<ShowBookResult>(cnn: connect,
                                                    sql: "sp_ShowBooks",
                                                    param: parameters,
                                                    commandType: CommandType.StoredProcedure);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        public async Task<IEnumerable<Book>> Gets()
        {
            return await SqlMapper.QueryAsync<Book>(cnn: connect,
                                                sql: "sp_GetBooks",
                                                commandType: CommandType.StoredProcedure);
        }

       
    }
}
