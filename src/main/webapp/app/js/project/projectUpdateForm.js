$(function () {

    $('#updateBtn').on('click', function () {
        if (confirm('프로젝트를 수정하시겠습니까?')) {
            submitForm();
        }
    });

    // 취소 버튼 클릭
    $('#cancleBtn').on('click', function () {
        var projectId = $('#projectId').val();
        location.href = '/project/projectDetail.do?projectId=' + projectId;
    });

    // 삭제 버튼 클릭
    $('#deleteBtn').on('click', function () {
        if (confirm('정말로 이 프로젝트를 삭제하시겠습니까?')) {
            $('#deleteForm').submit();
        }
    });

    // 폼 제출 함수
    function submitForm() {
        var form = $('#projectForm');

        form.submit();
    }
});


// 팝업창 열기 함수
function openPopup() {
    var popupWidth = 1000;
    var popupHeight = 600;

    // 현재 브라우저 창의 위치와 크기를 기준으로 계산
    var left = window.screenX + (window.outerWidth / 2) - (popupWidth / 2);
    var top = window.screenY + (window.outerHeight / 2) - (popupHeight / 2);

    var option = 'width=' + popupWidth + ',height=' + popupHeight + ',left=' + left + ',top=' + top + ',scrollbars=yes,resizable=yes';

    window.open('/project/popup/teamMemberSelect.do', 'teamPopup', option);
}


function receiveSelectedMembers(members) {
    if (members.length > 0) {
        var emails = [];
        var names = [];

        for (var i = 0; i < members.length; i++) {
            emails.push(members[i].email);
            names.push(members[i].name);
        }

        // hidden input에 데이터 저장
        $('#teamMemberEmails').val(emails.join(','));
        $('#teamMemberNames').val(names.join(','));

        // 화면에 표시 업데이트
        $('#selectedMembers').text(names.join(', '));
    }
}