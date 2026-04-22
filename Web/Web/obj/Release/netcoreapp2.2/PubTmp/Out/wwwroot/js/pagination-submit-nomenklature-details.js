function UpdatePagination(e, pageNumber, nameFilter) {

    $("#pagination-current-page").val(pageNumber);
    $("#name-filter-hidden").val(nameFilter);

    let nomenklatureTable = $("#nomenklature-table");
    let paginationContainer = $("#pagination-container");
    let nomenklatureId = $("#nomenklature-id").val();


    let model = {
        'NomenklatureId': nomenklatureId,
        'CurrentPage': pageNumber,
        'NameFilter': nameFilter 
    };

    $.ajax({
        url: "/Spravki/Home/GetNomenklatureDetails",
        type: "GET",
        accepts: "json",
        contentType: "application/json",
        dataType: "json",
        data: model,
        success: function (data) {
            nomenklatureTable.html(data.nomenklatureTableHTML);
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

$("#name-filter").keyup(function (e) {
    let nameFilter = $(this).val();

    if (nameFilter.length > 1) {
        $("#name-filter-hidden").val(nameFilter);
        UpdatePagination(null, $("#pagination-current-page").val(), nameFilter);
    }
    else if (nameFilter.length <= 1) {
        $("#name-filter-hidden").val(null);
        UpdatePagination(null, $("#pagination-current-page").val(), null);
    }  

});
