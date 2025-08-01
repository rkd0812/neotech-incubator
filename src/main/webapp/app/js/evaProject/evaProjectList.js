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

    // 달력 onchange
    $('input[type="date"]').on('change', function() {
        const startDate = $('#startDate').val();
        const endDate = $('#endDate').val();

        if(startDate > endDate) {
            alert('종료일은 시작일보다 이후여야 합니다.');
            setMonth();
        }
    });


    // 버튼 클릭 시 날짜 조정
    $('.date_range_btn').on('click', function () {
        var days = parseInt($(this).data('range')); // data-range 읽기

        const today = new Date();
        const day = today.getDate();
        const month = today.getMonth();
        const year = today.getFullYear();

        const startDate = new Date(year, month, day - days).toISOString();
        $('#startDate').val(startDate.substring(0, 10));
        $('#endDate').val(today.toISOString().substring(0, 10));
    });

    // 초기화 버튼
    $('#initBtn').click(function() {
        setMonth();
        $('#projectName').val('');
        $('#All').prop('checked', true);

    })

    // 검색 버튼
    $('#searchBtn').click(function() {
        const startDate = $('#startDate').val().replaceAll('-', '');
        const endDate = $('#endDate').val().replaceAll('-', '');

        if(startDate > endDate) {
            alert('종료일은 시작일보다 이후여야 합니다.');
        } else {
            $('input[name="currentPageNo"]').val(1);
            $('#searchForm').submit();
        }
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