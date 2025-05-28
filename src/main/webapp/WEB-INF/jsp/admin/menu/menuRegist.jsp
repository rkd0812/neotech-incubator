<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 25. 4. 28.
  Time: 오전 10:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="/app/js/admin/menu/menuRegist.js"></script>
<div id="page-wrapper">
    <div class="header">
        <h1 class="page-title">메뉴 등록</h1>
    </div>
    <div class="page-inner">
        <form id="registForm" name="registForm" action="/admin/menu/regist.do" method="post">
            <table>
                <colgroup>
                    <col style="width: 20%;" />
                    <col />
                </colgroup>
                <tbody>
                    <tr>
                        <th>메뉴명</th>
                        <td><input type="text" id="menuName" name="menuName" /></td>
                    </tr>
                    <tr>
                        <th>상위메뉴</th>
                        <td>
                            <select id="upperMenuId" name="upperMenuId">
                                <option value="">선택안함</option>
                                <c:forEach items="${menuList}" var="menu" varStatus="status">
                                    <option value="${menu.menuId}">${menu.menuName}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <button id="btnCancel" onclick=location.href="/admin/menu/list.do">취소</button>
        <button id="btnRegist">등록</button>
    </div>
</div>
