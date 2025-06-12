$(function() {

    const codeInfoForm = $('#codeInfoForm');

    // 수정
    $('#updateBtn').click(function() {
        if(confirm("수정하시겠습니까?")) {
            if($('#upperCodeName').val() === '' ) {
                alert("상위코드명을 입력해주세요.");
            } else if ($('#codeVal').val() === '') {
                alert("코드값을 입력해주세요.");
            } else if ($('#codeName').val() === '') {
                alert("코드명을 입력해주세요.");
            } else {
                codeInfoForm.attr("method", "POST");
                codeInfoForm.attr("action", "/admin/code/update.do");
                codeInfoForm.submit();
            }
        }
    })

    // 삭제
    $('#deleteBtn').click(function() {
        if(confirm("삭제하시겠습니까?")) {
            codeInfoForm.attr("method", "POST");
            codeInfoForm.attr("action", "/admin/code/delete.do");
            codeInfoForm.submit();
        }
    })

})