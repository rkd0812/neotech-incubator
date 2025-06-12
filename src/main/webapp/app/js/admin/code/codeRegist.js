$(function() {

    $('#btnRegist').click(function() {
        if(confirm("등록하시겠습니까?")) {
            if($('#upperCodeName').val() === '' ) {
                alert("상위코드명을 입력해주세요.");
                return;
            } else if ($('#codeVal').val() === '') {
                alert("코드값을 입력해주세요.");
                return;
            } else if ($('#codeName').val() === '') {
                alert("코드명을 입력해주세요.");
            } else {
                $('#codeRegistForm').submit();
            }
        }
    })

})