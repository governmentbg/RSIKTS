
function SetPaymentCorrection(e, liceId) {
    let model = {
        'pIdLice': liceId
    };

    $.ajax({
        url: "/Obrabotki/Home/GetPayments4Correction",
        type: "GET",
        contentType: "application/json",
        data: model,
        success: function (data) {
            $("#korekcii-payment-modal-body").html(data["paymentTableHTML"]);
            $("#korekcii-payment-modal").modal("show");
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
