$(function () {
    function userLoginAlert(message) {
        $(".loginAlert").remove();
        var bootstrapAlert = `
            <div class="alert alert-danger alert-dismissible fade show loginAlert mt-3" role="alert">
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        `;
        $("#userLogin").prepend(bootstrapAlert);
    }

    // 도메인 선택 변경 시
    $("#domainList").change(function () {
        var domain = $(this).val();
        $("#userDomain").val(domain).prop("readonly", domain !== "");
        if (domain === "") $("#userDomain").focus();
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
    });

    // 글자 수 입력 제한 (20자에서 추가 입력 방지)
    $('#userEmail, #userDomain').on("keydown", function (event) {
        var currentLength = $(this).val().length;
        var maxLengthEmail = 20;
        var maxLengthDomain = 20;

        // 허용할 키코드들 : 8=Backspace, 46=Delete, 9=Tab, 27=Escape, 13=Enter, 37=좌화살표, 39=우화살표, 38=위화살표, 40=아래화살표, 36=Home, 35=End, 33=PageUp, 34=PageDown
        //                16=Shift, 17=Ctrl, 18=Alt, 20=CapsLock, 91=좌Windows키, 93=우Windows키, 112~123=F1~F12키, 144=NumLock, 145=ScrollLock
        var allowedKeys = [
            8, 46, 9, 27, 13, 37, 39, 38, 40, 36, 35, 33, 34, 16, 17, 18, 20, 91, 93
            , 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 144, 145];

        // Ctrl이나 Cmd 키와 함께 누른 조합키는 허용 (복사, 붙여넣기 등)
        if (event.ctrlKey || event.metaKey) {
        }
        // 허용된 키가 아니고, 현재 길이가 최대값에 도달했으면 입력 막기
        else if (allowedKeys.indexOf(event.keyCode) === -1 && currentLength >= maxLengthEmail) {
            event.preventDefault();
        }
        else if (allowedKeys.indexOf(event.keyCode) === -1 && currentLength >= maxLengthDomain) {
            event.preventDefault();
        }
    });

    // 폼 제출 시 유효성 검사
    $("#userLogin").submit(function (event) {
        var userEmail = $("#userEmail").val().trim();
        var userDomain = $("#userDomain").val().trim();
        var userPassword = $("#userPassword").val().trim();

        // 필드 검증
        if (userEmail === "") {
            userLoginAlert("이메일을 입력해주세요.");
            $("#userEmail").focus();
            event.preventDefault();
            return false;
        }

        if (userDomain === "") {
            userLoginAlert("도메인을 입력하거나 선택해주세요.");
            $("#userDomain").focus();
            event.preventDefault();
            return false;
        }

        if (userPassword === "") {
            userLoginAlert("비밀번호를 입력해주세요.");
            $("#userPassword").focus();
            event.preventDefault();
            return false;
        } else if (userPassword.length < 10) {
            userLoginAlert("비밀번호는 최소 10자 이상이어야 합니다.");
            $("#userPassword").focus();
            event.preventDefault();
            return false;
        }

        // 이메일 조합
        $("#dbEmail").val(userEmail + "@" + userDomain);
        return true;
    });

    // 회원가입 버튼
    $("#registerBtn").click(function () {
        location.href = "/userinfo/registForm.do";
    });
});