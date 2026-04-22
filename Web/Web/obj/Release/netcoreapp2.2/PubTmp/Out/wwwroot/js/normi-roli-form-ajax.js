$("#normi-edit-form").ajaxForm(
    {
        url: '/Normi/Home/EditNormaRoli',
        type: 'get',
        accepts: "json",
        contentType: "application/json",
        dataType: "json",
        success: function (data) {
            if (data["success"]) {
                $("#normi-edit-modal").modal("hide");
                UpdateNormiRoliTable();
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