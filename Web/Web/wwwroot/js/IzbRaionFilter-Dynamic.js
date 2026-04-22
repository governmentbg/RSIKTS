$("#izbraion-select").change(function () {

    let model = {
        'Nkod' : $(this).val()
    };

    $.ajax({
        url: "/Raioni/Home/GetAdmninistrativniRaioniByIzbRaion",
        type: "GET",
        contentType: "application/json",
        data: model,
        success: function (data) {

            $("#izbraion-raion-select").html('<option value="">Всички</option>');

            $(data["allRaioni"]).each(function (i, raion) {
                $("#izbraion-raion-select").html($("#izbraion-raion-select").html() + '<option value="' + raion["nkod"] + '">' + raion["nime"] + '</option>');
            });

            $("#izbraion-raion-select").selectpicker('refresh');
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
});

$("#izbraion-raion-select").change(function () {

    let model = {
        'Nkod': $(this).val()
    };

    $.ajax({
        url: "/Sik/Home/GetSiksByAdministrativenRaion",
        type: "GET",
        contentType: "application/json",
        data: model,
        success: function (data) {

            $("#izbraion-sik-select").html('');

            $(data["allSiks"]).each(function (i, sik) {
                $("#izbraion-sik-select").html($("#izbraion-sik-select").html() + '<option value="' + sik["idSek"] + '">' + sik["id"] + ' | ' + sik["address"] + '</option>');
            });

            $("#izbraion-sik-select").selectpicker('refresh');
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
    
});