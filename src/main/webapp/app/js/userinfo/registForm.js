// $(function() {
//     $("#userForm").submit(function(event) {
//         event.preventDefault();
//
//         // 확인 창 표시
//         if(confirm("등록을 하시겠습니까?")) {
//             this.submit(); // 실제 폼 제출
//         }
//     });
// });

$(function () {
    // 이메일 중복 확인
    $("#checkemailBtn").click(function () {
        var userEmail = $("#userEmail").val();

        if (userEmail === "") {
            alert("이메일을 입력해주세요.");
            return;
        }

        $.ajax({
            url: "/userinfo/checkEmailDuplicate.do",
            method: "POST",
            data: {userEmail: userEmail},
            success: function (isDupicate) {
                if (isDupicate) {
                    alert("중복된 아이디입니다.");
                } else {
                    alert("사용 가능한 아이디입니다.");
                }
            },
            error: function () {
                alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
            }
        });
    });

    // 회원가입 버튼 클릭시
    $("#registerBtn").click(function () {
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

        // 회원등록 확인
        if (confirm("회원등록을 하시겠습니까?")) {
            $("#userForm").submit(); // 폼 제출
        }
    });
});