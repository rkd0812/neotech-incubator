$(function() {

    const searchBtn = $('#searchBtn');

    // 검색 폼
    searchBtn.on('click', function() {
        const searchForm = $('#searchForm');
        searchForm.submit();
    })

    const initBtn = $('#initBtn');

    initBtn.on('click', function() {
        $('input[name="inputEmail"]').val("");
        $('#All').prop('checked', true);

    })

    $('#registBtn').on('click', () => {
        location.href = '/user/openRegist.do';
    })

})
