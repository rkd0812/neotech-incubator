<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-04-29
  Time: 오후 2:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="<c:url value="/app/js/userinfo/userinfoLogin.js"/>"></script> <%-- 필수 --%>
<div id="page-wrapper">
    <div class="row justify-content-center mt-5">
        <div class="col-md-6 col-lg-5">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">로그인</h4>
                </div>
                <div class="card-body p-4">
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show mt-2 loginAlert" role="alert">
                                ${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                    <form id="userLogin" action="/userinfo/login.do" method="post">
                        <div class="mb-3">
                            <label for="userEmail" class="form-label">이메일</label>
                            <div class="input-group email-group">
                                <input type="text" class="form-control email-input" id="userEmail" name="userEmailId" placeholder="이메일을 입력해주세요" value="${userEmailId}">
                                <span class="input-group-text">@</span>
                                <input type="text" class="form-control domain-input" id="userDomain" name="userDomain" placeholder="도메인" value="${userDomain}">
                                <select id = "domainList" class="form-select domain-select">
                                    <option value="">직접 입력</option>
                                    <option value="naver.com">naver.com</option>
                                    <option value="google.com">google.com</option>
                                    <option value="kakao.com">kakao.com</option>
                                    <option value="daum.net">daum.net</option>
                                </select>
                            </div>
                            <input type="hidden" id="dbEmail" name="userEmail">
                        </div>
                        <div class="mb-3">
                            <label for="userPassword" class="form-label">비밀번호</label>
                            <input type="password" class="form-control" id="userPassword" name="userPassword"
                                   placeholder="비밀번호를 입력하세요">
                        </div>
                        <div>
<%--                            <a>--%>
<%--                                아이디 찾기--%>
<%--                            </a>--%>
<%--                            <a>--%>
<%--                                비밀번호 찾기--%>
<%--                            </a>--%>
                            <small class="text-dark">
                                아이디 찾기
                            </small>
                            &emsp;
                            <small class="text-dark">
                                비밀번호 찾기
                            </small>
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
