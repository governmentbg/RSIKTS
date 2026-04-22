function SendLicaToImport() {    
    var model = {
        PoliticheskaSila: $("#political-power").find(":selected").val(),
        allLica: lica,
        file: $("#exampleInputFile").val()
    };

    if (lica.length > 0){

        if(model.PoliticheskaSila > 0) {

            AttachLoader();

            $.ajax({
                url: "/Lica/Home/ParseLica",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(model),
                success: function (data) {
                    RemoveLoader();
                    $("#lica-table-body").html("");
                    if (data["hasWrongRecords"]) {
                        $("#alerts-container")
                            .html('<div class="alert alert-danger alert-dismissible fade show" role="alert"> ' +
                                data["impMessage"] +
                                ' <button class="btn btn-danger ml-4" onclick="UpdateInvalidRecordsTable();">Покажи невалидни/отхвърлени</button> '+
                                ' <button class="close" type="button" data-dismiss="alert" aria-label="Close" > ' +
                                ' <span aria-hidden="true">&times;</span></button ></div>');
                    }
                    else {
                        $("#alerts-container")
                            .html('<div class="alert alert-success alert-dismissible fade show" role="alert"> ' +
                                data["impMessage"] +
                                ' <button type="button" class="close" data-dismiss="alert" aria-label="Close"> ' +
                                ' <span aria-hidden="true">&times;</span></button></div>');
                    }
                    
                },
                error: function (e) {

                    console.log(e);
                    $("#alerts-container").html('<div class="alert alert-danger alert-dismissible fade show" role="alert"><strong>Грешка! </strong>Възникна грешка при импортиране на лицата.<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>');
                }
            });
        }
        else {
            $("#alerts-container").html('<div class="alert alert-danger alert-dismissible fade show" role="alert"><strong>Неуспешно!</strong> Няма избрана партия.<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>');
        }
    }
    else {
        $("#alerts-container").html('<div class="alert alert-danger alert-dismissible fade show" role="alert"><strong>Неуспешно!</strong> Празен е списъкът с лица.<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>');

    }

    
}