$(function () {
    function getTodayString() {
        var today = new Date();
        var year = today.getFullYear();
        var month = (today.getMonth() + 1).toString().padStart(2, '0');
        var day = today.getDate().toString().padStart(2, '0');
        return year + '-' + month + '-' + day;
    }

    // 한달 전 날짜 계산 함수
    function getOneMonthAgoString() {
        var today = new Date();
        var oneMonthAgo = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
        var year = oneMonthAgo.getFullYear();
        var month = (oneMonthAgo.getMonth() + 1).toString().padStart(2, '0');
        var day = oneMonthAgo.getDate().toString().padStart(2, '0');
        return year + '-' + month + '-' + day;
    }

    // 특정 일 수 전의 날짜 구하는 함수
    function getDaysAgoString(days) {
        var today = new Date();
        var pastDate = new Date(today);
        pastDate.setDate(today.getDate() - days);
        var year = pastDate.getFullYear();
        var month = (pastDate.getMonth() + 1).toString().padStart(2, '0');
        var day = pastDate.getDate().toString().padStart(2, '0');
        return year + '-' + month + '-' + day;
    }

    // 날짜 관련 초기 설정
    var todayString = getTodayString();
    var oneMonthAgoString = getOneMonthAgoString();

    // 날짜 입력 필듸의 최소값을 설정
    $('#startDate').attr('min', '2010-01-01');
    $('#endDate').attr('min', '2010-01-01');

    // 날짜 입력 필드의 최대값을 오늘 날짜로 설정
    $('#startDate').attr('max', todayString);
    $('#endDate').attr('max', todayString);

    // 페이지 로드 시 검색 조건이 있으면 화면에 표시
    // 이미 검색한 상태라면 검색 조건을 화면에 복원
    if (!$('#startDate').val()) {
        $('#startDate').val(oneMonthAgoString);  // 한달 전
    }
    if (!$('#endDate').val()) {
        $('#endDate').val(todayString);      // 오늘
    }


    // 버튼 클릭 시 날짜 조정
    $('.date_range_btn').on('click', function () {
        var days = parseInt($(this).data('range')); // data-range 읽기
        var todayString = getTodayString();
        var fromDate = getDaysAgoString(days);

        $('#startDate').val(fromDate);
        $('#endDate').val(todayString);
    });

    // 날짜 선택 시 유효성 자동 체크
    $('#startDate, #endDate').on('change', function () {
        var startDate = $('#startDate').val();
        var endDate = $('#endDate').val();

        if (startDate && endDate && startDate > endDate) {
            alert('종료일은 시작일보다 이후여야 합니다.');

            // 날짜 되돌리기
            $('#startDate').val(oneMonthAgoString);
            $('#endDate').val(todayString);
        }
    });

    // 검색 버튼 클릭 이벤트
    $('#searchBtn').on('click', function () {
        // 검색할 때는 1페이지부터 시작
        $('input[name="currentPageNo"]').val(1);

        $('#searchForm').submit();
    });

    // 초기화 버튼 클릭 이벤트
    $('#initBtn').on('click', function () {
        // 모든 검색 조건을 기본값으로 초기화
        $('#startDate').val(oneMonthAgoString);  // 한달 전
        $('#endDate').val(todayString);      // 오늘
        $('#projectName').val('');           // 프로젝트명 비우기
        $('#All').prop('checked', true);     // 심사 상태를 '전체'로 초기화

        // 페이지를 1페이지로 초기화
        $('input[name="currentPageNo"]').val(1);
    });

    // 프로젝트 등록 버튼
    $('#registBtn').on('click', function () {
        location.href = '/project/projectRegist.do';
    });

});

//  페이징
function fnPaging(pageNo) {
    $('input[name="currentPageNo"]').val(pageNo);
    $('#searchForm').submit();
}

