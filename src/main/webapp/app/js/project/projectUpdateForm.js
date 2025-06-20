$(function () {

    $('#updateBtn').on('click', function () {
        if (confirm('프로젝트를 수정하시겠습니까?')) {
            submitForm();
        }
    });

    // 취소 버튼 클릭
    $('#cancleBtn').on('click', function () {
        var projectId = $('#projectId').val();
        location.href = '/project/projectDetail.do?projectUd=' + projectId;
    });

    // 삭제 버튼 클릭
    $('#deleteBtn').on('click', function () {
        if (confirm('정말로 이 프로젝트를 삭제하시겠습니까?')) {
            $('#deleteBtn').submit();
        }
    });

    // 폼 제출 함수
    function submitForm() {
        var form = $('#projectForm');
        var projectId = $('#projectId').val();

        // 폼에 필요한 정보 추가
        form.attr('action', '/project/updateProject.do');
        form.append('<input type="hidden" name="projectId" value="' + projectId + '" />');

        // 폼 제출
        form.submit();
    }
});