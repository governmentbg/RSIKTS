
function printpage() {
    var printButton = document.getElementById("printbtn");
    var closeButton = document.getElementById("closebtn");
    var exportButton = document.getElementById("exportbtn");
    var exportButton1 = document.getElementById("exportbtn1");

    printButton.style.visibility = 'hidden';
    closeButton.style.visibility = 'hidden';
    if (typeof (exportButton) !== 'undefined' && exportButton !== null)
        exportButton.style.visibility = 'hidden';

    if (typeof (exportButton1) !== 'undefined' && exportButton1 !== null)
        exportButton1.style.visibility = 'hidden';

    window.print();

    printButton.style.visibility = 'visible';
    closeButton.style.visibility = 'visible';

    if (typeof (exportButton) !== 'undefined' && exportButton !== null)
        exportButton.style.visibility = 'visible';

    if (typeof (exportButton1) !== 'undefined' && exportButton1 !== null)
        exportButton1.style.visibility = 'visible';
}

function closepage() {
     close();
}

function closepage_with_message() {
    Swal.fire({
        title: "Внимание!",
        text: "Искате ли да затворите страницаta?",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Да",
        cancelButtonText: "Не",
        closeOnConfirm: false,
        closeOnCancel: false
    }).then(function (result) {
                if (result.value) {
                    close();
                }
            });
}
