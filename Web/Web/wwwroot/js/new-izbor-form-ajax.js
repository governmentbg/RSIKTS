function BindIzboriFormAjax() {

    if ($("#Tip").val() != undefined) {

        $.ajax({
            url: "/Admin/Home/GetMaxIzborTur",
            data: { izborNkod: $("#Tip").val() }
        })
            .done(function (maxTurs) {
                if (maxTurs == 1) {
                    $("#DateTur2Group").hide();
                    document.getElementById("lbldatetur1").innerHTML = "Дата на изборите";
                }
                else {
                    $("#DateTur2Group").show();
                    document.getElementById("lbldatetur1").innerHTML = "Дата на тур 1";
                }
            });
    }

    $("#Tip").change(function () {
        $.ajax({
            url: "/Admin/Home/GetMaxIzborTur",
            data: { izborNkod: $(this).val() }
        })
        .done(function (maxTurs) {
            if (maxTurs === 1) {
                $("#DateTur2Group").hide();
                document.getElementById("lbldatetur1").innerHTML = "Дата на изборите";
            }
            else {
                $("#DateTur2Group").show();
                document.getElementById("lbldatetur1").innerHTML  = "Дата на тур 1";
            }
        });

    });

    $("#new-izbor-form").ajaxForm(
        {
            url: '/Obrabotki/Home/ResolveNewIzborOption',
            type: 'get',
            accepts: "json",
            contentType: "application/json",
            dataType: "json",
            success: function (data) {
                if (data["success"]) {
                    //$("#admin-options-body").html("");
                    //$("#admin-options-body").html(data["formHTML"]);
                    $("select").selectpicker();
                    document.getElementById("new-izbor-form").reset();
                    $("#admin-options-modal").modal("hide");
                    $("#alerts-container").html('<div class="alert alert-success alert-dismissible fade show" role="alert"><strong>Успешно! </strong>Успешно е изпълнена операцията.<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>');
                    BindIzboriFormAjax();
                    location.reload();
                }
                else {
                    $("#admin-options-body").html("");
                    $("#admin-options-body").html(data["formHtml"]);
                    if ($('#new-izbor-radio').is(':checked')) {
                        ShowIzboriForm();
                    }
                    $("select").selectpicker();
                    BindIzboriFormAjax();
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
}

BindIzboriFormAjax();