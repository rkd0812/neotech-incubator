$(function() {

    // 수정
    $('#updateBtn').click(function() {
        if(confirm("수정하시겠습니까?")) {
            if($('#upperCodeName').val() === null || $('#upperCodeName').val() === '' ) {
                alert("상위코드명을 입력해주세요.");
                return;
            } else if ($('#codeVal').val() === null || $('#codeVal').val() === '') {
                alert("코드값을 입력해주세요.");
                return;
            } else if ($('#codeName').val() === null || $('#codeName').val() === '') {
                alert("코드명을 입력해주세요.");
            } else {
                $('#detailForm').submit();
            }
        }
    })

    // 삭제
    $('#deleteBtn').click(function() {
        if(confirm("삭제하시겠습니까?")) {
            location.href = "/admin/code/delete.do?upperCodeName=" + $('#upperCodeName').val() + "&codeVal=" + $('#codeVal').val();
        }
    })

})