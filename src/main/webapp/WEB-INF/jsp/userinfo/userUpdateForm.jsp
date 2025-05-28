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
    <div class="row justify-content-center mt-4">
        <div class="col-md-8 col-lg-6">
            <div class="card shadow">
                <div class="card-header bg-primary text-dark text-center">
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
                            <input type="password" class="form-control" id="userPassword" name="userPassword"
                                   placeholder="새 비밀번호를 입력하세요">
                        </div>

                        <!-- 비밀번호 확인 -->
                        <div class="mb-3">
                            <label for="passwordConfirm" class="form-label fw-bold">비밀번호 확인</label>
                            <input type="password" class="form-control" id="passwordConfirm"
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

                        <!-- 권한 설정 -->
                        <c:choose>
                            <c:when test="${loginUser.roleCd eq 'Z' || loginUser.roleCd eq 'C'}">
                                <!-- 시스템 관리자나 심사장만 권한 수정 가능 -->
                                <div class="mb-4">
                                    <label for="roleCd" class="form-label fw-bold">권한</label>
                                    <select name="roleCd" id="roleCd" class="form-select">
                                        <option value="A" ${userInfo.roleCd eq 'A' ? 'selected' : ''}>A (일반 사용자)</option>
                                        <option value="B" ${userInfo.roleCd eq 'B' ? 'selected' : ''}>B (심사자)</option>
                                        <option value="C" ${userInfo.roleCd eq 'C' ? 'selected' : ''}>C (심사장)</option>
                                        <c:if test="${loginUser.roleCd eq 'Z'}">
                                            <option value="Z" ${userInfo.roleCd eq 'Z' ? 'selected' : ''}>Z (시스템 관리자)</option>
                                        </c:if>
                                    </select>
                                    <small class="text-muted">권한을 변경할 수 있습니다.</small>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <!-- 일반 사용자는 권한 보기만 가능 -->
                                <div class="mb-4">
                                    <label class="form-label fw-bold">현재 권한</label>
                                    <div class="form-control bg-light d-flex align-items-center">
                                        <span class="badge bg-secondary me-2">${userInfo.roleCd}</span>
                                        <c:choose>
                                            <c:when test="${userInfo.roleCd eq 'A'}">일반 사용자</c:when>
                                            <c:when test="${userInfo.roleCd eq 'B'}">심사자</c:when>
                                            <c:when test="${userInfo.roleCd eq 'C'}">심사장</c:when>
                                            <c:when test="${userInfo.roleCd eq 'Z'}">시스템 관리자</c:when>
                                        </c:choose>
                                    </div>
                                    <small class="text-muted">권한은 관리자만 변경할 수 있습니다.</small>
                                    <!-- 히든 필드로 기존 권한 유지 -->
                                    <input type="hidden" name="roleCd" value="${userInfo.roleCd}">
                                </div>
                            </c:otherwise>
                        </c:choose>

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
</div>
