$(function() {
    $("#rgsbtn").click(function() {
        location.href = "/userinfo/registForm.do";
    });

    var message = $("#messageValue").val();
    if(message && message !== "" && message !== "null") {
        alert(message);
    }
});