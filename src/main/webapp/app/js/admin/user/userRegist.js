$(function() {


    $('#btnRegist').click(() => {
        const userEmailId =  $('#userEmailId').val();
        const userEmailDomain = $('#userEmailDomain').val();
        const userPassword = $('#userPassword').val();

        $('input[name="userEmail"]').val(userEmailId + '@' + userEmailDomain);

        // validation
        if (userEmailId === null || userEmailId === '' || userEmailDomain === null || userEmailDomain === '') {
            alert("이메일을 입력해주세요");
        } else if (userPassword === null || userPassword === '') {
            alert("비밀번호를 입력해주세요");
        } else {
            if(confirm("등록하시겠습니까?")) {
                $('#registForm').submit();
            }
        }
    })


    // 도메인 선택
    $("#domainList").change(function () {
        const domain = $(this).val();
        $('#userEmailDomain').val(domain);
    });

})