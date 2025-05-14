$(function () {
    var errorMessage = $("#errorMessage").val();

    if (errorMessage && errorMessage.trim() !== "") {
        alert(errorMessage);
    }

    $("#domainList").change(function () {
        var domain = $(this).val();
        if (domain === "") {
            $("#userDomain").val("").prop("readonly", false).focus();
        } else {
            $("#userDomain").val(domain).prop("readonly", true);
        }
    });

    $("#userLogin").submit(function (event) {
        // 이메일, 비밀번호 입력 확인
        var userEmail = $("#userEmail").val().trim();
        var userPassword = $("#userPassword").val().trim();

        if (userEmail === "" && userPassword === "") {
            alert("이메일과 비밀번호를 입력하지 않았습니다.");
            $("#userEmail").focus();
            event.preventDefault();
            return false;
        }

        if (userEmail === "") {
            alert("이메일을 입력해주세요.");
            $("#userEmail").focus();
            event.preventDefault();
            return false;
        }

        if (userPassword === "") {
            alert("비밀번호를 입력해주세요.");
            $("#userPassword").focus();
            event.preventDefault();
            return false;
        }

        if (userPassword.length < 10 ){
            alert("비빌번호는 최소 10자 이상이어야 합니다.");
            $("#userPassword").focus();
            event.preventDefault()
            return false;
        }

        var userDomain = $("#userDomain").val().trim();
        if (userDomain === "") {
            alert("도메인을 입력하거나 선택해주세요.");
            $("#userDomain").focus();
            event.preventDefault();
            return false;
        }
        $("#dbEmail").val(userEmail + "@" + userDomain);

        return true;
    });

    // 회원가입 버튼
    $("#registerBtn").click(function () {
        location.href = "/userinfo/registForm.do";
    });
});