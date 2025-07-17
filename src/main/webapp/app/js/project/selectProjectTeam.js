$(function () {

    initializeSelectedMembers();

    $('#selectBtn').on('click', function () {
        selectMembers();
    });

    $('#cancelBtn').on('click', function() {
        window.close();
    });

    // 기존 선택된 팀원들을 체크 상태로 설정
    function initializeSelectedMembers() {
        // URL 파라미터에서 선택된 이메일 목록 가져오기
        var urlParams = new URLSearchParams(window.location.search);
        var selectedEmailsParam = urlParams.get('selectedEmails');
        var preSelectedEmails = selectedEmailsParam ? selectedEmailsParam.split(',') : [];

        if (preSelectedEmails.length > 0) {
            $('input[name="member"]').each(function() {
                var email = $(this).val();
                // 기존 선택된 이메일 목록에 있으면 체크
                if (preSelectedEmails.indexOf(email) !== -1) {
                    $(this).prop('checked', true);
                }
            });
        }
    }


    function selectMembers() {
        var members = [];

        $('input[name="member"]:checked').each(function() {
            members.push({
                name: $(this).data('name'),
                email: $(this).val()
            });
        });

        if (members.length > 0) {
            window.opener.receiveSelectedMembers(members);
            window.close();
        } else {
            alert('팀원을 선택해주세요.');
        }
    }
});
