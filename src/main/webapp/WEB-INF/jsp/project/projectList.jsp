<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-04-24
  Time: 오후 2:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="<c:url value="/app/js/project/projectList.do"/>"></script> <%-- 필수 --%>
<!-- 메인 컨텐츠 -->
<div>
    <a href="/userinfo/userDetail.do?userEmail=${loginUser.userEmail}" id="myInfoBtn">내정보</a>
    <a href="/userinfo/logout.do" id="logoutBtn">로그아웃</a>
</div>

<!-- 검색 영역 -->
<div>
    <!-- 검색 영역 -->
    <form>
        <p>기간
            <input type="date" name="startdate" id="startdate">
            ~
            <input type="date" name="'enddate" id="enddate">
        </p>
        <p>검색어
            <input class="search-txt" tpye="text" id='search-txt' name="" placeholder="검색어를 입력하세요.">
        </p>
        <p>상태
            <select name="eva_state" id="eva_state">
                <option value="" selected>--선택--</option>
                <option value="before_eva">심사 전</option>
                <option value="ing_eva">심사 중</option>
                <option value="after_eva">심사 완료</option>
            </select>
        </p>
        <p>
            <button type="button" id="search_btn">조회</button>
        </p>
    </form>
</div>
<!-- 테이블 영역 -->
<div>
    <!-- 프로젝트 목로 테이블 -->
    <table border="1">
        <thead>
        <tr>
            <th>프로젝트 명</th>
            <th>작성자</th>
            <th>요청일자</th>
            <th>심사 상태</th>
        </tr>
        </thead>
        <c:forEach var="project" items="${projectList}">
            <tr>
                <td>
                    <a href="/project/projectDetail.do?projectId=${project.projectId}">${project.projectName}</a>
                </td>
                <td>${project.groupId}</td>
                <td>${project.evastartDt}</td>
                <td>${project.evaCd}</td>
            </tr>


        </c:forEach>


    </table>
    <button type="button"  id="register_btn">프로젝트 등록</button>
</div>

<!-- 페이징, 버튼 영역 -->
<div>
    <!-- 페이지 링크 -->
</div>


