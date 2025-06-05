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

        resetEmailCheckStatus();
    });

    var isTyping = false;
    var savedValue = "";

    // 허용할 키코드들 : 8=Backspace, 46=Delete, 9=Tab, 27=Escape, 13=Enter, 37=좌화살표, 39=우화살표, 38=위화살표, 40=아래화살표, 36=Home, 35=End, 33=PageUp, 34=PageDown
    //                16=Shift, 17=Ctrl, 18=Alt, 20=CapsLock, 91=좌Windows키, 93=우Windows키, 112~123=F1~F12키, 144=NumLock, 145=ScrollLock
    var allowedKeys = [
        8, 46, 9, 27, 13, 37, 39, 38, 40, 36, 35, 33, 34, 16, 17, 18, 20, 91, 93, 144, 145];


    // 한글 조합 시작
    $('#userName').on("compositionstart", function () {
        isTyping = true;
        savedValue = $(this).val(); // 현재 입력된 값 저장
    });

    // 한글 조합 완료
    $('#userName').on("compositionend", function () {
        isTyping = false;

        var currentValue = $(this).val();

        // 길이 초과하면 저장된 값으로 되돌리기
        if (currentValue.length > 10) {
            $(this).val(savedValue);
        } else {
            savedValue = currentValue; // 유효하면 저장
        }
    });

    // 실시간으로 입력 차단
    $('#userName').on("beforeinput", function (event) {
        var currentLength = $(this).val().length;

        // 삽입 타입이고 이미 10글자면 차단
        if (event.originalEvent.inputType === 'insertText' && currentLength >= 10) {
            event.preventDefault();
            return false;
        }
        // 조합 중이고 길이 초과 예상되면 차단
        else if (isTyping && currentLength >= 10) {
            event.preventDefault();
            return false;
        }
    });

    $('#userName').on("input", function () {
        // 한글 조합 중이 아닐 때만 길이 체크
        if (!isTyping) {
            var currentValue = $(this).val();

            if (inputValue.length > 10) {
                $(this).val(currentValue.substring(0, 10));
            } else {
                savedValue = currentValue;
            }
        }
    })

    // 글자 수 입력 제한 (20자에서 추가 입력 방지)
    $('#userEmail, #userDomain').on("keydown", function (event) {
        var currentLength = $(this).val().length;

        // Ctrl이나 Cmd 키와 함께 누른 조합키는 허용 (복사, 붙여넣기 등)
        if (event.ctrlKey || event.metaKey) {
        }
        // 허용된 키가 아니고, 현재 길이가 최대값에 도달했으면 입력 막기
        else if (allowedKeys.indexOf(event.keyCode) === -1 && currentLength >= 20) {
            event.preventDefault();
        }
    });

    $('#userName').on("keydown", function (event) {
        var currentLength = $(this).val().length;

        // 한글 조합 중이면 키보드 제한 안함
        if (isTyping) {
        }
        // Ctrl이나 Cmd 키 조합은 허용 (복사, 붙여넣기 등)
        else if (event.ctrlKey || event.metaKey) {
        }
        // 10글자 도달했고 허용되지 않은 키면 차단
        else if (allowedKeys.indexOf(event.keyCode) === -1 && currentLength >= 10) {
            event.preventDefault();
        }
    });

    // 이메일 입력 필터링
    var specialChar = /[ \{\}\[\]\/?.,;:|\)*~`!^\_+┼<>@\#$%&\'\"\\\(\=]/gi;
    var koreanChar = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/gi;
    $('#userEmail').on("input", function () {
        var emailInput = $(this).val();

        if (specialChar.test(emailInput) || koreanChar.test(emailInput)) {
            alert('영문과 숫자만 입력 가능합니다.');
            $(this).val(""); //입력값 초기화
            $(this).focus();
        }

        isEmailChecked = false;
        isEmailAvailable = false;
        $("#duplicateResult").html(""); // 결과 메시지 초기화

        resetEmailCheckStatus();
    });

    // 사용자 도메인 입력 시 중복확인 초기화
    $('#userDomain').on("input", function () {
        resetEmailCheckStatus();
    });

    // 중복확인 상태 리셋
    function resetEmailCheckStatus() {
        isEmailChecked = false;
        isEmailAvailable = false;
        $('#duplicateResult').html("");

        // 버튼을 원래 상태로 되될림
        $('#checkemailBtn')
            .prop("disabled", false)
            .removeClass("btn-success btn-secondary")
            .addClass("btn-outline-primary")
            .text("중복확인")
    }

    // 중복확인 버튼 로딩 상태로 변경
    function setButtonLoading() {
        $("#checkemailBtn")
            .prop("disabled", true)
            .removeClass("btn-outline-primary btn-success")
            .addClass("btn-secondary")
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

                    resetEmailCheckStatus();
                }
            });
        }, 2000);
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