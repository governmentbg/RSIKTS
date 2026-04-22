function UpdateNormaTable() {
    var tur = 1;
    if (document.getElementById("tur-type"))
        tur = $("#tur-type").val();

    let model = {
        'vid': $("#norma-name").val(),
        'tur': tur
    };

    $.ajax({
        url: "/Normi/Home/GetNormaTable",
        type: "GET",
        contentType: "application/json",
        data: model,
        success: function (data) {
            $("#normi-table").html(data["tableHTML"]);
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

function UpdateCodePositionEditModal(e, normaId) {
    var tur = 1;
    if (document.getElementById("tur-type"))
        tur = $("#tur-type").val();

    let model = {
        'normaId': normaId,
        'tur': tur
    };

    $.ajax({
        url: "/Normi/Home/GetNormaEdit",
        type: "GET",
        contentType: "application/json",
        data: model,
        success: function (data) {
            $("#normi-edit-modal-body").html(data["editModalHTML"]);
            $("#normi-edit-modal").modal("show");
            $("#Money").change(function () {
                $("#Money").val($("#Money").val().replace(",", "."));
            });
            $("#Money").val($("#Money").val().replace(",", "."));
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

$('#tur-type').on('change', function (e) {
    UpdateNormaTable();
});