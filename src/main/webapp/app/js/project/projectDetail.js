// $(function (){
//     $('#pro_eva').on('click', function(){
//         if($('#pro_name').val() === '' || $('#explain').val() === ''){
//             alert('빠진 부분이 있으니 확인해주세요.');
//         }
//     });
// })
$(function() {
    // 수정 버튼 클릭 시
    $("#pro_modify").on("click", function() {
        // 유효성 검사
        if($('#pro_name').val() === '' || $('#explain').val() === ''){
            alert('빠진 부분이 있으니 확인해주세요.');
            return;
        }

        if (confirm("프로젝트를 수정하시겠습니까?")) {
            // 폼 데이터 생성
            var formData = {
                projectId: getUrlParameter('projectId'),
                projectName: $("#pro_name").val(),
                projectDetail: $("#explain" ).val(),
                url: $("#url").val(),
                attachmentId: $("#attachment").val()
            };

            // AJAX 요청
            $.ajax({
                url: "/project/updateProject.do",
                type: "POST",
                data: formData,
                success: function(data) {
                    alert("프로젝트가 성공적으로 수정되었습니다.");
                    // 현재 페이지 리로드
                    location.reload();
                },
                error: function(xhr, status, error) {
                    alert("프로젝트 수정 중 오류가 발생했습니다.");
                }
            });
        }
    });

    // 삭제 버튼 클릭 시
    $("#pro_delete").on("click", function() {
        if (confirm("정말로 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.")) {
            $.ajax({
                url: "/project/deleteProject.do",
                type: "POST",
                data: {
                    projectId: getUrlParameter('projectId')
                },
                success: function(data) {
                    alert("프로젝트가 성공적으로 삭제되었습니다.");
                    // 목록 페이지로 이동
                    window.location.href = "/project/projectList.do";
                },
                error: function(xhr, status, error) {
                    alert("프로젝트 삭제 중 오류가 발생했습니다.");
                }
            });
        }
    });

    // 심사요청 버튼 (기존 기능 유지)
    $('#pro_eva').on('click', function(){
        if($('#pro_name').val() === '' || $('#explain').val() === ''){
            alert('빠진 부분이 있으니 확인해주세요.');
        }
    });

    // URL에서 파라미터 추출하는 함수
    function getUrlParameter(name) {
        name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
        var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
        var results = regex.exec(location.search);
        return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
    }
});