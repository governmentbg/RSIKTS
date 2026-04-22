function UpdateLicaTable() {

    let model =
    {
        'sikId': $("#sik-select").val(),
        'resheniq': $("#reshenie-select option:selected").text(),
        'deinost': $("#deinost-select").val()
    };

    $.ajax({
        url: "/Lica/Home/GetDeinostiTablePartial",
        type: "GET",
        contentType: "application/json",
        data: model,
        success: function (data) {
            allLicaIds = [];
            licaIds = [];
            $("#lica-table").html(data["tableHTML"]);
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