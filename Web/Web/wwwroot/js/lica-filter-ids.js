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
    document.getElementById("generate-report-btn").disabled = false;
}

function GenerateReport() {
    AttachLoader();

    var val = $("#tur-select").val()
    if (val === undefined || val == null || val.length <= 0)
        tur = 0
    else
        tur = val;

    var model = {
        'Seleciq': $("#seleciq-select").val(),
        'AllLicaIds': allLicaIds,
        'LicaIds': licaIds,
        'StatisticId': $("#statistic-id-hidden").val(),
        'Tur': tur
    };

    $.ajax({
        url: "/Spravki/Home/PrintStatistic",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(model),
        success: function (data) {
            RemoveLoader();
            if (data["success"]) {
                window.location = "/Spravki/Home/DownloadReportByGuid?guid=" + data["fileGUID"] + "&statisticId=" + $("#statistic-id-hidden").val();
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