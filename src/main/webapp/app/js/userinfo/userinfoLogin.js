$(function() {
    var errorMessage = $("#errorMessage").val();

    if(errorMessage && errorMessage.trim() !== "") {
        alert(errorMessage);
    }

    $("#userLogin").submit(function(event) {
        // 이메일, 비밀번호 입력 확인
        var userEmail = $("#userEmail").val().trim();
        var userPassword = $("#userPassword").val().trim();

        if(userEmail === "" && userPassword === "") {
            alert("이메일과 비밀번호를 입력하지 않았습니다.");
            $("#userEmail").focus();
            event.preventDefault();
            return false;
        }

        if(userEmail === "") {
            alert("이메일을 입력해주세요.");
            $("#userEmail").focus();
            event.preventDefault();
            return false;
        }

        if(userPassword === "") {
            alert("비밀번호를 입력해주세요.");
            $("#userPassword").focus();
            event.preventDefault();
            return false;
        }

        return true;
    });

    // 회원가입 버튼 클릭 시
    $("#registerBtn").click(function() {
        location.href = "/userinfo/registForm.do";
    });
});