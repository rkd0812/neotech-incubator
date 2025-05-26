$(function (){
    function getTodayString() {
        var today = new Date();
        var year = today.getFullYear();
        var month = (today.getMonth() + 1).toString().padStart(2, '0');
        var day = today.getDate().toString().padStart(2, '0');
        return year + '-' + month + '-' + day;
    }

    // 날짜 입력 필드의 최대값을 오늘 날짜로 설정
    var todayString = getTodayString();
    $('#startDate').attr('max', todayString);
    $('#endDate').attr('max', todayString);

    // 페이지 로드 시 체크박스 상태 초기화
    function initCheckboxState() {
        var checkedStatuses = $('input[name="searchEvaCd"]:checked');
        if(checkedStatuses.length > 0) {
            // 각 심사상태 체크되어 있으면 [전체] 해제
            $('#allStatus').prop('checked', false);
        } else {
            // 각 심사상태가 없으면 [전체] 체크
            $('#allStatus').prop('checked', true);
        }
    }
    // 페이지 로드 시 초기화
    initCheckboxState();

    // [전체] 체크박스 클릭 시
    $('#allStatus').on('change', function(){
        if($(this).is(':checked')) {
            // [전체]가 체크되면 개별 상태들 모두 해제
            $('input[name="searchEvaCd"]').prop('checked', false);
        }
    });

    // 🎯 개별 상태 체크박스들 클릭 시 (원래 로직 복원)
    $('input[name="searchEvaCd"]').on('change', function(){
        if($(this).is(':checked')) {
            // ✅ 개별 상태가 체크되면 전체만 해제 (다른 개별 상태는 그대로 유지)
            $('#allStatus').prop('checked', false);
        } else {
            // ✅ 체크 해제될 때: 모든 개별 상태가 해제되면 전체를 다시 체크
            if($('input[name="searchEvaCd"]:checked').length === 0) {
                $('#allStatus').prop('checked', true);
            }
        }
    });

    // 🔍 검색 버튼 클릭 이벤트
    $('#search_btn').on('click', function(){
        // 📅 날짜 유효성 검사
        var startDate = $('#startDate').val();
        var endDate = $('#endDate').val();

        // 시작일과 종료일이 모두 입력된 경우 유효성 검사
        if(startDate !== '' && endDate !== '') {
            if (startDate > endDate) {
                alert('종료일은 시작일보다 이후여야 합니다.');
                return;
            }
        }

        // 현재 날짜보다 미래 날짜가 입력되었는지 확인
        if(startDate !== '' && startDate > todayString) {
            alert('시작일은 오늘 날짜보다 미래일 수 없습니다.');
            return;
        }

        if(endDate !== '' && endDate > todayString) {
            alert('종료일은 오늘 날짜보다 미래일 수 없습니다.');
            return;
        }

        // 🏷️ 전체가 선택된 경우 개별 상태 체크박스들을 모두 해제
        // (서버에서 상태 조건 없이 검색하도록)
        if($('#allStatus').is(':checked')) {
            $('input[name="searchEvaCd"]').prop('checked', false);
        }

        // 🎯 검색 폼 제출
        $('#searchForm').submit();
    });

    // 🧹 초기화 버튼 클릭 이벤트
    $('#reset_btn').on('click', function(){
        // 모든 입력 필드 초기화
        $('#startDate').val('');
        $('#endDate').val('');
        $('#projectName').val('');

        // 상태 체크박스 초기화 (전체 선택 상태로)
        $('#allStatus').prop('checked', true);
        $('input[name="searchEvaCd"]').prop('checked', false);

        // 전체 목록 조회 (검색 조건 없이)
        window.location.href = '/project/projectList.do';
    });

    // 로그아웃 버튼
    $('#logoutBtn').on('click', function(e) {
        e.preventDefault();

        if (confirm('로그아웃 하시겠습니까?')) {
            location.href = '/userinfo/logout.do';
        }
    });

    // 프로젝트 등록 버튼
    $('#register_btn').on('click', function(){
        window.location.href = '/project/registProjectForm.do';
    });
});