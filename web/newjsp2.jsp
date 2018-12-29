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

        </style>



    </head>
    <body id="activity_pane">
       
        <h5 style=" margin-left: 20px; color: #FFB800; width: 100%; ">温度单位：℃ &nbsp; &nbsp;湿度单位：%RH</h5>
        <div style=" width: 100%; height:40%; ">
            <div class="topCenter1" id="echarts1" style="width: 90%; height: 98%; ">

            </div>
        </div>
        <div style=" width: 70%; height:50%; margin-left: 15%; margin-top:10px; overflow-y: scroll;">
            <table id="kgtype"></table>
        </div>
        <!--        <div style=" width: 70%; height: 400px; float:  left; margin-top: 20px;">
                    <div class="topCenter1" id="echarts2" style="width: 90%; height: 98%; ">
        
                    </div>
                </div>-->
    </body>
    <script>
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
            var wdrs;
            var sdrs;
            var obj = {};
            obj.pid = "${param.pid}";
            console.log('${param.pid}');
            $.ajax({async: false, url: "homePage.homePage.getSensorList.action", type: "get", datatype: "JSON", data: obj,
                success: function (data) {
                    wdrs = data.wdrs;
                    sdrs = data.sdrs;
                },
                error: function () {
                    alert("提交失败！");
                }
            });


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

            //  wd("echarts2", qxbs, xdata, data, "℃");

            $('#kgtype').bootstrapTable({
                url: 'homePage.homePage.getkgList.action',
                columns: [
                     [
                            {
                                field: 'detail',
                                title:"开关型传感器", //详细数据
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
                        pid:"${param.pid}"   
                    };      
                    return temp;  
                },
            });
        });
        //浏览器大小改变时重置大小
        window.onresize = function () {

            myChart3.resize();

            // wdChart.resize();

        };
    </script>
</html>
