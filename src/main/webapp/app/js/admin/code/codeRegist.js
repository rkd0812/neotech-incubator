$(function() {

    $('#btnRegist').click(function() {
        if(confirm("등록하시겠습니까?")) {
            if($('#upperCodeName').val() === null || $('#upperCodeName').val() === '' ) {
                alert("상위코드명을 입력해주세요.");
                return;
            } else if ($('#codeVal').val() === null || $('#codeVal').val() === '') {
                alert("코드값을 입력해주세요.");
                return;
            } else if ($('#codeName').val() === null || $('#codeName').val() === '') {
                alert("코드명을 입력해주세요.");
            } else {
                $('#registForm').submit();
            }
        }
    })

})