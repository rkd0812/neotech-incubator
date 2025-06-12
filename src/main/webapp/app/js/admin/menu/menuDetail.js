$(function() {

    const menuInfoForm = $('#menuInfoForm');

    // 수정
    $('#updateBtn').click(function() {
        if(confirm("수정하시겠습니까?")) {
            menuInfoForm.attr("method", "POST");
            menuInfoForm.attr("action", "/admin/menu/update.do");
            menuInfoForm.submit();
        }
    })

    // 삭제
    $('#deleteBtn').click(function() {
        if(confirm("삭제하시겠습니까?")) {
            menuInfoForm.attr("method", "POST");
            menuInfoForm.attr("action", "/admin/menu/delete.do");
            menuInfoForm.submit();
        }
    })

})