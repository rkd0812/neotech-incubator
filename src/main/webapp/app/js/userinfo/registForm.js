$(function () {
    // 중복 확인 상태 변수
    var isEmailChecked = false; // 이메일 중복 확인 여부
    var isEmailAvailable = false; // 이메일 사용 가능 여부

    // 결과 메시지 초기화
    function clearEmailResult() {
        $("#emailCheckResult").html('');
    }

    // 도메인 선택 시 입력
    $("#domainList").change(function () {
        var domain = $(this).val();
        if (domain === "") {
            // 직접 입력 선택 시
            $("#userDomain").val("").prop("readonly", false).focus();
        } else {
            // 도메인 선택 시
            $("#userDomain").val(domain).prop("readonly", true);
        }

        // 도메인이 변경되면 중복 확인 초기화
        isEmailChecked = false;
        isEmailAvailable = false;
    });

    // 이메일 입력 필터링
    var specialChar = /[ \{\}\[\]\/?.,;:|\)*~`!^\_+┼<>@\#$%&\'\"\\\(\=]/gi;
    var koreanChar = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/gi;
    $('#userEmail').on("input", function () {
        var emailInput = $(this).val();

        if (specialChar.test(emailInput) || koreanChar.test(emailInput)) {
            alert('영문과 숫자만 입력 가능합니다.');
            $(this).val("") //입력값 초기화
            $(this).focus();
        }

        isEmailChecked = false;
        isEmailAvailable = false;
    });

    // 사용자 도메인 입력 시 중복확인 초기화
    $('#userDomain').on("input", function () {
        isEmailChecked = false;
        isEmailAvailable = false;
    });

    // 중복 확인 버튼 클릭
    $("#checkemailBtn").click(function () {
        var email = $("#userEmail").val();
        var domain = $("#userDomain").val();

        // 입력 확인
        if (email === "") {
            alert("이메일을 입력해주세요.");
            $("#userEmail").focus();
            return;
        }
        if (domain === "") {
            alert("도메인을 입력하거나 선택해주세요.");
            $("#userDomain").focus();
            return;
        }

        // 이메일 조합
        var fullEmail = email + "@" + domain;
        $("#dbEmail").val(fullEmail);

        // 중복 확인 버튼 상태 변경 및 로딩 표시
        var $checkBtn = $(this);
        $checkBtn.prop('disabled', true).html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 확인 중...');

        // 서버 중복 확인
        $.ajax({
            url: "/userinfo/checkEmailDuplicate.do",
            method: "POST",
            data: {userEmail: fullEmail},
            success: function (isDuplicate) {
                isEmailChecked = true; // 중복 확인

                if (isDuplicate) {
                    alert("중복된 이메일입니다.");
                    isEmailAvailable = false; // 사용 불가능
                } else {
                    alert("사용 가능한 이메일입니다.");
                    isEmailAvailable = true; // 사용 가능
                }

                // 버튼 상태 복원
                $checkBtn.prop('disabled', false).html('중복확인');
            },
            error: function() {
                alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
                isEmailChecked = false;
                isEmailAvailable = false;

                // 버튼 상태 복원
                $checkBtn.prop('disabled', false).html('중복확인');
            }
        });
    });

    // 비밀번호 유효성 검사 함수
    function validatePassword(password) {
        // 10~16자리 체크
        if (password.length < 10 || password.length > 16) {
            return false;
        }

        // 영문 포함 체크
        var letter = /[a-zA-Z]/.test(password);
        // 숫자 포함 체크
        var number = /[0-9]/.test(password);
        // 특수문자 포함 체크
        var specialChar = /[!@#$%^&*()]/.test(password);
        return letter && number && specialChar;
    }

    // 회원 등록 버튼 클릭
    $("#registerBtn").click(function () {
        var email = $("#userEmail").val();
        var domain = $("#userDomain").val();
        var pw = $("#userPassword").val();
        var pwConfirm = $("#passwordConfirm").val();

        // 입력 확인
        if (email === "") {
            alert("이메일을 입력해주세요.");
            $("#userEmail").focus();
            return;
        } else if (domain === "") {
            alert("도메인을 입력하거나 선택해주세요.");
            $("#userDomain").focus();
            return;
        } else if (pw === "") {
            alert("비밀번호를 입력해주세요.");
            $("#userPassword").focus();
            return;
        } else if (pwConfirm === "") {
            alert("비밀번호 확인을 입력해주세요.");
            $("#passwordConfirm").focus();
            return;
        } else if (!validatePassword(pw)) {
            alert("비밀번호는 10~16자리의 영문과 숫자, 특수문자를 포함해야 합니다.");
            $("#userPassword").focus();
            return;
        } else if (pw !== pwConfirm) {
            alert("비밀번호가 일치하지 않습니다.");
            $("#passwordConfirm").focus();
            return;
        } else if (!isEmailChecked) {
            alert("이메일 중복 확인을 해주세요.");
            return;
        } else if (!isEmailAvailable) {
            alert("사용할 수 없는 이메일입니다. 다른 이메일을 사용해주세요.");
            return;
        }

        $("#dbEmail").val(email + "@" + domain);

        alert("회원가입이 완료되었습니다.");

        $("#userForm").submit();
    });
});