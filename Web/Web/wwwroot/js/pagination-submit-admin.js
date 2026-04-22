function UpdatePagination(e, pageNumber, userRoleFilter, usernameFilter) {

    $("#pagination-current-page").val(pageNumber);
    $("#pagination-user-role-filter").val(userRoleFilter);

    let usersTable = $("#users-table");
    let paginationContainer = $("#pagination-container");
    let userFilters = $("#user-filters");

    let model = {
        'CurrentPage': pageNumber, 'UserRoleFilter': userRoleFilter, 'UsernameFilter': usernameFilter
    };


    $.ajax({
        url: "/Admin/Home/GetUsersByPageAndRole",
        type: "GET",
        accepts: "json",
        contentType: "application/json",
        dataType: "json",
        data: model,    
        success: function (data) {
            console.log(data);
            usersTable.html(data.usersTableHTML);
            paginationContainer.html(data.paginationHTML);
            userFilters.html(data.userFiltersHTML);
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

$("#admin-user-filter").keyup(function (e) {
    let egnFilterVal = $(this).val();

    if (egnFilterVal.length > 2) {
        //$("#egn-filter-hidden").val(egnFilterVal);
        UpdatePagination(null, $("#pagination-current-page").val(), $("#pagination-user-role-filter").val(), egnFilterVal);
    }
    else if (egnFilterVal.length <= 2) {
        //$("#egn-filter-hidden").val(null);
        UpdatePagination(null, $("#pagination-current-page").val(), $("#pagination-user-role-filter").val(), null);
    }

});