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
    var replaceChar = /[ \{\}\[\]\/?.,;:|\)*~`!^\_+┼<>@\#$%&\'\"\\\(\=]/gi;
    var replaceNotFullKorean = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/gi;
    $('#userEmail').on("input", function () {
        var emailInput = $(this).val()
            .replace(replaceChar, '')
            .replace(replaceNotFullKorean, '');
        $(this).val(emailInput);
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