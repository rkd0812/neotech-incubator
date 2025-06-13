$(function() {
    updateCharCount();

    $('#projectDetail').on('input', function() {
        updateCharCount();
    });

    function updateCharCount() {
        var length = $('#projectDetail').val().length;
        $('#charCount').text(length);

        if (length > 1000) {
            $('#charCount').css('color', 'red');
        } else {
            $('#charCount').css('color', 'black');
        }
    }

    // 목록 버튼
    $('#listBtn').on('click', function() {
        if (confirm('작성 중인 내용이 사라집니다. 정말 목록으로 이동하시겠습니까?')) {
            location.href = '/project/projectList.do';
        }
    });

    // 등록
    $('#submitBtn').on('click', function() {
        if (!checkForm()) {
            return;
        }

        if (confirm('프로젝트를 등록하시겠습니까?')) {
            $('#actionType').val('submit');
            $('#projectForm').submit();
        }
    });
});

// 폼 검증 함수
function checkForm() {
    var projectName = $('#projectName').val().trim();

    if (!projectName) {
        alert('프로젝트명을 입력해주세요.');
        $('#projectName').focus();
        return false;
    }

    if (projectName.length > 100) {
        alert('프로젝트명은 100자 이내로 입력해주세요.');
        $('#projectName').focus();
        return false;
    }

    var detail = $('#projectDetail').val();
    if (detail.length > 1000) {
        alert('프로젝트 설명은 1000자 이내로 입력해주세요.');
        $('#projectDetail').focus();
        return false;
    }

    return true;
}