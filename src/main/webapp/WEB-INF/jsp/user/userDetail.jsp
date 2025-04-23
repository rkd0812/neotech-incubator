<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-04-16
  Time: 오후 3:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>사용자 목록</title>
    <c:import charEncoding="utf-8" url="/layout/cmmnlib.do" />
    <script src="<c:url value="/app/js/user/userList.js"/>" ></script>
</head>
<body>
    <h4>사용자 상세조회</h4>
    <div class="wrap" style="vertical-align: middle;">
        <table style="width: 700px; border: solid 1px black; margin: 0 auto; text-align: center; ">
            <colgroup>
                <col style="width: 30%;">
                <col style="width: auto;">
            </colgroup>
            <tbody>
                <tr>
                    <th>이메일</th>
                    <td><input type="text" /></td>
                </tr>
                <tr>
                    <th></th>
                    <td><button style="float: right;">검색</button></td>
                </tr>
            </tbody>
        </table>
        <table style="width: 700px; border: solid 1px black; margin: 0 auto; text-align: center;">
            <colgroup>
                <col style="width: 20%;">
                <col style="width: 60%;">
                <col style="width: auto;">
            </colgroup>
            <thead>
                <tr>
                    <th>No</th>
                    <th>이메일</th>
                    <th>권한</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>${userDetail.userId}</td>
                    <td>test@test.com</td>
                    <td>권한</td>
                </tr>
            </tbody>
        </table>
    </div>
</body>
</html>
