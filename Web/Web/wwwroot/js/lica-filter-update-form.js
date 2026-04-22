$("#lice-filter-form").ajaxForm(
    {
        url: '/Lica/Home/GetLicaByFilterForEdit',
        type: 'get',
        accepts: "json",
        contentType: "application/json",
        dataType: "json",
        success: function (data) {
            console.log("test");
            if (data["success"]) {
                //UpdatePagination(null, $("#pagination-current-page").val(), $("#egn-filter-hidden").val());
                //$("#lica-edit-modal").modal("hide");
                //$("#alerts-container").html('<div class="alert alert-success alert-dismissible fade show" role="alert"><strong>Успешно! </strong>Успешно е обновено лицето.<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>');
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