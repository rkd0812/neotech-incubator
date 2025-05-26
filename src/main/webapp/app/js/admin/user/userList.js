$(function() {

    // 새로고침 시 파라미터 초기화
    $(document).keydown(function(e){
        key = (e)?e.keyCode:event.keyCode;
        //alert(key);
        if(key == 116 || (event.ctrlKey && event.keyCode == 82)) {
            history.replaceState({}, null, location.pathname);
        }
    })

    if($('#startDate').val() === '' && $('#endDate').val() === '') {
        setMonth();
    }

    // 검색 폼
    $('#searchBtn').on('click', function() {
        const startDate = $('#startDate').val().replaceAll('-', '');
        const endDate = $('#endDate').val().replaceAll('-', '');

        if(startDate > endDate) {
            alert("기간 입력이 잘못 되었습니다.");
        } else {
            $('input[name="currentPageNo"]').val(1);
            $('#searchForm').submit();
        }
    })

    // 초기화
    $('#initBtn').on('click', function() {
        setMonth();
        $('input[name="userEmail"]').val("");
        $('#All').prop('checked', true);
    })

    $('#registBtn').on('click', () => {
        location.href = '/admin/user/openRegist.do';
    })

})

const setMonth = function() {
    const now = new Date();
    $('#endDate').val(now.toISOString().substring(0, 10));
    $('#startDate').val(new Date(now.setMonth(now.getMonth() - 1)).toISOString().substring(0, 10));
}

// 페이징
const fnPaging = (page) => {
    $('input[name="currentPageNo"]').val(page);
    $('#searchForm').submit();
}