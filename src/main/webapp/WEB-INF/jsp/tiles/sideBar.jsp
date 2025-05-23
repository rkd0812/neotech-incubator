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
<%--        <div class="col-auto col-md-3 col-xl-2 px-sm-2 px-0 bg-light">--%>
<%--            <div class="d-flex flex-column align-items-center align-items-sm-start px-3 pt-2 text-white min-vh-100">--%>
<%--                <ul class="nav nav-pills flex-column mb-sm-auto mb-0 align-items-center align-items-sm-start" id="menu">--%>
<%--                    <li class="nav-item">--%>
<%--                        <a href="/project/projectList.do" class="nav-link align-middle px-0">--%>
<%--                            <i class="fs-4 bi-house"></i> <span class="ms-1 d-none d-sm-inline">사용자 프로젝트</span>--%>
<%--                        </a>--%>
<%--                    </li>--%>
<%--                    <li class="nav-item">--%>
<%--                        <a href=/evaProject/list.do class="nav-link align-middle px-0">--%>
<%--                            <i class="fs-4 bi-house"></i> <span class="ms-1 d-none d-sm-inline">심사 프로젝트</span>--%>
<%--                        </a>--%>
<%--                    </li>--%>
<%--                    <li>--%>
<%--                        <a href="#submenu2" data-bs-toggle="collapse" class="nav-link px-0 align-middle ">--%>
<%--                        <i class="fs-4 bi-bootstrap"></i> <span class="ms-1 d-none d-sm-inline">관리자</span></a>--%>
<%--                        <ul class="collapse nav flex-column ms-1" id="submenu2" data-bs-parent="#menu">--%>
<%--                            <li class="w-100">--%>
<%--                                <a href="/admin/user/list.do" class="nav-link px-0"> <span class="d-none d-sm-inline">사용자 관리</span></a>--%>
<%--                            </li>--%>
<%--                            <li>--%>
<%--                                <a href="/admin/menu/list.do" class="nav-link px-0"> <span class="d-none d-sm-inline">메뉴 관리</span></a>--%>
<%--                            </li>--%>
<%--                            <li>--%>
<%--                                <a href="/admin/code/list.do" class="nav-link px-0"> <span class="d-none d-sm-inline">코드 관리</span></a>--%>
<%--                            </li>--%>
<%--                        </ul>--%>
<%--                    </li>--%>
<%--                </ul>--%>
<%--            </div>--%>
<%--        </div>--%>

<div class="l-navbar" id="navbar">
    <nav class="nav">
        <div>
            <div class="nav__brand">
<%--                <ion-icon name="menu-outline" class="nav__toggle" id="nav-toggle"></ion-icon>--%>
<%--                <a href="#" class="nav__logo">Bedimcode</a>--%>
            </div>


            <div class="nav__list">
                <a href="/project/projectList.do" class="nav__link">
                    <ion-icon name="home-outline" class="nav__icon"></ion-icon>
                    <span class="nav_name">사용자 프로젝트</span>
                </a>

                <a href="/evaProject/list.do" class="nav__link">
                    <ion-icon name="folder-outline" class="nav__icon"></ion-icon>
                    <span class="nav_name">관리자 프로젝트</span>
                </a>

                <div href="#" onclick="location.href='/admin/user/list.do'" class="nav__link collapse">
                    <ion-icon name="settings-outline" class="nav__icon"></ion-icon>
                    <span class="nav_name">관리자</span>

                    <ion-icon name="chevron-down-outline" class="collapse__link"></ion-icon>

                    <ul class="collapse__menu">
                        <a href="/admin/user/list.do" class="collapse__sublink">사용자 관리</a>
                        <a href="/admin/menu/list.do" class="collapse__sublink">메뉴 관리</a>
                        <a href="/admin/code/list.do" class="collapse__sublink">코드 관리</a>
                    </ul>
                </div>
            </div>
        </div>
    </nav>
</div>

<%--<h1>Componentes</h1>--%>
<!-- IONICONS -->
<script src="https://unpkg.com/ionicons@5.2.3/dist/ionicons.js"></script>
<!-- JS -->
<script>
    $(function() {
        const path = document.location.pathname.split('/')[1];

        const navLink = $('.nav__link');

        for (let i = 0; i < navLink.length; i++) {

            // console.log(navLink[i])

            // console.log(navLink[i].href)
            // console.log(path)

        }

        const toggle = document.getElementById('nav-toggle'),
            navbar = document.getElementById('navbar'),
            bodypadding = document.getElementById('body-pd');

        navbar.classList.toggle('expander');
        bodypadding.classList.toggle('body-pd');

    })



    /* EXPANDER MENU */
    const showMenu = (toggleId, navbarId, bodyId) => {
        const toggle = document.getElementById(toggleId),
            navbar = document.getElementById(navbarId),
            bodypadding = document.getElementById(bodyId)

        if( toggle && navbar ) {
            toggle.addEventListener('click', () => {
                navbar.classList.toggle('expander');

                bodypadding.classList.toggle('body-pd');
            })
        }
    }

    showMenu('nav-toggle', 'navbar', 'body-pd');

    /* LINK ACTIVE */
    const linkColor = document.querySelectorAll('.nav__link');

    function colorLink() {
        linkColor.forEach(l => l.classList.remove('active'));
        // this.classList.add('active');

    }
    linkColor.forEach(l => l.addEventListener('click', colorLink));

    /* COLLAPSE MENU */
    const linkCollapse = document.getElementsByClassName('collapse__link');

    for(var i = 0; i < linkCollapse.length; i++) {
        linkCollapse[i].addEventListener('click', function() {
            event.stopPropagation();
            const collapseMenu = this.nextElementSibling;
            collapseMenu.classList.toggle('showCollapse');

            const rotate = collapseMenu.previousElementSibling;
            rotate.classList.toggle('rotate');
        });
    }
</script>