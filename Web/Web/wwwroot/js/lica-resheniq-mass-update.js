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
    var reshenie = $("#reshenie-select").val();

    if (reshenie === "") {
        Swal.fire(
            'Грешка',
            'Не е избрано решение.',
            'error'
        );
        return;
    }

    var canexec = 0;
    var val = $("#seleciq-select").val();
    if (val === undefined || val == null || val.length <= 0)
        sel = -1
    else
        sel = val;

    var model = {
        'Seleciq': sel,
        'Reshenie': reshenie,
        'AllLicaIds': allLicaIds,
        'LicaIds': licaIds
    };

    if (sel == -1) {
        Swal.fire({
            type: 'error',
            title: 'Грешка!',
            text: 'Не е избрано важи за!',
            footer: ''
        });
    } else {

        if (reshenie === "0")
            Swal.fire({
                title: 'Сигурни ли сте?',
                text: "Искате да изтриете въведените решения!",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Да, искам',
                cancelButtonText: 'НЕ'
            }).then(function (result) {
                if (result.value) {
                    $.ajax({
                        url: "/Lica/Home/MassUpdateLicaResheniq",
                        type: "POST",
                        contentType: "application/json",
                        data: JSON.stringify(model),
                        success: function (data) {
                            //console.log(data);
                            if (data["success"]) {
                                Swal.fire(
                                    'Успешно!',
                                    'Успешно бяха изтрити решенията за избраните лица.',
                                    'success'
                                );
                                UpdateLicaTable();
                            }
                        },
                        error: function (e) {
                            Swal.fire({
                                type: 'error',
                                title: 'Грешка!',
                                text: е.message,
                                footer: '<p class="text-center">Открита е грешка!<br>Моля обърнете се към администратора на програмата.</p>'
                            });
                        }
                    });
                }
            });
        else {
            $.ajax({
                url: "/Lica/Home/MassUpdateLicaResheniq",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(model),
                success: function (data) {
                    //console.log(data);
                    if (data["success"]) {
                        $("#alerts-container").html('<div class="alert alert-success alert-dismissible fade show" role="alert"><strong>Успешно! </strong>Успешно беше присвоено решението за избраните лица.<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>');
                        UpdateLicaTable();
                    }
                },
                error: function (e) {
                    Swal.fire({
                        type: 'error',
                        title: 'Грешка!',
                        text: е.message,
                        footer: '<p class="text-center">Открита е грешка!<br>Моля обърнете се към администратора на програмата.</p>'
                    });
                }
            });
        }
    }
}