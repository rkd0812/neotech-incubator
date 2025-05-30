<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-04-28
  Time: 오후 4:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="<c:url value="/app/js/userinfo/userDetail.js"/>"></script> <%-- 필수 --%>
<div id="page-wrapper">
    <div class="user-detail-container">
        <div class="card shadow">
            <div class="card-header bg-primary text-white text-center">
                <h4 class="mb-0">사용자 상세 정보</h4>
            </div>
            <div class="card-body p-3">

                <!-- 사용자 정보 테이블 -->
                <div class="table-responsive mb-4">
                    <table class="table table-bordered table-hover">
                        <tbody>
                        <tr>
                            <td class="bg-light fw-bold" style="width: 30%;">이메일</td>
                            <td id="displayEmail">${userInfo.userEmail}</td>
                        </tr>
                        <tr>
                            <td class="bg-light fw-bold" style="width: 30%;">이름</td>
                            <td id="displayName">${userInfo.userName}</td>
                        </tr>
                        <tr>
                            <td class="bg-light fw-bold">비밀번호</td>
                            <td>
                                <span class="text-muted">**********</span>
                                <small class="text-muted ms-2">(보안상 표시되지 않습니다.)</small>
                            </td>
                        </tr>
                        <tr>
                            <td class="bg-light fw-bold">권한명</td>
                            <td>
                                <span class="badge bg-primary">${userInfo.codeName}</span>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>

                <!-- 버튼 영역 -->
                <div class="d-grid gap-2">
                    <!-- 수정 버튼 -->
                    <form id="updateForm" action="/userinfo/updateForm.do" method="get">
                        <input type="hidden" name="userEmail" value="${userInfo.userEmail}">
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="fas fa-edit me-1"></i>정보 수정
                        </button>
                    </form>

                    <!-- 버튼 그룹 -->
                    <div class="row g-2 mt-1">
                        <div class="col-6">
                            <!-- HOME 버튼 -->
                            <form method="get" action="/project/projectList.do">
                                <button type="submit" id="listBtn" class="btn btn-info w-100">
                                    <i class="fas fa-home me-1"></i>HOME
                                </button>
                            </form>
                        </div>
                        <div class="col-6">
                            <!-- 회원탈퇴 버튼 -->
                            <button id="deleteBtn" style="background-color: #dc3545; color: white;" class="btn w-100">
                                <i class="fas fa-user-times me-1"></i>회원탈퇴
                            </button>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<!-- 숨겨진 삭제 폼 -->
<form id="deleteForm" action="/userinfo/deleteUserInfo.do" method="post" style="display: none;">
    <input type="hidden" name="userEmail" value="${userInfo.userEmail}">
</form>
