
$(function() {
    // 수정 버튼 클릭 시
    $("#updateSubmitBtn").click(function() {
        var password = $("#userPassword").val();
        var passwordConfirm = $("#passwordConfirm").val();
        var roleCd = $("#roleCd").val() || $("input[name='roleCd']").val();

        // 입력값 확인
        if (password === "") {
            alert("비밀번호 입력해주세요.");
            return;
        } else if (password !== "" && (password.length < 10 || password.length > 16)) {
            alert("비밀번호는 10~16자리여야 합니다.");
            $("#userPassword").focus();
            return;
        } else if (password !== "" && !(/[A-Za-z]/.test(password) && /[0-9]/.test(password) && /[!@#$%^&*()]/.test(password))) {
            alert("비밀번호는 영문, 숫자, 특수문자(!@#$%^&*())를 모두 포함해야 합니다.");
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

    // 취소 버튼 클릭 시
    $("#cancelBtn").click(function() {
        if (confirm("수정을 취소하고 이전 페이지로 돌아가시겠습니까?")) {
            history.back();
        }
    });
});