$(function() {

    $('#btnRegist').click(function() {
        if(confirm("등록하시겠습니까?")) {
            // TODO: validation
            if($('#menuName').val() === '') {
                alert("메뉴명을 입력해주세요.");
                return;
            } else {
                $('#menuRegistForm').submit();
            }

        }
    })

})