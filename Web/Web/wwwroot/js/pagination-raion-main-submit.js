function UpdatePagination(e, pageNumber, toaIdFilter) {

    $("#pagination-current-page").val(pageNumber);
    $("#name-filter-hidden").val(toaIdFilter);

    let nomenklatureTable = $("#raioni-main-table");
    let paginationContainer = $("#pagination-container");

    let model = {
        'CurrentPage': pageNumber,
        'ToaIdFilter': toaIdFilter
    };

    $.ajax({
        url: "/Raioni/Home/GetRaioniMainByPageAndUser",
        type: "GET",
        accepts: "json",
        contentType: "application/json",
        dataType: "json",
        data: model,
        success: function (data) {
            nomenklatureTable.html(data.raioniMainTableHTML);
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

$("#toa-id-filter").keyup(function (e) {
    let toaIdFilter = $(this).val();

    if (toaIdFilter.length > 1) {
        $("#toa-id-filter-hidden").val(toaIdFilter);
        UpdatePagination(null, $("#pagination-current-page").val(), toaIdFilter);
    }
    else if (toaIdFilter.length <= 1) {
        $("#toa-id-filter-hidden").val(null);
        UpdatePagination(null, $("#pagination-current-page").val(), null);
    }

});

