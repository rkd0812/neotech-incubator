$(function() {

    // 초기화 버튼
    $('#initBtn').click(function() {
        $('#menuName').val('');
    })

    // 검색 버튼
    $('#searchBtn').click(function() {
        $('#searchForm').submit();
    })

    // 등록 버튼
    $('#registBtn').click(function() {
        location.href = "/menu/openRegist.do";
    })

})