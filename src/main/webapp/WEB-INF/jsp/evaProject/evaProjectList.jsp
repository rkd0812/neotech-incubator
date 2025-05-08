<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 25. 5. 8.
  Time: 오후 3:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>심사 프로젝트 목록</title>
    <c:import charEncoding="utf-8" url="/layout/cmmnlib.do" />
    <script src="/app/js/evaProject/evaProjectList.js"></script>
</head>
<body>
<div id="page-wrapper">
    <div class="header">
        <h1 class="page-header">심사 프로젝트 목록조회</h1>
    </div>
    <div id="page-inner" style="text-align: center;">
        <form id="searchForm" name="searchForm" action="/evaProject/list.do" >
            <table style="width: 700px; border: solid 1px black; margin: 0 auto; text-align: center;">
                <colgroup>
                </colgroup>
                <tbody>
                    <tr>
                        <th>기간</th>
                        <td><input type="date" id="startDate" name="startDate" />~<input type="date" id="endDate" name="endDate" /></td>
                    </tr>
                </tbody>
            </table>
        </form>
        <button id="initBtn">초기화</button>
        <button id="searchBtn">검색</button>
        <table style="width: 700px; border: solid 1px black; margin: 0 auto; text-align: center;">
            <colgroup>
            </colgroup>
            <thead>
            <tr>
                <th>No</th>
                <th>프로젝트명</th>
                <th>심사상태</th>
                <th>심사시작일자</th>
                <th>심사종료일자</th>
                <th>등록일자</th>
            </tr>
            </thead>
            <tbody>
                <c:if test="${evaProject.size() eq 0}">
                    <tr>
                        <td colspan="2">
                            조회된 데이터가 없습니다
                        </td>
                    </tr>
                </c:if>
                <c:forEach var="evaProj" items="#{eveProjectList}" varStatus="status">
                    <tr>
                        <td>${status.count}</td>
                        <td><a href="/evaProject/detail.do?projectId=${evaProj.projectId}">${evaProj.projectName}</td>
                        <td>${evaProj.evaCdNm}</td>
                        <td>${evaProj.evaStartDt}</td>
                        <td>${evaProj.evaEndDt}</td>
                        <td>${evaProj.frstRgsrDtlDttm}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
