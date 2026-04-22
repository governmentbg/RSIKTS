
function stopRKey(evt) {
    var evt = (evt) ? evt : ((event) ? event : null);
    var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement : null);
    if ((evt.keyCode == 13) && (node.type == "text")) { return false; }
}

var currentTab = 0; // Current tab is set to be the first tab (0)
showTab(currentTab); // Display the current tab
document.onkeypress = stopRKey;

function showTab(n) {
    // This function will display the specified tab of the form ...
    var x = document.getElementsByClassName("tab");

    for (let i = 0; i < x.length; i++) {
        x[i].style.display = "none";
    }

    let form_tab_text = document.getElementsByClassName("form-tab-info-text")[0];

    if (form_tab_text != undefined) {

        if (n === 0) {
            form_tab_text.innerHTML = "Лични данни";
        }
        else if (n === 1) {
            form_tab_text.innerHTML = "Общи данни";
        }
        else if (n === 2) {
            form_tab_text.innerHTML = "Адресни данни";
        }
    

        x[n].style.display = "block";
        // ... and fix the Previous/Next buttons:
        // ... and run a function that displays the correct step indicator:
        fixStepIndicator(n);

        currentTab = n;

        showPagesWithError();
    }
}

function nextPrev(n) {
    console.log(currentTab + n);
    if (currentTab + n > -1 && currentTab + n < 3) {
        // This function will figure out which tab to display
        var x = document.getElementsByClassName("tab");
        // Exit the function if any field in the current tab is invalid:
        // Hide the current tab:
        x[currentTab].style.display = "none";
        // Increase or decrease the current tab by 1:
        currentTab = currentTab + n;
        // if you have reached the end of the form... :
        if (currentTab >= x.length) {
            //...the form gets submitted:
            document.getElementById("regForm").submit();
            return false;
        }
        // Otherwise, display the correct tab:
        showTab(currentTab);
    }
}

function validateForm() {
    // This function deals with validation of the form fields
    var x, y, i, valid = true;
    x = document.getElementsByClassName("tab");
    y = x[currentTab].getElementsByTagName("input");
    // A loop that checks every input field in the current tab:
    for (i = 0; i < y.length; i++) {
        // If a field is empty...
        if (y[i].value == "") {
            // add an "invalid" class to the field:
            y[i].className += " invalid";
            // and set the current valid status to false:
            valid = false;
        }
    }
    // If the valid status is true, mark the step as finished and valid:
    if (valid) {
        document.getElementsByClassName("step")[currentTab].className += " finish";
    }
    return valid; // return the valid status
}

function fixStepIndicator(n) {
    // This function removes the "active" class of all steps...
    var i, x = document.getElementsByClassName("step");
    for (i = 0; i < x.length; i++) {
        x[i].className = x[i].className.replace(" active", "");
    }
    //... and adds the "active" class to the current step:
    x[n].className += " active";
}

function compareNumbers(a, b) {
    return a - b;
}


function showPagesWithError() {

    $(".tab").each(function (i, element) {

        let hasValidationError = false;

        $(element).find(".field-validation-error").each(function (i, element) {
            if (element.innerHTML !== "") {
                hasValidationError = true;
            }
        });

        if (hasValidationError) {
            $($(".step").get(i)).css("background-color", "red");
            $($(".step").get(i)).addClass("has-validation-error");
        }
    });

    //let stepIndexes = [];

    //$(".step").each(function (i, element) {
    //    if ($(element).hasClass("has-validation-error")) {
    //        stepIndexes.push(i);
    //    }
    //});


    //if (stepIndexes.length > 0) {
    //    stepIndexes.sort(compareNumbers);
    //    showTab(stepIndexes[0], false);
    //}
}

function checkGrao() {

    var graonumb = $('#egn').val();
    var graovid = $('#videgn').val();

    var fullurl = '/Lica/Home/CheckGraoNumber?graonumber=' + graonumb + '&vidgrao=' + graovid;
    if (graonumb.length > 0) {
        $.ajax({
            url: fullurl,
            type: 'GET',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            success: function (data) {
                if (!data.isValid) {
                    Swal.fire({
                        type: 'error',
                        title: 'Грешка!',
                        text: $(data.responseText).find("span").html(),
                        footer: '<p class="text-center">Невалиден идентификатор!'
                    });
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
    } else {
        $('#egn').attr('placeholder', '*');
    }
}

//Convert to module