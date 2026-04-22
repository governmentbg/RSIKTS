$("#nomenklature-edit-form").ajaxForm(
{
    url: '/Spravki/Home/EditNomenklatureBasic',
    type: 'get',
    accepts: "json",
    contentType: "application/json",
    dataType: "json",
    success: function (data) {
        if (data["success"]) {
            $("#nomenklature-edit-modal").modal("hide");
            UpdatePagination(null, $("#pagination-current-page").val(), $("#name-filter-hidden").val());
        }
        else {
            $("#nomenklature-edit-modal-body").html(data["editModalHTML"]);
            $("#Stoinost").change(function () {
                $("#Stoinost").val($("#Stoinost").val().replace(",", "."));
            });

            if ($("#Stoinost").length !== 0)
                $("#Stoinost").val($("#Stoinost").val().replace(",", "."));
        }
    },
    error: function (data) {
        console.log("Test");
    }
});

$("#nomenklature-add-form").ajaxForm(
    {
        url: '/Spravki/Home/AddNomenklature',
        type: 'get',
        accepts: "json",
        contentType: "application/json",
        dataType: "json",
        success: function (data) {
            if (data["success"]) {
                $("#nomenklature-add-modal").modal("hide");
                UpdatePagination(null, $("#pagination-current-page").val(), $("#name-filter-hidden").val());
            }
            else {
                $("#nomenklature-add-modal-body").html(data["addModalHTML"]);
                $("#Stoinost").change(function () {
                    $("#Stoinost").val($("#Stoinost").val().replace(",", "."));
                });

                if ($("#Stoinost").length !== 0)
                    $("#Stoinost").val($("#Stoinost").val().replace(",", "."));
            }
        },
        error: function (data) {
            console.log("Test");
        }
    });