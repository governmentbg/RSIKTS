$("#normi-edit-form").ajaxForm(
    {
        url: '/Normi/Home/EditNorma',
        type: 'get',
        accepts: "json",
        contentType: "application/json",
        dataType: "json",
        success: function (data) {
            if (data["success"]) {
                $("#normi-edit-modal").modal("hide");
                UpdateNormaTable();
            }
            else {
                $("#normi-edit-modal-body").html(data["editModalHTML"]);
                $("select").selectpicker();
            }
        },
        error: function (data) {
            console.log("Test");
        }
    });