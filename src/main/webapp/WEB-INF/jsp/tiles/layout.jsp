<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-04-16
  Time: 오후 3:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>tiles</title>
<%--    <c:import charEncoding="utf-8" url="/layout/cmmnlib.do" />--%>
</head>
<body>
<div class="wrap">
    <tiles:insertAttribute name="navBar" />
    <div class="container-fluid">
        <div class="row flex-nowrap">
            <tiles:insertAttribute name="sideBar" />
            <div class="col py-3">
                <tiles:insertAttribute name="body" />
            </div>
        </div>
    </div>

</div>
</body>
</html>
