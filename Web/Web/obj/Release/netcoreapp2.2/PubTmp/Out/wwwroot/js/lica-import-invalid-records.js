function UpdateInvalidRecordsTable() {
    $.ajax({
        url: "/Lica/Home/GetWrongImportLicaForUser",
        type: "POST",
        contentType: "application/json",
        success: function (data) {
            $("#lica-import-table-body").html("");
            $(data["licaArray"]).each(function (i, lice) {
                //console.log(lice);
                let tableRowString = "  <tr>           <td><span>"
                    .concat(lice.egn, "</span></td>    <td>")
                    .concat(lice.ime1, "</td>          <td>")
                    .concat(lice.ime2, "</td>          <td>")
                    .concat(lice.ime3, "</td>          <td>")
                    .concat(lice.sikNomer, "</td>      <td>")
                    .concat(lice.dlujnost, "</td>      <td>")
                    .concat(lice.obrazovanie, "</td>   <td>")
                    .concat(lice.specialnost, "</td>   <td>")
                    .concat(lice.telephone, "</td>     <td>")
                    .concat(lice.opisanie, "</td> <td class=\"")
                    .concat(lice.status === 2 ? "orange" : "red", "\"> ")
                    .concat(lice.status === 2 ? "Невалиден" :"Отхвърлен", "</td> </tr>");

                $("#lica-import-table-body").html($("#lica-import-table-body").html() + tableRowString);
            });

            $("#lice-import-modal").modal("show");
        },
        error: function () {
            Swal.fire({
                type: 'error',
                title: 'Грешка!',
                text: 'Грешка при обработване на данните.',
                footer: '<p class="text-center">Открита е грешка!<br>Моля обърнете се към администратора на програмата.</p>'
            });
        }
    });

}