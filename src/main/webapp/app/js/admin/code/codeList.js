$(function() {

    // 초기화
    $('#initBtn').click(function() {
        $('#codeName').val("");
    })

    // 검색
    $('#searchBtn').click(function() {
        $('#searchForm').submit();
    })

    // 등록
    $('#registBtn').click(function() {
        location.href = "/admin/code/openRegist.do";
    })

})