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
        <link rel="stylesheet" type="text/css" href="static/h-ui/css/H-ui.css" />
        <link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/H-ui.admin.css" />
        <link rel="stylesheet" type="text/css" href="lib/Hui-iconfont/1.0.8/iconfont.css" />
        <link rel="stylesheet" type="text/css" href="static/h-ui.admin/skin/default/skin.css" id="skin" />
        <!--<link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/bootstrap.min.css" />-->
        <script type="text/javascript"  src="js/getdate.js"></script>
        <script type="text/javascript"  src="js/genel.js"></script>
        <!--[if IE 6]>
        <script type="text/javascript" src="lib/DD_belatedPNG_0.0.8a-min.js" ></script>
        <script>DD_belatedPNG.fix('*');</script>
        <![endif]-->
        <title>智慧农业生产管理控制系统</title>
        <link rel="icon" href="Images/logo.ico" type="image/x-icon" />
        <style>
            #fnumber{
                background-color: red;
                width: 20px;
                height: 20px;
                text-align: center;
                vertical-align: middle;

                border-radius: 14px;
                position: absolute;
                left: 78%;
                top: 5px;
            }
            @media screen and (max-width:767px) {  
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
                #userinfo{
                    margin-left: -20px;
                }
                html{
                    font-size: 14px;
                }

                #fnumber{
                    position: absolute;
                    left: 72%;
                    top: 5px;
                }

                #l_comaddr{
                    width: 100px;
                }


            } 
            @media screen and (min-width:767px){  
                #pojects{
                    width: 200px;
                } 
                #Hui-userbar{
                    display: block;
                }
                #Hui-userbar{
                    margin-right: 20px;
                }
                #userinfo{
                    margin-left: -20px;
                }
                html{
                    font-size: 18px;
                }
                #l_comaddr{
                    width: 140px;
                }
            } 
            table td { line-height: 40px; } 
        </style>
        <script>
            var projectId = "${fn:split(param.pid,',')[0]}";
            var withs;
            function getpojectId() {
                projectId = $("#pojects").val();
                return  projectId;
            }
            function callchild(obj) {
                console.log(obj);
                if (obj.page == "main.jsp") {
                    dealfaultCB(obj);
                } else {
                    var func = obj.function;
                    var objframe = $("iframe");
                    for (var i = 0; i < objframe.length; i++) {
                        var src = $(objframe[i]).attr("src");
                        if (src.indexOf(obj.page) != -1) {
                            var win = objframe[i].contentWindow;
                            if (win.hasOwnProperty(func)) {
                                win[func](obj);
                            }
                            break;
                        }
                    }

                }

            }

            function dealfaultCB(obj) {
//                $('#panemask').hideLoading();
                console.log("o:" + obj.status);
                if (obj.status == "success") {
                    var data = Str2BytesH(obj.data);
                    var v = "";
                    for (var i = 0; i < data.length; i++) {
                        v = v + sprintf("%02x", data[i]) + " ";
                    }
                    if (data[1] == 0x10) {
                        var infonum = (2000 + obj.val * 10 + 6) | 0x1000;
                        var high = infonum >> 8 & 0xff;
                        var low = infonum & 0xff;
                        if (data[2] == high && data[3] == low) {
                            var ooo = {id: obj.param, f_handlep: getusername()};
                            $.ajax({async: false, url: "sensor.sensorform.updfualt.action", type: "get", datatype: "JSON", data: ooo,
                                success: function (data) {
                                    getfNumber();
                                    $("#fauttable").bootstrapTable('refresh');
                                }
                            });
                        }

                    }

                }
            }

            //处理报警
            function handle() {
                var eles = $("#fauttable").bootstrapTable('getSelections');
                if (eles.length == 0) {
                    alert("请勾选表格");
                    return;
                }
                var ele = eles[0];
                if (ele.f_Isfault != 1) {
                    var vv = [];
                    vv.push(1);
                    vv.push(0x10);
                    var info = parseInt(ele.f_setcode);
                    var infonum = (2000 + info * 10 + 6) | 0x1000;
                    vv.push(infonum >> 8 & 0xff);
                    vv.push(infonum & 0xff);
                    vv.push(0);
                    vv.push(1); //寄存器数目 2字节     
                    vv.push(2)
                    vv.push(0);
                    vv.push(0);
                    var data = buicode2(vv);
                    console.log(data);
                    dealsend2("10", data, "dealfaultCB", ele.f_comaddr, 0, ele.id, info, "main.jsp");
                }
            }

            //获取故障数量
            function getfNumber() {
                $.ajax({async: false, url: "homePage.fault.getfaultNumber.action", type: "get", datatype: "JSON", data: {pid: getpojectId()},
                    success: function (data) {
                        var rs = data.rs;
                        if (rs[0].number > 0) {
                            $("#fnumber").html(rs[0].number);
                            $("#fnumber").show();
                        } else {
                            $("#fnumber").hide();
                        }
                    }
                });
            }



            function  imgM() {
                $("#l_comaddr").combobox({
                    url: "gayway.GaywayForm.getComaddr.action?pid=" + getpojectId()
//                    formatter: function (row) {
//                        var v1 = row.online == 1 ? "&nbsp;<img src='img/online1.png'>" : "&nbsp;<img src='img/off.png'>";
//                        var v = row.text + v1;
//                        row.id = row.id;
//                        row.text = v;
//                        var opts = $(this).combobox('options');
//                        return row[opts.textField];
//                    },
//                    onLoadSuccess: function (data) {
//                        if (Array.isArray(data) && data.length > 0) {
//                            for (var i = 0; i < data.length; i++) {
//                                data[i].text = data[i].name;
//                            }
//                            $(this).combobox('select', data[0].id);
//                        }
//
//                    }
                });
                $("#fauttable").bootstrapTable('destroy');
                $('#fauttable').bootstrapTable({
                    url: 'homePage.fault.getfault.action',
                    columns: [
                        {
                            title: '单选',
                            field: 'select',
                            //复选框
                            checkbox: true,
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        },
                        {

                            field: 'f_comaddr',
                            title: '所属网关', //设备名称
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            formatter: function (value, row, index) {
                                // return  value.replace(/\b(0+)/gi, "");
                                var obj = {};
                                obj.comaddr = value;
                                var name = "";
                                $.ajax({async: false, url: "homePage.gayway.getnamebycode.action", type: "get", datatype: "JSON", data: obj,
                                    success: function (data) {
                                        var rs = data.rs;
                                        name = rs[0].name;
                                    }
                                });
                                return  name;

                            }
                        }, {
                            field: 'f_day',
                            title: '报警时间', //时间
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            formatter: function (value) {
                                if (value == null || value == "") {
                                    return  null;
                                } else {
                                    return value.substring(0, 19);
                                }
                            }
                        }, {
                            field: 'f_type',
                            title: '设备类型', //异常类型
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            formatter: function (value) {
                                if (value == 1) {
                                    return "温度传感器";
                                } else if (value == 2) {
                                    return "湿度传感器";
                                }
                            }
                        }, {
                            field: 'f_comment',
                            title: '异常说明', //异常说明
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            formatter: function (value, row, index, field) {
                                var str = "通信中断";
                                return str;
                            }
                        }
                        , {
                            field: 'f_name',
                            title: '传感器名称',
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }
//                        ,
//                        {
//                            field: 'f_detail',
//                            title: '详情', //状态字2
//                            width: 25,
//                            align: 'center',
//                            valign: 'middle',
//                            formatter: function (value, row, index, field) {
//
//                                return value;
//                            }
//                        }
                    ],
                    clickToSelect: true,
                    singleSelect: true,
                    sortName: 'id',
                    locale: 'zh-CN', //中文支持,
                    showColumns: true,
                    sortOrder: 'desc',
                    pagination: true,
                    sidePagination: 'server',
                    pageNumber: 1,
                    pageSize: 5,
//                    showRefresh: true,
                    //showToggle: true,
                    // 设置默认分页为 50
                    pageList: [5, 10, 15],
                    striped: true,

                    onLoadSuccess: function () {  //加载成功时执行  表格加载完成时 获取集中器在线状态
//                        console.info("加载成功");
                    },

                    //服务器url
                    queryParams: function (params)  {   //配置参数     
                        var temp  =   {    //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的 
                            search: params.search,
                            skip: params.offset,
                            limit: params.limit,
                            pid: getpojectId(),
                            type_id: "1",
                            f_comaddr: "" 
                        };      
                        return temp;  
                    }
                });
                $('#faultDiv').dialog('open');
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
                    var func = info.function;
                    callchild(info);
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
                size();


                $("dd").delegate("ul li", "click", function () {
                    var childli = $(this).children();
                    var url = $(childli).attr("data-url");
                    url = url + "&pid=" + getpojectId();
                    $(childli).attr("data-href", url);

                    console.log($(childli).attr("data-href"));
                    //导航栏颜色
                });

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
                $("#admin").mousemove(function () {
                    $("#userinfo").show();
                });
                $("#admin").mouseout(function () {
                    $("#userinfo").hide();
                });

                $("#faultDiv").dialog({
                    autoOpen: false,
                    modal: true,
                    width: withs,
                    height: 500,
                    position: ["top", "top"],
                    buttons: {
                        处理报警: function () {
                            handle();
                        }, 关闭: function () {
                            $("#faultDiv").dialog("close");
                        }
                    }
                });

            });
            function size() {
                var iframeWidth = $(window).width();
                $("#iframe").css("width", iframeWidth);
            }

            function getout() {
                layer.confirm("确定退出吗？", {
                    btn: ["确定", "取消"]//确定、取消按钮
                }, function (index) {

                    window.location = "${pageContext.request.contextPath }/login.jsp";
                    var name = $("#u_name").val();
                    addlogon(name, "退出", getpojectId(), "首页", "退出");

                    layer.close(index);

                });
            }

            function select() {
                var obj = {};
                obj.pid = getpojectId();
                obj.f_comaddr = $("#l_comaddr").val();
                var opt = {
                    url: "homePage.fault.getfault.action",
                    silent: true,
                    query: obj
                };
                $("#fauttable").bootstrapTable('refresh', opt);
            }


        </script>
        <script type="text/javascript">
            function layerAler(str) {
                layer.alert(str, {
                    icon: 6,
                    offset: 'center'
                });
            }
            $(function () {
                var pid = '${rs[0].pid}';
                var pids = [];
                if (pid != null && pid != "") {
                    pids = pid.split(",");   //项目编号
                }

                // $("#pojects").val(pids[0]);
                var pname = [];   //项目名称
                for (var i = 0; i < pids.length; i++) {
                    var obj = {};
                    obj.code = pids[i];
                    $.ajax({url: "login.main.getpojcetname.action", async: false, type: "get", datatype: "JSON", data: obj,
                        success: function (data) {
                            pname.push(data.rs[0].name);
                        },
                        error: function () {
                            alert("出现异常！");
                        }
                    });
                }

                for (var i = 0; i < pids.length; i++) {
                    var options;
                    options += "<option value=\"" + pids[i] + "\">" + pname[i] + "</option>";
                    $("#pojects").html(options);
                }

                $("#dialog-add").dialog({
                    autoOpen: false,
                    modal: true,
                    width: 300,
                    height: 350,
                    position: ["top", "top"],
                    buttons: {
                        修改: function () {
                            updateinfo();
                        }, 关闭: function () {
                            $(this).dialog("close");
                        }
                    }
                });
                $("#pojects").change(function () {
                    projectId = $(this).val();
                    $("#MenuBox li:eq(0) a").click();
                    $('#panemask').showLoading({
                        'afterShow': function () {
                            setTimeout("$('#panemask').hideLoading()", 1000);
                        }

                    });
                    getfNumber();
                });
                getfNumber();
            });
            //修改个人信息
            function updateinfo() {
                var obj = {};
                obj.id = $("#id").val();
                obj.email = $("#email1").val();
                obj.phone = $("#phone1").val();
                obj.department = $("#department1").val();
                $.ajax({async: false, url: "login.usermanage.editUinfo.action", type: "get", datatype: "JSON", data: obj,
                    success: function (data) {
                        var arrlist = data.rs;
                        if (arrlist.length > 0) {
                            layerAler("修改成功！");
                            $('#dialog-add').dialog('close');
                        }
                    }
                });

            }

            function showDialog() {
                $("#id").val($("#userid").val());
                $("#uname1").val($("#u_name").val());
                $("#email1").val($("#email").val());
                $("#phone1").val($("#phone").val());
                $("#department1").val($("#department").val());
                $('#dialog-add').dialog('open');
                return false;
            }





            function  getusername() {
                var name = $("#u_name").val();
                return name;
            }

            function  getupid() {
                var upid = $("#upid").val();
                return upid;
            }

            //后台管理
            function  manage() {
                $("#iiii").click();
            }

            function size() {
                var Wwidth = $(window).width();
                if (Wwidth > 768) {
                    withs = $(window).width() * 0.5;
                } else if (Wwidth > 1024) {
                    withs = $(window).width() * 0.3;
                } else {
                    withs = 350;
                }

            }
            window.onresize = function () {
                size();
            };

        </script> 
    </head>
    <body id="panemask">


        <c:set var="lang" value="${cookie.lang.value}"></c:set>     
        <c:set var="pid" value="${fn:split(param.pid,',')[0]}"></c:set>   
        <c:if test="${empty cookie.lang.value }">
            <c:set var="lang" value="zh_CN"></c:set>     
        </c:if>
        <c:set var="urlparam" value="lang=${lang}&name=${param.name}&userId=${param.id}&role=${param.role}"></c:set>     
            <header class="navbar-wrapper">
                <div class="navbar navbar-fixed-top" style=" background-color:rgb(92, 183, 92);">
                    <div class="container-fluid cl">
                        <a href='#' class="logo navbar-logo f-l mr-10 hidden-xs"><img src="img/jdkj.png" style=" width: 110px;"></a>
                        <a class="logo navbar-logo f-l mr-10 hidden-xs" href="#" style=' font-size: 18px;'>智慧农业生产管理控制系统</a> 
                        <a class="logo navbar-logo-m f-l mr-10 visible-xs" href="#"></a> 
                        <nav id="Hui-userbar" style=" display: block; color: white;">
                            <ul class=" inline" style=" margin-top: 10px; float: left" id="infoUL">
                                <li>
                                    <select style=" height: 30px; margin-top:0px;  background-color:  #7aba7b; color:  white; font-size: 16px;" id="pojects">
                                    </select>
                                </li>
                                <li class="dropDown dropDown_hover" style=" margin-right: -15px;">
                                    <a href="#" class="dropDown_A">语言<i class="Hui-iconfont">&#xe6d5;</i></a>
                                    <ul class="dropDown-menu menu radius box-shadow">
                                        <li><a href="#">中文</a></li>
                                        <li><a href="#">英文</a></li>
                                    </ul>
                                </li>                             
                                <li id="Hui-msg" onclick="imgM()"> <a href="#" title="消息"><i class="Hui-iconfont" style="font-size:18px">&#xe68a;</i></a> <div id="fnumber">1</div></li>
                                <li  style=" margin-right: 10px;" id="admin">
                                    <!--                                    <a href="#" class="dropDown_A">admin <i class="Hui-iconfont">&#xe6d5;</i></a>-->
                                    <span  style="color: rgb(255, 255, 255);"><img src="./img/user.jpg" style=" height: 40px; width: 40px;vertical-align: middle; border-radius: 16px;"></span>
                                    <input id="m_code" type="hidden" value="${rs[0].m_code}"/>
                                <input id="pwd" type="hidden" value="${rs[0].password}"/>
                                <input id="userid" type="hidden" value="${rs[0].id}"/>
                                <input id="upid" type="hidden" value="${rs[0].pid}"/>
                                <input id="u_name" type="hidden" value="${rs[0].name}"/>
                                <input id="email" type="hidden" value="${rs[0].email}">
                                <input id="phone" type="hidden" value="${rs[0].phone}">
                                <input id="department" type="hidden" value="${rs[0].department}">
                                <ul class="dropDown-menu menu radius box-shadow" id="userinfo" style="display: none;">
                                    <li onclick="showDialog()"><a href="#">个人信息</a></li>
                                        <c:if test="${rs[0].Ismanage==1}">
                                        <li onclick="manage()"><a href="#">后台数据管理</a></li>
                                        </c:if>
                                    <li onclick="getout()"><a href="#">退出</a></li>
                                </ul>
                            </li>
                        </ul>
                    </nav>
                    <a aria-hidden="false" class="nav-toggle Hui-iconfont visible-xs" href="javascript:;" id="smdh">&#xe667;</a>       
                </div>
            </div>
        </header>
        <aside class="Hui-aside" style=" background-color: rgb(14, 98, 199);">
            <div class="menu_dropdown bk_2">
                <c:forEach items="${menu}" var="t" varStatus="i">
                    <c:if test="${t.m_parent==0}">
                        <dl id="menu-picture">

                            <dt>
                                <span class="${t.m_icon}"></span>&nbsp;
                                ${t.m_text[lang]}
                                <i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i>
                            </dt>
                            <dd>
                                <ul id="MenuBox">
                                    <c:if test="${fn:length(t.children)==0}">
                                        <li>
                                            <a data-url="${t.m_action}?${urlparam}&action=${t.m_action}" data-href="${t.m_action}?${urlparam}&action=${t.m_action}" data-title="${t.m_text[lang]}" href="javascript:void(0)">${t.m_text[lang]}</a>
                                        </li>
                                    </c:if>
                                    <c:forEach items="${t.children}" var="t1" varStatus="y">
                                        <li>
                                            <a data-url="${t1.m_action}?${urlparam}&action=${t1.m_action}" data-href="${t1.m_action}?${urlparam}&action=${t1.m_action}" data-title="${t1.m_text[lang]}" href="javascript:void(0)">${t1.m_text[lang]}</a>
                                        </li>
                                    </c:forEach>
                                    <li style=" display: none">
                                        <a id="iiii" data-url="gatewaymanage.jsp?" data-href="" data-title="后台数据管理" href="javascript:void(0)">后台数据管理</a>

                                        <!--<a data-url="monitor.jsp?lang=zh_CN&amp;name=jiade&amp;userId=12&amp;role=1&amp;action=monitor.jsp" data-href="monitor.jsp?lang=zh_CN&amp;name=jiade&amp;userId=12&amp;role=1&amp;action=monitor.jsp" data-title="传感器监视" href="javascript:void(0)">传感器监视</a>-->


                                    </li>
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
                                    <span data-url="${t.m_action}?${urlparam}&action=${t.m_action}" data-href="${t.m_action}?pid=${param.pid}&${urlparam}&action=${t.m_action}" title="${t.m_text[lang]}" >${t.m_text[lang]}</span>
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
                    <iframe id="iframe" scrolling="yes" frameborder="0" src="${main}?${urlparam}&pid=${param.pid}"></iframe>
                </div>
            </div>
        </section>

        <div class="contextMenu" id="Huiadminmenu">
            <ul>
                <li id="closethis">关闭当前 </li>
                <li id="closeall">关闭全部 </li>
            </ul>
        </div>

        <script type="text/javascript" src="static/h-ui/js/H-ui.js"></script>
        <script type="text/javascript" src="static/h-ui.admin/js/H-ui.admin.js"></script>
        <script type="text/javascript" src="lib/jquery.contextmenu/jquery.contextmenu.r2.js"></script> 




        <div id="dialog-add"  class="bodycenter"  style=" display: none" title="个人信息">

            <form action="" method="POST" id="userInfo">   
                <input id="id" name="id" type="hidden">
                <table>
                    <tbody>
                        <tr>
                            <td>
                                <span style="margin-left:15px;">用户名：</span>&nbsp;
                                <input id="uname1" class="form-control" style="width:150px;display: inline;" readonly="true"  type="text">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span style="margin-left:28px;">邮箱：</span>&nbsp;
                                <input id="email1" class="form-control" style="width:150px;display: inline;" placeholder="请输入邮箱" type="text">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span style="margin-left:28px;">电话：</span>&nbsp;
                                <input id="phone1" class="form-control" style="width:150px;display: inline;" placeholder="请输入联系方式" type="text">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span style="margin-left:28px;">部门：</span>&nbsp;
                                <input id="department1" class="form-control" style="width:150px;display: inline;" placeholder="请输入部门" type="text">
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form>                        
        </div>

        <div id="faultDiv"  class="bodycenter"  style=" display: none" title="报警信息">
            <div>
                <span style="margin-left:10px;">网关&nbsp;</span>
                <input id="l_comaddr" name="l_comaddr" class="easyui-combobox"  style=" height: 30px" data-options="editable:true,valueField:'id', textField:'text' " />
                <button style=" height: 30px;" class="btn btn-sm btn-success" onclick="select()" style="margin-left:10px;"><label id="34" name="xxx">搜索</label></button>
                <button style=" height: 30px; margin-left: 5px;" type="button" id="btn_download" class="btn btn-primary" onClick ="$('#fauttable').tableExport({type: 'excel', escape: 'false'})">
                    <label id="110" name="xxx">导出Excel</label>
                </button>
            </div>
            <hr>
            <table id="fauttable">

            </table>
        </div>




    </body>
</html>
