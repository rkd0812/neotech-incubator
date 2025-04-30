$(function() {
    // 수정 버튼 클릭 시
    $("#updateBtn").click(function() {
        var userEmail = "${userInfo.userEmail}";
        location.href = "/userinfo/updateForm.do?userEmail=" + encodeURIComponent(userEmail);
    });

    // 삭제 버튼 클릭 시
    $("#deleteBtn").click(function() {
        if (confirm("정말로 삭제하시겠습니까?")) {
            $("#deleteForm").submit();
            alert("삭제가 완료되었습니다.");
        } else {
            alert("취소되었습니다.");
        }
    });

    // 목록 버튼 클릭 시
    $("#listBtn").click(function() {
        location.href = "/userinfo/userinfoList.do";
    });
});