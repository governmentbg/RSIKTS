$(document).ready(function () {
   
    let incrementalStep = 0;
    let filledCount = 0;
    let licaCount = 0;
    let currentLice = 0;

    $.ajax({
        url: "/Lica/Home/GetLicaFromIzobryCount",
        type: "GET",
        accepts: "json",
        contentType: "application/json",
        dataType: "json",
        success: function (data) {
            incrementalStep = 100 / data["count"];
            licaCount = data["count"];
            $("#progress-bar-label").text("Извършено за 0 от " + data["count"]);
            $('#theprogressbar').attr("aria-valuemax", data["count"]);
            callForEachLicaNachislqvane();
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

    function callForEachLicaNachislqvane() {

        if (licaCount === 0) {
            window.setTimeout(RedirectBackToObrabotki, 1500);
        }

        for (let i = 0; i < licaCount; i++) {
            $.ajax({
                url: "/Lica/Home/NachislqvaneForLicaByIndex",
                type: "GET",
                accepts: "json",
                contentType: "application/json",
                dataType: "json",
                data: {liceIndex : i},
                success: function (data) {
                    if (data["success"]) {
                        filledCount = filledCount + incrementalStep;
                        $("#progress-bar-label").text("Извършено за " + (currentLice + 1) + " от " + licaCount);
                        $('#nachislqvane-progress-bar').attr("style", "width:" + filledCount + "%");
                        currentLice = currentLice + 1;
                        if ((currentLice === licaCount - 1) || licaCount === 1) {
                            window.setTimeout(RedirectBackToObrabotki, 1500);
                        }
                    }
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
    }

    function RedirectBackToObrabotki() {
        window.location.replace("/Obrabotki");
    }

});


