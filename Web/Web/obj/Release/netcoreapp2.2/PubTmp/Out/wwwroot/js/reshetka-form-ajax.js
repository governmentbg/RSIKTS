$("#reshetka-edit-form").ajaxForm(
    {
        url: '/Kvoti/Home/EditReshetka',
        type: 'get',
        accepts: "json",
        contentType: "application/json",
        dataType: "json",
        success: function (data) {
            if (data["success"]) {
                $("#reshetka-edit-modal").modal("hide");
                $("#alerts-container").html('<div class="alert alert-success alert-dismissible fade show" role="alert"><strong>Успешно! </strong>Успешно бе обновяването!<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>');
                UpdateReshetkaTable();
            }
            else {
                $("#kvoti-edit-modal-body").html(data["editModalHTML"]);
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