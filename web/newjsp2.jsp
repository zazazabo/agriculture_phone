<%-- 
    Document   : newjsp1
    Created on : 2018-8-6, 18:19:59
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include  file="js.jspf" %>



        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="renderer" content="webkit|ie-comp|ie-stand">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
        <title>JSP Page</title>
        <script type="text/javascript" src="js/genel.js"></script>
        <script src="echarts/dist/echarts_3.8.5_echarts.min.js"></script>
        <script src="js/chart/chart.js"></script>
        <link rel="stylesheet" type="text/css" href="bootstrap-datetimepicker/bootstrap-datetimepicker.css">
        <script src="bootstrap-datetimepicker/bootstrap-datetimepicker.js"></script>
        <link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.css" type="text/css">
        <style type="text/css">
            .topCenter1 {

                margin-left: 3%;
                margin-top: 20px;
            }
            html {
                height: 100%;
                width: 100%;
                display: table;
            }

            body {
                display: table-cell;
                height: 100%;
                width: 100%;

            }

            /*            手机*/
            @media screen and (min-width:0px) and (max-width:666px) {  
                #l_comaddr2{
                    width: 120px;
                }
                #sensorlist{
                    width: 120px;
                }
                #selectdiv{
                    margin-top: 10px;
                }

            }
            /*            手机横屏*/
            @media screen and (min-width:667px) and (max-width:767px) {  
                #l_comaddr2{
                    width: 120px;
                }
                #sensorlist{
                    width: 120px;
                }
                #selectdiv{
                    margin-left: 20px;
                }

            }
            /*           ipad竖屏*/
            @media screen and (min-width:768px) and (max-width:1023px) {  
                #l_comaddr2{
                    width: 150px;
                }
                #sensorlist{
                    width: 150px;
                }
                #selectdiv{
                    margin-left: 20px;
                }

            }

            @media screen and (min-width:1024px){  
                #l_comaddr2{
                    width: 150px;
                }
                #sensorlist{
                    width: 150px;
                }
                #selectdiv{
                    margin-top: 0px;
                    margin-left: 20px;
                }
                #selectdiv2{
                    float: left;
                }
                #Day{
                    /*                   margin-right: 110px;*/
                }
            } 

        </style>



    </head>
    <body id="activity_pane">

        <div class="row"  style=" margin-top: 10px;">
            <div id="selectdiv2"  class="col-xs-12 col-sm-6 col-md-5 col-lg-4 "> 
                <span style=" margin-left: 10px;">查询条件</span>
                <input id="l_comaddr2" name="l_comaddr" class="easyui-combobox" 
                       data-options="editable:true,valueField:'id', textField:'text' " />
                <select class="easyui-combobox" id="sensorlist" style=" margin-left: 3px;  height: 30px">
                    <option value="0">15分钟</option>
                    <option value="1">30分钟</option>   
                    <option value="2">1小时</option> 
                </select>
                &nbsp;
            </div>

            <div id="Day"  class="col-xs-12 col-sm-6 col-md-5 col-lg-4 ">
                <form action="" id="day1" class="form-horizontal" role="form" style="float:left; width: 166px">
                    <label for="dtp_input2" class="control-label" style="float: left;"></label>
                    <input id="dtp_input2" value="" type="hidden">
                    <span class="input-group date col-md-2 day" style="float:initial;" data-date=""  data-link-field="dtp_input2">
                        <input id="sday" name="day"  class="form-control" style="width:90px;" size="16" readonly="readonly" type="text">
                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                    </span>
                </form>
                <span style="float: left; margin-top: 4px;">&nbsp;
                    <span>至</span>
                    &nbsp;</span>
                <form action="" id="day2" class="form-horizontal" role="form" style="float:left;width: 166px">
                    <label for="dtp_input2" class="control-label" style="float: left;"></label>
                    <input id="dtp_input2" value="" type="hidden">
                    <span class="input-group date col-md-2 day" style="float:initial;" data-date=""  data-link-field="dtp_input2">
                        <input id="eday" name="day"  class="form-control" style="width:90px;" size="16" readonly="readonly" type="text">
                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                    </span>
                </form>
                <div id="selectdiv" style=" text-align:right;margin:0px 10px 0px auto;">
                    <button type="button" class="btn btn-xm btn-success" onclick="select()" >
                        <span>搜索</span>
                    </button>
                </div>
            </div>

        </div>
        <!--        <h5 style=" margin-left: 20px; color: #FFB800; width: 100%;clear:both; margin-top: 80px; ">温度单位：℃ &nbsp; &nbsp;湿度单位：%RH</h5>-->
        <div class="topCenter1" id="echarts1" style="width: 95%; height: 80%;">

        </div>
        <!--        <div style=" width:70%; height:40%; margin-left: 15%; margin-top:80px; overflow-y: scroll;">
                    <table id="kgtype"></table>
                </div>-->
    </body>
    <script>
        var pid = parent.parent.getpojectId();
        //动态创建折线对象

        function functionNodname(data) {
            var series = [];
            for (var p = 0; p < data.length; p++) {
                var xyData = [];
                xyData = data[p].data;
                var item = {
                    name: data[p].name,
                    type: 'line',
                    data: xyData
                };

                series.push(item);
            }

            return series;

        }
        //温度
//        function wd(id, qxbs, xdata, data, unit) {
//            wdChart = echarts.init(document.getElementById(id));
//            option = {
//                title: {
//                    text: '温度曲线图'
//                },
//                tooltip: {
//                    trigger: 'axis'
//                },
//                legend: {
//                    data: qxbs
//                },
//                grid: {
//                    left: '3%',
//                    right: '4%',
//                    bottom: '3%',
//                    containLabel: true
//                },
//                toolbox: {
//                    feature: {
//                        saveAsImage: {}
//                    }
//                },
//                xAxis: {
//                    type: 'category',
//                    boundaryGap: false,
//                    data: xdata
//                },
//                yAxis: {
//                    type: 'value',
//                    axisLabel: {
//                        formatter: '{value} ' + unit
//                    }
//                },
//                series: functionNodname(data)
//            };
//            wdChart.setOption(option,true);
//        }
        //湿度
        function echarts3(id, qxbs, xdata, data) {

            myChart3 = echarts.init(document.getElementById(id));
            option = {
                title: {
                    text: '曲线示意图'
                },
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    x: 'center', // 'center' | 'left' | {number},
                    y: 'top', // 'center' | 'bottom' | {number}
                    data: qxbs
                },
                grid: {
                    left: '1%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                },
                toolbox: {
                    feature: {
                        saveAsImage: {}
                    }
                },
                xAxis: {
                    type: 'category',
                    boundaryGap: false,
                    data: xdata
                },
                yAxis: {
                    type: 'value',
                    axisLabel: {
                        formatter: '{value} '
                    }
                },
                series: functionNodname(data)
            };
            myChart3.setOption(option, true);
        }

        $(function () {
            $("#l_comaddr2").combobox({
                url: "homePage.gayway.getComaddr.action?pid=" + pid,
//                formatter: function (row) {
//                    var v1 = row.online == 1 ? "&nbsp;<img src='img/online1.png'>" : "&nbsp;<img src='img/off.png'>";
//                    var v = row.text + v1;
//                    row.id = row.id;
//                    row.text = v;
//                    var opts = $(this).combobox('options');
//                    return row[opts.textField];
//                },
                onLoadSuccess: function (data) {
//                    if (Array.isArray(data) && data.length > 0) {
//                        for (var i = 0; i < data.length; i++) {
//                            data[i].text = data[i].name;
//                        }
//                        $(this).combobox('select', data[0].id);
//                    }
                    $(this).combobox('select', data[0].id);


                },
                onSelect: function (record) {

                }
            });
            var obj = {};
            obj.pid = pid;
            $.ajax({async: false, url: "homePage.homePage.getSensorList.action", type: "get", datatype: "JSON", data: obj,
                success: function (data) {
                    var sdrs = data.sdrs;
                    var xdata = data.xdata;
                    createChart(sdrs, xdata);
                },
                error: function () {
                    alert("提交失败！");
                }
            });

            $(".day").datetimepicker({
                format: 'yyyy/mm/dd',
                language: 'zh-CN',
                minView: "month",
                todayBtn: 1,
                autoclose: 1
            });
        });
        //创建曲线图

        function createChart(sdrs, xdata) {
            var sdqxbs = [];  //湿度曲线标识
            var qxbstype = [];  //曲线标识类型
            var sdxdata = [];      //x轴描述 ['周一', '周二', '周三', '周四', '周五', '周六', '周日']
            var sddata = [];   //填充数据
            if (sdrs.length > 0) {

                for (var i = 0; i < sdrs.length; i++) {
                    if (sdqxbs.length == 0) {
                        sdqxbs.push(sdrs[i].name);
                        if (sdrs[i].type == "1") {
                            qxbstype.push(1);
                        } else if (sdrs[i].type == "2") {
                            qxbstype.push(2);
                        } else if (sdrs[i].type == "4") {
                            qxbstype.push(4);
                        } else if (sdrs[i].type == "5") {
                            qxbstype.push(5);
                        } else if (sdrs[i].type == "6") {
                            qxbstype.push(6);
                        }
                    } else {
                        for (var j = 0; j < sdqxbs.length; j++) {
                            if (sdqxbs[j] == sdrs[i].name) {
                                break;
                            } else if (j == sdqxbs.length - 1) {
                                sdqxbs.push(sdrs[i].name);
                                if (sdrs[i].type == "1") {
                                    qxbstype.push(1);
                                } else if (sdrs[i].type == "2") {
                                    qxbstype.push(2);
                                } else if (sdrs[i].type == "4") {
                                    qxbstype.push(4);
                                } else if (sdrs[i].type == "5") {
                                    qxbstype.push(5);
                                } else if (sdrs[i].type == "6") {
                                    qxbstype.push(6);
                                }
                            }

                        }
                    }
                }

                for (var i = 0; i < xdata.length; i++) {
                    // sdxdata.push(xdata[i].collectime);
                    console.log(xdata[i].collectime.substring(11, 16).length);
                    if (xdata[i].collectime.substring(11, 16) == "00:00") {
                        sdxdata.push(xdata[i].collectime.substring(0, 10));
                    } else {
                        sdxdata.push(xdata[i].collectime.substring(11, 16));
                    }


                }
            }

            if (sdqxbs.length > 0) {
                for (var i = 0; i < sdqxbs.length; i++) {
                    var obj = {};
                    var wdvals = []; //温度数值数组
                    var sdvals = []; //温度数值数组
                    var fsvals = []; //风速数值数组
                    var fxvals = []; //风向数值数组
                    var zdvals = []; //照度数值数组
                    for (var j = 0; j < sdrs.length; j++) {
                        //温度
                        if (sdqxbs[i] == sdrs[j].name && sdrs[j].type == 1) {
                            var value = parseInt(sdrs[j].value);
                            if (value > 0) {
                                value = (value / 10).toFixed(1);
                            }
                            wdvals.push(value);
                        }
                        //湿度
                        if (sdqxbs[i] == sdrs[j].name && sdrs[j].type == 2) {
                            var value = parseInt(sdrs[j].value);
                            if (value > 0) {
                                value = (value / 10).toFixed(1);
                            }
                            sdvals.push(value);
                        }
                        //风速
                        if (sdqxbs[i] == sdrs[j].name && sdrs[j].type == 4) {
                            var value = parseInt(sdrs[j].value);
                            if (value > 0) {
                                value = (value / 10).toFixed(1);
                            }
                            fsvals.push(value);
                        }
                        //风向
                        if (sdqxbs[i] == sdrs[j].name && sdrs[j].type == 5) {
                            var value = parseInt(sdrs[j].value);
//                            if (value > 0) {
//                                value = (value / 10).toFixed(1);
//                            }
                            fxvals.push(value);
                        }

                        //照度
                        if (sdqxbs[i] == sdrs[j].name && sdrs[j].type == 6) {
                            var value = parseInt(sdrs[j].value);
                            if (value > 0) {
                                value = (value / 10).toFixed(1);
                            }
                            zdvals.push(value);
                        }
                    }
                    obj.name = sdqxbs[i];
                    if (qxbstype[i] == 1) {
                        var wdvals2 = [];
                        if (wdvals.length < sdxdata.length) {
                            var index = 0;
                            for (var k = 0; k < sdxdata.length; k++) {
                                if (k >= (sdxdata.length - wdvals.length)) {
                                    wdvals2.push(wdvals[index]);
                                    index++;
                                } else {
                                    wdvals2.push(0);
                                }

                            }

                        } else {
                            wdvals2 = wdvals;
                        }
                        obj.data = wdvals2;
                    } else if (qxbstype[i] == 2) {
                        var sdvals2 = [];
                        if (sdvals.length < sdxdata.length) {
                            var index = 0;
                            for (var k = 0; k < sdxdata.length; k++) {
                                if (k >= (sdxdata.length - sdvals.length)) {
                                    sdvals2.push(sdvals[index]);
                                    index++;
                                } else {
                                    sdvals2.push(0);
                                }

                            }
                        } else {
                            sdvals2 = sdvals;
                        }
                        obj.data = sdvals2;
                    } else if (qxbstype[i] == 4) {
                        var fsvals2 = [];
                        if (fsvals.length < sdxdata.length) {
                            var index = 0;
                            for (var k = 0; k < sdxdata.length; k++) {
                                if (k >= (sdxdata.length - fsvals.length)) {
                                    fsvals2.push(fsvals[index]);
                                    index++;
                                } else {
                                    fsvals2.push(0);
                                }

                            }
                        } else {
                            fsvals2 = fsvals;
                        }
                        //console.log("f2:"+fsvals2);
                        obj.data = fsvals2;
                    } else if (qxbstype[i] == 5) {
                        var fxvals2 = [];
                        if (fxvals.length < sdxdata.length) {
                            var index = 0;
                            for (var k = 0; k < sdxdata.length; k++) {
                                if (k >= (sdxdata.length - fxvals.length)) {
                                    fxvals2.push(fxvals[index]);
                                    index++;
                                } else {
                                    fxvals2.push(0);
                                }

                            }
                        } else {
                            fxvals2 = fxvals;
                        }
                        //console.log("f2:"+fsvals2);
                        obj.data = fxvals2;
                    } else if (qxbstype[i] == 6) {
                        var zdvals2 = [];
                        if (zdvals.length < sdxdata.length) {
                            var index = 0;
                            for (var k = 0; k < sdxdata.length; k++) {
                                if (k >= (sdxdata.length - zdvals.length)) {
                                    zdvals2.push(zdvals[index]);
                                    index++;
                                } else {
                                    zdvals2.push(0);
                                }

                            }
                        } else {
                            zdvals2 = zdvals;
                        }
                        //console.log("f2:"+fsvals2);
                        obj.data = zdvals2;
                    }

                    sddata.push(obj);
                }
            } else {
                sdxdata = ['00:00', '01:00', '02:00', '03:00', '04:00', '05:00', '06:00'];
                sdqxbs = ['虚拟数据'];
                sddata = [{name: "虚拟数据", data: [1, 3, 2, 5, 4, 7, 6]}];
            }
            echarts3("echarts1", sdqxbs, sdxdata, sddata);
        }
        //浏览器大小改变时重置大小
        window.onresize = function () {

            myChart3.resize();

            // wdChart.resize();

        };
        //搜索
        function  select() {
            var type = $("#sensorlist").val();
            var obj2 = {};
            obj2.comaddr = $("#l_comaddr2").val();
            var statr = $("#sday").val();
            var end = $("#eday").val();
            if (statr != "") {
                obj2.statr = statr;
            }
            if (end != "") {
                obj2.end = end;
            }
            if (type == "0") {
                $.ajax({async: false, url: "homePage.homePage.getSensorListBytj.action", type: "post", datatype: "JSON", data: obj2,
                    success: function (data) {
                        var sdrs = data.sdrs;
                        var xdata = data.xdata;
                        createChart(sdrs, xdata);
                    },
                    error: function () {
                        alert("提交失败！");
                    }
                });
            } else if (type == "1") {  //30分钟
                $.ajax({async: false, url: "homePage.homePage.getSensorListBy30.action", type: "post", datatype: "JSON", data: obj2,
                    success: function (data) {
                        var sdrs = data.sdrs;
                        var xdata = data.xdata;
                        createChart(sdrs, xdata);
                    },
                    error: function () {
                        alert("提交失败！");
                    }
                });
            } else if (type == "2") {  //1小时
                $.ajax({async: false, url: "homePage.homePage.getSensorListBy00.action", type: "post", datatype: "JSON", data: obj2,
                    success: function (data) {
                        var sdrs = data.sdrs;
                        var xdata = data.xdata;
                        createChart(sdrs, xdata);
                    },
                    error: function () {
                        alert("提交失败！");
                    }
                });
            }


        }
    </script>
</html>
