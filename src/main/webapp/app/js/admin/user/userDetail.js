$(function() {


    $('#updateBtn').on('click', function() {
        if(confirm("수정하시겠습니까?")) {
            //  TODO: validation
            $('#detailForm').submit();
        }


    })

    $('#deleteBtn').on('click', function() {
        if(confirm("삭제하시겠습니까?")) {
            location.href = "/admin/user/delete.do?userEmail=" + $('input[name="userEmail"]').val();
        }
    })


})
