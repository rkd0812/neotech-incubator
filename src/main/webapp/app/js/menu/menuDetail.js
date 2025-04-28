$(function() {

    // 수정
    $('#updateBtn').click(function() {
        if(confirm("수정하시겠습니까?")) {
            $('#detailForm').submit();
        }
    })

    // 삭제
    $('#deleteBtn').click(function() {
        if(confirm("삭제하시겠습니까?")) {
            location.href = "/menu/delete.do?menuId=" + $('input[name="menuId"]').val();
        }

    })

})