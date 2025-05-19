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
    <link href="<c:url value="/assets/lib/bootstrap-5.3.5-dist/css/bootstrap-grid.min.css"/>"  rel="stylesheet" />
    <link href="<c:url value="/assets/lib/bootstrap-5.3.5-dist/css/bootstrap-reboot.min.css"/>"  rel="stylesheet" />
    <link href="<c:url value="/assets/lib/bootstrap-5.3.5-dist/css/bootstrap-utilities.min.css"/>"  rel="stylesheet" />
    <link href="<c:url value="/assets/lib/bootstrap-5.3.5-dist/css/bootstrap.min.css"/>"  rel="stylesheet" />

    <script src="<c:url value="/assets/lib/jquery/jquery-3.7.1.min.js" />"></script>
    <script src="<c:url value="/assets/lib/bootstrap-5.3.5-dist/js/bootstrap.bundle.min.js" />"></script>
    <script src="<c:url value="/assets/lib/bootstrap-5.3.5-dist/js/bootstrap.min.js" />"></script>
</head>
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
