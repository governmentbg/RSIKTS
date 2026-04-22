FileReader.prototype.readAsBinaryString = function (fileData) {
    var binary = "";
    var pt = this;
    var reader = new FileReader();
    reader.onload = function (e) {
        var bytes = new Uint8Array(reader.result);
        var length = bytes.byteLength;
        for (var i = 0; i < length; i++) {
            binary += String.fromCharCode(bytes[i]);
        }
        //pt.result  - readonly so assign binary
        pt.content = binary;
        $(pt).trigger('onload');
    };
    reader.readAsArrayBuffer(fileData);
};


function _instanceof(left, right) { if (right != null && typeof Symbol !== "undefined" && right[Symbol.hasInstance]) { return right[Symbol.hasInstance](left); } else { return left instanceof right; } }

function _classCallCheck(instance, Constructor) { if (!_instanceof(instance, Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var Lice = function Lice(egn, ime1, ime2, ime3, sikNomer, dlujnost, obrazovanie, specialnost, telefon, pas1) {
    _classCallCheck(this, Lice);

    this.Egn = egn + "";
    this.Ime1 = ime1;
    this.Ime2 = ime2;
    this.Ime3 = ime3;
    this.SikNomer = sikNomer;
    this.Dlujnost = dlujnost;
    this.Obrazovanie = obrazovanie;
    this.Specialnost = specialnost;
    this.Telephone = telefon;
    this.pas1 = pas1;
};
let lica = [];

parseExcel = function (file) {
    lica = [];
    file = document.getElementById("exampleInputFile").files[0];
    var reader = new FileReader();
   
    reader.onload = function (e) {
        $("#lica-table-body").html("");

        var data = reader.content;
        var workbook = XLSX.read(data, {
            type: 'binary'
        });
        
        var firstSheet = workbook.SheetNames[0];

        // Here is your object
        var sheet = workbook.Sheets[firstSheet];

        if (sheet["L5"] != undefined && sheet["L5"].v == "###") {
            var rowCounter = 6;

            while (sheet["A" + rowCounter] != undefined ||
                sheet["B" + rowCounter] != undefined ||
                sheet["C" + rowCounter] != undefined ||
                sheet["D" + rowCounter] != undefined ||
                sheet["E" + rowCounter] != undefined ||
                sheet["F" + rowCounter] != undefined ||
                sheet["G" + rowCounter] != undefined ||
                sheet["H" + rowCounter] != undefined ||
                sheet["I" + rowCounter] != undefined ||
                sheet["J" + rowCounter] != undefined
            ) {

                let lice = new Lice(sheet["A" + rowCounter] === undefined ? "" : sheet["A" + rowCounter].v,
                    sheet["B" + rowCounter] === undefined ? "" : sheet["B" + rowCounter].v,
                    sheet["C" + rowCounter] === undefined ? "" : sheet["C" + rowCounter].v,
                    sheet["D" + rowCounter] === undefined ? "" : sheet["D" + rowCounter].v,
                    sheet["E" + rowCounter] === undefined ? "" : sheet["E" + rowCounter].v,
                    sheet["F" + rowCounter] === undefined ? "" : sheet["F" + rowCounter].v,
                    sheet["G" + rowCounter] === undefined ? "" : sheet["G" + rowCounter].v,
                    sheet["H" + rowCounter] === undefined ? "" : sheet["H" + rowCounter].v,
                    sheet["I" + rowCounter] === undefined ? "" : sheet["I" + rowCounter].v,
                    sheet["J" + rowCounter] === undefined ? "" : sheet["J" + rowCounter].v
                );

                lica.push(lice);
                rowCounter = rowCounter + 1;
            }

            $(lica).each(function (i, lice) {
                let tableRowString =            "<tr><td data-title=\"\u0415\u0413\u041D\"><span>"
                    .concat(lice.Egn,           "</span></td><td data-title=\"\u0418\u043C\u0435\">")
                    .concat(lice.Ime1,          "</td><td data-title=\"\u041F\u0440\u0435\u0437\u0438\u043C\u0435\">")
                    .concat(lice.Ime2,          "</td><td data-title=\"\u0424\u0430\u043C\u0438\u043B\u0438\u044F\">")
                    .concat(lice.Ime3,          "</td><td data-title=\"\u0421\u0418\u041A \u041D\u043E\u043C\u0435\u0440\">")
                    .concat(lice.SikNomer,      "</td><td data-title=\"\u0414\u043B\u044A\u0436\u043D\u043E\u0441\u0442\">")
                    .concat(lice.Dlujnost,      "</td><td data-title=\"\u041E\u0431\u0440\u0430\u0437\u043E\u0432\u0430\u043D\u0438\u0435\">")
                    .concat(lice.Obrazovanie,   "</td><td data-title=\"\u0421\u043F\u0435\u0446\u0438\u0430\u043B\u043D\u043E\u0441\u0442\">")
                    .concat(lice.Specialnost,   "</td><td data-title=\"\u0422\u0435\u043B\u0435\u0444\u043E\u043D\">")
                    .concat(lice.Telephone,     "</td></tr>");

                $("#lica-table-body").html($("#lica-table-body").html() + tableRowString);
            });

            reader.content = "";
        } else {
            Swal.fire({
                type: 'error',
                title: 'Грешка!',
                text: 'Неразпознат формат на файла за импорт!',
                footer: ''
            });
        }
    };

    reader.onerror = function (ex) {
        console.log(ex);
    };

    reader.readAsBinaryString(file);
};
