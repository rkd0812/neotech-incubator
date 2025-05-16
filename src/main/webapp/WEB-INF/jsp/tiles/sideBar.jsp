<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-04-16
  Time: 오후 3:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<html>
<head>
    <title></title>
<%--    <c:import charEncoding="utf-8" url="/layout/cmmnlib.do" />--%>
</head>
<body>

<%--    <div class="container-fluid">--%>
<%--        <div class="row flex-nowrap">--%>
        <div class="col-auto col-md-3 col-xl-2 px-sm-2 px-0 bg-light">
            <div class="d-flex flex-column align-items-center align-items-sm-start px-3 pt-2 text-white min-vh-100">
<%--                <a href="/" class="d-flex align-items-center pb-3 mb-md-0 me-md-auto text-white text-decoration-none">--%>
<%--                    <span class="fs-5 d-none d-sm-inline text-black">Menu</span>--%>
<%--                </a>--%>
                <ul class="nav nav-pills flex-column mb-sm-auto mb-0 align-items-center align-items-sm-start" id="menu">
                    <li class="nav-item">
                        <a href="/project/projectList.do" class="nav-link align-middle px-0">
                            <i class="fs-4 bi-house"></i> <span class="ms-1 d-none d-sm-inline">사용자 프로젝트</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href=/evaProject/list.do class="nav-link align-middle px-0">
                            <i class="fs-4 bi-house"></i> <span class="ms-1 d-none d-sm-inline">심사 프로젝트</span>
                        </a>
                    </li>

<%--                    <li>--%>
<%--                        <a href="#submenu1" data-bs-toggle="collapse" class="nav-link px-0 align-middle">--%>
<%--                            <i class="fs-4 bi-speedometer2"></i> <span class="ms-1 d-none d-sm-inline">심사 프로젝트</span> </a>--%>
<%--                        <ul class="collapse show nav flex-column ms-1" id="submenu1" data-bs-parent="#menu">--%>
<%--                            <li class="w-100">--%>
<%--                                <a href="#" class="nav-link px-0"> <span class="d-none d-sm-inline">Item</span> 1 </a>--%>
<%--                            </li>--%>
<%--                            <li>--%>
<%--                                <a href="#" class="nav-link px-0"> <span class="d-none d-sm-inline">Item</span> 2 </a>--%>
<%--                            </li>--%>
<%--                        </ul>--%>
<%--                    </li>--%>
                    <li>
<%--                        <a href="#submenu2" data-bs-toggle="collapse" class="nav-link px-0 align-middle ">--%>
                        <a href="#submenu2" data-bs-toggle="collapse" class="nav-link px-0 align-middle ">
                        <i class="fs-4 bi-bootstrap"></i> <span class="ms-1 d-none d-sm-inline">관리자</span></a>
                        <ul class="collapse nav flex-column ms-1" id="submenu2" data-bs-parent="#menu">
                            <li class="w-100">
                                <a href="/admin/user/list.do" class="nav-link px-0"> <span class="d-none d-sm-inline">사용자 관리</span></a>
                            </li>
                            <li>
                                <a href="/admin/menu/list.do" class="nav-link px-0"> <span class="d-none d-sm-inline">메뉴 관리</span></a>
                            </li>
                            <li>
                                <a href="/admin/code/list.do" class="nav-link px-0"> <span class="d-none d-sm-inline">코드 관리</span></a>
                            </li>
                        </ul>
                    </li>
                </ul>

            </div>
        </div>
<%--        <div class="col py-3">--%>
<%--            Content area...--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>


</body>
</html>
