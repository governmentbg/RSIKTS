$("#korekcii-payment-form").ajaxForm(
{
    url: '/Obrabotki/Home/SetPaymentsCorrection',
    type: 'get',
    accepts: "json",
    contentType: "application/json",
    dataType: "json",
    success: function (data) {
        if (data["success"])
        {
            $("#korekcii-payment-modal").modal("hide");
            $("#alerts-container").html('<div class="alert alert-success alert-dismissible fade show" role="alert"><strong>Успешно! </strong>Успешно е направена корекцията.<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>');
        }
        else {
            Swal.fire({
                type: 'error',
                title: 'Грешка!',
                text: $(data.responseText).find("span").html(),
                footer: '<p class="text-center">Открита е грешка!<br>Моля обърнете се към администратора на програмата.</p>'
            });
        }
    },
    error: function (data) {
        Swal.fire({
            type: 'error',
            title: 'Грешка!',
            text: $(data.responseText).find("span").html(),
            footer: '<p class="text-center">Открита е грешка!<br>Моля обърнете се към администратора на програмата.</p>'
        });
    }
});

$("#lice-filter-form").ajaxForm(
{
    url: '/Obrabotki/Home/GetLicaByKorekciiPaymentFilter',
    type: 'get',
    accepts: "json",
    contentType: "application/json",
    dataType: "json",
    success: function (data) {
        if (data["success"]) {
            $("#lica-table-container").html(data["tableHTML"]);
        }
        else {
            $("#lica-edit-modal-body").html(data["editModalHTML"]);
            showTab(currentTab);
            $("select").selectpicker();
            BindPlaceHolderSelect();
            AttachUlicaFilter();
            AttachToggleForReplacementList();
            //UpdateRolqForZamestitel();
        }
    },
    error: function (data) {
        Swal.fire({
            type: 'error',
            title: 'Грешка!',
            text: $(data.responseText).find("span").html(),
            footer: '<p class="text-center">Открита е грешка!<br>Моля обърнете се към администратора на програмата.</p>'
        });
    }
});