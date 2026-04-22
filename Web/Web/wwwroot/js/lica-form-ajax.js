
$("#lica-add-form").ajaxForm(
{
    url: '/Lica/Home/AddLica',
    type: 'get',
    accepts: "json",
    contentType: "application/json",
    dataType: "json",
    success: function (data) {
        if (data["success"]) {
            UpdatePagination(null, $("#pagination-current-page").val(), $("#egn-filter-hidden").val());
            $("#lica-add-modal-body").html("");
            $("#lica-add-modal-body").html(data["addModalHTML"]);
            showTab(currentTab);
            $("select").selectpicker();
            AttachUlicaFilter();
            document.getElementById("lica-add-form").reset();
            $("#lica-add-modal").modal("hide");
            $("#alerts-container").html('<div class="alert alert-success alert-dismissible fade show" role="alert"><strong>Успешно! </strong>Успешно е добавено лицето.<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>');
        }
        else {
            $("#lica-add-modal-body").html(data["addModalHTML"]);
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

$("#lica-edit-form").ajaxForm(
{
    url: '/Lica/Home/EditLica',
    type: 'get',
    accepts: "json",
    contentType: "application/json",
    dataType: "json",
    success: function (data) {
        if (data["success"]) {
            UpdatePagination(null, $("#pagination-current-page").val(), $("#egn-filter-hidden").val());
            $("#lica-edit-modal").modal("hide");
            $("#alerts-container").html('<div class="alert alert-success alert-dismissible fade show" role="alert"><strong>Успешно! </strong>Успешно е обновено лицето.<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>');

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
        console.log("Test");
    }
});