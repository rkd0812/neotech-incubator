$(function () {
    $('#selectBtn').on('click', function () {
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

        console.log('선택된 멤버들:', members);

        if (members.length > 0) {
            window.opener.receiveSelectedMembers(members);
            window.close();
        } else {
            alert('팀원을 선택해주세요.');
        }
    }
});
