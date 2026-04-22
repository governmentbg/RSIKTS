function UpdateUliciByNaselenoMqsto() {
    let model = {
        'naselenoMqstoId': $("#naselno-mqsto-select").val()
    };

    $.ajax({
        url: "/Ulici/Home/GetUliciByNaselenoMqsto",
        type: "GET",
        contentType: "application/json",
        data: model,
        success: function (data) {

            let ulicaSelectElem = $("#ulica-select");

            $("#ulica-select").html("");

            let ulicaHtml = "";
            for (let i = 0; i < data["ulici"].length; i++) {
                ulicaHtml += '<option value="' + data["ulici"][i].value + '">' + data["ulici"][i].text + '</option>';
            }
            ulicaSelectElem.html(ulicaHtml);
            ulicaSelectElem.selectpicker();
            ulicaSelectElem.selectpicker('refresh');
            ulicaSelectElem.selectpicker('render');
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

function AttachUlicaFilter() {
    $("#naselno-mqsto-select").change(UpdateUliciByNaselenoMqsto);
}

AttachUlicaFilter();