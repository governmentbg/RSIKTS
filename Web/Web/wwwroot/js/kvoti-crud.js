function UpdateKvotiEditModal(e, kvotaId, partiqName) {
    let model = {
        'silaId': kvotaId
    };

    $.ajax({
        url: "/Kvoti/Home/GetKvotiEdit",
        type: "GET",
        contentType: "application/json",
        data: model,
        success: function (data) {
            $("#kvoti-edit-modal-header").html("Редактиране - " + partiqName);
            $("#kvoti-edit-modal-body").html(data["editModalHTML"]);
            $("#kvoti-edit-modal").modal("show");
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

function UpdateKvotiTable() {
    $.ajax({
        url: "/Kvoti/Home/GetKvotiTable",
        type: "GET",
        contentType: "application/json",
        success: function (data) {
            $("#kvoti-table").html(data["kvotiTableHTML"]);
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