<%-- 
    Document   : map
    Created on : 2018-8-2, 15:29:53
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include  file="js.jspf" %>
        <script src="layer/layer.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
        <style type="text/css">
            body, html {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
            .search>tr>td {
                padding-top: 20px;
            }
            #showtext{
                width: 230px;
                height: 30px;
                font-size: 20px;
            }
            #fdiv{
                width: 70%;
                margin-left: -20%;
            }
            .bodycenter { text-align: -webkit-center; text-align: -moz-center; width: 600px; margin: auto; } 

            #up-map-div{
                width:300px;

            }
            #ta tr td{
                margin-top: 20px;

            }
            .items li{ 
                width: 100px;
                height:20px; 
                text-align:left; 
                margin-left: -40px;
                line-height:20px; 
                cursor:pointer;

            } 
            .items li:hover {color: #FF00FF}

            @media screen and (max-width:767px) {  
                #up-map-div{
                    width:260px;

                }

                #showdiv{
                    top:1%;
                    left:3%;
                    position:absolute;
                    z-index:9999;
                    filter:alpha(opacity=40);
                }
                #showtext{
                    display: none;
                }
                html{
                    font-size: 6px;
                }
                #abut{
                    margin-top: 3px;
                }
                #righttext{
                    font-size: 12px;
                }
                #textdiv{
                    font-size: 10px;
                }
                #showwg{
                    margin-top: 2px;
                }
            }

            @media screen and (min-width:768px) {  
                #up-map-div{
                    width:260px;

                }

                #showdiv{
                    top:1%;
                    left:1%;
                    position:absolute;
                    z-index:9999;
                    filter:alpha(opacity=40);
                }
                #showtext{
                    display: none;
                }
                html{
                    font-size: 6px;
                }
                #abut{
                    margin-top: 3px;
                    width: 30%;
                    float: left;
                }
                #showtext{
                    display: block;
                    width: 30%;
                    float: left;
                }
                #showwg{
                    width: 40%;
                    float: left;
                }

            }
            @media screen and (min-width:1025px) {  
                #up-map-div{
                    width:100%;

                }

                #showdiv{
                    top:2%;
                    left:5%;
                    position:absolute;
                    z-index:9999;
                    filter:alpha(opacity=40);
                }
                #showtext{
                    display: none;
                }
                html{
                    font-size: 6px;
                }
                #abut{
                    margin-top: 3px;
                    width: 300px;
                    float: left;
                }
                #showtext{
                    display: block;
                    width: 230px;
                    float: left;
                }
                #showwg{
                    width: 250px;
                    float: left;
                }

            }

        </style>
        <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=19mXqU4pjrrqSH20w2gORu6OhFaKddYo"></script>
        <script type="text/javascript" src="js/genel.js"></script>
        <script type="text/javascript" src="js/getdate.js"></script>
        <script type="text/javascript" src="bootstrap-table/dist/bootstrap-table.js"></script>
        <script type="text/javascript" src="bootstrap-table/dist/locale/bootstrap-table-zh-CN.min.js"></script>
        <script type="text/javascript" src="bootstrap-table/dist/locale/bootstrap-table-zh-CN.js"></script>
        <script>
            var u_name = "${param.name}";
            var o_pid = "${param.pid}";
            function layerAler(str) {
                layer.alert(str, {
                    icon: 6,
                    offset: 'center'
                });
            }
            function wg() {
                var allOver = map.getOverlays(); //获取全部标注
                for (var j = 0; j < allOver.length; j++) {
                    if (allOver[j].toString() == "[object Marker]") {
                        //清除所有标记
                        map.removeOverlay(allOver[j]);
                    }
                    if (allOver[j].toString().indexOf("Polyline") > 0) {//删除折线
                        map.removeOverlay(allOver[j]);
                    }
                }
                var pid = parent.getpojectId();
                var objw = {};
                objw.pid = pid;
                if ($("#lampcomaddrlist2").val() != "") {
                    objw.comaddr = $("#lampcomaddrlist2").val();
                }
                $.ajax({async: false, url: "login.map.lnglat.action", type: "get", datatype: "JSON", data: objw,
                    success: function (data) {
                        var arrlist = data.rs;
                        if (arrlist.length > 0) {
                            wglist(arrlist);
                        }
                    },
                    error: function () {
                        alert("提交失败！");
                    }
                });
            }

            function  cgq() {
                var allOver = map.getOverlays(); //获取全部标注
                for (var j = 0; j < allOver.length; j++) {
                    if (allOver[j].toString() == "[object Marker]") {
                        //清除所有标记
                        map.removeOverlay(allOver[j]);
                    }
                    if (allOver[j].toString().indexOf("Polyline") > 0) {//删除折线
                        map.removeOverlay(allOver[j]);
                    }
                }
                var pid = parent.getpojectId();
//                    var d = new Date();
//                    var day = d.toLocaleDateString();
                var lobj = {};
                lobj.pid = pid;
                if ($("#lampcomaddrlist2").val() != "") {
                    lobj.comaddr = $("#lampcomaddrlist2").val();
                }
                $.ajax({async: false, url: "login.map.queryLamp.action", type: "get", datatype: "JSON", data: lobj,
                    success: function (data) {

                        var arrlist = data.rs;
                        if (arrlist.length > 0) {
                            lamplists(arrlist);
                        }

                    },
                    error: function () {
                        alert("提交失败！");
                    }
                });
            }

            function  hl() {
                var allOver = map.getOverlays(); //获取全部标注
                for (var j = 0; j < allOver.length; j++) {
                    if (allOver[j].toString() == "[object Marker]") {
                        //清除所有标记
                        map.removeOverlay(allOver[j]);
                    }
                    if (allOver[j].toString().indexOf("Polyline") > 0) {//删除折线
                        map.removeOverlay(allOver[j]);
                    }
                }
                var pid = parent.getpojectId();
//                    var d = new Date();
//                    var day = d.toLocaleDateString();
                var lobj = {};
                lobj.pid = pid;
                if ($("#lampcomaddrlist2").val() != "") {
                    lobj.l_comaddr = $("#lampcomaddrlist2").val();
                }
                $.ajax({async: false, url: "login.map.queryloop.action", type: "get", datatype: "JSON", data: lobj,
                    success: function (data) {

                        var arrlist = data.rs;
                        if (arrlist.length > 0) {
                            Loopbz(arrlist);
                        }

                    },
                    error: function () {
                        alert("提交失败！");
                    }
                });
            }
            function size() {
                var showdivWidth = $(window).width() * 0.8;
                $("#showdiv").css("width", showdivWidth);
            }
            window.onresize = function () {
                size();
            };
        </script>
    </head>
    <body id="panemask">
        <div id="showdiv">
            <input type="text" id="showtext" readonly="true">
            <div  id="showwg">
                <span>网关</span>：
                <input id="lampcomaddrlist2" data-options="editable:true,valueField:'id', textField:'text'"  class="easyui-combobox"/>&nbsp; 
            </div>
            <div id="abut">
                <button onclick="wg()"><span>网关</span></button>
                <button onclick="hl()">回路</button>
                <button onclick="cgq()" id="dj"><span >传感器</span></button>
                <button id="bzzt"><span>标识状态</span></button>
            </div>
        </div>
        <div id="allmap" style=" width: 85%; height: 100%; float: left;">

        </div>
        <div style=" width: 15%; height: 100%; float: left;" id="righttextdiv">
            <div id="textdiv" style=" margin-left: 10px;  height: 91%; overflow-x: scroll;">
                <div id="up-map-div" style=" display: none">
                    <h4>标识状态</h4>
                    <hr>
                    <p>传感器在线:<img src="img/cglv.png" style=" margin-left:0px;"></p>
                    <p>传感器离线:<img src="img/cglan.png" style=" margin-left:0px;"></p>
                    <p>传感器异常:<img src="img/cgred.png" style=" margin-left:0px;"></p>
                    <p>网关在线:<img src="img/wzx.png" style=" margin-left:3px;"></p>
                    <p>网关离线:<img src="img/wlx.png" style=" margin-left:3px;"></p>
                    <p>回路闭合:<img src="img/hll.png" style=" margin-left:3px;"></p>
                    <p>回路断开:<img src="img/hldk.png" style=" margin-left:3px;"></p>
                </div>
                <div id="textdiv2">

                </div>
            </div>

        </div>

        <!-- 添加 网关-->
        <div  id="addwanguang" class="bodycenter"  style=" display: none" title=" 添加网关" >
            <div class="">
                <div class="">
                    <table>
                        <tbody class="search">
                            <tr>
                                <td>
                                    <span style="margin-left:0px;" id="64" name="xxxx">
                                        所属区域
                                    </span>&nbsp;
                                    <input type="text" id ="area" style="width:150px; height: 30px;">
                                </td>
                                <td>
                                    <span style="margin-left:30px;">                                     
                                        <span>网关名称</span>
                                        &nbsp;</span>
                                    <input id="comaddrlist" data-options='editable:false,valueField:"id", textField:"text"' class="easyui-combobox"/>
                                </td>
                                <td>
                                    <!-- <input type="button" class="btn btn-sm btn-success" onclick="selectlamp()" value="搜索" style="margin-left:10px;">-->
                                    <button class="btn btn-sm btn-success" onclick="getInfoByComaddr()" style="margin-left:10px;"><span id="34" name="xxxx">搜索</span></button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <hr>
                <div>
                    <table id="wgtable">

                    </table>
                </div>
            </div>
        </div>
        <!--添加传感器-->
        <div  id="addlamp" class="bodycenter"  style=" display: none" title="添加传感器" >
            <div class="">
                <div  style="min-width:700px;">   
                    <div class="">
                        <table>
                            <tbody class="search">
                                <tr>
                                    <td>
                                        <span style="margin-left:30px;" id="54" name="xxxx">
                                            传感器名称
                                        </span>&nbsp;
                                        <input type='text' id='lampname'>
                                    <td>
                                        <span style="margin-left:50px;">
                                            <span id="55" name="xxxx">所属网关</span>
                                            &nbsp;</span>
                                        <input id="lampcomaddrlist" data-options='editable:false,valueField:"id", textField:"text"' class="easyui-combobox"/>
                                    </td>
                                    <td>
                                        <!-- <input type="button" class="btn btn-sm btn-success" onclick="selectlamp()" value="搜索" style="margin-left:10px;">-->
                                        <button class="btn btn-sm btn-success" onclick="selectlamp()" style="margin-left:10px;"><span id="34" name="xxxx">搜索</span></button>
                                    </td>
                                </tr>                                   
                            </tbody>
                        </table>
                    </div>
                    <hr>
                    <div>
                        <table id="lamptable">

                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!--添加回路-->
        <div  id="addloop" class="bodycenter"  style=" display: none" title="添加回路" >
            <div class="">
                <div  style="min-width:700px;">   
                    <div class="">
                        <table>
                            <tbody class="search">
                                <tr>
                                    <td>
                                        <span style="margin-left:30px;" id="54" name="xxxx">
                                            回路名称
                                        </span>&nbsp;
                                        <input type='text' id='loopname'>
                                    <td>
                                        <span style="margin-left:50px;">
                                            <span >所属网关</span>
                                            &nbsp;</span>
                                        <input id="loopcomaddrlist" data-options='editable:false,valueField:"id", textField:"text"' class="easyui-combobox"/>
                                    </td>
                                    <td>
                                        <!-- <input type="button" class="btn btn-sm btn-success" onclick="selectlamp()" value="搜索" style="margin-left:10px;">-->
                                        <button class="btn btn-sm btn-success" onclick="selectloop()" style="margin-left:10px;"><span id="34" name="xxxx">搜索</span></button>
                                    </td>
                                </tr>                                   
                            </tbody>
                        </table>
                    </div>
                    <hr>
                    <div>
                        <table id="looptable">

                        </table>
                    </div>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            //创建网关在线图标
            var wggreenicon = new BMap.Icon('./img/wzx.png', new BMap.Size(27, 32), {//20，30是图片大小
                //anchor: new BMap.Size(0, 0)      //这个是信息窗口位置（可以改改看看效果）
            });
            //创建网关离线图标
            var wghuiicon = new BMap.Icon('./img/wlx.png', new BMap.Size(27, 32), {//20，30是图片大小
                //anchor: new BMap.Size(0, 0)      //这个是信息窗口位置（可以改改看看效果）
            });
            //创建传感器离线图标
            var lhui = new BMap.Icon('./img/cglan.png', new BMap.Size(27, 32), {//20，30是图片大小
                // anchor: new BMap.Size(0, 0)      //这个是信息窗口位置（可以改改看看效果）
            });
            //创建传感器在线图标
            var lgreen = new BMap.Icon('./img/cglv.png', new BMap.Size(27, 32), {//20，30是图片大小
                //anchor: new BMap.Size(0, 0)      //这个是信息窗口位置（可以改改看看效果）
            });
            //创建传感器异常图标
            var lred = new BMap.Icon('./img/cgred.png', new BMap.Size(27, 32), {//20，30是图片大小
                //anchor: new BMap.Size(0, 0)      //这个是信息窗口位置（可以改改看看效果）
            });
            //创建传感器亮灯图标
            var lyello = new BMap.Icon('./img/lyello.png', new BMap.Size(27, 32), {//20，30是图片大小
                //anchor: new BMap.Size(0, 0)      //这个是信息窗口位置（可以改改看看效果）
            });
            //创建回路闭合图标
            var hlbh = new BMap.Icon('./img/hll.png', new BMap.Size(27, 32), {//20，30是图片大小
                //anchor: new BMap.Size(0, 0)      //这个是信息窗口位置（可以改改看看效果）
            });
            //创建传感器亮灯图标
            var hldk = new BMap.Icon('./img/hldk.png', new BMap.Size(27, 32), {//20，30是图片大小
                //anchor: new BMap.Size(0, 0)      //这个是信息窗口位置（可以改改看看效果）
            });
            function layerAler(str) {
                layer.alert(str, {
                    icon: 6,
                    offset: 'center'
                });
            }

            //计算时间差
            function TimeDifference(time1, time2)
            {

                time1 = new Date(time1.replace(/-/g, '/'));
                time2 = new Date(time2.replace(/-/g, '/'));
                var ms = Math.abs(time1.getTime() - time2.getTime());
                return ms / 1000 / 60;

            }
            var lang = "${param.lang}";
            //加载所有传感器信息
            function  getAllLampInfo(pid) {

                $('#lamptable').bootstrapTable({
                    url: 'login.map.sensor.action?pid=' + pid,
                    columns: [
                        {
                            title: 'id',
                            field: 'id',
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            visible: false, //不显示
                            class: 'lampId'
                        },
                        {
                            title: '单选',
                            field: 'select',
                            //复选框
                            checkbox: true,
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            field: 'name',
                            title: '传感器名称', //传感器名称
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            field: 's_identify',
                            title: '所属网关', //所属网关
                            width: 25,
                            align: 'center',
                            valign: 'middle'
//                            formatter: function (value, row, index, field) {
//                                return  value.replace(/\b(0+)/gi, "");
//                            }
                        },
                        {
                            field: 'longitude',
                            title: '经度', //经度
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            field: 'latitude',
                            title: '纬度', //纬度
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            field: 'onlinetime',
                            title: '状态', //在线状态
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            formatter: function (value, row, index, field) {
                                var str = "";
                                if (row.errflag == 1) {
                                    str = "<img  src='img/cgred.png'/>";
                                } else {
                                    var obj = {};
                                    obj.identify = row.s_identify; //selects[0];
                                    $.ajax({url: "login.gateway.comaddrzx.action", async: false, type: "get", datatype: "JSON", data: obj,
                                        success: function (data) {
                                            var arrlist = data.rs;
                                            if (arrlist[0].online == 1) {
                                                str = "<img  src='img/cglv.png'/>";
                                            } else {
                                                str = "<img  src='img/cglan.png'/>";
                                            }
                                        },
                                        error: function () {
                                            alert("提交添加失败！请刷新");
                                        }
                                    });
                                }

                                return  str;
                            }
                        }],
                    method: "post",
                    contentType: "application/x-www-form-urlencoded",
                    singleSelect: false, //设置单选还是多选，true为单选 false为多选
                    sortName: 'id',
                    locale: 'zh-CN', //中文支持,
                    minimumCountColumns: 7, //最少显示多少列
                    showColumns: true,
                    sortOrder: 'desc',
                    pagination: true,
                    sidePagination: 'server',
                    pageNumber: 1,
                    pageSize: 15,
                    showRefresh: false,
                    showToggle: true,
                    // 设置默认分页为 50
                    pageList: [5, 10, 15, 20, 25],
                    onLoadSuccess: function () {  //加载成功时执行  表格加载完成时 获取集中器在线状态
                        console.info("加载成功");
                    },
                    //服务器url
                    queryParams: function (params)  {   //配置参数     
                        var temp  =   {    //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的 
                            search: params.search,
                            skip: params.offset,
                            limit: params.limit,
                            type_id: "1"   
                        };      
                        return temp;  
                    }
                });
            }
            //加载所有所属网关信息
            function getAllInfo() {
                var pid = parent.getpojectId();
                $("#wgtable").bootstrapTable({
                    url: 'login.map.map.action?pid=' + pid,
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
//                        {
//                            field: 'model',
//                            title: '型号', //型号
//                            width: 25,
//                            align: 'center',
//                            valign: 'middle'
//                        }, 
                        {
                            field: 'name',
                            title: '名称', //名称
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            field: 'comaddr',
                            title: '网关地址', //网关地址
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            formatter: function (value, row, index, field) {
                                return  value.replace(/\b(0+)/gi, "");
                            }
                        }, {
                            field: 'Longitude',
                            title: '经度', //经度
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            field: 'latitude',
                            title: '纬度', //纬度
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            field: 'online',
                            title: '在线状态', //在线状态
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            formatter: function (value, row, index) {
                                if (value == 1) {
                                    return "<img  src='img/online1.png'/>";
                                } else {
                                    return "<img  src='img/off.png'/>";
                                }

                            }
                        }],
                    singleSelect: false,
                    sortName: 'id',
                    locale: 'zh-CN', //中文支持,
                    // minimumCountColumns: 7, //最少显示多少列
                    showColumns: true,
                    sortOrder: 'desc',
                    pagination: true,
                    sidePagination: 'server',
                    pageNumber: 1,
                    pageSize: 10,
                    showRefresh: false, //是否显示刷新
                    // showToggle: true,
                    // 设置默认分页为 50
                    pageList: [5, 10, 15, 20, 25],
                    onLoadSuccess: function () {  //加载成功时执行  表格加载完成时 获取集中器在线状态
                        console.info("加载成功");
                    },
                    //服务器url
                    queryParams: function (params)  {   //配置参数     
                        var temp  =   {    //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的 
                            search: params.search,
                            skip: params.offset,
                            limit: params.limit,
                            type_id: "1"   
                        };      
                        return temp;  
                    }
                });
            }


            //加载所有回路信息
            function getLoopInfo() {
                var pid = parent.getpojectId();
                $("#looptable").bootstrapTable({
                    url: 'login.map.loop.action?pid=' + pid,
                    columns: [
                        {
                            title: '单选',
                            field: 'select',
                            //复选框
                            checkbox: true,
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            field: 'l_name',
                            title: '回路名称', //型号
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            field: 'l_switch',
                            title: '状态',
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            formatter: function (value, row, index, field) {
                                if (value == 1) {
                                    return "闭合";
                                } else {
                                    return "断开";
                                }
                            }

                        }, {
                            field: 'l_identify',
                            title: '所属网关', //网关地址
                            width: 25,
                            align: 'center',
                            valign: 'middle'
//                            formatter: function (value, row, index, field) {
//                                return  value.replace(/\b(0+)/gi, "");
//                            }
                        }, {
                            field: 'l_longitude',
                            title: '经度', //经度
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            field: 'l_latitude',
                            title: '纬度', //纬度
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }
                    ],
                    singleSelect: false,
                    sortName: 'id',
                    locale: 'zh-CN', //中文支持,
                    // minimumCountColumns: 7, //最少显示多少列
                    showColumns: true,
                    sortOrder: 'desc',
                    pagination: true,
                    sidePagination: 'server',
                    pageNumber: 1,
                    pageSize: 10,
                    showRefresh: false, //是否显示刷新
                    // showToggle: true,
                    // 设置默认分页为 50
                    pageList: [5, 10, 15, 20, 25],
                    onLoadSuccess: function () {  //加载成功时执行  表格加载完成时 获取集中器在线状态
                        console.info("加载成功");
                    },
                    //服务器url
                    queryParams: function (params)  {   //配置参数     
                        var temp  =   {    //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的 
                            search: params.search,
                            skip: params.offset,
                            limit: params.limit,
                            type_id: "1"   
                        };      
                        return temp;  
                    }
                });
            }

            //根据所属网关查询网关信息
            function getInfoByComaddr() {

                var comaddr = $("#comaddrlist").val();
                var area = $("#area").val();
                var obj = {};
                obj.type = "ALL";
                if (comaddr != "") {
                    obj.comaddr = comaddr;
                }
                if (area != "") {
                    obj.area = encodeURI(area);
                }
                var pid = parent.getpojectId();
                obj.pid = pid;

                var opt = {
                    //method: "post",
                    url: "login.map.map.action",
                    silent: true,
                    query: obj
                };
                $("#wgtable").bootstrapTable('refresh', opt);
            }
            //关闭添加传感器弹窗
            function  lampout() {
                $("#lamptable input:checkbox").each(function () {
                    if ($(this).is(":checked")) {
                        $(this).prop("checked", false);
                    }
                });
                layer.close(layer.index);
            }
            //关闭添加网关弹窗
            function closeAddComaddr() {
                $("#wgtable input:checkbox").each(function () {
                    if ($(this).is(":checked")) {
                        $(this).prop("checked", false);
                    }
                });
                layer.close(layer.index);
            }
            // 百度地图API功能
            var map = new BMap.Map("allmap", {enableMapClick: false}); // 创建Map实例
            map.centerAndZoom(new BMap.Point(110.32962, 21.281107), 15); // 初始化地图,设置中心点坐标和地图级别
            //添加地图类型控件
            map.addControl(new BMap.MapTypeControl({
                mapTypes: [
                    BMAP_NORMAL_MAP,
                    BMAP_HYBRID_MAP
                ]}));
            //  map.centerAndZoom("湛江", 15); // 设置地图显示的城市 此项是必须设置的
            map.enableScrollWheelZoom(true); //开启鼠标滚轮缩放

            var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT}); // 左上角，添加比例尺
            var top_left_navigation = new BMap.NavigationControl(); //左上角，添加默认缩放平移控件
            var top_right_navigation = new BMap.NavigationControl({anchor: BMAP_ANCHOR_TOP_RIGHT, type: BMAP_NAVIGATION_CONTROL_SMALL}); //右上角，仅包含平移和缩放按钮
            /*缩放控件type有四种类型:
             BMAP_NAVIGATION_CONTROL_SMALL：仅包含平移和缩放按钮；BMAP_NAVIGATION_CONTROL_PAN:仅包含平移按钮；BMAP_NAVIGATION_CONTROL_ZOOM：仅包含缩放按钮*/
            map.addControl(top_left_control);
            map.addControl(top_left_navigation);
            map.addControl(top_right_navigation);
            function ZoomControl() {
                // 默认停靠位置和偏移量
                this.defaultAnchor = BMAP_ANCHOR_TOP_LEFT;
                this.defaultOffset = new BMap.Size(450, 5);
            }

            // 通过JavaScript的prototype属性继承于BMap.Control
            ZoomControl.prototype = new BMap.Control();
            // 自定义控件必须实现自己的initialize方法,并且将控件的DOM元素返回
            // 在本方法中创建个div元素作为控件的容器,并将其添加到地图容器中
            //           ZoomControl.prototype.initialize = function (map) {
//                var o = parent.parent.getLnas();
//                var lang = "${param.lang}";
//                // 创建一个DOM元素
//                var div = document.createElement("div");
//                div.setAttribute("id", "fdiv");
//                var button1 = document.createElement("input");
//                var text = document.createElement("input"); //显示经纬度
//                text.setAttribute("type", "text");
//                text.setAttribute("value", "");
//                text.setAttribute("id", "showtext");
//                text.setAttribute("style", "margin-right: 40px;");
//                text.setAttribute("readonly", "readonly");
//                div.appendChild(text);
//                button1.setAttribute("type", "text");
//                button1.setAttribute("value", "");
//                button1.setAttribute("id", "seartxt");
//                div.appendChild(button1);
//                var button2 = document.createElement("input");
//                button2.setAttribute("type", "button");
//                button2.setAttribute("value", o[34][lang]);//搜索按钮
//                button2.setAttribute("style", "margin-left: 5px");
//                button2.setAttribute("id", "search");
//                div.appendChild(button2);
//                var button3 = document.createElement("input");
//                button3.setAttribute("type", "button");
//                button3.setAttribute("value", o[50][lang]);//网关按钮
//                button3.setAttribute("style", "margin-left: 5px");
//                button3.setAttribute("id", "jzq");
//                div.appendChild(button3);
//                var button4 = document.createElement("input");
//                button4.setAttribute("type", "button");
//                button4.setAttribute("value", o[51][lang]); //传感器按钮
//                button4.setAttribute("style", "margin-left: 5px");
//                button4.setAttribute("id", "dj");
//                div.appendChild(button4);
//
//                var button5 = document.createElement("input");
//                button5.setAttribute("type", "button");
//                button5.setAttribute("value", o[52][lang]);//状态标识
//                button5.setAttribute("style", "margin-left: 5px");
//                button5.setAttribute("id", "zt");
//                div.appendChild(button5);
//
//                var button6 = document.createElement("input");
//                button6.setAttribute("type", "button");
//                button6.setAttribute("value", o[414][lang]);//状态标识
//                button6.setAttribute("style", "margin-left: 5px");
//                button6.setAttribute("id", "zt");
//                div.appendChild(button6);
//
//                //网关单击事件
//                button3.onclick = function (e) {
//                    var allOver = map.getOverlays(); //获取全部标注
//                    for (var j = 0; j < allOver.length; j++) {
//                        if (allOver[j].toString() == "[object Marker]") {
//                            //清除所有标记
//                            map.removeOverlay(allOver[j]);
//                        }
//                        if (allOver[j].toString().indexOf("Polyline") > 0) {//删除折线
//                            map.removeOverlay(allOver[j]);
//                        }
//                    }
//                    var pid = parent.getpojectId();
//                    var objw = {};
//                    objw.pid = pid;
//                    $.ajax({async: false, url: "login.map.lnglat.action", type: "get", datatype: "JSON", data: objw,
//                        success: function (data) {
//                            var arrlist = data.rs;
//                            if(arrlist.length>0){
//                                 wglist(arrlist);
//                            }
//                        },
//                        error: function () {
//                            alert("提交失败！");
//                        }
//                    });
//                };
//                //搜索网关
//                button2.onclick = function (e) {
//                    var pid = parent.getpojectId();
//                    var allOver = map.getOverlays(); //获取全部标注
//                    for (var j = 0; j < allOver.length; j++) {
//                        if (allOver[j].toString() == "[object Marker]") {
//                            //清除所有标记
//                            map.removeOverlay(allOver[j]);
//                        }
//                        if (allOver[j].toString().indexOf("Polyline") > 0) {//删除折线
//                            map.removeOverlay(allOver[j]);
//                        }
//                    }
//                    var obj = {};
//                    var comaddr = $("#seartxt").val();
//                    if (comaddr != "") {
//                        obj.comaddr = comaddr;
//                    }
//                    obj.pid = pid;
//                    $.ajax({async: false, url: "login.map.lnglat.action", type: "get", datatype: "JSON", data: obj,
//                        success: function (data) {
//                            var arrlist = data.rs;
//                            if (arrlist.length > 0) {
//                                for (var i = 0; i < arrlist.length; i++) {
//                                    var obj = arrlist[i];
//                                    var Longitude = obj.Longitude;
//                                    var latitude = obj.latitude;
//                                    var Iszx = o[285][lang];   //离线    
//                                    if (obj.online == 1) {
//                                        Iszx = o[284][lang];   //在线    
//                                    }
//                                    if (Longitude != "" && latitude != "") {
//                                        var point = new BMap.Point(Longitude, latitude);
//                                        var marker1;
//                                        var marker1;
//                                        if (obj.online == 1) {
//                                            marker1 = new BMap.Marker(point, {
//                                                icon: wggreenicon
//                                            });
//                                        } else {
//                                            marker1 = new BMap.Marker(point, {
//                                                icon: wghuiicon
//                                            });
//                                        }
//                                        marker1.setTitle(obj.comaddr + "," + Iszx);   //这里设置maker的title (鼠标放到marker点上,会出现它的title,所以我这里把name,放到title里)
//                                        map.addOverlay(marker1);
//                                        map.panTo(point);
//                                    }
//                                }
//                            } else {
//                                alert(o[301][lang]);  //不存在该网关
//                            }
//                        },
//                        error: function () {
//                            alert("提交失败！");
//                        }
//                    });
//                };
//
//                //传感器
//                button4.onclick = function (e) {
//                    var allOver = map.getOverlays(); //获取全部标注
//                    for (var j = 0; j < allOver.length; j++) {
//                        if (allOver[j].toString() == "[object Marker]") {
//                            //清除所有标记
//                            map.removeOverlay(allOver[j]);
//                        }
//                        if (allOver[j].toString().indexOf("Polyline") > 0) {//删除折线
//                            map.removeOverlay(allOver[j]);
//                        }
//                    }
//                    var pid = parent.getpojectId();
//                    var d = new Date();
//                    var day = d.toLocaleDateString();
//                    var lobj = {};
//                    lobj.pid = pid;
//                    lobj.f_day = day;
//                    $.ajax({async: false, url: "login.map.queryLamp.action", type: "get", datatype: "JSON", data: lobj,
//                        success: function (data) {
//
//                            var arrlist = data.rs;
//                            if(arrlist.length>0){
//                               lamplists(arrlist);
//                            }
//                            
//                        },
//                        error: function () {
//                            alert("提交失败！");
//                        }
//                    });
//                };
//                var ij = 0;
//                button5.onclick = function (e) {
//                    if (ij == 0) {
//                        $("#up-map-div").show();
//                        ij = 1;
//                    } else {
//                        $("#up-map-div").hide();
//                        ij = 0;
//                    }
//                };
//
//                button6.onclick = function (e) {
//                    dealsend3("CheckLamp", "a", 0, 0, "check", 0, 0, "${param.pid}");
//                }
//                // 添加DOM元素到地图中
//                map.getContainer().appendChild(div);
//                // 将DOM元素返回
//                return div;
//            };

            var txtMenuItem = [
                {
                    text: '添加传感器', //添加传感器
                    callback: function () {
                        var allOver = map.getOverlays(); //获取全部标注
                        for (var j = 0; j < allOver.length; j++) {
                            if (allOver[j].toString() == "[object Marker]") {
                                //清除所有标记
                                map.removeOverlay(allOver[j]);
                            }
                            if (allOver[j].toString().indexOf("Polyline") > 0) {//删除折线
                                map.removeOverlay(allOver[j]);
                            }
                        }

                        //加载所有传感器信息
                        var porjectId = parent.getpojectId();
                        var obj = {};
                        obj.pid = porjectId;
                        var opt = {
                            method: "post",
                            contentType: "application/x-www-form-urlencoded",
                            url: "login.map.sensor.action",
                            silent: true,
                            query: obj
                        };
                        $("#lamptable").bootstrapTable('refresh', opt);
                        var id = "#lampcomaddrlist";
                        combobox(id, porjectId);
                        //清空标记
                        draw = false;
                        idlist = [];
                        onedraw = false;
                        wgdraw = false;
                        wgonedraw = false;
                        wgidlist = [];
                        $("#addlamp").dialog("open");


                    }
                },
                {
                    text: '添加网关', //添加网关
                    callback: function () {

                        var allOver = map.getOverlays(); //获取全部标注
                        for (var j = 0; j < allOver.length; j++) {
                            if (allOver[j].toString() == "[object Marker]") {
                                //清除所有标记
                                map.removeOverlay(allOver[j]);
                            }
                            if (allOver[j].toString().indexOf("Polyline") > 0) {//删除折线
                                map.removeOverlay(allOver[j]);
                            }
                        }
                        var porjectId = parent.getpojectId();
                        var obj = {};
                        obj.pid = porjectId;
                        //加载所有网关信息
                        var opt = {
                            method: "post",
                            contentType: "application/x-www-form-urlencoded",
                            url: "login.map.map.action",
                            silent: true,
                            query: obj
                        };
                        $("#wgtable").bootstrapTable('refresh', opt);
                        //加载所属网关
                        var id = "#comaddrlist";
                        combobox(id, porjectId);
                        //清空标记
                        wgdraw = false;
                        wgonedraw = false;
                        wgidlist = [];
                        draw = false;
                        idlist = [];
                        onedraw = false;
                        $('#addwanguang').dialog('open');
                    }
                }, {
                    text: '添加回路',
                    callback: function () {

                        var allOver = map.getOverlays(); //获取全部标注
                        for (var j = 0; j < allOver.length; j++) {
                            if (allOver[j].toString() == "[object Marker]") {
                                //清除所有标记
                                map.removeOverlay(allOver[j]);
                            }
                            if (allOver[j].toString().indexOf("Polyline") > 0) {//删除折线
                                map.removeOverlay(allOver[j]);
                            }
                        }
                        var porjectId = parent.getpojectId();
                        var obj = {};
                        obj.pid = porjectId;
                        //加载所有网关信息
                        var opt = {
                            method: "post",
                            contentType: "application/x-www-form-urlencoded",
                            url: "login.map.loop.action",
                            silent: true,
                            query: obj
                        };
                        $("#looptable").bootstrapTable('refresh', opt);
                        //加载所属网关
                        var id = "#loopcomaddrlist";
                        combobox(id, porjectId);
                        //清空标记
                        wgdraw = false;
                        wgonedraw = false;
                        wgidlist = [];
                        draw = false;
                        idlist = [];
                        onedraw = false;
                        $('#addloop').dialog('open');
                    }
                }
            ];
            //传感器选点绘线
            var draw = false;   //标记是否多点绘线
            var onedraw = false;  //勾选单个传感器
            var lampchecck;   //勾选单个传感器对象
            var idlist = new Array();  //标记选中的id
            function  Drawing() {
                var lampchecck2 = $("#lamptable").bootstrapTable('getSelections');
                if (lampchecck2.length > 1) {
                    draw = true;
                    for (var i = 0; i < lampchecck2.length; i++) {
                        idlist.push(lampchecck2[i].id);
                    }
                    $("#lamptable input:checkbox").each(function () {
                        if ($(this).is(":checked")) {
                            $(this).prop("checked", false);
                        }
                    });
                    $("#lamptable").bootstrapTable('refresh');
                    $('#addlamp').dialog("close");
                } else if (lampchecck2.length == 1) {
                    onedraw = true;
                    lampchecck = lampchecck2[0];
                    $("#lamptable input:checkbox").each(function () {
                        if ($(this).is(":checked")) {
                            $(this).prop("checked", false);
                        }
                    });
                    $("#lamptable").bootstrapTable('refresh');
                    $('#addlamp').dialog("close");
                } else {
                    alert("请勾选表格数据");  //请勾选表格数据
                }
            }

            //回路选点绘线
            var loopdraw = false;   //标记回路是否多点绘线
            var looponedraw = false;  //是否勾选单个回路
            var looplist = new Array(); //勾选的多个对象
            var loopobj;  //勾选单个对象
            function loopDrawing() {
                var loopchecck = $("#looptable").bootstrapTable('getSelections');
                if (loopchecck.length > 1) {
                    loopdraw = true;
                    for (var i = 0; i < loopchecck.length; i++) {
                        looplist.push(loopchecck[i].id);
                    }
                    $("#looptable input:checkbox").each(function () {
                        if ($(this).is(":checked")) {
                            $(this).prop("checked", false);
                        }
                    });
                    $("#looptable").bootstrapTable('refresh');
                    $('#addloop').dialog("close");
                } else if (loopchecck.length == 1) {
                    looponedraw = true;
                    loopobj = loopchecck[0];
                    $("#looptable input:checkbox").each(function () {
                        if ($(this).is(":checked")) {
                            $(this).prop("checked", false);
                        }
                    });
                    $("#looptable").bootstrapTable('refresh');
                    $('#addloop').dialog("close");
                } else {
                    alert("请勾选表格数据");
                }
            }
            //网关选点绘线
            var wgdraw = false;   //标记网关是否多点绘线
            var wgonedraw = false;  //勾选单个网关
            var wgchecck;   //勾选单个网关对象
            var wgidlist = new Array();  //标记选中网关的id
            function  wgDrawing() {
                var wgcheck2 = $("#wgtable").bootstrapTable('getSelections');
                if (wgcheck2.length > 1) {
                    wgdraw = true;
                    for (var i = 0; i < wgcheck2.length; i++) {
                        wgidlist.push(wgcheck2[i].identify);
                    }
                    $("#wgtable input:checkbox").each(function () {
                        if ($(this).is(":checked")) {
                            $(this).prop("checked", false);
                        }
                    });
                    $("#wgtable").bootstrapTable('refresh');
                    $('#addwanguang').dialog("close");
                } else if (wgcheck2.length == 1) {
                    wgonedraw = true;
                    wgchecck = wgcheck2[0];
                    $("#wgtable input:checkbox").each(function () {
                        if ($(this).is(":checked")) {
                            $(this).prop("checked", false);
                        }
                    });
                    $("#wgtable").bootstrapTable('refresh');
                    $('#addwanguang').dialog("close");
                } else {
                    alert("请勾选表格数据");  //请勾选表格数据
                }
            }
            //根据条件查询传感器
            function selectlamp() {
                var porjectId = parent.getpojectId();
                var lampname = $("#lampname").val();
                var l_commadr = $("#lampcomaddrlist").val();
                var obj = {};
                obj.type = "ALL";
                if (lampname != "") {
                    obj.name = encodeURI(lampname);
                }
                obj.l_comaddr = l_commadr;
                obj.pid = porjectId;
                var opt = {
                    url: "login.map.sensor.action",
                    silent: true,
                    query: obj
                };
                $("#lamptable").bootstrapTable('refresh', opt);
            }

            //根据条件查询回路selectloop
            function selectloop() {
                var porjectId = parent.getpojectId();
                var loopname = $("#loopname").val();
                var l_commadr = $("#loopcomaddrlist").val();
                var obj = {};
                obj.type = "ALL";
                if (loopname != "") {
                    obj.l_name = encodeURI(loopname);
                }
                obj.l_comaddr = l_commadr;
                obj.pid = porjectId;
                var opt = {
                    url: "login.map.loop.action",
                    silent: true,
                    query: obj
                };
                $("#looptable").bootstrapTable('refresh', opt);
            }
            $(function () {
                size();
                var porjectId = parent.getpojectId();
                combobox("#lampcomaddrlist2", porjectId);
                $("#bzzt").mouseover(function () {
                    $("#up-map-div").show();
                    $("#textdiv2").hide();
                });
                $("#bzzt").mouseout(function () {
                    $("#up-map-div").hide();
                    $("#textdiv2").show();
                });
                var obj2 = {};
                obj2.pid = porjectId;
                $.ajax({async: false, url: "login.map.getAllinfo.action", type: "get", datatype: "JSON", data: obj2,
                    success: function (data) {
                        var arrlist = data.wgrs;   //网关集合
                        var lamplist = data.lamprs;  //灯具集合
                        var looplist = data.looprs;  //回路集合
                        if (arrlist.length > 0) {
                            wglist(arrlist);
                        }
                        if (lamplist.length > 0) {
                            lamplists(lamplist);
                        }
                        if (looplist.length > 0) {
                            Loopbz(looplist);
                        }
                    },
                    error: function () {
                        alert("提交失败！");
                    }
                });
                $('#slide_lamp_val').slider({
                    onChange: function (v1, v2) {
                        $("#val").val(v1);
                    }
                });
                var aaa = $("span[name=xxx]");
                for (var i = 0; i < aaa.length; i++) {
                    var d = aaa[i];
                    var e = $(d).attr("id");
                    $(d).html(lans[e][lang]);
                }
                //加载所有网关信息
                getAllInfo();
                //加载传感器信息
                getAllLampInfo(porjectId);
                //加载回路信息
                getLoopInfo();
                $("#addwanguang").dialog({
                    autoOpen: false,
                    modal: false,
                    width: 650,
                    height: 550,
                    left: 150,
                    top: 50,
                    buttons: {
                        选点绘线: function () {
                            wgDrawing();
                        }, 关闭: function () {
                            $(this).dialog("close");
                        }
                    }
                });

                $("#addlamp").dialog({
                    autoOpen: false,
                    modal: false,
                    width: 720,
                    height: 550,
                    left: 150,
                    top: 50,
                    buttons: {
                        选点绘线: function () {   //选点绘线
                            Drawing();
                        }, 关闭: function () {
                            $(this).dialog("close");
                        }
                    }
                });

                $("#addloop").dialog({
                    autoOpen: false,
                    modal: false,
                    width: 720,
                    height: 550,
                    left: 150,
                    top: 50,
                    buttons: {
                        选点绘线: function () {   //选点绘线
                            loopDrawing();
                        }, 关闭: function () {
                            $(this).dialog("close");
                        }
                    }
                });
                $("#switchCj").dialog({
                    autoOpen: false,
                    modal: false,
                    width: 420,
                    height: 200,
                    position: ["top", "top"],
                    buttons: {
                        关闭: function () {
                            $(this).dialog("close");
                        }
                    }
                });

                $("#ddljtg").dialog({
                    autoOpen: false,
                    modal: false,
                    width: 350,
                    height: 200,
                    position: ["top", "top"],
                    buttons: {
                        关闭: function () {
                            $(this).dialog("close");
                        }
                    }
                });



                var marker; //创建标注对象
                // 创建控件
                var myZoomCtrl = new ZoomControl();
                // 添加到地图当中
                map.addControl(myZoomCtrl);
                var menu = new BMap.ContextMenu();
                for (var i = 0; i < txtMenuItem.length; i++) {
                    menu.addItem(new BMap.MenuItem(txtMenuItem[i].text, txtMenuItem[i].callback, 100));
                }
                map.addContextMenu(menu);
                //鼠标移动事件
                map.addEventListener("mousemove", function (e) {
                    var str = e.point.lng + "," + e.point.lat;
                    $("#showtext").val(str);
                });
                //修改网关经纬度
                function updatelnglat(lng, lat, comaddr) {
                    var porjectId = parent.getpojectId();
                    var obj = {};
                    obj.Longitude = lng;
                    obj.latitude = lat;
                    obj.comaddr = comaddr;
                    $.ajax({url: "login.map.updatelnglat.action", async: false, type: "get", datatype: "JSON", data: obj,
                        success: function (data) {
                            var arrlist = data.rs;
                            if (arrlist.length == 1) {
                                var obj = {};
                                obj.pid = porjectId;
                                //加载所有网关信息
                                var opt = {
                                    //method: "post",
                                    url: "login.map.map.action",
                                    silent: true,
                                    query: obj
                                };
                                $("#wgtable").bootstrapTable('refresh', opt);
                                var now_point = new BMap.Point(lng, lat);
                                marker = new BMap.Marker(now_point); //addMarker(now_point, myIcon, comaddr);
                                var label = new BMap.Label(comaddr, {offset: new BMap.Size(20, 0)}); //创建marker点的标记,这里注意下,因为百度地图可以对label样式做编辑,所以我这里吧重要的id放在了label(然后再隐藏)   
                                label.setStyle({display: "none"}); //对label 样式隐藏    
                                marker.setLabel(label); //把label设置到maker上 
                                marker.enableDragging(); //标注可拖拽
                                map.addOverlay(marker); // 添加标注
                                // 开启事件监听,标注移动事件
                                marker.addEventListener("dragend", function (e) {
                                    var x = e.point.lng; //经度
                                    var y = e.point.lat; //纬度
                                    if (confirm("该设备已有经纬度了，您确定更改吗?")) {  //该设备已有经纬度了，您确定更改吗?
                                        var obj2 = {};
                                        obj2.Longitude = x;
                                        obj2.latitude = y;
                                        obj2.comaddr = e.target.getLabel().content; //获取标注隐藏的值
                                        $.ajax({url: "login.map.updatelnglat.action", async: false, type: "get", datatype: "JSON", data: obj2,
                                            success: function (data) {
                                                var arrlist = data.rs;
                                                if (arrlist.length == 1) {
                                                    var obj = {};
                                                    obj.pid = porjectId;
                                                    //加载所有网关信息
                                                    var opt = {
                                                        //method: "post",
                                                        url: "login.map.map.action",
                                                        silent: true,
                                                        query: obj
                                                    };
                                                    $("#wgtable").bootstrapTable('refresh', opt);

                                                } else {
                                                    alert("修改失败");  //修改失败
                                                }
                                            },
                                            error: function () {
                                                alert("提交添加失败！");
                                            }
                                        });
                                    }

                                });
                            } else {
                                alert("修改失败");  //修改失败
                            }
                        },
                        error: function () {
                            alert("提交添加失败！");
                        }
                    });
                }
                //修改多个传感器的经纬度
                function updateMayLamplnglat(lng, lat, id) {
                    var obj = {};
                    obj.Longitude = lng;
                    obj.latitude = lat;
                    obj.id = id;
                    $.ajax({url: "login.map.updateLamplnglat.action", async: false, type: "get", datatype: "JSON", data: obj,
                        success: function (data) {
                            var arrlist = data.rs;
                        },
                        error: function () {
                            alert("提交添加失败！");
                        }
                    });

                }
                //修改单个传感器经纬度
                function updateLamplnglat(lng, lat, id) {
                    var porjectId = parent.getpojectId();
                    var nobj2 = {};
                    nobj2.name = u_name;
                    var day = getNowFormatDate2();
                    nobj2.time = day;
                    nobj2.type = "修改";
                    nobj2.comment = "修改传感器经纬度";
                    nobj2.page = "地图导航";
                    nobj2.pid = porjectId;
                    $.ajax({async: false, url: "login.oplog.addoplog.action", type: "get", datatype: "JSON", data: nobj2,
                        success: function (data) {
                            var arrlist = data.rs;
                        }
                    });
                    var obj = {};
                    obj.Longitude = lng;
                    obj.latitude = lat;
                    obj.id = id;
                    $.ajax({url: "login.map.updateLamplnglat.action", async: false, type: "get", datatype: "JSON", data: obj,
                        success: function (data) {
                            var arrlist = data.rs;
                            if (arrlist.length == 1) {
                                var obj = {};
                                obj.pid = porjectId;
                                var opt = {
                                    //method: "post",
                                    url: "login.map.lamp.action",
                                    silent: true,
                                    query: obj
                                };
                                //  $("#lamptable").bootstrapTable('refresh', opt);
                                var now_point = new BMap.Point(lng, lat);
                                marker = new BMap.Marker(now_point); //addMarker(now_point, myIcon, comaddr);
                                var label = new BMap.Label(id, {offset: new BMap.Size(20, 0)}); //创建marker点的标记,这里注意下,因为百度地图可以对label样式做编辑,所以我这里吧重要的id放在了label(然后再隐藏)   
                                label.setStyle({display: "none"}); //对label 样式隐藏    
                                marker.setLabel(label); //把label设置到maker上 
                                marker.enableDragging(); //标注可拖拽
                                map.addOverlay(marker); // 添加标注
                                // 开启事件监听,标注移动事件
                                marker.addEventListener("dragend", function (e) {
                                    var x = e.point.lng; //经度
                                    var y = e.point.lat; //纬度
                                    if (confirm("您确定更改该设备经纬度吗?")) {  //该设备已有经纬度了，您确定更改吗?
                                        var obj2 = {};
                                        obj2.Longitude = x;
                                        obj2.latitude = y;
                                        obj2.id = e.target.getLabel().content; //获取标注隐藏的值
                                        $.ajax({url: "login.map.updateLamplnglat.action", async: false, type: "get", datatype: "JSON", data: obj2,
                                            success: function (data) {
                                                var arrlist = data.rs;
                                                if (arrlist.length == 1) {
                                                    alert("修改成功");  //修改成功
                                                } else {
                                                    alert("修改失败");  //修改失败
                                                }
                                            },
                                            error: function () {
                                                alert("提交添加失败！");
                                            }
                                        });
                                    }

                                });
                            } else {
                                alert("修改失败");  //修改失败
                            }
                        },
                        error: function () {
                            alert("提交添加失败！");
                        }
                    });
                }

                //修改单个回路经纬度
                function updateoneLoop(lng, lat, id) {
                    var obj = {};
                    obj.l_longitude = lng;
                    obj.l_latitude = lat;
                    obj.id = id;
                    $.ajax({url: "login.map.updateLooplnglat.action", async: false, type: "get", datatype: "JSON", data: obj,
                        success: function (data) {
                            var arrlist = data.rs;
                            if (arrlist.length == 1) {
                                var now_point = new BMap.Point(lng, lat);
                                marker = new BMap.Marker(now_point); //addMarker(now_point, myIcon, comaddr);
                                var label = new BMap.Label(id, {offset: new BMap.Size(20, 0)}); //创建marker点的标记,这里注意下,因为百度地图可以对label样式做编辑,所以我这里吧重要的id放在了label(然后再隐藏)   
                                label.setStyle({display: "none"}); //对label 样式隐藏    
                                marker.setLabel(label); //把label设置到maker上 
                                marker.enableDragging(); //标注可拖拽
                                map.addOverlay(marker); // 添加标注
                                // 开启事件监听,标注移动事件
                                marker.addEventListener("dragend", function (e) {
                                    var x = e.point.lng; //经度
                                    var y = e.point.lat; //纬度
                                    if (confirm("该设备已有经纬度了，您确定更改吗?")) {  //该设备已有经纬度了，您确定更改吗?
                                        var obj2 = {};
                                        obj2.l_longitude = x;
                                        obj2.l_latitude = y;
                                        obj2.id = e.target.getLabel().content; //获取标注隐藏的值
                                        $.ajax({url: "login.map.updateLooplnglat.action", async: false, type: "get", datatype: "JSON", data: obj2,
                                            success: function (data) {
                                                var arrlist = data.rs;
                                                if (arrlist.length == 1) {
                                                    alert("修改成功");  //修改成功
                                                } else {
                                                    alert("修改失败");  //修改失败
                                                }
                                            },
                                            error: function () {
                                                alert("提交添加失败！");
                                            }
                                        });
                                    }

                                });
                            } else {
                                alert("修改失败");  //修改失败
                            }
                        },
                        error: function () {
                            alert("提交添加失败！");
                        }
                    });
                }
                //修改多个回路经纬度
                function updateMayLoop(lng, lat, id) {
                    var obj = {};
                    obj.l_longitude = lng;
                    obj.l_latitude = lat;
                    obj.id = id;
                    $.ajax({url: "login.map.updateLooplnglat.action", async: false, type: "get", datatype: "JSON", data: obj,
                        success: function (data) {
                            var arrlist = data.rs;
                        },
                        error: function () {
                            alert("提交添加失败！");
                        }
                    });

                }
                //给地图添加点击事件
                var array = [];   //存储排练标注的经纬度数组
                var wgarray = []; //存储排练标注网关的经纬度数组
                map.addEventListener("click", function (e) {
                    var comaddr; //存储选中数据的通信地址
                    var lng; //经度
                    var lat; //纬度
                    //修改单个网关
                    if (wgonedraw) {
                        if (wgchecck.Longitude != null && wgchecck.latitude != null) {
                            if (confirm("该设备已有经纬度了，您确定更改吗?")) {  //该设备已有经纬度了，您确定更改吗?
                                updatelnglat(e.point.lng, e.point.lat, wgchecck.identify);
                                var allOver = map.getOverlays(); //获取全部标注
                                for (var j = 0; j < allOver.length; j++) {
                                    if (allOver[j].toString() == "[object Marker]") {
                                        if (allOver[j].getPosition().lng == lng && allOver[j].getPosition().lat == lat) {
                                            map.removeOverlay(allOver[j]);
                                        }
                                    }
                                }
                            }
                        } else {
                            updatelnglat(e.point.lng, e.point.lat, wgchecck.identify);
                        }
                        wgonedraw = false;
                        wgchecck = [];
                    }

                    //修改多个网关
                    if (wgdraw) {
                        var obj3 = {};
                        obj3.x = e.point.lng;
                        obj3.y = e.point.lat;
                        wgarray.push(obj3);
                        var now_point = new BMap.Point(e.point.lng, e.point.lat);
                        var marker2 = new BMap.Marker(now_point); //addMarker(now_point, myIcon, comaddr);
                        map.addOverlay(marker2); // 添加标注

                        if (wgarray.length > 1) {
                            var polyline = new BMap.Polyline([
                                new BMap.Point(wgarray[wgarray.length - 2].x, wgarray[wgarray.length - 2].y), //起始点的经纬度
                                new BMap.Point(wgarray[wgarray.length - 1].x, wgarray[wgarray.length - 1].y)//终止点的经纬度
                            ], {strokeColor: "red", //设置颜色
                                strokeWeight: 3, //宽度
                                strokeOpacity: 0.5});//透明度
                            map.addOverlay(polyline);

                            if (confirm("你还要继续选点吗？")) {  //你还要继续选点吗？

                            } else {
                                for (var i = 0; i < wgidlist.length; i++) {
                                    updatelnglat(wgarray[i].x, wgarray[i].y, wgidlist[i]);
                                }
                                alert("配置经纬度成功"); //配置经纬度成功
//                                var nobj = {};
//                                nobj.name = u_name;
//                                var day = getNowFormatDate2();
//                                nobj.time = day;
//                                nobj.type = "修改";
//                                nobj.pid = porjectId;
//                                nobj.comment = "批量修改网关的经纬度";
//                                nobj.page = "地图导航";
//                                $.ajax({async: false, url: "login.oplog.addoplog.action", type: "get", datatype: "JSON", data: nobj,
//                                    success: function (data) {
//                                        var arrlist = data.rs;
//                                        if (arrlist.length > 0) {
//
//                                        }
//                                    }
//                                });
                                addlogon(u_name, "修改", o_pid, "电子地图", "批量修改网关的经纬度");
                                //刷新，重置
                                wgarray = [];
                                wgdraw = false;
                                wgidlist = [];
                            }
                        }
                    }

                    //单个传感器修改经纬度
                    if (onedraw) {
                        if (lampchecck.Longitude != null && lampchecck.latitude != null) {
                            if (confirm(lans[288][lang])) {  //该设备已有经纬度了，您确定更改吗?
                                updateLamplnglat(e.point.lng, e.point.lat, lampchecck.id);
                                var allOver = map.getOverlays(); //获取全部标注
                                for (var j = 0; j < allOver.length; j++) {
                                    if (allOver[j].toString() == "[object Marker]") {
                                        if (allOver[j].getPosition().lng == lampchecck.Longitude && allOver[j].getPosition().lat == lampchecck.latitude) {
                                            map.removeOverlay(allOver[j]);
                                        }
                                    }
                                }
                            }
                        } else {
                            updateLamplnglat(e.point.lng, e.point.lat, lampchecck.id);
                        }
                        addlogon(u_name, "修改", o_pid, "电子地图", "修改传感器【" + lampchecck.name + "】的经纬度", lampchecck.s_identify);
                        lampchecck = [];
                        onedraw = false;
                    }
                    //多个传感器
                    if (draw) {
                        var obj3 = {};
                        obj3.x = e.point.lng;
                        obj3.y = e.point.lat;
                        array.push(obj3);
                        var now_point = new BMap.Point(e.point.lng, e.point.lat);
                        var marker2 = new BMap.Marker(now_point); //addMarker(now_point, myIcon, comaddr);
                        map.addOverlay(marker2); // 添加标注

                        if (array.length > 1) {
                            var polyline = new BMap.Polyline([
                                new BMap.Point(array[array.length - 2].x, array[array.length - 2].y), //起始点的经纬度
                                new BMap.Point(array[array.length - 1].x, array[array.length - 1].y)//终止点的经纬度
                            ], {strokeColor: "red", //设置颜色
                                strokeWeight: 3, //宽度
                                strokeOpacity: 0.5});//透明度
                            map.addOverlay(polyline);

                            if (confirm("你还要继续选点吗？")) {  //你还要继续选点吗？

                            } else {
                                for (var i = 0; i < idlist.length; i++) {
                                    //alert("id:" + idlist[i] + "lng:" + array[i].x + "lat:" + array[i].y);
                                    updateMayLamplnglat(array[i].x, array[i].y, idlist[i]);
                                }
                                alert("配置成功"); //配置经纬度成功
                                addlogon(u_name, "修改", o_pid, "电子地图", "修改传感器的经纬度");
                                //刷新，重置
                                array = [];
                                draw = false;
                                idlist = [];
                            }
                        }
                    }

                    //单个回路
                    if (looponedraw) {
                        if (loopobj.l_longitude != null && loopobj.l_latitude != null) {
                            if (confirm("该设备已有经纬度了，您确定更改吗?")) {  //该设备已有经纬度了，您确定更改吗?
                                updateoneLoop(e.point.lng, e.point.lat, loopobj.id);
                                var allOver = map.getOverlays(); //获取全部标注
                                for (var j = 0; j < allOver.length; j++) {
                                    if (allOver[j].toString() == "[object Marker]") {
                                        if (allOver[j].getPosition().lng == loopobj.l_longitude && allOver[j].getPosition().lat == loopobj.l_latitude) {
                                            map.removeOverlay(allOver[j]);
                                        }
                                    }
                                }
                            }
                        } else {

                            updateoneLoop(e.point.lng, e.point.lat, loopobj.id);
                        }
                        addlogon(u_name, "修改", o_pid, "电子地图", "修改回路【" + loopobj.l_name + "】的经纬度", loopobj.l_identify);
                        loopobj = [];
                        looponedraw = false;
                    }
                    //多个回路
                    if (loopdraw) {
                        var obj3 = {};
                        obj3.x = e.point.lng;
                        obj3.y = e.point.lat;
                        array.push(obj3);
                        var now_point = new BMap.Point(e.point.lng, e.point.lat);
                        var marker2 = new BMap.Marker(now_point); //addMarker(now_point, myIcon, comaddr);
                        map.addOverlay(marker2); // 添加标注

                        if (array.length > 1) {
                            var polyline = new BMap.Polyline([
                                new BMap.Point(array[array.length - 2].x, array[array.length - 2].y), //起始点的经纬度
                                new BMap.Point(array[array.length - 1].x, array[array.length - 1].y)//终止点的经纬度
                            ], {strokeColor: "red", //设置颜色
                                strokeWeight: 3, //宽度
                                strokeOpacity: 0.5});//透明度
                            map.addOverlay(polyline);

                            if (confirm("你还要继续选点吗？")) {  //你还要继续选点吗？

                            } else {
                                for (var i = 0; i < looplist.length; i++) {
                                    //alert("id:" + idlist[i] + "lng:" + array[i].x + "lat:" + array[i].y);
                                    updateMayLoop(array[i].x, array[i].y, looplist[i]);
                                }
                                alert("成功");
                                addlogon(u_name, "修改", o_pid, "电子地图", "修改回路【" + loopobj.l_name + "】的经纬度");
                                //刷新，重置
                                array = [];
                                loopdraw = false;
                                looplist = [];
                            }
                        }
                    }
                });
            });
            //网关标注
            function wglist(arrlist) {
                var show = 0;
                for (var i = 0; i < arrlist.length; i++) {
                    (function (x) {
                        var obj = arrlist[i];
                        var Longitude = obj.Longitude;
                        var latitude = obj.latitude;
                        var Iszx = "离线";   //离线    
                        if (obj.online == 1) {
                            Iszx = "在线";   //在线    
                        }
                        if (Longitude != "" && latitude != "") {
                            if (show == 0) {
                                rightshow(obj);
                                show = 1;
                            }
                            var point = new BMap.Point(Longitude, latitude);
                            var marker1;
                            if (obj.online == 1) {
                                marker1 = new BMap.Marker(point, {
                                    icon: wggreenicon
                                });
                            } else {
                                marker1 = new BMap.Marker(point, {
                                    icon: wghuiicon
                                });
                            }
//                            var textvalue = "<div style='line-height:1.8em;font-size:12px;'>\n\
//                                   \n\
//                                    <table style='text-align:center'>\n\
//                                        <tr>\n\
//                                            <td>" + "网关地址" + ":</td>\n\
//                                            <td>" + obj.comaddr.replace(/\b(0+)/gi, "") + "</td>\n\
//                                            <td></td>\n\
//                                            <td>" + "名称" + ":</td>\n\
//                                            <td>" + obj.name + "</td>\n\
//                                        </tr>\n\
//                                        <tr>\n\
//                                            <td>" + "状态" + ":</td>\n\
//                                            <td>" + Iszx + "</td>\n\
//                                             <td>&nbsp&nbsp</td>\n\
//                                        </tr>\n\ \n\
//                                    </table></div>";
//                            var opts = {title: '<span style="font-size:14px;color:#0A8021">' + "网关信息" + '</span>'};//设置信息框、信息说明
//                            var infoWindow = new BMap.InfoWindow(textvalue, opts); // 创建信息窗口对象，引号里可以书写任意的html语句。
//                            marker1.addEventListener("mouseover", function () {
//                                this.openInfoWindow(infoWindow);
//                            });
                            //点击事件
                            marker1.addEventListener("click", function () {
                                rightshow(obj);
                            });
                            marker1.addEventListener("rightclick", function () {
                                //移动、移除
                                var textvalue2 = "<ul style='list-style-type:none;width=100px;' class='items'><li id='kdl'>" + "移动" + "</li><li id='yc'>" + "移除" + "</li></ul>";
                                var opts2 = {title: '<span style="font-size:14px;color:#0A8021">' + "功能操作" + '</span>'};//设置信息框、功能操作
                                var infoWindow2 = new BMap.InfoWindow(textvalue2, opts2); // 创建信息窗口对象，引号里可以书写任意的html语句。
                                this.openInfoWindow(infoWindow2);
                                //移动
                                $("#kdl").click(function () {
                                    // console.log("ok");
                                    layer.confirm("确定要移动该网关吗？", {//确定要移动该网关吗？
                                        btn: ["确定", "取消"] //确定、取消按钮
                                    }, function (index) {
                                        marker1.enableDragging(); //标注可拖拽
                                        marker1.addEventListener("dragend", function (e) {
                                            var x = e.point.lng; //经度
                                            var y = e.point.lat; //纬度
                                            var obj2 = {};
                                            obj2.Longitude = x;
                                            obj2.latitude = y;
                                            obj2.comaddr = obj.identify;
                                            $.ajax({url: "login.map.updatelnglat.action", async: false, type: "get", datatype: "JSON", data: obj2,
                                                success: function (data) {
                                                    var arrlist = data.rs;
                                                    if (arrlist.length == 1) {
                                                        alert("修改成功");  //修改成功
                                                        addlogon(u_name, "修改", o_pid, "电子地图", "移动网关【" + obj.name + "】");
                                                    } else {
                                                        alert("修改失败");  //修改失败
                                                    }
                                                },
                                                error: function () {
                                                    console.log("提交失败");
                                                }
                                            });

                                        });
                                        layer.close(index);
                                        //此处请求后台程序，下方是成功后的前台处理……
                                    });
                                });
                                //移除网关
                                $("#yc").click(function () {
                                    layer.confirm("确定要移除该网关吗?", {//确定要移除该网关吗？
                                        btn: ["确定", "取消"] //确定、取消按钮
                                    }, function (index) {
                                        var allOverlay = map.getOverlays();
                                        for (var i = 0; i < allOverlay.length; i++) {
                                            if (allOverlay[i].toString() == "[object Marker]") {
                                                console.log(allOverlay[i].getPosition().lng,allOverlay[i].getPosition().lng);
                                                console.log(obj.Longitude,obj.Longitude);
                                                if (allOverlay[i].getPosition().lng == obj.Longitude && allOverlay[i].getPosition().lng == obj.Longitude) {
                                                    map.removeOverlay(allOverlay[i]);
                                                    var obj3 = {};
                                                    obj3.Longitude = "";
                                                    obj3.latitude = "";
                                                    obj3.comaddr = obj.identify;
                                                    $.ajax({url: "login.map.updatelnglat.action", async: false, type: "get", datatype: "JSON", data: obj3,
                                                        success: function (data) {
                                                            var arrlist = data.rs;
                                                            if (arrlist.length == 1) {
                                                                alert("移除成功!");  //移除成功
                                                                addlogon(u_name, "移除", o_pid, "电子地图", "网关【" + obj.name + "】");
                                                            } else {
                                                                alert("移除失败");  //移除失败
                                                            }
                                                        },
                                                        error: function () {
                                                            console.log("提交失败");
                                                        }
                                                    });
                                                }
                                            }
                                        }
                                        layer.close(index);
                                    });
                                });

                            });
                            marker1.setTitle(obj.name);   //这里设置maker的title (鼠标放到marker点上,会出现它的title,所以我这里把name,放到title里)
                            map.addOverlay(marker1);
                            map.panTo(point);
                        }
                    })(i);

                }
            }

            //传感器标注
            function lamplists(arrlist) {
                for (var i = 0; i < arrlist.length; i++) {
                    (function (x) {
                        var obj = arrlist[i];
                        var Longitude = obj.longitude;
                        var latitude = obj.latitude;
//                        var time1 = obj.onlinetime.substring(0, 16);
//                        var time2 = obj.dtime.substring(0, 16);
//                        var stime = TimeDifference(time1, time2);
                        var lx = "离线";
                        var isLx = 0;  //判断是否在线
                        var gobj = {};
                        gobj.identify = obj.s_identify; //selects[0];
                        $.ajax({url: "login.gateway.comaddrzx.action", async: false, type: "get", datatype: "JSON", data: gobj,
                            success: function (data) {
                                var arrlist = data.rs;
                                if (arrlist[0].online == 1) {
                                    lx = "在线";
                                    isLx = 1;
                                } else {
                                    lx = "离线";
                                }
                            },
                            error: function () {
                                alert("提交添加失败！请刷新");
                            }
                        });
                        //var isred = 0; //判断是否为故障 0非故障
//                        var sobj = {};
//                        sobj.f_comaddr = obj.l_comaddr;
//                        sobj.f_setcode = obj.infonum;
//                        $.ajax({url: "homePage.sensormanage.IssensroRed.action", async: false, type: "get", datatype: "JSON", data: sobj,
//                            success: function (data) {
//                                var arrlist = data.rs;
//                                if (arrlist.length > 0) {
//                                    isred = 1;
//                                    lx = "故障";
//                                }
//                            },
//                            error: function () {
//                                console.log("提交添加失败！请刷新");
//                                // alert("提交添加失败！请刷新");
//                            }
//                        });

                        //var lampcode = parseInt(arrlist[i].l_factorycode);

//                        var textvalue = "<div style='line-height:1.8em;font-size:12px;'>\n\
//                                   \n\
//                                    <table style='text-align:center'>\n\
//                                        <tr>\n\
//                                            <td>" + "名称" + ":</td>\n\
//                                            <td>" + obj.name + "</td>\n\
//                                            <td>&nbsp;&nbsp;</td>\n\
//                                            <td>" + "所属网关" + ":</td>\n\
//                                            <td>" + obj.l_comaddr.replace(/\b(0+)/gi, "") + "</td>\n\
//                                        </tr>\n\
//                                        <tr>\n\
//                                            <td>" + "型号" + ":</td>\n\
//                                            <td>" + obj.model + "</td>\n\
//                                            <td>&nbsp;&nbsp;</td>\n\
//                                            <td>" + "类型" + ":</td>\n\
//                                            <td>" + type + "</td>\n\
//                                        </tr>\n\
//                                         <tr>\n\
//                                            <td>" + "数值" + ":</td>\n\
//                                            <td>" + numvalue + "</td>\n\
//                                            <td>&nbsp;&nbsp;</td>\n\
//                                            <td>" + "状态" + ":</td>\n\
//                                            <td>" + lx + "</td>\n\
//                                        </tr>\n\
//                                    </table></div>";
                        if ((Longitude != "" && latitude != "") && (Longitude != null && latitude != null)) {
                            var point = new BMap.Point(Longitude, latitude);
                            var marker1;
                            if (obj.errflag == 1) {
                                lx = "故障";
                                marker1 = new BMap.Marker(point, {
                                    icon: lred
                                });
                            } else if (isLx == 1) {
                                marker1 = new BMap.Marker(point, {
                                    icon: lgreen
                                });
                            } else {
                                marker1 = new BMap.Marker(point, {
                                    icon: lhui
                                });
                            }
                            marker1.setTitle(obj.name);   //这里设置maker的title (鼠标放到marker点上,会出现它的title,所以我这里把name,放到title里)
                            //标注点点击事件
                            marker1.addEventListener("click", function () {
                                obj.lx = lx;
                                senrightshow(obj);
                            });
                            //标注点右击事件
                            marker1.addEventListener("rightclick", function () {
                                //开灯、关灯、调光值、请输入调光值、调光
                                var textvalue2 = "<ul class='items' style='list-style-type:none;'>\n\
                                                                <li id='move'>" + "移动" + "</li>\n\
                                                                <li id='clean'>" + "清除" + "</li>\n\
                                                                </ul>";
                                var opts2 = {title: '<span style="font-size:14px;color:#0A8021">' + "功能操作" + '</span>'};//设置信息框、功能操作
                                var infoWindow2 = new BMap.InfoWindow(textvalue2, opts2); // 创建信息窗口对象，引号里可以书写任意的html语句。
                                this.openInfoWindow(infoWindow2);

                                //移动
                                $("#move").click(function () {
                                    marker1.closeInfoWindow(infoWindow2);
                                    layer.confirm("确认要移动该传感器吗？", {//确认要移动该灯具吗？
                                        btn: ["确定", "取消"] //确定、取消按钮
                                    }, function (index) {
                                        marker1.enableDragging(); //标注可拖拽
                                        marker1.addEventListener("dragend", function (e) {
                                            var x = e.point.lng; //经度
                                            var y = e.point.lat; //纬度
                                            var obj2 = {};
                                            obj2.Longitude = x;
                                            obj2.latitude = y;
                                            obj2.id = obj.id; //获取标注隐藏的值
                                            $.ajax({url: "login.map.updateLamplnglat.action", async: false, type: "get", datatype: "JSON", data: obj2,
                                                success: function (data) {
                                                    var arrlist = data.rs;
                                                    if (arrlist.length == 1) {
                                                        alert("修改成功");  //修改成功
                                                        addlogon(u_name, "移动", o_pid, "电子地图", "移动传感器【" + obj.name + "】", obj.s_identify);
                                                    } else {
                                                        alert("修改失败");  //修改失败
                                                    }
                                                },
                                                error: function () {
                                                    console.log("提交失败");
                                                }
                                            });

                                        });
                                        layer.close(index);
                                        //此处请求后台程序，下方是成功后的前台处理……
                                    });
                                });
                                //移除传感器
                                $("#clean").click(function () {
                                    marker1.closeInfoWindow(infoWindow2);
                                    layer.confirm("确认要移除该传感器吗？", {//确认要移动该灯具吗？
                                        btn: ["确定", "取消"] //确定、取消按钮
                                    }, function (index) {
                                        var allOverlay = map.getOverlays();
                                        for (var i = 0; i < allOverlay.length; i++) {
                                            if (allOverlay[i].toString() == "[object Marker]") {
                                                if (allOverlay[i].getPosition().lng == obj.longitude && allOverlay[i].getPosition().lat == obj.latitude) {
                                                    map.removeOverlay(allOverlay[i]);
                                                    var obj3 = {};
                                                    obj3.Longitude = "";
                                                    obj3.latitude = "";
                                                    obj3.id = obj.id; //获取标注隐藏的值
                                                    $.ajax({url: "login.map.updateLamplnglat.action", async: false, type: "get", datatype: "JSON", data: obj3,
                                                        success: function (data) {
                                                            var arrlist = data.rs;
                                                            if (arrlist.length == 1) {
                                                                alert("移除成功");  //移除成功
                                                                addlogon(u_name, "移除", o_pid, "电子地图", "移除传感器【" + obj.name + "】", obj.s_identify);
                                                            } else {
                                                                alert("移除失败");  //移除失败
                                                            }
                                                        },
                                                        error: function () {
                                                            console.log("提交失败");
                                                        }
                                                    });
                                                }
                                            }
                                        }
                                        layer.close(index);
                                    });
                                });

                            });
                            map.addOverlay(marker1);
                            map.panTo(point);
                        }
                    })(i);
                }
            }

            //回路标注
            function Loopbz(arrlist) {
                for (var i = 0; i < arrlist.length; i++) {
                    (function (x) {
                        var obj = arrlist[i];
                        var Longitude = obj.l_longitude;
                        var latitude = obj.l_latitude;
//                        var textvalue = "<div style='line-height:1.8em;font-size:12px;'>\n\
//                                   \n\
//                                    <table style='text-align:center'>\n\
//                                        <tr>\n\
//                                            <td>" + "名称" + ":</td>\n\
//                                            <td>" + obj.l_name + "</td>\n\
//                                            <td>&nbsp;&nbsp;</td>\n\
//                                            <td>" + "所属网关" + ":</td>\n\
//                                            <td>" + obj.l_comaddr.replace(/\b(0+)/gi, "") + "</td>\n\
//                                        </tr>\n\
//                                    </table></div>";
                        if ((Longitude != "" && latitude != "") && (Longitude != null && latitude != null)) {
                            var point = new BMap.Point(Longitude, latitude);
                            var marker1;

                            if (obj.l_switch == 1) {
                                marker1 = new BMap.Marker(point, {
                                    icon: hlbh
                                });
                            } else {
                                marker1 = new BMap.Marker(point, {
                                    icon: hldk
                                });
                            }
                            marker1.setTitle(obj.l_name);   //这里设置maker的title (鼠标放到marker点上,会出现它的title,所以我这里把name,放到title里)
                            //标注点点击事件
                            marker1.addEventListener("click", function () {
                                looprightshow(obj);
                            });
                            //标注右击事件
                            marker1.addEventListener("rightclick", function () {
                                var textvalue2 = "<ul class='items' style='list-style-type:none;'>\n\
                                                                <li id='break'>" + "断开" + "</li>\n\
                                                                <li id='close'>" + "闭合" + "</li>\n\
                                                                <li id='lmove'>" + "移动" + "</li>\n\
                                                                <li id='lclean'>" + "清除" + "</li>\n\
                                                                </ul>";
                                var opts2 = {title: '<span style="font-size:14px;color:#0A8021">' + "功能操作" + '</span>'};//设置信息框、功能操作
                                var infoWindow2 = new BMap.InfoWindow(textvalue2, opts2); // 创建信息窗口对象，引号里可以书写任意的html语句。
                                this.openInfoWindow(infoWindow2);
                                var comaddr;
                                $.ajax({async: false, url: "homePage.gayway.getcomaddrbyidentify.action", type: "post", datatype: "JSON", data: {identify: obj.l_identify},
                                    success: function (data) {
                                        var rs = data.rs;
                                        if (rs.length > 0) {
                                            comaddr = rs[0].comaddr;
                                        }
                                    },
                                    error: function () {
                                        alert("提交失败！");
                                    }
                                });

                                //断开
                                $("#break").click(function () {
                                    var ele = obj;
                                    addlogon(u_name, "设置", o_pid, "电子地图", "断开回路【" + ele.l_name + "】", obj.l_identify);
                                    var o = {};
                                    o.l_comaddr = ele.l_comaddr;
                                    console.log(ele);
                                    var vv = [];
                                    vv.push(1);
                                    vv.push(0x10);               //头指令 
                                    var info = parseInt(ele.l_info);
                                    console.log(info);
                                    var infonum = (3000 + info * 20 + 3) | 0x1000;
                                    vv.push(infonum >> 8 & 0xff); //起始地址
                                    vv.push(infonum & 0xff);

                                    vv.push(0);           //寄存器数目 2字节  
                                    vv.push(2);   //5
                                    vv.push(4);           //字节数目长度  1字节 10




                                    var worktype = parseInt(ele.l_worktype);
                                    worktype = worktype & 0xfe;
                                    vv.push(worktype >> 8 & 0xff)   //工作模式
                                    vv.push(worktype & 0xff);



                                    var val2 = parseInt(0);
                                    vv.push(val2 >> 8 & 0xff);   //控制值
                                    vv.push(val2 & 0xff);

                                    var data = buicode2(vv);
                                    console.log(data);
                                    dealsend2("10", data, "switchloopCB", comaddr, 0, ele.id, info, "${param.action}");
                                    $('#panemask').showLoading({
                                        'afterShow': function () {
                                            setTimeout("$('#panemask').hideLoading()", 10000);
                                        }
                                    }
                                    );
                                });

                                //闭合
                                $("#close").click(function () {
                                    var ele = obj;
                                    addlogon(u_name, "设置", o_pid, "电子地图", "闭合回路【" + ele.l_name + "】", obj.l_identify);
                                    var o = {};
                                    o.l_comaddr = ele.l_comaddr;
                                    console.log(ele);
                                    var vv = [];
                                    vv.push(1);
                                    vv.push(0x10);               //头指令 
                                    var info = parseInt(ele.l_info);
                                    console.log(info);
                                    var infonum = (3000 + info * 20 + 3) | 0x1000;
                                    vv.push(infonum >> 8 & 0xff); //起始地址
                                    vv.push(infonum & 0xff);

                                    vv.push(0);           //寄存器数目 2字节  
                                    vv.push(2);   //5
                                    vv.push(4);           //字节数目长度  1字节 10




                                    var worktype = parseInt(ele.l_worktype);
                                    worktype = worktype & 0xfe;
                                    vv.push(worktype >> 8 & 0xff)   //工作模式
                                    vv.push(worktype & 0xff);



                                    var val2 = parseInt(0);
                                    vv.push(val2 >> 8 & 0xff);   //控制值
                                    vv.push(val2 & 0xff);

                                    var data = buicode2(vv);
                                    console.log(data);
                                    dealsend2("10", data, "switchloopCB", comaddr, 1, ele.id, info, "${param.action}");
                                    $('#panemask').showLoading({
                                        'afterShow': function () {
                                            setTimeout("$('#panemask').hideLoading()", 10000);
                                        }
                                    }
                                    );
                                });


                                //移动
                                $("#lmove").click(function () {
                                    marker1.closeInfoWindow(infoWindow2);
                                    layer.confirm("确认要移动该回路吗？", {//确认要移动该灯具吗？
                                        btn: ["确定", "取消"] //确定、取消按钮
                                    }, function (index) {
                                        marker1.enableDragging(); //标注可拖拽
                                        marker1.addEventListener("dragend", function (e) {
                                            var x = e.point.lng; //经度
                                            var y = e.point.lat; //纬度
                                            var obj2 = {};
                                            obj2.l_longitude = x;
                                            obj2.l_latitude = y;
                                            obj2.id = obj.id; //获取标注隐藏的值
                                            $.ajax({url: "login.map.updateLooplnglat.action", async: false, type: "get", datatype: "JSON", data: obj2,
                                                success: function (data) {
                                                    var arrlist = data.rs;
                                                    if (arrlist.length == 1) {
                                                        alert("修改成功");  //修改成功
                                                        addlogon(u_name, "移动", o_pid, "电子地图", "移动回路【" + obj.l_name + "】", obj.l_identify);
                                                    } else {
                                                        alert("修改失败");  //修改失败
                                                    }
                                                },
                                                error: function () {
                                                    console.log("提交失败");
                                                }
                                            });

                                        });
                                        layer.close(index);
                                        //此处请求后台程序，下方是成功后的前台处理……
                                    });
                                });
                                //移除回路
                                $("#lclean").click(function () {
                                    marker1.closeInfoWindow(infoWindow2);
                                    layer.confirm("确认要移除该回路吗？", {//确认要移动该灯具吗？
                                        btn: ["确定", "取消"] //确定、取消按钮
                                    }, function (index) {
                                        var allOverlay = map.getOverlays();
                                        for (var i = 0; i < allOverlay.length; i++) {
                                            if (allOverlay[i].toString() == "[object Marker]") {
                                                if (allOverlay[i].getPosition().lng == obj.l_longitude && allOverlay[i].getPosition().lat == obj.l_latitude) {
                                                    map.removeOverlay(allOverlay[i]);
                                                    var obj3 = {};
                                                    obj3.l_longitude = "";
                                                    obj3.l_latitude = "";
                                                    obj3.id = obj.id; //获取标注隐藏的值
                                                    $.ajax({url: "login.map.updateLooplnglat.action", async: false, type: "get", datatype: "JSON", data: obj3,
                                                        success: function (data) {
                                                            var arrlist = data.rs;
                                                            if (arrlist.length == 1) {
                                                                alert("移除成功");  //移除成功
                                                                addlogon(u_name, "移除", o_pid, "电子地图", "移除回路【" + obj.l_name + "】", obj.l_identify);
                                                            } else {
                                                                alert("移除失败");  //移除失败
                                                            }
                                                        },
                                                        error: function () {
                                                            console.log("提交失败");
                                                        }
                                                    });
                                                }
                                            }
                                        }
                                        layer.close(index);
                                    });
                                });

                            });
                            map.addOverlay(marker1);
                            map.panTo(point);
                        }
                    })(i);
                }
            }


            //回路设置回调函数
            function switchloopCB(obj) {
                $('#panemask').hideLoading();
                if (obj.status == "success") {
                    var data = Str2BytesH(obj.data);
                    var v = "";
                    for (var i = 0; i < data.length; i++) {
                        v = v + sprintf("%02x", data[i]) + " ";
                    }
                    console.log(v);
                    if (data[1] == 0x10) {
                        var infonum = (3000 + obj.val * 20 + 3) | 0x1000;
                        var high = infonum >> 8 & 0xff;
                        var low = infonum & 0xff;
                        if (data[2] == high && data[3] == low) {
                            var str = obj.type == 0 ? "断开成功" : "闭合成功";
                            var param = {id: obj.param, l_switch: obj.type};
                            $.ajax({async: false, url: "loop.loopForm.modifySwitch.action", type: "get", datatype: "JSON", data: param,
                                success: function (data) {
                                    var arrlist = data.rs;
                                    if (arrlist.length == 1) {
                                        layerAler(str);

                                    }
                                },
                                error: function () {
                                    alert("提交失败！");
                                }
                            });
                        }

                    }

                }

            }

            //网关下拉框
            function combobox(id, pid) {
                $(id).combobox({
                    url: "homePage.gayway.getComaddr.action?pid=" + pid
//                    onLoadSuccess: function (data) {
//                        $(this).combobox("select", data[0].id);
//                        $(this).val(data[0].text);
//                    }
                });
            }

            //网关标注点点击事件
            function  rightshow(obj) {
                $("#textdiv2").html("");
                var h4 = document.createElement("h4");
                h4.innerHTML = obj.name;
                $("#textdiv2").append(h4);
                var obj1 = {};
                obj1.s_identify = obj.identify;
                $.ajax({url: "homePage.sensormanage.getsensorBycomaddr.action", async: false, type: "get", datatype: "JSON", data: obj1,
                    success: function (data) {
                        var arrlist = data.rs;
                        if (arrlist.length > 0) {
                            for (var i = 0; i < arrlist.length; i++) {
                                // div11.innerHTML = "状态";
                                var sensor = arrlist[i];
                                var p = document.createElement("p");
                                var span1 = document.createElement("span");
                                var span2 = document.createElement("span");
                                var name = sensor.name;
                                var val = "";
                                console.log(sensor);
                                if (sensor.type == "1") {
                                    var num;
                                    if (sensor.numvalue > 0) {
                                        num = sensor.numvalue / 10;
                                    } else {
                                        num = 0;
                                    }
                                    val = num.toString() + "℃";
                                } else if (sensor.type == "2") {
                                    var num;
                                    if (sensor.numvalue > 0) {
                                        num = sensor.numvalue / 10;
                                    } else {
                                        num = 0;
                                    }
                                    val = num.toString() + "%RH";
                                } else if (sensor.type == "3") {
                                    if (sensor.numvalue == "1") {
                                        val = "闭合";
                                    } else {
                                        val = "断开";
                                    }
                                } else if (sensor.type == "4") {
                                    var num;
                                    if (sensor.numvalue > 0) {
                                        num = sensor.numvalue / 10;
                                    } else {
                                        num = 0;
                                    }
                                    val = num + "m/s";
                                } else if (sensor.type == "5") {
                                    val = getDirection(sensor.numvalue);
                                } else if (sensor.type == "6") {
                                    var num;
                                    if (sensor.numvalue > 0) {
                                        num = sensor.numvalue / 10;
                                    } else {
                                        num = 0;
                                    }
                                    val = num.toString() + "    lux";
                                }
                                span1.innerHTML = name + ":&nbsp ";
                                span2.innerHTML = val;
                                span2.setAttribute("style", "color: green;");
                                p.appendChild(span1);
                                p.appendChild(span2);
                                // p.innerHTML = name + ":      " + val;
                                $("#textdiv2").append(p);
                            }
                        }
                    },
                    error: function () {
                        alert("提交添加失败！请刷新");
                    }
                });
            }
            //传感器点击事件
            function senrightshow(obj) {
                $.ajax({url: "homePage.sensormanage.getsensorById.action", async: false, type: "get", datatype: "JSON", data: {id: obj.id},
                    success: function (data) {
                        var arrlist = data.rs;
                        if (arrlist.length > 0) {
                            var sensor = arrlist[0];
                            $("#textdiv2").html("");
                            var h4 = document.createElement("h4");
                            h4.innerHTML = "传感器信息";
                            $("#textdiv2").append(h4);
                            var p = document.createElement("p");
                            var p1 = document.createElement("p");
                            var p2 = document.createElement("p");
                            var p3 = document.createElement("p");
                            var p4 = document.createElement("p");
                            var type = "";
                            var numvalue = "";
                            if (sensor.type == 1) {
                                type = "温度";
                                if (sensor.numvalue > 0) {
                                    numvalue = sensor.numvalue / 10 + "℃";
                                } else {
                                    numvalue = sensor.numvalue + "℃";
                                }
                            } else if (sensor.type == 2) {
                                type = "湿度";
                                if (sensor.numvalue > 0) {
                                    numvalue = sensor.numvalue / 10 + "%RH";
                                } else {
                                    numvalue = sensor.numvalue + "%RH";
                                }
                            } else if (sensor.type == 3) {
                                type = "开关";
                                if (sensor.numvalue != null && sensor.numvalue != 0) {
                                    numvalue = "开";
                                } else {
                                    numvalue = "关";
                                }
                            } else if (sensor.type == 4) {
                                type = "风速";
                                if (sensor.numvalue > 0) {
                                    numvalue = sensor.numvalue / 10 + "m/s";
                                } else {
                                    numvalue = 0 + "m/s";
                                }
                            } else if (sensor.type == 5) {
                                type = "风向";
                                numvalue = getDirection(sensor.numvalue);

                            } else if (sensor.type == 6) {
                                type = "照度";
                                if (sensor.numvalue > 0) {
                                    numvalue = sensor.numvalue / 10 + "lux";
                                } else {
                                    numvalue = sensor.numvalue + "lux";
                                }
                            }
                            var wgname;
                            $.ajax({url: "homePage.gayway.getnamebycode.action", async: false, type: "get", datatype: "JSON", data: {comaddr: obj.s_identify},
                                success: function (data) {
                                    var gay = data.rs;
                                    if (gay.length > 0) {
                                        wgname = gay[0].name;
                                    }
                                }});
                            var span1 = document.createElement("span");
                            var span11 = document.createElement("span");
                            var span2 = document.createElement("span");
                            var span22 = document.createElement("span");
                            var span3 = document.createElement("span");
                            var span33 = document.createElement("span");
                            var span4 = document.createElement("span");
                            var span44 = document.createElement("span");
                            var span5 = document.createElement("span");
                            var span55 = document.createElement("span");
                            span1.innerHTML = "名称" + "：&nbsp";
                            span2.innerHTML = "所属网关" + "：&nbsp";
                            span3.innerHTML = "类型" + "：&nbsp";
                            span4.innerHTML = "数值" + "：&nbsp";
                            span5.innerHTML = "状态" + "：&nbsp";
                            span11.innerHTML = sensor.name;
                            span22.innerHTML = wgname;
                            span33.innerHTML = type;
                            span44.innerHTML = numvalue;
                            span55.innerHTML = obj.lx;
                            span11.setAttribute("style", "color: green;");
                            span22.setAttribute("style", "color: green;");
                            span33.setAttribute("style", "color: green;");
                            span44.setAttribute("style", "color: green;");
                            span55.setAttribute("style", "color: green;");

                            p.appendChild(span1);
                            p.appendChild(span11);
                            
                            p1.appendChild(span2);
                            p1.appendChild(span22);
                            
                            p2.appendChild(span3);
                            p2.appendChild(span33);
                            
                            p3.appendChild(span4);
                            p3.appendChild(span44);
                            
                            p4.appendChild(span5);
                            p4.appendChild(span55);
//                            p.innerHTML = "名称" + "：      " + sensor.name;
//                            p1.innerHTML = "所属网关" + "：      " + wgname;
//                            p2.innerHTML = "类型" + "：      " + type;
//                            p3.innerHTML = "数值" + "：      " + numvalue;
//                            p4.innerHTML = "状态" + "：      " + obj.lx;
                            $("#textdiv2").append(p);
                            $("#textdiv2").append(p1);
                            $("#textdiv2").append(p2);
                            $("#textdiv2").append(p3);
                            $("#textdiv2").append(p4);
                        }

                    },
                    error: function () {
                        alert("提交添加失败！请刷新");
                    }
                });



            }

            //计算风向
            function getDirection(val)
            {
                var str = "";
                switch (val) {
                    case  0:
                        str = "北";
                        break;
                    case 45:
                        str = "东北";
                        break;
                    case 90:
                        str = "东";
                        break;
                    case 135:
                        str = "东南";
                        break;
                    case 180:
                        str = "南";
                        break;
                    case 225:
                        str = "西南";
                        break;
                    case 270:
                        str = "西";
                        break;
                    case 315:
                        str = "西北";
                        break;
                        defaul:
                                break;
                }

                if (str == "") {
                    if (val > 0 && val < 45) {
                        str = "东北偏北";
                    } else if (val > 45 && val < 90) {
                        str = "东北偏东";
                    } else if (val > 90 && val < 135) {
                        str = "东南偏东";
                    } else if (val > 135 && val < 180) {
                        str = "东南偏南";
                    } else if (val > 180 && val < 225) {
                        str = "西南偏南";
                    } else if (val > 225 && val < 270) {
                        str = "西南偏西";
                    } else if (val > 270 && val < 315) {
                        str = "西北偏西";
                    } else if (val > 315 && val < 360) {
                        str = "西北偏北";
                    }

                }

                return  str;
            }

            //回路标注点击事件
            function  looprightshow(obj) {
                $.ajax({url: "homePage.loop.getloopById.action", async: false, type: "get", datatype: "JSON", data: {id: obj.id},
                    success: function (data) {
                        var arrlist = data.rs;
                        if (arrlist.length > 0) {
                            var loop = arrlist[0];
                            $("#textdiv2").html("");
                            var h4 = document.createElement("h4");
                            var plandiv = document.createElement("div");
                            //plandiv.html("");
                            h4.innerHTML = "回路信息";
                            $("#textdiv2").append(h4);
                            var type = parseInt(loop.l_worktype);
                            var l_switch = "";   //状态
                            var plan = "";     //工作方案
                            var str = "";     //工作方式
                            var infolist = {};
                            var infoscene = {};
                            var obj2 = {};
                            obj2.identify = obj.l_identify;
                            obj2.pid = o_pid;
                            $.ajax({async: false, url: "sensor.sensorform.getInfoNumList2.action", type: "get", datatype: "JSON", data: obj2,
                                success: function (data) {
                                    for (var i = 0; i < data.length; i++) {
                                        var o = data[i];
                                        infolist[o.id] = o.text;
                                    }
                                },
                                error: function () {
                                    alert("提交失败！");
                                }
                            });


                            $.ajax({async: false, url: "plan.planForm.getAllScennumName.action", type: "get", datatype: "JSON", data: obj2,
                                success: function (data) {
                                    for (var i = 0; i < data.length; i++) {
                                        var o = data[i];
                                        infoscene[o.id] = o.text;
                                    }
                                },
                                error: function () {
                                    alert("提交失败！");
                                }
                            });
                            if (type >> 1 & 0x1 == 1) {
                                str = "时间";
                            } else if (type >> 2 & 0x1 == 1) {
                                str = '场景';
                            } else if (type >> 3 & 0x1 == 1) {
                                str = '信息点';
                            }
                            if (loop.l_switch == "1") {
                                l_switch = "闭合";
                            } else {
                                l_switch = "断开";
                            }

                            if (type >> 1 & 0x1 == 1) {
                                for (var i = 0; i < 5; i++) {
                                    var index = "l_val" + (i + 1).toString();
                                    var strobj = loop[index];
                                    if (isJSON(strobj)) {
                                        var obj1 = eval('(' + strobj + ')');
                                        var s1 = obj1.value == 1 ? "闭合" : "断开";
                                        // plan = plan + obj1.time + ":" + s1 + "&emsp;";
                                        var pl = document.createElement("p");
                                        pl.innerHTML = obj1.time + ":" + s1 + "&emsp;";
                                        plandiv.append(pl);
                                    }

                                }

                            } else if (type >> 2 & 0x1 == 1) {
                                // plan = "";
                                for (var i = 0; i < 5; i++) {
                                    var index = "l_val" + (i + 1).toString();
                                    var strobj = loop[index];
                                    if (isJSON(strobj)) {
                                        var obj1 = eval('(' + strobj + ')');
                                        var scenename = infoscene[obj1.scene.toString()];
                                        var s1 = obj1.value == 1 ? "闭合" : "断开";
                                        // plan = plan + scenename + ":" + s1 + "&emsp;";
                                        var pl = document.createElement("p");
                                        pl.innerHTML = scenename + ":" + s1 + "&emsp;";
                                        plandiv.append(pl);
                                    }
                                }

                            } else if (type >> 3 & 0x1 == 1) {

                                plan = "";
                                for (var i = 0; i < 5; i++) {
                                    var index = "l_val" + (i + 1).toString();
                                    var strobj = loop[index];
                                    if (isJSON(strobj)) {
                                        var obj1 = eval('(' + strobj + ')');
                                        if (i == 0) {
                                            //plan = plan + infolist[obj1.infonum.toString()] + "&emsp;偏差值:" + obj1.offset + "&emsp;";
                                            var pl = document.createElement("p");
                                            pl.innerHTML = infolist[obj1.infonum.toString()] + "&emsp;偏差值:" + obj1.offset + "&emsp;";
                                            plandiv.append(pl);
                                        } else
                                        {
                                            var s1 = obj1.value == 1 ? "闭合" : "断开";
                                            //plan = plan + obj1.info + ":" + s1 + "&emsp;";
                                            var pl = document.createElement("p");
                                            pl.innerHTML = obj1.info + ":" + s1 + "&emsp;";
                                            plandiv.append(pl);
                                        }

                                    }
                                }
                            }

                            var wgname;
                            $.ajax({url: "homePage.gayway.getnamebycode.action", async: false, type: "get", datatype: "JSON", data: {comaddr: loop.l_identify},
                                success: function (data) {
                                    var gay = data.rs;
                                    if (gay.length > 0) {
                                        wgname = gay[0].name;
                                    }
                                }});
                            var p = document.createElement("p");
                            var p1 = document.createElement("p");
                            var p2 = document.createElement("p");
                            var p3 = document.createElement("p");
                            var p4 = document.createElement("p");
                             var span1 = document.createElement("span");
                            var span11 = document.createElement("span");
                            var span2 = document.createElement("span");
                            var span22 = document.createElement("span");
                            var span3 = document.createElement("span");
                            var span33 = document.createElement("span");
                            var span4 = document.createElement("span");
                            var span44 = document.createElement("span");
                            //var span5 = document.createElement("span");
                            //var span55 = document.createElement("span");
                            span1.innerHTML = "名称" + "：      ";
                            span2.innerHTML = "所属网关" + "：      ";
                            span3.innerHTML = "工作模式" + "：      ";
                            span4.innerHTML = "状态" + "：      ";
                           
                            span11.innerHTML = loop.l_name;
                            span22.innerHTML = wgname;
                            span33.innerHTML = str;
                            span44.innerHTML = l_switch;
                            //span55.innerHTML = obj.lx;
                            span11.setAttribute("style", "color: green;");
                            span22.setAttribute("style", "color: green;");
                            span33.setAttribute("style", "color: green;");
                            span44.setAttribute("style", "color: green;");
                           // span55.setAttribute("style", "color: green;");

                            p.appendChild(span1);
                            p.appendChild(span11);
                            
                            p1.appendChild(span2);
                            p1.appendChild(span22);
                            
                            p2.appendChild(span3);
                            p2.appendChild(span33);
                            
                            p3.appendChild(span4);
                            p3.appendChild(span44);
                            
                           
//                            p.innerHTML = "名称" + "：      " + loop.l_name;
//                            p1.innerHTML = "所属网关" + "：      " + wgname;
//                            p2.innerHTML = "工作模式" + "：      " + str;
//                            p3.innerHTML = "状态" + "：      " + l_switch;
                           p4.innerHTML = "工作方案" + "：      ";
                            $("#textdiv2").append(p);
                            $("#textdiv2").append(p1);
                            $("#textdiv2").append(p2);
                            $("#textdiv2").append(p3);
                            $("#textdiv2").append(p4);
                            $("#textdiv2").append(plandiv);
                        }

                    },
                    error: function () {
                        alert("提交添加失败！请刷新");
                    }
                });
            }
        </script>
    </body>
</html>
