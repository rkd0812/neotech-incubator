$(function() {
    // 수정 버튼 클릭 시
    $("#updateSubmitBtn").click(function() {
        var userEmail = $("#hiddenUserEmail").val();
        var password = $("#userPassword").val();
        var passwordConfirm = $("#passwordConfirm").val();

        var passwordLength = password.length >= 10 && password.length <= 16;
        var hasLetters = /[A-Za-z]/.test(password);
        var hasNumbers = /[0-9]/.test(password);
        var hasSpecialChars = /[!@#$%^&*()]/.test(password);

        if (password === "") {
            alert("비밀번호를 입력해주세요.");
            return;
        }

        if (!passwordLength) {
            alert("비밀번호는 10~16자리여야 합니다.");
            return;
        }

        // 영문 + 숫자 + 특수문자 조합 확인
        if (!(hasLetters && hasNumbers && hasSpecialChars)) {
            alert("비밀번호는 영문, 숫자, 특수문자(!@#$%^&*())를 모두 포함해야 합니다.");
            return;
        }

        if (password !== passwordConfirm) {
            alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
            return;
        }

        // 수정 확인
        if (confirm("수정을 하시겠습니까?")) {
            console.log("비밀번호 : " +password)
            console.log("권한코드 : " +$("select[name='roleCd']").val())
            $("#updateForm").submit();
            alert("수정이 완료되었습니다.");
        } else {
            alert("취소되었습니다.");
        }
    });

    // 취소 버튼 클릭 시
    $("#cancelBtn").click(function() {
        history.back(); // 이전 페이지로 돌아가기
    });
});