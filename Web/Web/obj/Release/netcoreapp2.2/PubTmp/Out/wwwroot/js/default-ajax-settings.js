$.ajaxSetup({
    cache: false,
    beforeSend: function () {
        AttachLoader();
    },
    complete: function (xhr, stat) {
        RemoveLoader();
    }
});
$(".selectpicker").selectpicker();
BindPlaceHolderSelect();