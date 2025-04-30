$(function() {

    const searchBtn = $('#searchBtn');

    // 검색 폼
    searchBtn.on('click', function() {
        const searchForm = $('#searchForm');
        searchForm.submit();
    })

    // 초기화
    $('#initBtn').on('click', function() {
        $('input[name="userEmail"]').val("");
        $('#All').prop('checked', true);
    })

    $('#registBtn').on('click', () => {
        location.href = '/admin/user/openRegist.do';
    })

})
