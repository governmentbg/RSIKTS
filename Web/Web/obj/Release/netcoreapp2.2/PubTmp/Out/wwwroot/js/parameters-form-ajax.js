

$("#parameters-edit-form").ajaxForm(
    {
        url: '/Parameters/Home/EditParameter',
        type: 'get',
        accepts: "json",
        contentType: "application/json",
        dataType: "json",
        success: function (data) {
            if (data["success"]) {
                $("#parameters-edit-modal").modal("hide");
                location.reload();
            }
            else {
                $("#parameters-edit-modal-body").html(data["editModalHTML"]);
            }
        },
        error: function (data) {
            console.log("Test");
        }
    });