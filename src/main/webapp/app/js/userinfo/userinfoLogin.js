$(function() {
    // 로그인 폼 제출 시
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