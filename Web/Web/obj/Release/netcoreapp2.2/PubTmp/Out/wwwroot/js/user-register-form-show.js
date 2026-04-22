function AttachUserRegisterFormShow() {

    $('#obhavt-select').change(function () {
        if ($(this).val() == 1) {
            $('#raion-select-container').css("display", "block");
        } else {
            $('#raion-select-container').css("display", "none");
        }
    });

    $('#role-select').change(function () {
        if ($('#role-select').val() == 2) {

            $('#obhavt-select').html("");

            $('#obhavt-select').append($('<option>', {
                value: 0,
                text: 'Глобален'
            }));

            $("#obhavt-select").selectpicker('refresh');
            $('#raion-select-container').css("display", "none");
            $('#partiq-select-container').css("display", "none");
        }
        else if ($('#role-select').val() == 0) {

            $('#obhavt-select').html("");

            $('#obhavt-select').append($('<option>', {
                value: 0,
                text: 'Глобален'
            }));

            $("#obhavt-select").selectpicker('refresh');
            $('#raion-select-container').css("display", "none");
            $('#partiq-select-container').css("display", "none");
        }
        else if ($('#role-select').val() == 1) {

            $('#obhavt-select').html("");

            $('#obhavt-select').append($('<option>', {
                value: 0,
                text: 'Глобален'
            }));

            $('#obhavt-select').append($('<option>', {
                value: 1,
                text: 'За регион'
            }));

            $("#obhavt-select").selectpicker('refresh');
            $('#partiq-select-container').css("display", "none");
            $('#raion-select-container').css("display", "none");
        }
    });

    if ($("#obhavt-select").val() == 1) {
        $('#raion-select-container').css("display", "block");
    } else {
        $('#raion-select-container').css("display", "none");
    }

    if ($('#role-select').val() == 2) {

        $('#obhavt-select').html("");

        $('#obhavt-select').append($('<option>', {
            value: 0,
            text: 'Глобален'
        }));

        $("#obhavt-select").selectpicker('refresh');
        $('#raion-select-container').css("display", "none");
        $('#partiq-select-container').css("display", "none");
    }
    else if ($('#role-select').val() == 0) {

        $('#obhavt-select').html("");

        $('#obhavt-select').append($('<option>', {
            value: 0,
            text: 'Глобален'
        }));      

        $("#obhavt-select").selectpicker("refresh");
        $('#partiq-select-container').css("display", "none");
        $('#raion-select-container').css("display", "none");
    }
    else if ($('#role-select').val() == 1) {

        let selectedOption = $("#obhavt-select").val();

        $('#obhavt-select').html("");

        if (selectedOption == 0) {
            $('#obhavt-select').append($('<option>', {
                value: 0,
                text: 'Глобален',
                selected: true
            }));
        }
        else {
            $('#obhavt-select').append($('<option>', {
                value: 0,
                text: 'Глобален'
            }));
        }

        if (selectedOption == 1) {
            $('#obhavt-select').append($('<option>', {
                value: 1,
                text: 'За регион',
                selected: true
            }));
        }
        else {
            $('#obhavt-select').append($('<option>', {
                value: 1,
                text: 'За регион'
            }));
        }

        $("#obhavt-select").selectpicker("refresh");
        $('#partiq-select-container').css("display", "none");
        $('#raion-select-container').css("display", "none");

        if ($('#obhavt-select').val() == 1) {
            $('#raion-select-container').css("display", "block");
        } else {
            $('#raion-select-container').css("display", "none");
        }
    }
}