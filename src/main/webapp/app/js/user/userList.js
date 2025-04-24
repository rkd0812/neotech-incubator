$(function() {

    const searchBtn = $('#searchBtn');

    // 검색 폼
    searchBtn.on('click', function() {
        const userDetailForm = $('#userDetailForm');

        userDetailForm.action = "/user/list.do";
        userDetailForm.submit();
    })

    const initBtn = $('#initBtn');

    initBtn.on('click', function() {
        $('input[name="inputEmail"]').val("");
        $('#All').prop('checked', true);

    })

})
