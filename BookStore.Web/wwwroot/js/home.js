var home = {} || home;

home.tbBook = function () {
    $.ajax({
        url: 'https://localhost:44378/api/book/gets',
        method: 'GET',
        contentType: 'JSON',
        success: function (data) {
            $.each(data, function (i, v) {
                $('#tbBook>tbody').append(`<tr>
                                              <th scope="row">${v.BookId}</th>
                                              <td>${v.BookName}</td>
                                              <td>${v.Author}</td>
                                              <td>${v.Publisher}</td>
                                              <td>${v.PublishYear}</td>
                                              <td>${v.Price}</td>
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