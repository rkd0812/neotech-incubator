$(function() {
    var errorCode = $("#errorCode").val();

    if(errorCode) {
        if(errorCode === "empty") {
            alert("이메일과 비밀번호를 입력해주세요.");
        } else if(errorCode === "password") {
            alert("비밀번호가 일치하지 않습니다.");
        } else if(errorCode === "email") {
            alert("존재하지 않는 이메일입니다.");
        } else if(errorCode === "system") {
            alert("시스템 오류가 발생했습니다. 관리자에게 문의하세요.");
        }
    }

    $("#userLogin").submit(function(event) {
        // 이메일, 비밀번호 입력 확인
        var userEmail = $("#userEmail").val();
        var userPassword = $("#userPassword").val();

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