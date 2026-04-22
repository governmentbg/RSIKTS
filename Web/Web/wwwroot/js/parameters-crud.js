function UpdateParametersEditModal(e, parameterKod) {
    let model = {
        'Kod': parameterKod
    };

    $.ajax({
        url: "/Parameters/Home/GetParameterEdit",
        type: "GET",
        contentType: "application/json",
        data: model,
        success: function (data) {
            $("#parameters-edit-modal-body").html(data["editModalHTML"]);
            $("#parameters-edit-modal").modal("show");
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

function UpdateIzbRajonParametersEditModal(e, parameterKod) {
    let model = {
        'kod': parameterKod
    };

    $.ajax({
        url: "/Parameters/Home/GetIzbRajonParameterEdit",
        type: "GET",
        contentType: "application/json",
        data: model,
        success: function (data) {
            $("#parameters-edit-modal-body").html(data["editModalHTML"]);
            $("#parameters-edit-modal").modal("show");
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

//v.2
function UpdateNomenlaturesEditModal(e, parameterKod) {
    let model = {
        'Id': parameterKod
    };

    $.ajax({
        url: "/Parameters/Home/GetNomenlatureEdit",
        type: "GET",
        contentType: "application/json",
        data: model,
        success: function (data) {
            $("#nomenclature-edit-modal-body").html(data["editModalHTML"]);
            $("select").selectpicker();
            $("#nomenclatures-edit-modal").modal("show");
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

