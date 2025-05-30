<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-04-25
  Time: 오후 4:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--<html>--%>
<%--<head>--%>
<%--    <title>회원 등록</title>--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1">--%>
<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">--%>
<%--    <c:import charEncoding="utf-8" url="/layout/cmmnlib.do" />--%>
<%--    <script src="/app/js/userinfo/registForm.js"></script>--%>
<%--    <style>--%>
<%--        .email-input {--%>
<%--            min-width: 200px;--%>
<%--        }--%>
<%--        .domain-input {--%>
<%--            min-width: 10px;--%>
<%--        }--%>
<%--        .domain-select {--%>
<%--            min-width: 10px;--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>
<%--<body>--%>
<script src="<c:url value="/app/js/userinfo/registForm.js"/>"></script> <%-- 필수 --%>
<div id="page-wrapper">
    <div class="register-container">
        <div class="card shadow">
            <div class="card-header bg-primary text-white">
                <h4 class="mb-0">회원가입</h4>
            </div>
            <div class="card-body p-4">
                <form id="userForm" action="/userinfo/registerUserInfo.do" method="post">

                    <div class="mb-4">
                        <label class="form-label">이메일</label>
                        <div class="input-group email-group">
                            <input type="text" class="form-control email-input" id="userEmail" maxlength="20" placeholder="아이디를 입력하세요">
                            <span class="input-group-text">@</span>
                            <input type="text" class="form-control domain-input" id="userDomain" name="userDomain" maxlength="20" placeholder="도메인">
                            <select id="domainList" class="form-select domain-select">
                                <option value="">직접 입력</option>
                                <option value="naver.com">naver.com</option>
                                <option value="gmail.com">gmail.com</option>
                                <option value="kakao.com">kakao.com</option>
                                <option value="daum.net">daum.net</option>
                            </select>
                            <button type="button" id="checkemailBtn" class="btn btn-outline-primary check-button">중복확인
                            </button>
                        </div>
                        <%-- 중복 확인 후 상태 표시 --%>
                        <div id="duplicateResult" style="margin-top: 5px;"></div>
                        <input type="hidden" id="dbEmail" name="userEmail">
                    </div>

                    <div class="mb-3">
                        <label for="userName" class="form-label">이름</label>
                        <input type="text" class="form-control" id="userName" name="userName" maxlength="10"
                               placeholder="이름을 입력하세요">
                        <small class="text-muted">
                            * 최대 10자리까지 입력 가능
                        </small>
                    </div>

                    <div class="mb-3">
                        <label for="userPassword" class="form-label">비밀번호</label>
                        <input type="password" class="form-control" id="userPassword" name="userPassword" maxlength="20"
                               placeholder="비밀번호를 입력하세요">
                    </div>

                    <div class="mb-3">
                        <label for="passwordConfirm" class="form-label">비밀번호 확인</label>
                        <input type="password" class="form-control" id="passwordConfirm" name="passwordConfirm"
                               maxlength="20" placeholder="비밀번호를 입력하세요">
                    </div>

                    <div class="mb-4">
                        <small class="text-muted">
                            * 10~16자리 영문/숫자/특수문자[!@#$%^&*()]혼용
                        </small>
                    </div>

                    <input type="hidden" name="roleCd" value="A">

                    <div class="d-grid gap-2">
                        <button type="button" id="registerBtn" class="btn btn-primary">회원가입</button>
                        <a href="/userinfo/loginForm.do" class="btn btn-outline-secondary">이미 계정이 있으신가요? 로그인</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>