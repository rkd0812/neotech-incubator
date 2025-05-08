$(function() {
    // 수정 버튼 클릭 시
    $("#updateSubmitBtn").click(function() {
        var userEmail = $("#hiddenUserEmail").val();
        var password = $("#userPassword").val();
        var passwordConfirm = $("#passwordConfirm").val();
        var roleCd = $("#roleCd").val();

        if (password === "" && roleCd === "") {
            alert("비밀번호 또는 권한 코드를 입력해주세요.");
            return;
        }

        if (password !== "") {
            var passwordLength = password.length >= 10 && password.length <= 16;
            var hasLetters = /[A-Za-z]/.test(password);
            var hasNumbers = /[0-9]/.test(password);
            var hasSpecialChars = /[!@#$%^&*()]/.test(password);

            if (!passwordLength) {
                alert("비밀번호는 10~16자리여야 합니다.");
                return;
            }

            if (!(hasLetters && hasNumbers && hasSpecialChars)) {
                alert("비밀번호는 영문, 숫자, 특수문자(!@#$%^&*())를 모두 포함해야 합니다.");
                return;
            }

            if (password !== passwordConfirm) {
                alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
                return;
            }
        }

        // 수정 확인
        if (confirm("수정을 하시겠습니까?")) {
            $("#updateForm").submit();
        } else {
            alert("수정이 취소되었습니다.");
        }
    });

    // 취소 버튼 클릭 시
    $("#cancelBtn").click(function() {
        history.back();
    });
});