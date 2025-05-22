$(function (){
    $('#search_btn').on('click', function(){
        if($('#startdate').val() === '' && $('#enddate').val() === '' &&
            $('#search-txt').val() === '' && $('#search_btn').val() === ''){
            alert('기간, 검색어, 상태 중 하나라도 입력해주세요.');
        }

        if($('#startdate').val() !== '' && $('#enddate').val() !== '') {
            var startDate = new Date($('#startdate').val());
            var endDate = new Date($('#enddate').val());

            if (startDate > endDate) {
                alert('종료일은 시작일보다 이후여야 합니다.');
                return;
            }
        }
        $('#searchForm').submit();
    });

    $('#logoutBtn').on('click', function(e) {
        e.preventDefault();

        if (confirm('로그아웃 하시겠습니까?')) {
            location.href = '/userinfo/logout.do';
        }
    });

    $('#register_btn').on('click', function(){
        alert("프로젝트 등록 기능은 아직 구현되지 않았습니다.");
    });
})

