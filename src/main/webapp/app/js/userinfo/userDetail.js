$(function() {
    // 수정 버튼 클릭 시
    $("#updateBtn").click(function() {

        var userEmail = $(this).attr("data-email");
        console.log("데이터 속성에서 가져온 이메일: [" + userEmail + "]");

        if(!userEmail || userEmail === "") {
            alert("이메일을 가져올 수 없습니다.");
            return;
        }

        // 페이지 이동
        location.href = "/userinfo/updateForm.do?userEmail=" + userEmail;
    });
    // 삭제 버튼 클릭 시
    $("#deleteBtn").click(function() {
        if (confirm("정말로 삭제하시겠습니까?")) {
            $("#deleteForm").submit();
            alert("회원탈퇴가 완료되었습니다.");
        } else {
            alert("취소되었습니다.");
        }
    });

    // 목록 버튼 클릭 시
    $("#listBtn").click(function() {
        location.href = "/project/projectList.do";
    });
});