function UpdateNomenklatureEditModal(e, nomenklatureId, nomenklatureCode, id) {

    let nomenklatureEditModal = $("#nomenklature-edit-modal-body");
    let nomenklatureModalHeader = $('#nomenklature-edit-header');

    let model = {
        'NomenklatureId': nomenklatureId,
        'NomenklatureCode': nomenklatureCode,
        'Id': id
    };

    $.ajax({
        url: "/Spravki/Home/NomenklatureEdit",
        type: "GET",
        accepts: "json",
        contentType: "application/json",
        dataType: "json",
        data: model,
        success: function (data) {
            nomenklatureModalHeader.html("Номенклатура код - " + nomenklatureCode);

            if (nomenklatureCode === "") {
                nomenklatureModalHeader.html("Номенклатура код - " + id);
            }

            nomenklatureEditModal.html(data.nomenklatureEdiHtml);
            $("#Stoinost").change(function () {
                $("#Stoinost").val($("#Stoinost").val().replace(",", "."));
            });
            if ($("#Stoinost").length != 0)
                $("#Stoinost").val($("#Stoinost").val().replace(",", "."));
            $("#nomenklature-edit-modal").modal("show");
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

function UpdateNomenklatureAddModal(e, nomenklatureId) {

    let nomenklatureAddModal = $("#nomenklature-add-modal-body");

    let model = {
        'NomenklatureId': nomenklatureId
    };

    $.ajax({
        url: "/Spravki/Home/GetNomenklatureAdd",
        type: "GET",
        accepts: "json",
        contentType: "application/json",
        dataType: "json",
        data: model,
        success: function (data) {
            nomenklatureAddModal.html(data.nomenklatureAddHtml);
            $("#Stoinost").change(function () {
                $("#Stoinost").val($("#Stoinost").val().replace(",", "."));
            });
            if ($("#Stoinost").length != 0)
                $("#Stoinost").val($("#Stoinost").val().replace(",", "."));
            $("#nomenklature-add-modal").modal("show");
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

function DeleteNomenklaturePopup(e, nomenklatureId, nomenklatureCode, id) {

    $("#nomenklature-delete-nomenklatureId").val(nomenklatureId);
    $("#nomenklature-delete-code").val(nomenklatureCode);
    $("#nomenklature-delete-id").val(id);

    $("#nomenklature-delete-modal").modal("show");
}


function DeleteNomenklature(e) {

    let model = {
        'NomenklatureId': $("#nomenklature-delete-nomenklatureId").val(),
        'NomenklatureCode': $("#nomenklature-delete-code").val(),
        'Id': $("#nomenklature-delete-id").val()
    };

    $.ajax({
        url: "/Spravki/Home/NomenklatureDelete",
        type: "GET",
        contentType: "application/json",
        data: model,
        success: function () {
            UpdatePagination(e, $("#pagination-current-page").val(), $("#name-filter-hidden").val());
            $("#nomenklature-delete-modal").modal("hide");
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

