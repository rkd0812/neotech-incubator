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

    $('#myInfoBtn').on('click', function(){
        // POST 방식으로 처리하는 간결한 방법
        var form = $('<form action="/userinfo/userDetail.do" method="post"></form>');
        form.append('<input type="hidden" name="userEmail" value="exam250507@naver.com">');
        $('body').append(form);
        form.submit();
    });

    $('#register_btn').on('click', function(){
        alert("프로젝트 등록 기능은 아직 구현되지 않았습니다.");
    });
})