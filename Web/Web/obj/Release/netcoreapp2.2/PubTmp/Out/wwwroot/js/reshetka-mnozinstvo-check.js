function AttachMnozinstvoChecker() {

    $("#reshetka-edit-modal-body .selectpicker").on("change", function () {

        let currentVal = $(this).val();

        if (currentVal === "0") {
            let buttonSelect = $(this).next();
            $(buttonSelect).css("border-color", "#ced4da");
            $(buttonSelect).css("background-color", "white");
            $(buttonSelect).css("color", "black");
        }

        let sikValues = [];

        $("#reshetka-edit-modal-body .selectpicker").each(function (index) {
            sikValues.push($(this).val());
        });

        var occurancesPerValue = {};


        for (let i = 0; i < sikValues.length; i++) {

            let occurenceCount = 0;

            if (sikValues[i] === "0") { continue; }

            for (let j = 0; j < sikValues.length; j++) {

                if (sikValues[i] === sikValues[j]) {
                    occurenceCount += 1;
                }

            }

            occurancesPerValue[sikValues[i]] = occurenceCount;
        }

        console.log(occurancesPerValue);

        let hasMajority = false;

        for (let i = 0; i < sikValues.length; i++) {

            if (sikValues[i] === "0") { continue; }

            let occurenceCount = occurancesPerValue[sikValues[i]]

            let occuranceProcent = occurenceCount / sikValues.length;

            if (occuranceProcent >= 0.5) {
                $("#reshetka-edit-modal-body .selectpicker").each(function (index) {
                    if ($(this).val() === sikValues[i]) {
                        let buttonSelect = $(this).next();
                        $(buttonSelect).css("border-color", "lightcoral");
                        $(buttonSelect).css("background-color", "lightcoral");
                        $(buttonSelect).css("color", "white");
                    }
                });

                hasMajority = true;
            }
            else {
                $("#reshetka-edit-modal-body .selectpicker").each(function (index) {
                    if ($(this).val() === sikValues[i]) {
                        let buttonSelect = $(this).next();
                        $(buttonSelect).css("border-color", "#ced4da");
                        $(buttonSelect).css("background-color", "white");
                        $(buttonSelect).css("color", "black");
                    }
                });
            }
        }

        if (hasMajority) {
            $("#reshetka-edit-modal-btn").prop("disabled", true);
            $("#reshetka-edit-modal-btn").css("cursor", "no-drop");
            $("#majority-error").text("Партия или коалиция не може да има мнозинство!");
            $("#majority-error").css("margin-top", "1rem")
        }
        else {
            $("#reshetka-edit-modal-btn").prop("disabled", false);
            $("#reshetka-edit-modal-btn").css("cursor", "pointer");
            $("#majority-error").text("");
            $("#majority-error").css("margin-top", "0");
        }
    });
}