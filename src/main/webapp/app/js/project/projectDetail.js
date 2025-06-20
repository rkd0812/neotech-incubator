$(function () {
    initButtons();

    $('#listBtn').on('click', function () {
        location.href = '/project/projectList.do';
    });

    $('#updateBtn').on('click', function () {
        var projectId = $('#projectId').val();
        location.href = '/project/projectUpdate.do?projectId=' + projectId;
    });

    $('#requestEvaBtn').on('click', function () {
        if (confirm('심사요청을 하시겠습니까?\n심사요청 후에는 수정이 불가능합니다.')) {
            var projectId = $('#projectId').val();

            // 폼 생성해서 제출
            var form = $('<form></form>');
            form.attr('method', 'post');
            form.attr('action', '/project/requestEvaluation.do');
            form.append('<input type="hidden" name="projectId" value="' + projectId + '" />');
            form.appendTo('body').submit();
        }
    });

    $('#deleteBtn').on('click', function () {
        if (confirm('정말로 이 프로젝트를 삭제하시겠습니까?')) {
            $('#deleteForm').submit();
        }
    });

    function initButtons() {
        var status = $('#projectEvaCd').val();

        // 모든 버튼 숨기기
        $('#updateBtn, #requestEvaBtn, #deleteBtn').hide();


        if (status === '00') {
            $('#updateBtn, #requestEvaBtn, #deleteBtn').show();
        } else if (status === '01') {
            $('#deleteBtn').show();
        }
    }
});

// 파일 다운로드 함수 (전역 함수로 선언)
function downloadFile(projectId) {
    try {
        // 다운로드 URL 생성
        var downloadUrl = '/project/downloadFile.do?projectId=' + projectId;

        // 임시 링크 생성해서 클릭
        var link = document.createElement('a');
        link.href = downloadUrl;
        link.download = ''; // 서버에서 파일명 결정
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);

    } catch (error) {
        alert('파일 다운로드 중 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.');
        console.error('다운로드 오류:', error);
    }
}