$(function() {

    const userInfoForm = $('#userInfoForm');

    $('#updateBtn').on('click', function() {
        if(confirm("수정하시겠습니까?")) {
            //  TODO: validation
            const userPassword = $('#userPassword');

            if(userPassword.val() !== '') {
                userInfoForm.attr("method", "POST");
                userInfoForm.attr("action", "/admin/user/update.do");
                userInfoForm.submit();
            } else {
                alert("비밀번호를 입력해주세요.");
                userPassword.focus();
            }
        }
    })

    $('#deleteBtn').on('click', function() {
        if(confirm("삭제하시겠습니까?")) {
            userInfoForm.attr("method", "POST");
            userInfoForm.attr("action", "/admin/user/delete.do");
            userInfoForm.submit();
        }
    })


})
