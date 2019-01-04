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
        <link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/css/bootstrap.css">
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
            } 

        </style>



    </head>
    <body id="activity_pane">

        <div style=" margin-top: 10px;"> 
            <span style=" margin-left: 10px;">查询条件</span>
            <input id="l_comaddr2" name="l_comaddr" class="easyui-combobox"  style=" height: 30px" 
                   data-options="editable:true,valueField:'id', textField:'text' " />
            <select class="easyui-combobox" id="sensorlist" style=" margin-left: 3px;  height: 30px">
                <option value="0">15分钟</option>
                <option value="1">30分钟</option>   
                <option value="2">1小时</option> 
            </select>

        </div>

        <div style="margin-top:15px;margin-left: 10px;" id="Day">
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
            <div id="selectdiv" style=" float: left;">
                <button type="button" class="btn btn-xm btn-success" onclick="select()" >
                    <span>搜索</span>
                </button>
            </div>
        </div>
        <!--        <h5 style=" margin-left: 20px; color: #FFB800; width: 100%;clear:both; margin-top: 80px; ">温度单位：℃ &nbsp; &nbsp;湿度单位：%RH</h5>-->
        <div class="topCenter1" id="echarts1" style="width: 90%; height: 40%;">

        </div>
        <div style=" width:70%; height:40%; margin-left: 15%; margin-top:80px; overflow-y: scroll;">
            <table id="kgtype"></table>
        </div>
    </body>
    <script>
        var pid = parent.parent.getpojectId();
        //动态创建折线对象

        function functionNodname(data) {
            console.log(data);
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
        function wd(id, qxbs, xdata, data, unit) {
            wdChart = echarts.init(document.getElementById(id));
            option = {
                title: {
                    text: '温度曲线图'
                },
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    data: qxbs
                },
                grid: {
                    left: '3%',
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
                        formatter: '{value} ' + unit
                    }
                },
                series: functionNodname(data)
            };
            wdChart.setOption(option);
        }
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
                    data: qxbs
                },
                grid: {
                    left: '3%',
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
            myChart3.setOption(option);
        }

        $(function () {
            $("#l_comaddr2").combobox({
                url: "gayway.GaywayForm.getComaddr.action?pid=" + pid,
                formatter: function (row) {
                    var v1 = row.online == 1 ? "&nbsp;<img src='img/online1.png'>" : "&nbsp;<img src='img/off.png'>";
                    var v = row.text + v1;
                    row.id = row.id;
                    row.text = v;
                    var opts = $(this).combobox('options');
                    return row[opts.textField];
                },
                onLoadSuccess: function (data) {
                    if (Array.isArray(data) && data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            data[i].text = data[i].name;
                        }
                        $(this).combobox('select', data[0].id);
                    }

                },
                onSelect: function (record) {

                }
            });
            var obj = {};
            obj.pid = pid;
            $.ajax({async: false, url: "homePage.homePage.getSensorList.action", type: "get", datatype: "JSON", data: obj,
                success: function (data) {
                    var sdrs = data.sdrs;
                    createChart(sdrs);
                },
                error: function () {
                    alert("提交失败！");
                }
            });



            //  wd("echarts2", qxbs, xdata, data, "℃");

            $('#kgtype').bootstrapTable({
                url: 'homePage.homePage.getkgList.action',
                columns: [
                    [
                        {
                            field: 'detail',
                            title: "开关型传感器", //详细数据
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            colspan: 2
                        }
                    ],
                    [
                        {
                            field: 'name',
                            title: "名称",
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            field: 'numvalue',
                            title: "状态",
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
                        }]],
                clickToSelect: true,
                singleSelect: false,
                sortName: 'id',
                locale: 'zh-CN', //中文支持,
                showColumns: false,
                sortOrder: 'desc',
                pagination: true,
                sidePagination: 'server',
                pageNumber: 1,
                pageSize: 96,
                // 设置默认分页为 50
                pageList: [96],
                onLoadSuccess: function () {  //加载成功时执行  表格加载完成时 获取集中器在线状态
                    //                        console.info("加载成功");
                },
                //服务器url
                queryParams: function (params)  {   //配置参数     
                    var temp  =   {    //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的 
                        search: params.search,
                        skip: params.offset,
                        limit: params.limit,
                        type_id: "1",
                        pid: pid  
                    };      
                    return temp;  
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

        function createChart(sdrs) {
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
                                }
                            }

                        }
                    }
                }

                for (var i = 0; i < sdrs.length; i = i + sdqxbs.length) {

                   sdxdata.push(sdrs[i].times.substring(0, 5));

                }
            }

            if (sdqxbs.length > 0) {
                for (var i = 0; i < sdqxbs.length; i++) {
                    var obj = {};
                    var wdvals = []; //温度数值数组
                    var sdvals = []; //温度数值数组
                    for (var j = 0; j < sdrs.length; j++) {
                        if (sdqxbs[i] == sdrs[j].name && sdrs[j].type == 1) {
                            var value = parseInt(sdrs[j].value);
                            if (value > 0) {
                                value = (value / 10).toFixed(1);
                            }
                            wdvals.push(value);
                        }
                        if (sdqxbs[i] == sdrs[j].name && sdrs[j].type == 2) {
                            var value = parseInt(sdrs[j].value);
                            if (value > 0) {
                                value = (value / 10).toFixed(1);
                            }
                            sdvals.push(value);
                        }
                    }
                    obj.name = sdqxbs[i];
                    if (qxbstype[i] == 1) {
                        obj.data = wdvals;
                    } else {
                        obj.data = sdvals;
                    }

                    sddata.push(obj);
                }
            }
            if (sdxdata.length == 0) {
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
                        createChart(sdrs);
                    },
                    error: function () {
                        alert("提交失败！");
                    }
                });
            } else if (type == "1") {  //30分钟
                $.ajax({async: false, url: "homePage.homePage.getSensorListBy30.action", type: "post", datatype: "JSON", data: obj2,
                    success: function (data) {
                        var sdrs = data.sdrs;
                        createChart(sdrs);
                    },
                    error: function () {
                        alert("提交失败！");
                    }
                });
            } else if (type == "2") {  //1小时
                $.ajax({async: false, url: "homePage.homePage.getSensorListBy00.action", type: "post", datatype: "JSON", data: obj2,
                    success: function (data) {
                        var sdrs = data.sdrs;
                        createChart(sdrs);
                    },
                    error: function () {
                        alert("提交失败！");
                    }
                });
            }


        }
    </script>
</html>
