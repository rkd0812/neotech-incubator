$(function () {
    // 중복 확인 상태
    var isEmailChecked = false; // 이메일 중복 확인 여부
    var isEmailAvailable = false; // 이메일 사용 가능 여부

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

        resetEmailCheckStatus();  // 값이 바뀌었으므로 상태 리셋
    });

    // 허용할 키코드들 : 8=Backspace, 46=Delete, 9=Tab, 27=Escape, 13=Enter, 37=좌화살표, 39=우화살표, 38=위화살표, 40=아래화살표, 36=Home, 35=End, 33=PageUp, 34=PageDown
    //                16=Shift, 17=Ctrl, 18=Alt, 20=CapsLock, 91=좌Windows키, 93=우Windows키, 112~123=F1~F12키, 144=NumLock, 145=ScrollLock
    var allowedKeys = [
        8, 46, 9, 27, 13, 37, 39, 38, 40, 36, 35, 33, 34, 16, 17, 18, 20, 91, 93, 144, 145];


    // 실시간으로 입력 차단
    $('#userName').on("beforeinput", function (event) {
        var currentLength = $(this).val().length;

        // 삽입 타입이고 이미 10글자면 차단 (영어)
        if (currentLength >= 10) {
            var inputType = event.originalEvent.inputType;

            // 삭제 관련 입력만 허용
            if (inputType && (
                inputType.includes('delete') ||
                inputType.includes('backward') ||
                inputType === 'deleteContentBackward' ||
                inputType === 'deleteContentForward'
            )) {
                return true; // 삭제는 허용
            }

            event.preventDefault();
            return false;
        }
    });

    $('#userName').on("input", function () {
        var currentValue = $(this).val();

        if (currentValue.length > 10) {
            $(this).val(currentValue.substring(0, 10));
        }
    });

    $('#userName').on("keydown", function (event) {
        var currentLength = $(this).val().length;

        // Ctrl 이나 Cmd 키 조합 허용 (복사, 붙여넣기 등)
        if (event.ctrlKey || event.metaKey) {
            return true;
        }
    });

    // 글자 수 입력 제한 (20자에서 추가 입력 방지)
    $('#userEmail, #userDomain').on("keydown", function (event) {
        var currentLength = $(this).val().length;

        if (event.ctrlKey || event.metaKey) {
            return true;
        }
        else if (allowedKeys.indexOf(event.keyCode) === -1 && currentLength >= 20) {
            event.preventDefault();
        }
    });

    // 이메일 입력 필터링
    var specialChar = /[ \{\}\[\]\/?.,;:|\)*~`!^\_+┼<>@\#$%&\'\"\\\(\=]/gi; //gi → 전체에서 대소문자 구분안하고 찾기
    var koreanChar = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/gi; //gi → 전체에서 대소문자 구분안하고 찾기
    $('#userEmail').on("input", function () {
        var emailInput = $(this).val();

        if (specialChar.test(emailInput) || koreanChar.test(emailInput)) {    // 금지 문자 검사
            alert('영문과 숫자만 입력 가능합니다.');
            $(this).val(""); //입력값 초기화
            $(this).focus();
        }

        isEmailChecked = false;
        isEmailAvailable = false;
        $("#duplicateResult").html(""); // 결과 메시지 초기화

        resetEmailCheckStatus();  // 값이 바뀌었으므로 상태 리셋
    });

    // 사용자 도메인 입력 시 중복확인 초기화
    $('#userDomain').on("input", function () {
        resetEmailCheckStatus();  // 값이 바뀌었으므로 상태 리셋
    });

    // 중복확인 상태 리셋
    function resetEmailCheckStatus() {
        isEmailChecked = false;      // 중복확인
        isEmailAvailable = false;    // 이메일 사용 가능 여부 확인
        $('#duplicateResult').html("");  // 결과 메세지 초기화

        // 버튼을 원래 상태로 되될림
        $('#checkemailBtn')
            .prop("disabled", false)      // 버튼 활성화
            .removeClass("btn-success btn-secondary")  // 기존 색깔 클래스 제거
            .addClass("btn-outline-primary")   // 원래 색으로 변경
            .text("중복확인")
    }

    // 중복확인 버튼 로딩 상태로 변경
    function setButtonLoading() {
        $("#checkemailBtn")
            .prop("disabled", true)  // 버튼 비활성화
            .removeClass("btn-outline-primary btn-success")  // 기존 색 제거
            .addClass("btn-secondary")  // 회색으로 변경
            .html('<span class="spinner-border spinner-border-sm me-2" role="status"></span>확인중...');
    }

    // 중복확인 완료 후 버튼 상태 설정
    function setButtonResult(isAvailable) {
        if (isAvailable) {
            // 사용 가능한 경우 - 버튼 비활성화 및 성공 상태로 변경
            $("#checkemailBtn")
                .prop("disabled", true)
                .removeClass("btn-outline-primary btn-secondary")
                .addClass("btn-success")
                .html('<i class="fas fa-check me-1"></i>확인완료');
        } else {
            // 사용 불가능한 경우 - 버튼 다시 활성화
            $("#checkemailBtn")
                .prop("disabled", false)
                .removeClass("btn-secondary btn-success")
                .addClass("btn-outline-primary")
                .text("중복확인");
        }
    }

    // 중복 확인 버튼 클릭
    $("#checkemailBtn").click(function () {
        var email = $("#userEmail").val();
        var domain = $("#userDomain").val();

        // 입력 확인
        if (email === "") {
            alert("이메일을 입력해주세요.");
            $("#userEmail").focus();
        }
        else if (domain === "") {
            alert("도메인을 입력하거나 선택해주세요.");
            $("#userDomain").focus();
        }

        // 이메일 조합
        var fullEmail = email + "@" + domain;
        $("#dbEmail").val(fullEmail);

        // 로딩 상태로 버튼 변경
        setButtonLoading();

        // 실제 서버 요청 전에 2초 대기
        setTimeout(function () {
            // 서버 중복 확인
            $.ajax({
                url: "/userinfo/checkEmailDuplicate.do",
                method: "POST",
                data: {userEmail: fullEmail},
                success: function (isDuplicate) {
                    isEmailChecked = true; // 중복 확인

                    if (isDuplicate) {
                        $("#duplicateResult").html("이미 사용 중인 이메일입니다.").css("color", "red");
                        isEmailAvailable = false; // 사용 불가능
                        setButtonResult(false); // 버튼 다시 활성화
                    } else {
                        $("#duplicateResult").html("사용 가능한 이메일입니다.").css("color", "green");
                        isEmailAvailable = true; // 사용 가능
                        setButtonResult(true); // 버튼을 비활성화하고 성공 상태로 변경

                    }
                },
                error: function () {
                    alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
                    isEmailChecked = false;
                    isEmailAvailable = false;
                    $("#duplicateResult").html("");

                    resetEmailCheckStatus(); // 값이 바뀌었으므로 상태 리셋
                }
            });
        }, 2000);  // 2초 후에 실제로 요청 (로딩 하기 위해)
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
        var specialOk = hasAllowedSpecialChar && !hasForbiddenChar;  // 허용된 문자는 있어야 하고 금지된 문자는 없어야 함
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

    $('#userPassword').on('input', function() {  // 실시간 조건 체크
        var password = $(this).val();
        checkPasswordRequirements(password);
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
        var specialChar = /[!@#$%^&*()-_+=.]/.test(password);
        return letter && number && specialChar;
    }

    // 회원 등록 버튼 클릭
    $("#registerBtn").click(function () {
        var userName = $("#userName").val();
        var email = $("#userEmail").val();
        var domain = $("#userDomain").val();
        var pw = $("#userPassword").val();
        var pwConfirm = $("#passwordConfirm").val();

        // 입력 확인
        if (userName === "") {
            alert("성함을 입력해주세요.");
            $("#userName").focus();
            return;
        } else if (email === "") {
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