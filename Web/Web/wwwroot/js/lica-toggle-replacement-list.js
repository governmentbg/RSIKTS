function AttachToggleForReplacementList() {
    $("#zamestitel-check").on("change", ToggleZamestitelSelect);
 //   $("#zamestiteli-select").on("change", UpdateRolqForZamestitel);
    $("#sik-select").on("change", UpdateLicaForZamestitel);
    $("#political-power").on("change", UpdateAllLicaForZamestitel);

    $("#vzaimen-zamestitel-check").on("change", ToggleZamestitelSelect);
//    $("#vzaimni-zamestiteli-select").on("change", UpdateRolqForZamestitel);

    ToggleZamestitelSelect();
}

function ToggleZamestitelSelect() {
    if ($("#zamestitel-check").is(":checked") === true) {
        $("#zamestiteli-select-container").show();
        $("#vzaimni-zamestiteli-select-container").hide();
        $("#rolq-select").attr('disabled', true);
        $("#rolq-select").selectpicker('refresh');
    }
    else
        if ($("#vzaimen-zamestitel-check").is(":checked") === true) {
        $("#zamestiteli-select-container").hide();
        $("#vzaimni-zamestiteli-select-container").show();
        $("#rolq-select").attr('disabled', true);
        $("#rolq-select").selectpicker('refresh');
    }
    else {
        $("#zamestiteli-select-container").hide();
        $("#vzaimni-zamestiteli-select-container").hide();
        $("#rolq-select").attr('disabled', false);
        $("#rolq-select").selectpicker('refresh');
    }
}

function UpdateLicaForZamestitel() {

    let model = {
        'sikId': $("#sik-select").val(),
        'silaId': $("#political-power").val(),
        'liceId': $("#lice-id").val()
    };

    $.ajax({
        url: "/Lica/Home/GetLicaBySikAndSila",
        type: "GET",
        contentType: "application/json",
        data: model,
        success: function (data) {
            $("#zamestiteli-select").html("");
            $(data["licaArray"]).each(function (i) {
                $("#zamestiteli-select").html('<option value="' + data["licaArray"][i].id + '">' + data["licaArray"][i].imena + '</options>' + $("#zamestiteli-select").html());
            });
            $("#zamestiteli-select").html("<option value=0 selected>Няма</option>" + $("#zamestiteli-select").html());
            $("#zamestiteli-select").selectpicker('refresh');
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

function UpdateRolqForZamestitel() {

    let model = {
        'liceId': $("#zamestiteli-select").val()
    };

    if (model.liceId > 0) {

        $.ajax({
            url: "/Lica/Home/GetLiceRolq",
            type: "GET",
            contentType: "application/json",
            data: model,
            success: function (data) {
                $('#rolq-select').selectpicker('val', data["rolqVal"]);
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
    else {
        $('#rolq-select').selectpicker('val', 0);
    }
}


function UpdateLicaForVzaimnoZamestitel() {

    let model = {
        'toa': $("#raion").val(),
        'silaId': $("#political-power").val(),
        'liceId': $("#lice-id").val()
    };

    $.ajax({
        url: "/Lica/Home/GetLicaByToaAndSila",
        type: "GET",
        contentType: "application/json",
        data: model,
        success: function (data) {
            $("#vzaimni-zamestiteli-select").html("");
            $(data["licaArray"]).each(function (i) {
                $("#vzaimni-zamestiteli-select").html('<option value="' + data["licaArray"][i].id + '">' + data["licaArray"][i].imena + '</options>' + $("#vzaimni-zamestiteli-select").html());
            });
            $("#vzaimni-zamestiteli-select").html("<option value=0 selected>Няма</option>" + $("#vzaimni-zamestiteli-select").html());
            $("#vzaimni-zamestiteli-select").selectpicker('refresh');
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

function UpdateAllLicaForZamestitel() {
    UpdateLicaForZamestitel();
    UpdateLicaForVzaimnoZamestitel();
}

