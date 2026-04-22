
//Taq magiq e dosta slojna po - dobre ne q pipai che posle i az ne moga da q opravq :D

function mapFormToIndexedArrayById(formId) {
    var unindexed_array = $(`#${formId}`).serializeArray();
    var indexed_array = {};
    var issetstatus = 0;

    $.map(unindexed_array, function (n, i) {
        if (n['name'].indexOf('[') > 0) {
            let array_name = n['name'].slice(0, n['name'].indexOf('['));
            let array_index = n['name'].slice(n['name'].indexOf('[') + 1, n['name'].indexOf(']'));

            if (indexed_array[array_name] === undefined) {
                indexed_array[array_name] = [];
            }

            if (indexed_array[array_name][array_index] === undefined) {
                indexed_array[array_name][array_index] = {};
            }

            let array_prop_name = n['name'].slice(n['name'].indexOf('.') + 1, n['name'].length);
            indexed_array[array_name][array_index][array_prop_name] = n['value'];
        }
        else {
            if (n['name'] === 'Priznaci') {
                if (indexed_array[n['name']] === undefined) {
                    indexed_array[n['name']] = [];
                }
                indexed_array[n['name']].push(n['value']);

            } else {
                if (n['name'] === 'Status') {
                    if (issetstatus == 0) { 
                        issetstatus = 1;
                        indexed_array[n['name']] = n['value'];
                        console.log(indexed_array[n['name']]);
                    }
                } else {
                    indexed_array[n['name']] = n['value'];
                }
            }
        }
    });

//    console.log(JSON.stringify(indexed_array));
    return indexed_array;
}

function submitSikAdd() {
    
    $.ajax
        ({
            url: '/Sik/Home/AddSik',
            type: 'POST',
            accepts: "json",
            data: JSON.stringify(mapFormToIndexedArrayById('sik-add-form')),
            contentType: "application/json",
            dataType: "json",
            success: function (data) {
                if (data["success"]) {
                    UpdatePagination(null, $("#pagination-current-page").val(), $("#sik-filter-hidden").val());
                    $("#sik-add-modal-body").html("");
                    $("#sik-add-modal-body").html(data["addModalHTML"]);
                    showTab(currentTab);
                    $("select").selectpicker();
                    AttachUlicaFilter();
                    document.getElementById("sik-add-form").reset();
                    $("#sik-add-modal").modal("hide");
                    $("#alerts-container").html('<div class="alert alert-success alert-dismissible fade show" role="alert"><strong>Успешно! </strong>Успешно е добавена секцията.<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>');
                }
                else {
                    $("#sik-add-modal-body").html(data["addModalHTML"]);
                    showTab(currentTab);
                    $("select").selectpicker();
                    AttachUlicaFilter();
                    BindPlaceHolderSelect();
                }
            },
            error: function (data) {
                console.log("Test");
            }
        });
}

function submitSikEdit() {

    $.ajax
        ({
            url: '/Sik/Home/EditSik',
            type: 'POST',
            accepts: "json",
            data: JSON.stringify(mapFormToIndexedArrayById('sik-edit-form')),
            contentType: "application/json",
            dataType: "json",
            success: function (data) {
                if (data["success"]) {
                    UpdatePagination(null, $("#pagination-current-page").val(), $("#sik-filter-hidden").val());
    
                    $("#sik-edit-modal").modal("hide");
                    $("#alerts-container").html('<div class="alert alert-success alert-dismissible fade show" role="alert"><strong>Успешно! </strong>Успешно е обновена секцията.<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>');
                }
                else {
                    $("#sik-edit-modal-body").html(data["editModalHTML"]);
                    showTab(currentTab);
                    $("select").selectpicker();
                    AttachUlicaFilter();
                    BindPlaceHolderSelect();
                }
            },
            error: function (data) {
                console.log("Test");
            }
        });

}