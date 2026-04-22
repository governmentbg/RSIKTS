function DeleteRaioniMainPopup(e, id) {
    $("#raioni-main-delete-id").val(id);

    $("#raioni-main-delete-modal").modal("show");
}


function DeleteRaioniMain(e) {

    let model = {
        'raionMainId': $("#raioni-main-delete-id").val()
    };

    $.ajax({
        url: "/Raioni/Home/DeleteRaionMain",
        type: "GET",
        contentType: "application/json",
        data: model,
        success: function (data) {
            UpdatePagination(e, $("#pagination-current-page").val(), $("#name-filter-hidden").val());
            $("#raioni-main-delete-modal").modal("hide");
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


function UpdateRaioniMainAddModal(e) {
    $.ajax({
        url: "/Raioni/Home/GetRaionAdd",
        type: "GET",
        contentType: "application/json",
        success: function (data) {
            $("#raioni-main-add-modal-body").html(data["addModalHTML"]);
            showTab(currentTab);
            $("select").selectpicker();
            AttachUlicaFilter();
            $("#raioni-main-add-modal").modal("show");
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

function UpdateRaionEditModal(e, nrec) {
    let model = {
        'nrec': nrec
    };

    $.ajax({
        url: "/Raioni/Home/GetRaionEdit",
        type: "GET",
        contentType: "application/json",
        data: model,
        success: function (data) {
            $("#raioni-main-edit-modal-body").html(data["editModalHTML"]);
            showTab(currentTab);
            $("select").selectpicker();
            AttachUlicaFilter();
            $("#raioni-main-edit-modal").modal("show");
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

$('#raioni-main-edit-modal').on('hide.bs.modal', function (e) {

    $("#raioni-main-edit-modal-body").html("");
    currentTab = 0;
});


$('#raioni-main-add-modal').on('hide.bs.modal', function (e) {

    $("#raioni-main-add-modal-body").html("");
    currentTab = 0;
});