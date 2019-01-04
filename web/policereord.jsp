<%-- 
    Document   : policereord
    Created on : 2018-9-13, 15:40:10
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include  file="js.jspf" %>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>报警记录</title>
        <link rel="stylesheet" type="text/css" href="bootstrap-datetimepicker/bootstrap-datetimepicker.css">
        <link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/css/bootstrap.css">
        <script src="bootstrap-datetimepicker/bootstrap-datetimepicker.js"></script>
        <script type="text/javascript" src="js/genel.js"></script>
        <style>
            /*            手机*/
            @media screen and (min-width:0px) and (max-width:666px) {  

                #selectdiv{
                    position:relative; top: 10px;
                }


            }
            /*            手机横屏*/
            @media screen and (min-width:667px) and (max-width:767px) {  
                #l_comaddr2{
                    width: 120px;
                }
                #sensorlist{
                    width: 90px;
                }
                #selectdiv{
                    position:relative; left: 10px;
                }

            }


            /*           ipad竖屏*/
            @media screen and (min-width:767px) and (max-width:1023px) {  
                #l_comaddr2{
                    width: 150px;
                }
                #sensorlist{
                    width: 150px;
                }
                #selectdiv{
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
                    position:relative; left: 10px;
                }
            } 
        </style>
        <script>


            var u_name = "${param.name}";
            var o_pid = "${param.pid}";

            $(function () {
                $.ajax({
                    url: 'even.json',
                    async: false,
                    success: function (data) {
                        console.log(data);
                    }
                });

                $('#reordtabel').bootstrapTable({
                    url: 'login.policereord.reordInfo.action',
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
                            title: '设备名称', //设备名称
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
                            formatter: function (value, row, index, field) {
                                return  value.replace(".0", "");
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
                            title: '传感器编号', //灯具编号
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        },
                        {
                            field: 'f_detail',
                            title: '详情', //状态字2
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            formatter: function (value, row, index, field) {

                                return value;
                            }
                        },
                        {
                            field: 'f_handletime',
                            title: '处理时间', //异常类型
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            formatter: function (value) {
                                if (value == null || value == "") {
                                    return  null;
                                } else {
                                    var date = new Date(value);
                                    var year = date.getFullYear();
                                    var month = date.getMonth() + 1; //月份是从0开始的 
                                    var day = date.getDate(), hour = date.getHours();
                                    var min = date.getMinutes(), sec = date.getSeconds();
                                    var preArr = Array.apply(null, Array(10)).map(function (elem, index) {
                                        return '0' + index;
                                    });////开个长度为10的数组 格式为 00 01 02 03 
                                    var newTime = year + '-' + (preArr[month] || month) + '-' + (preArr[day] || day) + ' ' + (preArr[hour] || hour) + ':' + (preArr[min] || min) + ':' + (preArr[sec] || sec);
                                    return newTime;
                                }
                            }
                        },
                        {
                            field: 'f_handlep',
                            title: '处理人', //异常类型
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        },
                        {
                            field: 'f_Isfault',
                            title: '处理状态', //处理状态
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            formatter: function (value, row, index, field) {
                                if (value == 1) {
                                    var str = "<span class='label label-success'>" + "已处理" + "</span>";  //已处理
                                    return  str;
                                } else {
                                    var str = "<span class='label label-warning'>" + "未处理" + "</span>";  //未处理
                                    return  str;
                                }
                            }
                        }

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
                    pageSize: 10,
                    showRefresh: true,
                    showToggle: true,
                    // 设置默认分页为 50
                    pageList: [5, 10, 15, 20, 25],
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
                            pid: "${param.pid}",
                            type_id: "1",
                            statr: $("#sday").val(),
                            end: $("#eday").val()
                               
                        };      
                        return temp;  
                    },
                });
                $("#select").click(function () {
                    var statr = $("#sday").val();
                    var end = $("#eday").val();
                    var obj = {};

                    if (statr == "" && end == "") {
                        alert('请选择查询的时间段'); //请选择查询的时间段
                        return;
                    }
                    if (statr == "") {

                        obj.statr = "2017-01-01";
                    } else {
                        obj.statr = statr;
                    }
                    if (end == "") {
                        var d = new Date();
                        end = d.toLocaleDateString();
                        obj.end = end;
                    } else {
                        obj.end = end;
                    }
                    obj.pid = pid;
                    var opt = {
                        url: "login.policereord.reordInfo.action",
                        silent: true,
                        query: obj
                    };
                    $("#reordtabel").bootstrapTable('refresh', opt);
                });
                $(".day").datetimepicker({
                    format: 'yyyy/mm/dd',
                    language: 'zh-CN',
                    minView: "month",
                    todayBtn: 1,
                    autoclose: 1
                });
            });


            function dealfaultCB(obj) {
//                $('#panemask').hideLoading();
                if (obj.status == "success") {
                    var data = Str2BytesH(obj.data);
                    var v = "";
                    for (var i = 0; i < data.length; i++) {
                        v = v + sprintf("%02x", data[i]) + " ";
                    }
                    console.log(v);
                    if (data[1] == 0x10) {
                        var infonum = (2000 + obj.val * 10 + 6) | 0x1000;
                        console.log(infonum);
                        var high = infonum >> 8 & 0xff;
                        var low = infonum & 0xff;
                        if (data[2] == high && data[3] == low) {
                            console.log("${param.name}");
                            var ooo = {id: obj.param, f_handlep: "${param.name}"};
                            console.log(ooo);
                            $.ajax({async: false, url: "sensor.sensorform.updfualt.action", type: "get", datatype: "JSON", data: ooo,
                                success: function (data) {
                                 parent.parent.getfNumber();
                                 $("#reordtabel").bootstrapTable('refresh');
                                }
                            });
                        }

                    }

                }
            }
            function dealfault() {
                var eles = $("#reordtabel").bootstrapTable('getSelections');
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
                    dealsend2("10", data, "dealfaultCB", ele.f_comaddr, 0, ele.id, info, "${param.action}");
                }

            }







        </script>
    </head>
    <body>

        <div style="margin-top:15px; margin-left: 10px;" id="Day">
            <form action="" id="day1" class="form-horizontal" role="form" style="float:left; width: 166px;">
                <label for="dtp_input2" class="control-label" style="float: left;"></label>
                <input id="dtp_input2" value="" type="hidden">
                <span class="input-group date col-md-2 day" style="float:initial;" data-date=""  data-link-field="dtp_input2">
                    <input id="sday" name="day"  class="form-control" style="width:90px;" size="16" readonly="readonly" type="text">
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </span>
            </form>
            <span style="float: left; margin-top: 4px;">&nbsp;
                <span name="xxxx" id="119">至</span>
                &nbsp;</span>
            <form action="" id="day2" class="form-horizontal" role="form" style="float:left; width: 166px;">
                <label for="dtp_input2" class="control-label" style="float: left;"></label>
                <input id="dtp_input2" value="" type="hidden">
                <span class="input-group date col-md-2 day" style="float:initial;" data-date=""  data-link-field="dtp_input2">
                    <input id="eday" name="day"  class="form-control" style="width:90px;" size="16" readonly="readonly" type="text">
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </span>
            </form>
            <div id="selectdiv">
                <span style=" margin-left:0px;">
                    <button type="button" class="btn btn-sm btn-success" id="select" >
                        搜索
                    </button>
                </span>
                <button style=" height: 30px;" type="button" id="btn_download" class="btn btn-primary" onClick ="$('#reordtabel').tableExport({type: 'excel', escape: 'false'})">
                    导出Excel
                </button>

                <button style=" height: 30px;" type="button" id="btn_download" class="btn btn-primary" onClick ="dealfault()">
                    处理故障
                </button>
            </div>


        </div>
        <div>
            <table id="reordtabel">

            </table>
        </div>



    </body>
</html>
