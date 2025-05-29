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

    // 날짜 입력 필드의 최대값을 오늘 날짜로 설정
    $('#startDate').attr('max', todayString);
    $('#endDate').attr('max', todayString);

    // 화면 표시용 필드에 기본값 설정
    $('#startDate').val(oneMonthAgoString);  // 한달 전
    $('#endDate').val(todayString);      // 오늘

    // 페이지 로드 시 검색 조건이 있으면 화면에 표시
    // 이미 검색한 상태라면 검색 조건을 화면에 복원
    if ($('#hiddenStartDate').val()) {
        $('#startDate').val($('#hiddenStartDate').val());
    }
    if ($('#hiddenEndDate').val()) {
        $('#endDate').val($('#hiddenEndDate').val());
    }
    if ($('#hiddenProjectName').val()) {
        $('#projectName').val($('#hiddenProjectName').val());
    }
    if ($('#hiddenSearchEvaCd').val()) {
        var evaCd = $('#hiddenSearchEvaCd').val();
        if (evaCd === '00') $('#status00').prop('checked', true);
        else if (evaCd === '01') $('#status01').prop('checked', true);
        else if (evaCd === '02') $('#status02').prop('checked', true);
        else if (evaCd === '03') $('#status03').prop('checked', true);
        else $('#allStatus').prop('checked', true);
    }

    // 버튼 클릭 시 날짜 조정
    $('.date_range_btn').on('click', function () {
        var days = parseInt($(this).data('range')); // data-range 읽기
        var todayString = getTodayString();
        var fromDate = getDaysAgoString(days);

        $('#startDate').val(fromDate);
        $('#endDate').val(todayString);
    });

    // 검색 버튼 클릭 이벤트 (여기서 조건을 hidden 필드로 복사!)
    $('#searchBtn').on('click', function () {
        var startDate = $('#startDate').val();
        var endDate = $('#endDate').val();

        if (startDate && endDate && startDate > endDate) {
            alert('종료일은 시작일보다 이후여야 합니다.');
            return;
        } else if (startDate > todayString) {
            alert('시작일은 오늘 날짜보다 미래일 수 없습니다.');
            return;
        } else if (endDate > todayString) {
            alert('종료일은 오늘 날짜보다 미래일 수 없습니다.');
            return;
        }

        // 조회 버튼 클릭 시에만 화면 값을 hidden 필드로 복사 (실제 검색 조건으로 만들기)
        $('#hiddenStartDate').val($('#startDate').val());
        $('#hiddenEndDate').val($('#endDate').val());
        $('#hiddenProjectName').val($('#projectName').val());

        // 심사 상태 처리
        var selectedEvaCd = $('input[name="displayEvaCd"]:checked').val();
        $('#hiddenSearchEvaCd').val(selectedEvaCd);

        // 검색할 때는 1페이지부터 시작
        $('#currentPageNo').val(1);

        $('#searchForm').submit();
    });

    // 초기화 버튼 클릭 이벤트
    $('#resetBtn').on('click', function () {
        // 모든 검색 조건을 기본값으로 초기화
        $('#startDate').val(oneMonthAgoString);  // 일주일 전
        $('#endDate').val(todayString);      // 오늘
        $('#projectName').val('');           // 프로젝트명 비우기
        $('#allStatus').prop('checked', true); // 심사 상태를 '전체'로 초기화

        // hidden 필드는 비우기 (검색 조건 제거)
        $('#hiddenStartDate').val('');
        $('#hiddenEndDate').val('');
        $('#hiddenProjectName').val('');
        $('#hiddenSearchEvaCd').val('');

        // 페이지를 1페이지로 초기화
        $('#currentPageNo').val(1);
    });

    // 프로젝트 등록 버튼
    $('#registerBtn').on('click', function () {
        location.href = '/project/registProjectForm.do';
    });

});

// 페이징 부분 전역 함수로 선언
function goToPage(pageNumber) {
    $('#currentPageNo').val(pageNumber);
    $('#searchForm').submit();

}

