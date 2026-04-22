$("#administrativen-raion-select").change(function () {

    let model = {
        administrativenRaion: $("#administrativen-raion-select").val()
    };

    $.ajax({
        url: "/Home/UpdateUserAdministrativenRaion",
        type: "GET",
        accepts: "json",
        contentType: "application/json",
        dataType: "json",
        data: model,
        success: function (data) {
            if (location.pathname == '/Lica/Home/RegisterBySik') {
                window.location.href = location.origin+'/Sik/Home/Register'
            } else
                location.reload();
        }
    });
});

