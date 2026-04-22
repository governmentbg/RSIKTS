function UpdateSikAddModal(e) {
    $.ajax({
        url: "/Sik/Home/GetSikAdd",
        type: "GET",
        contentType: "application/json",
        success: function (data) {
            $("#sik-add-modal-body").html(data["addModalHTML"]);
            showTab(currentTab);
            $("select").selectpicker();
            AttachUlicaFilter();
            BindPlaceHolderSelect();
            $("#sik-add-modal").modal("show");

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

function UpdateSikDeleteModal(e) {
    let model = {
        'raionMainId': $("#sik-delete-id").val()
    };

    $.ajax({
        url: "/Sik/Home/DeleteSik",
        type: "GET",
        contentType: "application/json",
        data: model,
        success: function (data) {
            UpdatePagination(e, $("#pagination-current-page").val(), $("#sik-filter-hidden").val());
            $("#sik-delete-modal").modal("hide");
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

function UpdateSikEditModal(e, sikId) {
    let model = {
        'sikId': sikId
    };

    $.ajax({
        url: "/Sik/Home/GetSikEdit",
        type: "GET",
        contentType: "application/json",
        data: model,
        success: function (data) {
            $("#sik-edit-modal-body").html(data["editModalHTML"]);
            showTab(currentTab);
            AttachUlicaFilter();
            $("select").selectpicker();
            BindPlaceHolderSelect();
            $("#sik-edit-modal").modal("show");
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

function DeleteSik(e) {

    let model = {
        'sikId': $("#sik-delete-id").val()
    };

    $.ajax({
        url: "/Sik/Home/DeleteSik",
        type: "GET",
        contentType: "application/json",
        data: model,
        success: function (data) {
            console.log(data["success"]);
            if (data["success"]) {
                UpdatePagination(e, $("#pagination-current-page").val(), $("#sik-filter-hidden").val());
                $("#sik-delete-modal").modal("hide");
                $("#alerts-container").html('<div class="alert alert-success alert-dismissible fade show" role="alert"><strong>Успешно! </strong>Успешно е деактивирана секцията.<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>');
            }
            else if (!data["success"]) {
                $("#sik-delete-modal").modal("hide");
                $("#alerts-container").html('<div class="alert alert-danger alert-dismissible fade show" role="alert"><strong>Неуспешно! </strong>' + data["errorMessage"] + '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>');
            }
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


function UpdatePagination(e, pageNumber, sikFilter) {

    $("#pagination-current-page").val(pageNumber);
    $("#sik-filter-hidden").val(sikFilter);

    let sikTable = $("#sik-table");
    let paginationContainer = $("#pagination-container");

    let model = {
        'CurrentPage': pageNumber,
        'SikFilter': sikFilter
    };

    $.ajax({
        url: "/Sik/Home/GetSikByPage",
        type: "GET",
        accepts: "json",
        contentType: "application/json",
        dataType: "json",
        data: model,
        success: function (data) {
            sikTable.html(data.sikTableHTML);
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

$("#sik-filter-input").keyup(function (e) {
    let sikFilterVal = $(this).val();

    if (sikFilterVal.length > 0) {
        $("#sik-filter-hidden").val(sikFilterVal);
        UpdatePagination(null, $("#pagination-current-page").val(), sikFilterVal);
    }
    else if (sikFilterVal.length <= 0) {
        $("#sik-filter-hidden").val(null);
        UpdatePagination(null, $("#pagination-current-page").val(), null);
    }

});

function DeleteSikPopup(e, id) {
    $("#sik-delete-id").val(id);

    $("#sik-delete-modal").modal("show");
}

$('#sik-edit-modal').on('hide.bs.modal', function (e) {

    $("#sik-edit-modal-body").html("");
    currentTab = 0;
});


$('#sik-add-modal').on('hide.bs.modal', function (e) {

    $("#sik-add-modal-body").html("");
    currentTab = 0;
});