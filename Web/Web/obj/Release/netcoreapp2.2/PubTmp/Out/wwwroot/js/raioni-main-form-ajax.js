$("#raion-add-form").ajaxForm(
{
        url: '/Raioni/Home/AddRaion',
        type: 'get',
        accepts: "json",
        contentType: "application/json",
        dataType: "json",
        success: function (data) {
            if (data["success"]) {
                //UpdatePagination(null, $("#pagination-current-page").val(), $("#name-filter-hidden").val());
                $("#raioni-main-add-modal-body").html("");
                $("#raioni-main-add-modal-body").html(data["addModalHTML"]);
                showTab(currentTab);
                $("select").selectpicker();
                AttachUlicaFilter();
                document.getElementById("raion-add-form").reset();
                $("#raioni-main-add-modal").modal("hide");              
            }
            else {
                $("#raioni-main-add-modal-body").html(data["addModalHTML"]);
                showTab(currentTab);
                $("select").selectpicker();
                AttachUlicaFilter();
            }
        },
        error: function (data) {
            console.log("Test");
        }
    });

function AttachRaionEditFormAjax() {

    $("#raion-edit-form").ajaxForm(
        {
            url: '/Raioni/Home/EditRaion',
            type: 'get',
            accepts: "json",
            contentType: "application/json",
            dataType: "json",
            success: function (data) {
                if (data["success"]) {
                    //UpdatePagination(null, $("#pagination-current-page").val(), $("#name-filter-hidden").val());
                    $("#raioni-main-edit-modal").modal("hide");
                    $("#raion-edit-body").html(data["editModalHTML"]);
                    showTab(currentTab);
                    $("select").selectpicker();
                    AttachUlicaFilter();
                    AttachRaionEditFormAjax();
                    $("#alerts-container").html('<div class="alert alert-success alert-dismissible fade show" role="alert"><strong>Успешно! </strong>Успешно бе обновяването!<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>');

                }
                else {
                    $("#raion-edit-body").html(data["editModalHTML"]);
                    showTab(currentTab);
                    $("select").selectpicker();
                    AttachUlicaFilter();
                    AttachRaionEditFormAjax();
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
AttachRaionEditFormAjax();