$(function () {
    bindEvents();

    function bindEvents() {
        // 목록 버튼
        $('#listBtn').on('click',function () {
            location.href = '/project/projectList.do';
        });

        // 수정 버튼 (수정 페이지로 이동)
        $('#updateBtn').on('click', function () {
            var projectId = getProjectIdFromUrl();
            if (projectId) {
                location.href = '/project/projectUpdateForm.do?projectId=' +projectId;
            } else {
                alert('프로젝트 정보를 찾을 수 없습니다.')
            }
        });

        // 삭제 버튼
        $('#deleteBtn').on('click', function () {
            $('#deleteModal').show();
        });

        $('#downloadBtn').on('click', function () {
            var projectId = getProjectIdFromUrl();
            if (projectId) {
                location.href = '/project/downloadFile.do?projectId=' + projectId;
            } else {
                alert('파일 다운로드에 실패했습니다.');
            }
        });

        // 팀 구성원 보기 버튼
        $('#viewMemberBtn').on('click', function() {
            //
        });

        // 삭제 확인 버튼
        $('#confirmDeleteBtn').on('click', function () {
            confirmDelete();
        });

        // 삭제 취소 버튼
        $('#cancelDeleteBtn').on('click', function() {
            $('#deleteModal').hide();
        });

        // 모달 외부 클릭 시 닫기
        $('#deleteModal').on('click', function(e) {
            if (e.target === this) {
                $('#deleteModal').hide();
            }
        });
    }
})