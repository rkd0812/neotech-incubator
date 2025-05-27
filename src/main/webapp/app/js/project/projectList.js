$(function (){
    function getTodayString() {
        var today = new Date();
        var year = today.getFullYear();
        var month = (today.getMonth() + 1).toString().padStart(2, '0');
        var day = today.getDate().toString().padStart(2, '0');
        return year + '-' + month + '-' + day;
    }

    // 일주일 전 날짜 계산 함수
    function getWeekAgoString() {
        var today = new Date();
        var weekAgo = new Date(today.getTime() - (6 * 24 * 60 * 60 * 1000)); // 7일 전
        var year = weekAgo.getFullYear();
        var month = (weekAgo.getMonth() + 1).toString().padStart(2, '0');
        var day = weekAgo.getDate().toString().padStart(2, '0');
        return year + '-' + month + '-' + day;
    }

    // 날짜 관련 초기 설정
    var todayString = getTodayString();
    var weekAgoString = getWeekAgoString();

    // 날짜 입력 필드의 최대값을 오늘 날짜로 설정
    $('#startDate').attr('max', todayString);
    $('#endDate').attr('max', todayString);

    // 기본 날짜 설정 (처음 접속할 때만)
    if ($('#startDate').val() === '' && $('#endDate').val() === '') {
        $('#startDate').val(weekAgoString);  // 일주일 전
        $('#endDate').val(todayString);      // 오늘
    }

    // 페이지 로드 시 체크박스 상태 초기화
    function initCheckboxState() {
        // 실제 검색 조건을 기준으로 체크박스 상태 설정
        var hiddenEvaCd = $('#hiddenSearchEvaCd').val();
        if (hiddenEvaCd) {
            $('#allStatus').prop('checked', false);
            if (hiddenEvaCd.includes('01')) $('#status01').prop('checked', true);
            if (hiddenEvaCd.includes('02')) $('#status02').prop('checked', true);
            if (hiddenEvaCd.includes('03')) $('#status03').prop('checked', true);
        } else {
            $('#allStatus').prop('checked', true);
        }

        // 화면 표시용 필드에 실제 검색 조건 표시
        if ($('#hiddenStartDate').val()) {
            $('#startDate').val($('#hiddenStartDate').val());
        }
        if ($('#hiddenEndDate').val()) {
            $('#endDate').val($('#hiddenEndDate').val());
        }
        if ($('#hiddenProjectName').val()) {
            $('#projectName').val($('#hiddenProjectName').val());
        }
    }
    initCheckboxState();

    // [전체] 체크박스 클릭 시
    $('#allStatus').on('change', function(){
        if($(this).is(':checked')) {
            $('#status01, #status02, #status03').prop('checked', false);
        }
    });

    // 개별 상태 체크박스들 클릭 시
    $('#status01, #status02, #status03').on('change', function(){
        if($(this).is(':checked')) {
            $('#allStatus').prop('checked', false);
        } else {
            if($('#status01:checked, #status02:checked, #status03:checked').length === 0) {
                $('#allStatus').prop('checked', true);
            }
        }
    });

    // 검색 버튼 클릭 이벤트 (여기서 조건을 hidden 필드로 복사!)
    $('#search_btn').on('click', function(){
        var startDate = $('#startDate').val();
        var endDate = $('#endDate').val();

        if(startDate && endDate && startDate > endDate) {
            alert('종료일은 시작일보다 이후여야 합니다.');
            return;
        } else if(startDate > todayString) {
            alert('시작일은 오늘 날짜보다 미래일 수 없습니다.');
            return;
        } else if(endDate > todayString) {
            alert('종료일은 오늘 날짜보다 미래일 수 없습니다.');
            return;
        }

        // 조회 버튼 클릭 시에만 화면 값을 hidden 필드로 복사 (실제 검색 조건으로 만들기)
        $('#hiddenStartDate').val($('#startDate').val());
        $('#hiddenEndDate').val($('#endDate').val());
        $('#hiddenProjectName').val($('#projectName').val());

        // 심사 상태 처리
        if($('#allStatus').is(':checked')) {
            $('#hiddenSearchEvaCd').val(''); // 전체 선택 시 빈 값
        } else {
            var selectedEvaCd = [];
            if($('#status01').is(':checked')) selectedEvaCd.push('01');
            if($('#status02').is(':checked')) selectedEvaCd.push('02');
            if($('#status03').is(':checked')) selectedEvaCd.push('03');
            $('#hiddenSearchEvaCd').val(selectedEvaCd.join(','));
        }

        // 검색할 때는 1페이지부터 시작
        $('#pageNum').val(1);

        $('#searchForm').submit();
    });

    // 초기화 버튼 클릭 이벤트
    $('#reset_btn').on('click', function(){
        // 화면 표시용 필드 초기화 + 기본 날짜 설정
        $('#startDate').val(weekAgoString);
        $('#endDate').val(todayString);
        $('#projectName').val('');

        // 심사 상태 체크박스 초기화
        $('#allStatus').prop('checked', true);
        $('#status01, #status02, #status03').prop('checked', false);

        // hidden 필드도 모두 초기화 (검색 조건 제거)
        $('#hiddenStartDate').val('');
        $('#hiddenEndDate').val('');
        $('#hiddenProjectName').val('');
        $('#hiddenSearchEvaCd').val('');
        $('#pageNum').val(1);

        // 전체 리스트로 이동
        $('#searchForm').submit();
    });

    // 로그아웃 버튼
    $('#logoutBtn').on('click', function(e) {
        e.preventDefault();
        if (confirm('로그아웃 하시겠습니까?')) {
            document.location.href = '/userinfo/logout.do';
        }
    });

    // 프로젝트 등록 버튼
    $('#register_btn').on('click', function(){
        document.location.href = '/project/registProjectForm.do';
    });

});

// 페이징 부분 전역 함수로 선언
function goToPage(pageNumber) {
    $('#pageNum').val(pageNumber);
    // hidden 필드는 그대로 유지 (검색 조건 유지)
    $('#searchForm').submit();
}