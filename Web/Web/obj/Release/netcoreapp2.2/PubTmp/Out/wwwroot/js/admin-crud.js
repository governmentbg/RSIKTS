function UpdateAdminEditModal(e, userId) {

    let adminEditModal = $("#admin-edit-modal-body");

    let model = {
        'Id': userId
    };

    $.ajax({
        url: "/Admin/Home/EditUser",
        type: "GET",
        accepts: "json",
        contentType: "application/json",
        dataType: "json",
        data: model,
        success: function (data) {
            document.getElementById("admin-edit-modal-body").innerHTML = data["userEditHtml"];
            //$("#admin-edit-modal-body").html(data["userEditHtml"]);
            AttachUserRegisterFormShow();
            $("select").selectpicker();
            //AttachUlicaFilter();
            $("#admin-edit-modal").modal("show");
        },
        error: function (e) {
            Swal.fire({
                type: 'error',
                title: 'Грешка!',
                text: $(data.responseText).find("span").html(),
                footer: '<p class="text-center">Открита е грешка!<br>Моля обърнете се към администратора на програмата.</p>'
            });
        }
    });
}

function DeleteUserPopup(e, id) {
    $("#user-delete-id").val(id);

    $("#admin-delete-modal").modal("show");
}

function DeleteUser(e) {

    let model = {
        'userId': $("#user-delete-id").val()
    };

    $.ajax({
        url: "/Admin/Home/DeleteUser",
        type: "GET",
        contentType: "application/json",
        data: model,
        success: function (data) {
            UpdatePagination(e,
                $("#pagination-current-page").val(),
                $("#user-filters").val(),
                $("#admin-user-filter").val());

            $("#admin-delete-modal").modal("hide");
        },
        error: function (e) {
            Swal.fire({
                type: 'error',
                title: 'Грешка!',
                text: $(data.responseText).find("span").html(),
                footer: '<p class="text-center">Открита е грешка!<br>Моля обърнете се към администратора на програмата.</p>'
            });
        }
    });
}