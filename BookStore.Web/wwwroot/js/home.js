var home = {} || home;

home.tbBook = function () {
    $.ajax({
        url: 'https://localhost:44378/api/book/gets',
        method: 'GET',
        contentType: 'JSON',
        success: function (data) {
            $.each(data, function (i, v) {
                $('#tbBook>tbody').append(`<tr>
                                              <th scope="row">${v.bookId}</th>
                                              <td>${v.bookName}</td>
                                              <td>${v.author}</td>
                                              <td>${v.publisher}</td>
                                              <td>${v.publishYear}</td>
                                              <td>${v.price}</td>
                                           </tr>`);
            })

        }
    });
}
home.init = function () {  
    home.tbBook();
}

$(document).ready(function () {
    home.init();
});