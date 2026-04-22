let licaIds = [];

let allLicaIds = [];

function ToggleId(id) {
    let index = licaIds.indexOf(id);

    if (index > -1) {
        licaIds.splice(index, 1);
    }
    else {
        licaIds.push(id);
    }
}

function AddLiceId(id) {
    allLicaIds.push(id);
}

function MassUpdateLica() {

    if ($("#deinost-select").val() === "") {
        Swal.fire(
            'Грешка',
            'Не е избрана дейност.',
            'error'
        );
        return;
    }
    
    var model = {
        'Deinost': $("#deinost-select").val(),
        'AllLicaIds': allLicaIds,
        'LicaIds': licaIds
    };

    $.ajax({
        url: "/Lica/Home/MassUpdateLicaDeinost",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(model),
        success: function (data) {
            console.log(data);
            if (data["success"]) {
                $("#alerts-container").html('<div class="alert alert-success alert-dismissible fade show" role="alert"><strong>Успешно! </strong>Успешно бяха обновени лицата.<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>');
            }
        },
        error: function (e) {
            Swal.fire({
                type: 'error',
                title: 'Грешка!',
                text: $(data.responseText).find("span").html(),
                footer: '<p class="text-center">Открита е грешка!<br>Моля обърнете се към администратора на програмата.</p>'
            });
        }
    });
    

    
}