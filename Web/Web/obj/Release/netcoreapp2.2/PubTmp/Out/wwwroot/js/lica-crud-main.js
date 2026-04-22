function UpdateLicaAddModal(e) {
    let model = {
        sik: $("#sik-hidden-input").val()
    };

    $.ajax({
        url: "/Lica/Home/GetLicaAdd",
        type: "GET",
        contentType: "application/json",
        data: model,
        success: function (data) {
            $("#lica-add-modal-body").html(data["addModalHTML"]);
            showTab(currentTab);
            $("select").selectpicker();
            AttachUlicaFilter();
            BindPlaceHolderSelect();
            AttachToggleForReplacementList();
            $("#lica-add-modal").modal("show");
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

function UpdateLiceEditModal(e, liceId) {
    let model = {
        'Id': liceId,
        'sik': $("#sik-hidden-input").val()
    };

    $.ajax({
        url: "/Lica/Home/GetLiceEdit",
        type: "GET",
        contentType: "application/json",
        data: model,
        success: function (data) {
            $("#lica-edit-modal-body").html(data["editModalHTML"]);
            showTab(currentTab);
            $("select").selectpicker();
            AttachUlicaFilter();
            BindPlaceHolderSelect();
            AttachToggleForReplacementList();
            $("#lica-edit-modal").modal("show");
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

function DeleteLicePopup(e, id) {
    $("#lice-delete-id").val(id);

    $("#lice-delete-modal").modal("show");
}

function DeleteLice(e) {

    let model = {
        'liceId': $("#lice-delete-id").val()
    };

    $.ajax({
        url: "/Lica/Home/DeleteLice",
        type: "GET",
        contentType: "application/json",
        data: model,
        success: function (data) {
            if (data.rezult === -1) 
                Swal.fire({
                    type: 'warning',
                    title: 'Внимание!',
                    text: $(data.responseText).find("span").html(),
                    footer: '<p class="text-center">Изтриването на лице от ТУР 1 – недопустимо!</p>'
                });
            else
                UpdatePagination(e, $("#pagination-current-page").val(), $("#egn-filter-hidden").val());
                $("#lice-delete-modal").modal("hide");
                $("#alerts-container").html('<div class="alert alert-success alert-dismissible fade show" role="alert"><strong>Успешно! </strong>Успешно e изтрито лицето.<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>');
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


$('#lica-edit-modal').on('hide.bs.modal', function (e) {

    $("#lica-edit-modal-body").html("");
    currentTab = 0;
});


$('#lica-add-modal').on('hide.bs.modal', function (e) {

    $("#lica-add-modal-body").html("");
    currentTab = 0;
});