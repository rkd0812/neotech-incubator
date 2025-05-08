<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 25. 5. 8.
  Time: 오후 4:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>심사 프로젝트 상세</title>
    <c:import charEncoding="utf-8" url="/layout/cmmnlib.do" />
    <script src="<c:url value="/app/js/evaProject/evaProjectDetail.js"/>"></script>
</head>
<body>
<div id="page-wrapper">
    <div class="header">
        <h1 class="page-header">메뉴 상세</h1>
    </div>
    <div class="page-inner" style="text-align: center;">
        <form id="detailForm" name="detailForm" action="/evaProject/update.do" method="post">
            <table style="width: 700px; border: solid 1px black; margin: 0 auto; text-align: center;">
                <colgroup>
                </colgroup>
                <tbody>
                    <tr>
                        <th>심사상태</th>
                        <td>${evaProjectDetail.evaCdNm}</td>
                        <c:if test="${evaProjectDetail.evaCd eq 03}">
                            <th>심사결과</th>
                            <td>${evaProjectDetail.scoreFin} 점</td>
                        </c:if>
                    </tr>
                    <tr>
                        <th>프로젝트명</th>
                        <td colspan="3">${evaProjectDetail.projectName}</td>
                    </tr>
                    <tr>
                        <th>팀 구성원</th>
                        <td colspan="3">${evaProjectDetail.groupId}</td>
                    </tr>
                    <tr>
                        <th>프로젝트 설명</th>
                        <td colspan="3"><textarea style="width: 100%;" readonly>${evaProjectDetail.projectDetail}</textarea></td>
                    </tr>
                    <tr>
                        <th>url</th>
                        <td colspan="3"><a href="${evaProjectDetail.url}">${evaProjectDetail.url}</td>
                    </tr>
                    <tr>
                        <th>첨부파일</th>
                        <td></td>
                    </tr>
                </tbody>
            </table>
        </form>
        <button id="listBtn" onclick=location.href="/evaProject/list.do">목록</button>
        <c:if test="${evaProjectDetail.evaCd eq 01}"><button>심사하기</button></c:if>
    </div>
</div>
</body>
</html>
