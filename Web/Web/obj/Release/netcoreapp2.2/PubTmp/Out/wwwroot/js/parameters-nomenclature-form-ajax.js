$("#nomenclature-edit-form").ajaxForm(
    {
        url: '/Parameters/Home/EditNomenclature',
        type: 'get',
        accepts: "json",
        contentType: "application/json",
        dataType: "json",
        success: function (data) {
            if (data["success"]) {
                $("#nomenclature-edit-modal").modal("hide");
                location.reload();
            }
            else {
                $("#nomenclature-edit-modal-body").html(data["editModalHTML"]);
                $("select").selectpicker();
            }
        },
        error: function (data) {
            console.log("Test");
        }
    });