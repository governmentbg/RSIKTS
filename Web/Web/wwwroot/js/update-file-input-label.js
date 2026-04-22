$('.custom-file-input').on('change', function (e) {
    var fileName = $(this).val();
    if (fileName === "") {
        $("#file-name-label").text("Изберете файл...");
    } else {
        $("#file-name-label").text(fileName.substring(fileName.lastIndexOf("\\") + 1, fileName.lenght));
    }

    parseExcel(e);

});