$(function() {

    $('#btnRegist').click(function() {
        if(confirm("등록하시겠습니까?")) {
            $('#registForm').submit();
        }
    })

})