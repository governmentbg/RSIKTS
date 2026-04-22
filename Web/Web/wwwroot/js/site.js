// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.

function BindPlaceHolderSelect() {

    $(".required-select .filter-option-inner-inner").each(function (i) {
        if ($(this).text() === "Няма") {
            $(this).html('<span class="text-danger">*</span>' + $(this).html());
        }
    });


    $(".required-select .filter-option-inner-inner").on('DOMSubtreeModified', function () {
        if ($(this).text() === "Няма") {
            $(this).html('<span class="text-danger">*</span>' + $(this).html());
        }
    });
}

$(".close").on("click", function (index) {
    $(".alert").each(function () {
        $(this).remove();
    });
});
