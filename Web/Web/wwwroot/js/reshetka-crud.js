function UpdateKvotiEditModal(e, sikId, sikFullCode) {
    let model = {
        'sikId': sikId,
        'sikFullCode': sikFullCode
    };

    $.ajax({
        url: "/Kvoti/Home/GeReshetkaEdit",
        type: "GET",
        contentType: "application/json",
        data: model,
        success: function (data) {
            $("#reshetka-edit-header").html("Секция - " + sikFullCode);
            $("#reshetka-edit-modal-body").html(data["editModalHTML"]);
            $("select").selectpicker();
            AttachPartiqFilter();
            ResetPariq();
            AttachMnozinstvoChecker();
            $("#reshetka-edit-modal").modal("show");
        },
        error: function (e) {
            console.log(e);
            alert("Открита е грешка! Моля обърнете се към администратора на програмата.");
        }
    });
}

function UpdateReshetaDetailstModal(e, sikId, sikFullCode) {
    let model = {
        'sikId': sikId,
        'sikFullCode': sikFullCode
    };

    $.ajax({
        url: "/Kvoti/Home/GetReshetkaDetails",
        type: "GET",
        contentType: "application/json",
        data: model,
        success: function (data) {
            $("#reshetka-details-header").html("Секция - " + sikFullCode);
            $("#reshetka-details-modal-body").html(data["reshetkaDetailsHTML"]);
            $("#reshetka-details-modal").modal("show");
        },
        error: function (e) {
            console.log(e);
            Swal.fire({
                type: 'error',
                title: 'Грешка!',
                text: е.message,
                footer: '<p class="text-center">Открита е грешка!<br>Моля обърнете се към администратора на програмата.</p>'
            });
        }
    });
}

function UpdateReshetkaSumModal() {
    $.ajax({
        url: "/Kvoti/Home/GetReshetkaSum",
        type: "GET",
        contentType: "application/json",
        success: function (data) {
            $("#reshetka-sum-modal-body").html(data["reshetkaSumHTML"]);
            $("#reshetka-sum-modal").modal("show");
        },
        error: function (e) {
            console.log(e);
            alert("Открита е грешка! Моля обърнете се към администратора на програмата.");
        }
    });
}

function UpdateReshetkaTable() {
    $.ajax({
        url: "/Kvoti/Home/GetReshetkaTable",
        type: "GET",
        contentType: "application/json",
        success: function (data) {
            $("#reshetka-table").html(data["reshetkaTableHTML"]);
        },
        error: function (e) {
            console.log(e);
            alert("Открита е грешка! Моля обърнете се към администратора на програмата.");
        }
    });
}