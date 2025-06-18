$(function() {
    initButtons();

    $('#listBtn').on('click', function() {
        location.href = '/project/projectList.do';
    });

    $('#updateBtn').on('click', function() {
    });

    $('#requestEvaBtn').on('click', function() {

    });

    $('#deleteBtn').on('click', function() {
        console.log('삭제 버튼 클릭됨');
        if (confirm('정말로 이 프로젝트를 삭제하시겠습니까?')) {
            $('#deleteForm').submit();
        }
    });

    function initButtons() {
        var status = $('#projectEvaCd').val();

        // 모든 버튼 숨기기
        $('#updateBtn, #requestEvaBtn, #deleteBtn').hide();
        $('#statusMessage').text('');

        if (status === '00') {
            $('#updateBtn, #requestEvaBtn, #deleteBtn').show();
        } else if (status === '01') {
            $('#deleteBtn').show();
        }
    }
});