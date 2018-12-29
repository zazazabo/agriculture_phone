<%-- 
    Document   : index
    Created on : 2018-12-24, 16:17:35
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-INF/tld/fn.tld" prefix="fn" %>
<!DOCTYPE html>
<html>

    <head>
        <%@include  file="js.jspf" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="renderer" content="webkit|ie-comp|ie-stand">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
        <meta http-equiv="Cache-Control" content="no-siteapp" />
        <link rel="Bookmark" href="/favicon.ico" >
        <link rel="Shortcut Icon" href="/favicon.ico" />
        <!--[if lt IE 9]>
        <script type="text/javascript" src="lib/html5shiv.js"></script>
        <script type="text/javascript" src="lib/respond.min.js"></script>
        <![endif]-->
        <link rel="stylesheet" type="text/css" href="static/h-ui/css/H-ui.min.css" />
        <link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/H-ui.admin.css" />
        <link rel="stylesheet" type="text/css" href="lib/Hui-iconfont/1.0.8/iconfont.css" />
        <link rel="stylesheet" type="text/css" href="static/h-ui.admin/skin/default/skin.css" id="skin" />
        <link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/style.css" />
        <link rel="stylesheet" type="text/css" href="static/h-ui/css/H-ui.min.css" />
        <link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/H-ui.admin.css" />
        <link rel="stylesheet" type="text/css" href="lib/Hui-iconfont/1.0.8/iconfont.css" />
        <link rel="stylesheet" type="text/css" href="static/h-ui.admin/skin/default/skin.css" id="skin" />
        <link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/style.css" />
        <link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/bootstrap.min.css" />
        <!--[if IE 6]>
        <script type="text/javascript" src="lib/DD_belatedPNG_0.0.8a-min.js" ></script>
        <script>DD_belatedPNG.fix('*');</script>
        <![endif]-->
        <style>
            @media screen and (max-width:767px) and (max-width:1920px){  
                #pojects{
                    width: 120px;
                } 
                #Hui-userbar{
                    margin-right: 5%;
                }
                #Hui-userbar{
                    display: block;
                }
                #smdh{
                    margin-right: -10px;
                    margin-top: 2px;
                }
                #infoUL li{
                    margin-right: 1px;

                }
            } 
            @media screen and (min-width:767px) and (max-width:1920px){  
                #pojects{
                    width: 200px;
                } 
                #Hui-userbar{
                    display: block;
                }
            } 
        </style>
        <script>
            function getpojectId() {
//                var pojectid = $("#pojects").val();
                return  "P00001";
            }
            function callchild(obj) {
                var func = obj.function;
                var objchild = $("iframe").eq(0);
                var win = objchild[0].contentWindow;
                if (win.hasOwnProperty(func)) {
                    win[func](obj);
                }
            }


            var websocket = null;
            var conectstr = "ws://47.99.78.186:24228/";
            var timestamp = 0;
            function sendData(obj) {
                console.log("通信状态:", websocket.readyState);
                if (websocket.readyState == 3) {
                    layer.confirm("通迅已断开,重连吗?", {//确认要删除吗？
                        btn: ['确定', '取消'] //确定、取消按钮
                    }, function (index) {
                        websocket = new WebSocket(conectstr);
                        websocket.onopen = onopen;
                        websocket.onmessage = onmessage;
                        websocket.onclose = onclose;
                        websocket.onerror = onerror;
                        window.onbeforeunload = onbeforeunload;
                        layer.close(index);
                    });
                }
                if (websocket != null && websocket.readyState == 1) {
                    if (timestamp == 0) {
                        timestamp = (new Date()).valueOf();
                        console.log(obj);
                        var datajson = JSON.stringify(obj);
                        websocket.send(datajson);
                    } else {
                        var timestamptemp = (new Date()).valueOf();
                        console.log(timestamp, timestamptemp);
                        if ((timestamptemp - timestamp) / 1000 < 1) {
                            //layerAler("请不要连续发送");
                        } else {
                            timestamp = timestamptemp;
                            console.log(obj);
                            var datajson = JSON.stringify(obj);
                            websocket.send(datajson);
                        }
                    }


                }
            }

            function onopen(e) {
            }
            function onmessage(e) {
                var info = eval('(' + e.data + ')');
                console.log("main onmessage");
                console.log(info);

                if (info.hasOwnProperty("page")) {
                    console.log(info.page);
                    var obj = $("iframe").eq(0);
                    var win = obj[0].contentWindow;
                    if (info.page == 1) {
                        var func = info.function;
                        console.log(func);
                        win[func](info);
                    } else if (info.page == 2) {
                        callchild(info);
                    }
                }
            }

            function onclose(e) {
                console.log(e);
                console.log("websocket close");
                websocket.close();
            }
            function  onerror(e) {
                console.log("Webscoket连接发生错误");
            }
            function onbeforeunload(e) {
                websocket.close();
            }

            $(function () {
            <c:if test="${empty param.id }">
                window.location = "${pageContext.request.contextPath }/login.jsp";
                return;
            </c:if>

                if ('WebSocket' in window) {
                    websocket = new WebSocket(conectstr);
//                    websocket = new WebSocket("ws://localhost:5050/");
                } else {
                    alert('当前浏览器不支持websocket');
                }
                websocket.onopen = onopen;
                websocket.onmessage = onmessage;
                websocket.onclose = onclose;
                websocket.onerror = onerror;
                window.onbeforeunload = onbeforeunload;

//                size();
//                window.onresize = function () {
//                    size();
//                };
                $("#changeLanguage").mousemove(function () {
                    $("#languages").show();
                });
                $("#changeLanguage").mouseout(function () {
                    $("#languages").hide();
                });
            });
            function size() {
                var iframeWidth = $(window).width();
                $("#iframe").css("width", iframeWidth);
            }


        </script>
    </head>
    <body>

        <c:set var="lang" value="${cookie.lang.value}"></c:set>     
        <c:if test="${empty cookie.lang.value }">
            <c:set var="lang" value="zh_CN"></c:set>     
        </c:if>
        <c:set var="urlparam" value="lang=${lang}&name=${param.name}&userId=${param.id}&role=${param.role}"></c:set>     
            <header class="navbar-wrapper">
                <div class="navbar navbar-fixed-top" style=" background-color: green;">
                    <div class="container-fluid cl">
                        <a class="logo navbar-logo f-l mr-10 hidden-xs" href="#">智慧农业生产管理控制系统</a> 
                        <a class="logo navbar-logo-m f-l mr-10 visible-xs" href="#"></a> 
                        <nav id="Hui-userbar" style=" display: block; color: white;">
                            <ul class=" inline" style=" margin-top: 10px; float: left" id="infoUL">
                                <li>
                                    <select style=" height: 30px; margin-top:0px; font-size: 16px; background-color:  #7aba7b; color:  white;" id="pojects">
                                        <option>佳德测试项目</option>
                                    </select>
                                </li>
                                <li class="dropDown dropDown_hover" style=" margin-right: -15px;">
                                    <a href="#" class="dropDown_A">语言<i class="Hui-iconfont">&#xe6d5;</i></a>
                                    <ul class="dropDown-menu menu radius box-shadow">
                                        <li><a href="#">中文</a></li>
                                        <li><a href="#">英文</a></li>
                                    </ul>
                                </li>                             
                                <li id="Hui-msg"> <a href="#" title="消息"><i class="Hui-iconfont" style="font-size:18px">&#xe68a;</i></a> </li>
                                <li class="dropDown dropDown_hover" style=" margin-left: -10px;">
<!--                                    <a href="#" class="dropDown_A">admin <i class="Hui-iconfont">&#xe6d5;</i></a>-->
                                    <span class="admin" style="color: rgb(255, 255, 255);"><img src="./img/user.jpg" style=" height: 40px; width: 40px;vertical-align: middle; border-radius: 16px;"></span>
                                    <ul class="dropDown-menu menu radius box-shadow">
                                        <li><a href="javascript:;" onClick="myselfinfo()">个人信息</a></li>
                                        <li><a href="#">切换账户</a></li>
                                        <li><a href="#">退出</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </nav>
                        <a aria-hidden="false" class="nav-toggle Hui-iconfont visible-xs" href="javascript:;" id="smdh">&#xe667;</a>       
                    </div>
                </div>
            </header>
            <aside class="Hui-aside" style=" background-color: #0044cc;">
                <div class="menu_dropdown bk_2">
                <c:forEach items="${menu}" var="t" varStatus="i">
                    <c:if test="${t.m_parent==0}">
                        <dl id="menu-picture">

                            <dt>
                                <i class="Hui-iconfont">${t.m_icon}</i>
                                ${t.m_text[lang]}
                                <i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i>
                            </dt>
                            <dd>
                                <ul>
                                    <c:if test="${fn:length(t.children)==0}">
                                        <li>
                                            <a data-href="${t.m_action}?pid=${fn:split(param.pid,",")[0]}&${urlparam}" data-title="${t.m_text[lang]}" href="javascript:void(0)">${t.m_text[lang]}</a>
                                        </li>
                                    </c:if>
                                    <c:forEach items="${t.children}" var="t1" varStatus="y">

                                        <li>
                                            <a data-href="${t1.m_action}?pid=${fn:split(param.pid,",")[0]}&${urlparam}" data-title="${t1.m_text[lang]}" href="javascript:void(0)">${t1.m_text[lang]}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </dd>


                        </dl>

                    </c:if>

                </c:forEach>    
            </div>
        </aside>
        <div class="dislpayArrow hidden-xs"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a></div>
        <section class="Hui-article-box">
            <div id="Hui-tabNav" class="Hui-tabNav hidden-xs">
                <div class="Hui-tabNav-wp">
                    <ul id="min_title_list" class="acrossTab cl">
                        <c:forEach items="${menu}" var="t" varStatus="i">
                            <c:if test="${t.m_parent==0&&i.index==0}">
                                <li class="active">
                                    <span data-href="${t.m_action}?pid=${fn:split(param.pid,",")[0]}&${urlparam}" title="${t.m_text[lang]}" >${t.m_text[lang]}</span>
                                </li>
                                <c:set var="main" value="${t.m_action}"></c:set>     
                            </c:if> 
                        </c:forEach>
                    </ul>
                </div>
                <div class="Hui-tabNav-more btn-group">
                    <a id="js-tabNav-prev" class="btn radius btn-default size-S" href="javascript:;">
                        <i class="Hui-iconfont">&#xe6d4;</i>
                    </a>
                    <a id="js-tabNav-next" class="btn radius btn-default size-S" href="javascript:;">
                        <i class="Hui-iconfont">&#xe6d7;</i>
                    </a>
                </div>
            </div>
            <div id="iframe_box" class="Hui-article">
                <div class="show_iframe">
                    <div style="display:none" class="loading"></div>
                    <iframe id="iframe" scrolling="yes" frameborder="0" src="${main}?pid=${fn:split(param.pid,",")[0]}&${urlparam}"></iframe>
                </div>
            </div>
        </section>

        <div class="contextMenu" id="Huiadminmenu">
            <ul>
                <li id="closethis">关闭当前 </li>
                <li id="closeall">关闭全部 </li>
            </ul>
        </div>
        <!--_footer 作为公共模版分离出去-->
        <script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script> 
        <script type="text/javascript" src="lib/layer/2.4/layer.js"></script>
        <script type="text/javascript" src="static/h-ui/js/H-ui.min.js"></script>
        <script type="text/javascript" src="static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->

        <!--请在下方写此页面业务相关的脚本-->
        <script type="text/javascript" src="lib/jquery.contextmenu/jquery.contextmenu.r2.js"></script>
        <script type="text/javascript">
            $(function () {

            });
            /*个人信息*/
            function myselfinfo() {
                layer.open({
                    type: 1,
                    area: ['300px', '200px'],
                    fix: false, //不固定
                    maxmin: true,
                    shade: 0.4,
                    title: '查看信息',
                    content: '<div>管理员信息</div>'
                });
            }

            /*资讯-添加*/
            function article_add(title, url) {
                var index = layer.open({
                    type: 2,
                    title: title,
                    content: url
                });
                layer.full(index);
            }
            /*图片-添加*/
            function picture_add(title, url) {
                var index = layer.open({
                    type: 2,
                    title: title,
                    content: url
                });
                layer.full(index);
            }
            /*产品-添加*/
            function product_add(title, url) {
                var index = layer.open({
                    type: 2,
                    title: title,
                    content: url
                });
                layer.full(index);
            }
            /*用户-添加*/
            function member_add(title, url, w, h) {
                layer_show(title, url, w, h);
            }


        </script> 

    </body>
</html>
