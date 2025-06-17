$(function() {
    updateCharCount();

    $('#projectDetail').on('input', function() {
        updateCharCount();
    });

    // 파일 선택했을 때 처리
    $('#uploadFile').on('change', function() {
        handleFileSelect();
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

    function handleFileSelect() {
        var fileInput = $('#uploadFile')[0];
        var file = fileInput.files[0];

        if (file) {
            // 파일 크기 체크 (10MB)
            var maxSize = 10 * 1024 * 1024;
            if (file.size > maxSize) {
                alert('파일 크기는 10MB 이하만 가능합니다.');
                $('#uploadFile').val('');
                $('#fileInfo').text('선택된 파일이 없습니다.');
                return;
            }

            // 파일 정보 표시
            var fileName = file.name;
            var fileSize = getFileSizeText(file.size);
            $('#fileInfo').html('<strong>' + fileName + '</strong> (' + fileSize + ')');

        } else {
            $('#fileInfo').text('선택된 파일이 없습니다.');
        }
    }

    // 🔧 수정: getFileSizeText 함수를 handleFileSelect 밖으로 이동
    function getFileSizeText(bytes) {
        if (bytes < 1024) {
            return bytes + ' B';
        } else if (bytes < 1024 * 1024) {
            return (bytes / 1024).toFixed(1) + ' KB';
        } else {
            return (bytes / (1024 * 1024)).toFixed(1) + ' MB';
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

    // 🔧 수정: checkForm 함수를 $(function() 안으로 이동
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

        // 파일 관련 체크
        var fileInput = $('#uploadFile')[0];
        if (fileInput.files.length > 0) {
            var file = fileInput.files[0];

            // 파일 크기 체크
            var maxSize = 10 * 1024 * 1024; // 10MB
            if (file.size > maxSize) {
                alert('파일 크기는 10MB 이하만 가능합니다.');
                return false;
            }
        }

        return true;
    }
});