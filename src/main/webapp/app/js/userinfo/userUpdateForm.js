$(function () {
    // 수정 버튼 클릭 시
    $("#updateSubmitBtn").click(function () {
        var password = $("#userPassword").val();
        var passwordConfirm = $("#passwordConfirm").val();


        // 입력값 확인
        if (password === "") {
            alert("비밀번호 입력해주세요.");
            return;
        } else if (password !== "" && (password.length < 10 || password.length > 16)) {
            alert("비밀번호는 10~16자리여야 합니다.");
            $("#userPassword").focus();
            return;
        } else if (password !== "" && !(/[A-Za-z]/.test(password) && /[0-9]/.test(password) && /[!@#$%^&*()]/.test(password))) {
            alert("비밀번호는 영문, 숫자, 특수문자(!@#$%^&*()-_+=.)를 모두 포함해야 합니다.");
            $("#userPassword").focus();
            return;
        } else if (password !== "" && password !== passwordConfirm) {
            alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
            $("#passwordConfirm").focus();
            return;
        }

        if (confirm("사용자 정보를 수정하시겠습니까?")) {
            // 비밀번호가 비어있으면 해당 필드를 제거 (기존 비밀번호 유지)
            if (password === "") {
                $("#userPassword").remove();
            }
            $("#updateForm").submit();
        }
    });

    function checkPasswordRequirements(password) {
        // 길이 체크 (10~16자리)
        var lengthOk = password.length >= 10 && password.length <= 16;
        updateRequirement('req-length', lengthOk);

        // 영문자 체크
        var letterOk = /[a-zA-Z]/.test(password);
        updateRequirement('req-letter', letterOk);

        // 숫자 체크
        var numberOk = /[0-9]/.test(password);
        updateRequirement('req-number', numberOk);

        // 특수문자 체크 (금지된 특수문자는 제외)
        var allowSpecialChar = /[!@#$%^&*()\-_+=.\[\]{}|;:,?~]/;
        var forbiddenchar = /[\\'"<>`%=₩]/;

        var hasAllowedSpecialChar = allowSpecialChar.test(password);
        var hasForbiddenChar = forbiddenchar.test(password);
        var specialOk = hasAllowedSpecialChar && !hasForbiddenChar;
        updateRequirement('req-special', specialOk)

        return lengthOk && letterOk && numberOk && specialOk
    }

    function updateRequirement(elementId, satisfied) {
        var element = $('#' + elementId);

        if (satisfied) {
            // 조건 만족 시 - 녹색으로 변경
            element.addClass('satisfied');
        } else {
            // 조건 불만족 시 - 회색으로 변경
            element.removeClass('satisfied');
        }
    }

    $('#userPassword').on('input', function() {
        var password = $(this).val();
        checkPasswordRequirements(password);
    });


    // 취소 버튼 클릭 시
    $("#cancelBtn").click(function () {
        if (confirm("수정을 취소하고 이전 페이지로 돌아가시겠습니까?")) {
            history.back();
        }
    });
});