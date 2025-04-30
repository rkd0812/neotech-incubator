$(function() {


    $('#btnRegist').click(() => {
        if(confirm("등록하시겠습니까?")) {
            // TODO: validation
            $('#registForm').submit();
        }
    })

})