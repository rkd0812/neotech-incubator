<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-04-28
  Time: 오후 4:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--<html>--%>
<%--<head>--%>
<%--    <title>사용자 정보 수정</title>--%>
<%--    <c:import charEncoding="utf-8" url="/layout/cmmnlib.do" />--%>
<%--    <script src="/app/js/userinfo/userUpdateForm.js"></script>--%>
<%--</head>--%>
<%--<body>--%>
<script src="<c:url value="/app/js/userinfo/userUpdateForm.js"/>"></script> <%-- 필수 --%>
<div id="page-wrapper">
    <div class="user-update-container">
        <div class="card shadow">
            <div class="card-header bg-primary text-white text-center">
                <h4 class="mb-0">사용자 정보 수정</h4>
            </div>
            <div class="card-body p-3">

                <form id="updateForm" action="/userinfo/updateUserInfo.do" method="post">

                    <!-- 이메일  -->
                    <div class="mb-3">
                        <label class="form-label fw-bold">이메일</label>
                        <input type="text" class="form-control bg-light" value="${userInfo.userEmail}" readonly>
                        <small class="text-muted">이메일은 변경할 수 없습니다.</small>
                    </div>

                    <!-- 비밀번호 -->
                    <div class="mb-3">
                        <label for="userPassword" class="form-label fw-bold">새 비밀번호</label>
                        <input type="password" class="form-control" id="userPassword" name="userPassword" maxlength="20"
                               placeholder="새 비밀번호를 입력하세요">
                    </div>

                    <!-- 비밀번호 확인 -->
                    <div class="mb-3">
                        <label for="passwordConfirm" class="form-label fw-bold">비밀번호 확인</label>
                        <input type="password" class="form-control" id="passwordConfirm" maxlength="20"
                               placeholder="비밀번호를 다시 입력하세요">
                    </div>

                    <!-- 비밀번호 안내 -->
                    <div class="mb-4">
                        <div class="alert alert-info py-2">
                            <small>
                                <i class="fas fa-info-circle me-1"></i>
                                10~16자리 영문/숫자/특수문자[!@#$%^&*()]혼용
                            </small>
                        </div>
                    </div>

                    <!-- 버튼 영역 -->
                    <div class="d-grid gap-2">
                        <button type="button" id="updateSubmitBtn" class="btn btn-primary">
                            <i class="fas fa-save me-1"></i>수정 완료
                        </button>
                        <button type="button" id="cancelBtn" class="btn btn-outline-secondary">
                            <i class="fas fa-times me-1"></i>취소
                        </button>
                    </div>

                    <input type="hidden" id="hiddenUserEmail" name="userEmail" value="${userInfo.userEmail}">
                </form>
            </div>
        </div>
    </div>
</div>
