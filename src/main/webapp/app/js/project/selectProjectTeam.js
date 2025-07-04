$(function () {
    $('s#electBtn').on('click', function () {
        selectMembers();
    });

    $('#cancelBtn').on('click', function() {
        window.close();
    });


    function selectMembers() {
        var members = [];

        $('input[name="member"]:checked').each(function() {
            members.push({
                name: $(this).data('name'),
                email: $(this).val()
            });
        });

        if (members.length > 0) {
            // 부모 창의 함수 호출하고 팝업 닫기
            window.opener.receiveSelectedMembers(members);
            window.close();
        } else {
            alert('팀원을 선택해주세요.');
        }
    }
});
