<%--
  Created by IntelliJ IDEA.
  User: yungayoung
  Date: 25. 4. 29.
  Time: 오후 4:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>navBar</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Target Material Design Bootstrap Admin Template</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="/assets/materialize/css/materialize.min.css" media="screen,projection" />
    <!-- Bootstrap Styles-->
    <link href="/assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FontAwesome Styles-->
    <link href="/assets/css/font-awesome.css" rel="stylesheet" />
    <!-- Morris Chart Styles-->
<%--    <link href="/assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />--%>
    <!-- Custom Styles-->
    <link href="/assets/css/custom-styles.css" rel="stylesheet" />
    <!-- Google Fonts-->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
<%--    <link rel="stylesheet" href="/assets/js/Lightweight-Chart/cssCharts.css">--%>
</head>
<body>
<nav class="navbar navbar-default top-navbar" role="navigation">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle waves-effect waves-dark" data-toggle="collapse" data-target=".sidebar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand waves-effect waves-dark" href="/project/projectList.do">
<%--            <i class="large material-icons">track_changes</i>--%>
    <i class="large material-icons">home</i>
            <strong>logo</strong>
        </a>
        <div id="sideNav" href=""><i class="material-icons dp48">toc</i></div>
    </div>

    <ul class="nav navbar-top-links navbar-right">
<%--        <li><a class="dropdown-button waves-effect waves-dark" href="#!" data-activates="dropdown4"><i class="fa fa-envelope fa-fw"></i> <i class="material-icons right">arrow_drop_down</i></a></li>--%>
<%--        <li><a class="dropdown-button waves-effect waves-dark" href="#!" data-activates="dropdown3"><i class="fa fa-tasks fa-fw"></i> <i class="material-icons right">arrow_drop_down</i></a></li>--%>
<%--        <li><a class="dropdown-button waves-effect waves-dark" href="#!" data-activates="dropdown2"><i class="fa fa-bell fa-fw"></i> <i class="material-icons right">arrow_drop_down</i></a></li>--%>
        <li><a class="dropdown-button waves-effect waves-dark" href="#!" data-activates="dropdown1"><i class="fa fa-user fa-fw"></i> <b>John Doe</b> <i class="material-icons right">arrow_drop_down</i></a></li>
    </ul>
</nav>
<!-- Dropdown Structure -->
<ul id="dropdown1" class="dropdown-content">
    <li><a href="#"><i class="fa fa-user fa-fw"></i> My Profile</a></li>
<%--    <li><a href="#"><i class="fa fa-gear fa-fw"></i> Settings</a></li>--%>
    <li><a href="#"><i class="fa fa-sign-out fa-fw"></i> Logout</a></li>
</ul>
<ul id="dropdown2" class="dropdown-content w250">
    <li>
        <div>
            <i class="fa fa-comment fa-fw"></i> New Comment
            <span class="pull-right text-muted small">4 min</span>
        </div>
        </a>
    </li>
    <li class="divider"></li>
    <li>
        <div>
            <i class="fa fa-twitter fa-fw"></i> 3 New Followers
            <span class="pull-right text-muted small">12 min</span>
        </div>
        </a>
    </li>
    <li class="divider"></li>
    <li>
        <div>
            <i class="fa fa-envelope fa-fw"></i> Message Sent
            <span class="pull-right text-muted small">4 min</span>
        </div>
        </a>
    </li>
    <li class="divider"></li>
    <li>
        <div>
            <i class="fa fa-tasks fa-fw"></i> New Task
            <span class="pull-right text-muted small">4 min</span>
        </div>
        </a>
    </li>
    <li class="divider"></li>
    <li>
        <div>
            <i class="fa fa-upload fa-fw"></i> Server Rebooted
            <span class="pull-right text-muted small">4 min</span>
        </div>
        </a>
    </li>
    <li class="divider"></li>
    <li>
        <a class="text-center" href="#">
            <strong>See All Alerts</strong>
            <i class="fa fa-angle-right"></i>
        </a>
    </li>
</ul>
<ul id="dropdown3" class="dropdown-content dropdown-tasks w250">
    <li>
        <a href="#">
            <div>
                <p>
                    <strong>Task 1</strong>
                    <span class="pull-right text-muted">60% Complete</span>
                </p>
                <div class="progress progress-striped active">
                    <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%">
                        <span class="sr-only">60% Complete (success)</span>
                    </div>
                </div>
            </div>
        </a>
    </li>
    <li class="divider"></li>
    <li>
        <a href="#">
            <div>
                <p>
                    <strong>Task 2</strong>
                    <span class="pull-right text-muted">28% Complete</span>
                </p>
                <div class="progress progress-striped active">
                    <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="28" aria-valuemin="0" aria-valuemax="100" style="width: 28%">
                        <span class="sr-only">28% Complete</span>
                    </div>
                </div>
            </div>
        </a>
    </li>
    <li class="divider"></li>
    <li>
        <a href="#">
            <div>
                <p>
                    <strong>Task 3</strong>
                    <span class="pull-right text-muted">60% Complete</span>
                </p>
                <div class="progress progress-striped active">
                    <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%">
                        <span class="sr-only">60% Complete (warning)</span>
                    </div>
                </div>
            </div>
        </a>
    </li>
    <li class="divider"></li>
    <li>
        <a href="#">
            <div>
                <p>
                    <strong>Task 4</strong>
                    <span class="pull-right text-muted">85% Complete</span>
                </p>
                <div class="progress progress-striped active">
                    <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100" style="width: 85%">
                        <span class="sr-only">85% Complete (danger)</span>
                    </div>
                </div>
            </div>
        </a>
    </li>
    <li class="divider"></li>
    <li>
</ul>
<ul id="dropdown4" class="dropdown-content dropdown-tasks w250 taskList">
    <li>
        <div>
            <strong>John Doe</strong>
            <span class="pull-right text-muted">
								<em>Today</em>
							</span>
        </div>
        <p>Lorem Ipsum has been the industry's standard dummy text ever since the 1500s...</p>
        </a>
    </li>
    <li class="divider"></li>
    <li>
        <div>
            <strong>John Smith</strong>
            <span class="pull-right text-muted">
                                        <em>Yesterday</em>
                                    </span>
        </div>
        <p>Lorem Ipsum has been the industry's standard dummy text ever since an kwilnw...</p>
        </a>
    </li>
    <li class="divider"></li>
    <li>
        <a href="#">
            <div>
                <strong>John Smith</strong>
                <span class="pull-right text-muted">
                                        <em>Yesterday</em>
                                    </span>
            </div>
            <p>Lorem Ipsum has been the industry's standard dummy text ever since the...</p>
        </a>
    </li>
    <li class="divider"></li>
    <li>
        <a class="text-center" href="#">
            <strong>Read All Messages</strong>
            <i class="fa fa-angle-right"></i>
        </a>
    </li>
</ul>
<!--/. NAV TOP  -->
<nav class="navbar-default navbar-side" role="navigation">
    <div class="sidebar-collapse">
        <ul class="nav" id="main-menu">

            <li>
                <a class="active-menu waves-effect waves-dark" href="/project/projectList.do"><i class="fa fa-dashboard"></i> 사용자 프로젝트</a>
            </li>
            <li>
                <a href="#" class="waves-effect waves-dark"><i class="fa fa-desktop"></i>관리자 프로젝트</a>
            </li>
<%--            <li>--%>
<%--                <a href="chart.html" class="waves-effect waves-dark"><i class="fa fa-bar-chart-o"></i> Charts</a>--%>
<%--            </li>--%>
<%--            <li>--%>
<%--                <a href="tab-panel.html" class="waves-effect waves-dark"><i class="fa fa-qrcode"></i> Tabs & Panels</a>--%>
<%--            </li>--%>
<%--            <li>--%>
<%--                <a href="table.html" class="waves-effect waves-dark"><i class="fa fa-table"></i> Responsive Tables</a>--%>
<%--            </li>--%>
<%--            <li>--%>
<%--                <a href="form.html" class="waves-effect waves-dark"><i class="fa fa-edit"></i> Forms </a>--%>
<%--            </li>--%>
            <li>
                <a href="#" class="waves-effect waves-dark"><i class="fa fa-sitemap"></i>관리자<span class="fa arrow"></span></a>
                <ul class="nav nav-second-level">
                    <li>
                        <a href="/user/list.do">사용자 관리</a>
                    </li>
                    <li>
                        <a href="/menu/list.do">메뉴 관리</a>
                    </li>
                    <li>
                        <a href="/code/list.do">코드 관리</a>
                    </li>
<%--                    <li>--%>
<%--                        <a href="#">Second Level Link<span class="fa arrow"></span></a>--%>
<%--                        <ul class="nav nav-third-level">--%>
<%--                            <li>--%>
<%--                                <a href="#">Third Level Link</a>--%>
<%--                            </li>--%>
<%--                            <li>--%>
<%--                                <a href="#">Third Level Link</a>--%>
<%--                            </li>--%>
<%--                            <li>--%>
<%--                                <a href="#">Third Level Link</a>--%>
<%--                            </li>--%>
<%--                        </ul>--%>
<%--                    </li>--%>
                </ul>
            </li>
<%--            <li>--%>
<%--                <a href="empty.html" class="waves-effect waves-dark"><i class="fa fa-fw fa-file"></i> Empty Page</a>--%>
<%--            </li>--%>
        </ul>

    </div>

</nav>


<script src="/assets/js/jquery-1.10.2.js"></script>

<!-- Bootstrap Js -->
<script src="/assets/js/bootstrap.min.js"></script>

<script src="/assets/materialize/js/materialize.min.js"></script>

<!-- Metis Menu Js -->
<script src="/assets/js/jquery.metisMenu.js"></script>
<!-- Morris Chart Js -->
<script src="/assets/js/morris/raphael-2.1.0.min.js"></script>
<%--<script src="/assets/js/morris/morris.js"></script>--%>


<script src="/assets/js/easypiechart.js"></script>
<script src="/assets/js/easypiechart-data.js"></script>

<script src="/assets/js/Lightweight-Chart/jquery.chart.js"></script>

<!-- Custom Js -->
<script src="/assets/js/custom-scripts.js"></script>


</body>
</html>