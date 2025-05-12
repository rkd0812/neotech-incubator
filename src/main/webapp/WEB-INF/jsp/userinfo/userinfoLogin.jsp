<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-04-29
  Time: 오후 2:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>로그인</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <c:import charEncoding="utf-8" url="/layout/cmmnlib.do" />
    <script src="/app/js/userinfo/userinfoLogin.js"></script>
    <style>
        .email-input {
            min-width: 200px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center mt-5">
        <div class="col-md-7 col-lg-5">
            <div class="text-center mb-4">
                <h1>로고</h1>
            </div>
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">로그인</h4>
                </div>
                <div class="card-body p-4">
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger" role="alert">
                                ${errorMessage}
                        </div>
                    </c:if>
                    <form id="userLogin" action="/userinfo/login.do" method="post">
                        <div class="mb-3">
                            <label for="userEmail" class="form-label">이메일</label>
                            <input type="text" class="form-control email-input" id="userEmail" name="userEmail"
                                   placeholder="이메일을 입력하세요">
                        </div>
                        <div class="mb-3">
                            <label for="userPassword" class="form-label">비밀번호</label>
                            <input type="password" class="form-control" id="userPassword" name="userPassword"
                                   placeholder="비밀번호를 입력하세요">
                        </div>
                        <div class="d-grid gap-2 mt-4">
                            <button type="submit" id="loginBtn" class="btn btn-primary">로그인</button>
                            <button type="button" id="registerBtn" class="btn btn-outline-secondary">회원가입</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>