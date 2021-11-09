function showMsg(sts, msg) {
    $("#divSuccess").html('');
    $("#divError").html('');

    if ($("#divSuccess").hasClass("d-none")) {

    }
    else {
        $("#divSuccess").addClass('d-none');
    }
    if ($("#divError").hasClass("d-none")) {

    }
    else {
        $("#divError").addClass('d-none');
    }

    if (sts.trim().toUpperCase() == 'ERROR') {
        $("#divError").html(msg);
        $("#divError").removeClass('d-none');
    }
    if (sts.trim().toUpperCase() == 'SUCCESS') {
        $("#divSuccess").html(msg);
        $("#divSuccess").removeClass('d-none');
    }

    setTimeout(function () {
        if ($("#divError").hasClass("d-none")) {
            $("#divError").html('');
        }
        else {
            $("#divError").html('');
            $("#divError").addClass('d-none');
        }
        if ($("#divSuccess").hasClass("d-none")) {
            $("#divSuccess").html('');
        }
        else {
            $("#divSuccess").html('');
            $("#divSuccess").addClass('d-none');
        }
    }, 7000);
}