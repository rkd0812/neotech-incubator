$(function() {
    // 도메인 선택 시 입력
    $("#domainList").change(function() {
        var domain = $(this).val();
        if(domain === "") {
            // 직접 입력 선택 시
            $("#userDomain").val("").prop("readonly", false).focus();
        } else {
            // 도메인 선택 시
            $("#userDomain").val(domain).prop("readonly", true);
        }
    });

    // 중복 확인 버튼 클릭
    $("#checkemailBtn").click(function() {
        var email = $("#userEmail").val();
        var domain = $("#userDomain").val();

        // 입력 확인
        if(email === "") {
            alert("이메일을 입력해주세요.");
            $("#userEmail").focus();
            return;
        }
        if(domain === "") {
            alert("도메인을 입력하거나 선택해주세요.");
            $("#userDomain").focus();
            return;
        }

        // 이메일 조합
        var fullEmail = email + "@" + domain;
        $("#dbEmail").val(fullEmail);

        // 서버 중복
        $.ajax({
            url : "/userinfo/checkEmailDuplicate.do",
            method : "POST",
            data : {userEmail: fullEmail},
            success : function(isDupicate) {
                if(isDupicate) {
                    alert("중복된 아이디입니다.");
                } else {
                    alert("사용 가능한 아이디입니다.");
                }
            }
        });

    });

    // 회원 등록 버튼 클릭
    $("#registerBtn").click(function() {
        var email = $("#userEmail").val();
        var domain = $("#userDomain").val();
        var pw = $("#userPassword").val();
        var pwConfirm = $("#passwordConfirm").val();

        // 입력 확인
        if(email === "") {
            alert("이메일을 입력해주세요.");
            $("#userEmail").focus();
            return;
        }
        if(domain === "") {
            alert("도메인을 입력하거나 선택해주세요.");
            $("#userDomain").focus();
            return;
        }
        if(pw === "") {
            alert("비밀번호를 입력해주세요.");
            $("#userPassword").focus();
            return;
        }
        if(pwConfirm === "") {
            alert("비밀번호 확인을 입력해주세요.");
            $("#passwordConfirm").focus();
            return;
        }

        // 비밀번호 일치 확인
        if(pw !== pwConfirm) {
            alert("비밀번호가 일치하지 않습니다.");
            $("#passwordConfirm").focus();
            return;
        }

        $("#dbEmail").val(email + "@" + domain);


        $("#userForm").submit();
    });
});