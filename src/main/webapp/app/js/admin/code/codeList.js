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

    // 초기화
    $('#initBtn').click(function() {
        setMonth();
        $('#upperCodeName').val("");
    })

    // 검색
    $('#searchBtn').click(function() {
        const startDate = $('#startDate').val().replaceAll('-', '');
        const endDate = $('#endDate').val().replaceAll('-', '');

        if(startDate > endDate) {
            alert("기간 입력이 잘못 되었습니다.");
        } else {
            $('#searchForm').submit();
        }
    })

    // 등록
    $('#registBtn').click(function() {
        location.href = "/admin/code/openRegist.do";
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