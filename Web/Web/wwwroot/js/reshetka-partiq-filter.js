let lastRemovedOptionPrecedatel = "";
let lastRemovedOptionZamestnik = "";
let lastRemovedOptionSekretar = "";

function AttachPartiqFilter() {

    $("#precedatel-select").change(function () {
        if (lastRemovedOptionPrecedatel != "") {
            let currentVal = $("#zamestnik-precedatel-select").val();
            $("#zamestnik-precedatel-select option").each(function () {
                if ($(lastRemovedOptionPrecedatel).val() < $(this).val()) {
                    console.log($(this)[0].outerHTML);
                    $(this)[0].outerHTML = lastRemovedOptionPrecedatel + $(this)[0].outerHTML;
                    $("#zamestnik-precedatel-select").val(currentVal);
                    return false;
                }
            });

            currentVal = $("#sekretar-select").val();
            $("#sekretar-select option").each(function () {
                if ($(lastRemovedOptionPrecedatel).val() < $(this).val()) {
                    console.log($(this)[0].outerHTML);
                    $(this)[0].outerHTML = lastRemovedOptionPrecedatel + $(this)[0].outerHTML;
                    $("#sekretar-select").val(currentVal);
                    return false;
                }
            });
        }

        if ($(this).val() != "0") {

            lastRemovedOptionPrecedatel = $("#precedatel-select :selected")[0].outerHTML;

            if ($('#zamestnik-precedatel-select').val() === $(this).val()) {
                $('#zamestnik-precedatel-select').val("0");
            }

            if ($('#sekretar-select').val() === $(this).val()) {
                $('#sekretar-select').val("0");
            }

            $('#zamestnik-precedatel-select option[value="' + $(this).val() + '"]').remove();
            $('#sekretar-select option[value="' + $(this).val() + '"]').remove();
        }
        else {
            lastRemovedOptionPrecedatel = "";
        }

        $('#zamestnik-precedatel-select').selectpicker('refresh');
        $('#sekretar-select').selectpicker('refresh');
    });

    $("#zamestnik-precedatel-select").change(function () {
        if (lastRemovedOptionZamestnik != "") {
            let currentVal = $("#precedatel-select").val();
            $("#precedatel-select option").each(function () {
                if ($(lastRemovedOptionZamestnik).val() < $(this).val()) {
                    console.log($(this)[0].outerHTML);
                    $(this)[0].outerHTML = lastRemovedOptionZamestnik + $(this)[0].outerHTML;
                    $("#precedatel-select").val(currentVal);
                    return false;
                }
            });

            currentVal = $("#sekretar-select").val();
            $("#sekretar-select option").each(function () {
                if ($(lastRemovedOptionZamestnik).val() < $(this).val()) {
                    console.log($(this)[0].outerHTML);
                    $(this)[0].outerHTML = lastRemovedOptionZamestnik + $(this)[0].outerHTML;
                    $("#sekretar-select").val(currentVal);
                    return false;
                }
            });
        }

        if ($(this).val() != "0") {

            lastRemovedOptionZamestnik = $("#zamestnik-precedatel-select :selected")[0].outerHTML;

            if ($('#precedatel-select').val() === $(this).val()) {
                $('#precedatel-select').val("0");
            }

            if ($('#sekretar-select').val() === $(this).val()) {
                $('#sekretar-select').val("0");
            }

            $('#precedatel-select option[value="' + $(this).val() + '"]').remove();
            $('#sekretar-select option[value="' + $(this).val() + '"]').remove();
        }
        else {
            lastRemovedOptionZamestnik = "";
        }

        $('#precedatel-select').selectpicker('refresh');
        $('#sekretar-select').selectpicker('refresh');
    });

    $("#sekretar-select").change(function () {
        if (lastRemovedOptionSekretar != "") {
            let currentVal = $("#precedatel-select").val();
            $("#precedatel-select option").each(function () {
                if ($(lastRemovedOptionSekretar).val() < $(this).val()) {
                    console.log($(this)[0].outerHTML);
                    $(this)[0].outerHTML = lastRemovedOptionSekretar + $(this)[0].outerHTML;
                    $("#precedatel-select").val(currentVal);
                    return false;
                }
            });

            currentVal = $("#zamestnik-precedatel-select").val();
            $("#zamestnik-precedatel-select option").each(function () {
                if ($(lastRemovedOptionSekretar).val() < $(this).val()) {
                    console.log($(this)[0].outerHTML);
                    $(this)[0].outerHTML = lastRemovedOptionSekretar + $(this)[0].outerHTML;
                    $("#zamestnik-precedatel-select").val(currentVal);
                    return false;
                }
            });
        }

        if ($(this).val() != "0") {

            lastRemovedOptionSekretar = $("#sekretar-select :selected")[0].outerHTML;

            if ($('#precedatel-select').val() === $(this).val()) {
                $('#precedatel-select').val("0");
            }

            if ($('#zamestnik-precedatel-select').val() === $(this).val()) {
                $('#zamestnik-precedatel-select').val("0");
            }

            $('#precedatel-select option[value="' + $(this).val() + '"]').remove();
            $('#zamestnik-precedatel-select option[value="' + $(this).val() + '"]').remove();
        }
        else {
            lastRemovedOptionSekretar = "";
        }

        $('#precedatel-select').selectpicker('refresh');
        $('#zamestnik-precedatel-select').selectpicker('refresh');
    });

}

if (lastRemovedOptionPrecedatel != "") {
    $("#zamestnik-precedatel-select option").each(function () {
        if ($(lastRemovedOptionPrecedatel).val() < $("#precedatel-select").val()) {
            $("#precedatel-select")[0].outerHTML = lastRemovedOptionPrecedatel + $("#precedatel-select")[0].outerHTML;
            return false;
        }
    });

    $("#sekretar-select option").each(function () {
        if ($(lastRemovedOptionPrecedatel).val() < $("#precedatel-select").val()) {
            $("#precedatel-select")[0].outerHTML = lastRemovedOptionPrecedatel + $("#precedatel-select")[0].outerHTML;
            return false;
        }
    });
}

function ResetPariq() {
    lastRemovedOptionPrecedatel = "";
    lastRemovedOptionZamestnik = "";
    lastRemovedOptionSekretar = "";

    if ($("#precedatel-select").val() != "0") {

        lastRemovedOptionPrecedatel = $("#precedatel-select :selected")[0].outerHTML;

        if ($('#zamestnik-precedatel-select').val() === $("#precedatel-select").val()) {
            $('#zamestnik-precedatel-select').val("0");
        }

        if ($('#sekretar-select').val() === $("#precedatel-select").val()) {
            $('#sekretar-select').val("0");
        }

        $('#zamestnik-precedatel-select option[value="' + $("#precedatel-select").val() + '"]').remove();
        $('#sekretar-select option[value="' + $("#precedatel-select").val() + '"]').remove();
    }

    $('#zamestnik-precedatel-select').selectpicker('refresh');
    $('#sekretar-select').selectpicker('refresh');

    if (lastRemovedOptionZamestnik != "") {
        $("#precedatel-select option").each(function () {
            if ($(lastRemovedOptionZamestnik).val() < $("#zamestnik-precedatel-select").val()) {

                $("#zamestnik-precedatel-select")[0].outerHTML = lastRemovedOptionZamestnik + $("#zamestnik-precedatel-select")[0].outerHTML;
                return false;
            }
        });

        $("#sekretar-select option").each(function () {
            if ($(lastRemovedOptionZamestnik).val() < $("#zamestnik-precedatel-select").val()) {
                $("#zamestnik-precedatel-select")[0].outerHTML = lastRemovedOptionZamestnik + $("#zamestnik-precedatel-select")[0].outerHTML;
                return false;
            }
        });
    }

    if ($("#zamestnik-precedatel-select").val() != "0") {

        lastRemovedOptionZamestnik = $("#zamestnik-precedatel-select :selected")[0].outerHTML;

        if ($('#precedatel-select').val() === $("#zamestnik-precedatel-select").val()) {
            $('#precedatel-select').val("0");
        }

        if ($('#sekretar-select').val() === $("#zamestnik-precedatel-select").val()) {
            $('#sekretar-select').val("0");
        }

        $('#precedatel-select option[value="' + $("#zamestnik-precedatel-select").val() + '"]').remove();
        $('#sekretar-select option[value="' + $("#zamestnik-precedatel-select").val() + '"]').remove();
    }

    $('#precedatel-select').selectpicker('refresh');
    $('#sekretar-select').selectpicker('refresh');

    if (lastRemovedOptionSekretar != "") {
        $("#precedatel-select option").each(function () {
            if ($(lastRemovedOptionSekretar).val() < $("#sekretar-select").val()) {
                $("#sekretar-select")[0].outerHTML = lastRemovedOptionSekretar + $("#sekretar-select")[0].outerHTML;
                return false;
            }
        });

        $("#zamestnik-precedatel-select option").each(function () {
            if ($(lastRemovedOptionSekretar).val() < $("#sekretar-select").val()) {
                $("#sekretar-select")[0].outerHTML = lastRemovedOptionSekretar + $("#sekretar-select")[0].outerHTML;
                return false;
            }
        });
    }

    if ($("#sekretar-select").val() != "0") {

        lastRemovedOptionSekretar = $("#sekretar-select :selected")[0].outerHTML;

        if ($('#precedatel-select').val() === $("#sekretar-select").val()) {
            $('#precedatel-select').val("0");
        }

        if ($('#zamestnik-precedatel-select').val() === $("#sekretar-select").val()) {
            $('#zamestnik-precedatel-select').val("0");
        }

        $('#precedatel-select option[value="' + $("#sekretar-select").val() + '"]').remove();
        $('#zamestnik-precedatel-select option[value="' + $("#sekretar-select").val() + '"]').remove();
    }

    $('#precedatel-select').selectpicker('refresh');
    $('#zamestnik-precedatel-select').selectpicker('refresh');
}