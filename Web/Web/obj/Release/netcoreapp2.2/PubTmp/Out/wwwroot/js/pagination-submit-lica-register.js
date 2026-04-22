function UpdatePagination(e, pageNumber, egnFilter) {

    $("#pagination-current-page").val(pageNumber);
    $("#egn-filter-hidden").val(egnFilter);

    let licaTable = $("#lica-table");
    let paginationContainer = $("#pagination-container");

    let model = {
        'CurrentPage': pageNumber,
        'EgnFilter': egnFilter,
        'Sik': $("#sik-hidden-input").val()
    };

    $.ajax({
        url: "/Lica/Home/GetLicaByPage",
        type: "GET",
        accepts: "json",
        contentType: "application/json",
        dataType: "json",
        data: model,
        success: function (data) {
            licaTable.html(data.usersTableHTML);
            paginationContainer.html(data.paginationHTML);
        },
        error: function (e) {
            Swal.fire({
                type: 'error',
                title: 'Грешка!',
                text: е.message,
                footer: '<p class="text-center">Открита е грешка!<br>Моля обърнете се към администратора на програмата.</p>'
            });
        }
    });
}

$("#egn-filter-input").keyup(function (e) {
    let egnFilterVal = $(this).val();

    if (egnFilterVal.length > 2) {
        $("#egn-filter-hidden").val(egnFilterVal);
        UpdatePagination(null, $("#pagination-current-page").val(), egnFilterVal);
    }
    else if (egnFilterVal.length <= 2) {
        $("#egn-filter-hidden").val(null);
        UpdatePagination(null, $("#pagination-current-page").val(), null);
    }  

});
