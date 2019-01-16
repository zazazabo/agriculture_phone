<%-- 
    Document   : loopmanage
    Created on : 2018-7-4, 14:39:25
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns:f="http://java.sun.com/jsf/core">
    <head>
        <%@include  file="js.jspf" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="SheetJS-js-xlsx/dist/xlsx.core.min.js"></script>
        <script type="text/javascript" src="js/genel.js"></script>
        <script type="text/javascript" src="js/getdate.js"></script>
        <!--        <script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>-->
        <!--<link rel="stylesheet" type="text/css" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">-->
        <style>



        </style>
        <script>
            var withs;
            var u_name = "${param.name}";
            var o_pid = "${param.pid}";

            function layerAler(str) {
                layer.alert(str, {
                    icon: 6,
                    offset: '10px'
                });
            }

            function enablewarning(val) {
                var selects = $("#gravidaTable").bootstrapTable('getSelections');
                console.log(selects);
                if (selects.length == 0) {
                    layerAler("请勾选表格选项");
                    return;
                }
                var fmobj = $("#form1").serializeObject();
                
                fmobj.enable=1;
                
                console.log(fmobj);
                for (var i = 0; i < selects.length; i++) {
                    var ele = selects[i];
                    fmobj.id = ele.id;
                    fmobj.enable=val;
                    var str;
                    if(val ==1){
                        str = "启用";
                    }else{
                        str ="禁用";
                    }
                    addlogon(u_name, "设置传感器报警参数", o_pid, "报警参数设置", str+"回路【"+ele.name+"】报警参数设置",ele.s_identify);
                    $.ajax({async: false, url: "sensor.sensorform.uplimitenable.action", type: "get", datatype: "JSON", data: fmobj,
                        success: function (data) {
                            var arrlist = data.rs;
                            if (arrlist.length == 1) {
                            }
                        },
                        error: function () {
                            alert("提交失败！");
                        }
                    });
                }
                var obj = {};
                obj.identify = fmobj.s_identify;
                obj.pid = "${param.pid}";
                obj.deplayment = 1;
                var opt = {
                    url: "sensor.sensorform.getSensorList.action",
                    query: obj,
                    silent: false
                };
                $("#gravidaTable").bootstrapTable('refresh', opt);
            }

            //设置
            function  setWarning() {

                var selects = $("#gravidaTable").bootstrapTable('getSelections');
                console.log(selects);
                if (selects.length == 0) {
                    layerAler("请勾选表格选项");
                    return;
                }
                var fmobj = $("#form1").serializeObject();
                console.log(fmobj);
                for (var i = 0; i < selects.length; i++) {
                    var ele = selects[i];
                    fmobj.id = ele.id;
                    addlogon(u_name, "设置传感器报警参数", o_pid, "报警参数设置", "设置回路【"+ele.name+"】",ele.s_identify);
                    $.ajax({async: false, url: "sensor.sensorform.uplimitvalue.action", type: "get", datatype: "JSON", data: fmobj,
                        success: function (data) {
                            var arrlist = data.rs;
                            if (arrlist.length == 1) {
                            }
                        },
                        error: function () {
                            alert("提交失败！");
                        }
                    });


                }
                var obj = {};
                obj.identify = fmobj.s_identify;
                obj.pid = "${param.pid}";
                obj.deplayment = 1;
                var opt = {
                    url: "sensor.sensorform.getSensorList.action",
                    query: obj,
                    silent: false
                };
                $("#gravidaTable").bootstrapTable('refresh', opt);

            }


            $(function () {
                $('#gravidaTable').bootstrapTable({
                    showExport: false, //是否显示导出
                    exportDataType: "basic", //basic', 'a
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
                            field: 'name',
                            title: '传感器名称', //传感器名称
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        },
                        {
                            field: 'sitenum',
                            title: '站号', //组号
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            sortable: true,
                            sortOrder: "desc",
                            formatter: function (value, row, index, field) {
                                if (value != null) {
                                    return value.toString();
                                }

                            }
                        }
                        ,  {
                            field: 'infonum',
                            title: '信息点',
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            sortable: true,
                            //sortOrder: "desc",
                            formatter: function (value, row, index, field) {
                                return  value.toString();
                            }
                        },
                        {
                            field: 'minValue',
                            title: '最小值', //
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        },
                        {
                            field: 'maxValue',
                            title: '最大值', //
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            field: 'type',
                            title: '类型', //部署情况
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            formatter: function (value, row, index, field) {
                                if (value == "1") {
                                    return  "温度";
                                } else if (value == "2") {
                                    return  '湿度';
                                } else if (value == "3") {
                                    return  '开关';
                                }
                            }
                        },
                        {
                            field: 'enable',
                            title: '启用状态', //部署情况
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            formatter: function (value, row, index, field) {

                                if (value == "1") {
                                    var str = "<span class='label label-success'>" + "启用" + "</span>"; //已部署
                                    return  str;
                                } else {
                                    var str = "<span class='label label-warning'>" + "禁用" + "</span>"; //未部署
                                    return  str;
                                }
                            }
                        }
                    ],
                    smartDisplay: false,
                    clickToSelect: true,
                    singleSelect: false,
                    sortName: 's_index',
                    locale: 'zh-CN', //中文支持,
                    showColumns: true,
                    sortOrder: 'asc',
                    pagination: true,
                    sidePagination: 'server',
                    pageNumber: 1,
                    pageSize: 10,
                    showRefresh: true,
                    showToggle: true,
                    // 设置默认分页为 50
                    pageList: [10, 20, 40, 'ALL'],
                    sortable: true, //是否启用排序 
                    onLoadSuccess: function () {  //加载成功时执行  表格加载完成时 获取集中器在线状态
//                        console.info("加载成功");
                    },

                    //服务器url
                    queryParams: function (params)  {   //配置参数   
                        //
                        var v1 = params.sort + " " + params.order; 
                        var temp  =   {    //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的 
                            setWarning: params.setWarning,
                            skip: params.offset,
                            limit: params.limit,
                            sort: v1, //排序字段 和 （desc、ase）
                            sortOrder: params.order,
                            type_id: "1",
                            pid: "${param.pid}",
                            identify: $("#l_comaddr2").combobox('getValue')
//                            l_comaddr: $("#l_comaddr2").val()
                        };   
                        return temp;  
                    }
                });

                $("#l_comaddr2").combobox({
                    url: "homePage.gayway.getComaddr.action?pid=${param.pid}",
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
                        var obj = {};
                        obj.identify = record.id;
                        obj.pid = "${param.pid}";
                        obj.deplayment = 1;
                        var opt = {
                            url: "sensor.sensorform.getSensorList.action",
                            query: obj,
                            silent: false
                        };
                        $("#gravidaTable").bootstrapTable('refresh', opt);
                    }
                });

                $("#dialog-add").dialog({
                    autoOpen: false,
                    modal: true,
                    width: withs,
                    height: 300,
                    position: ["top", "top"],
                    buttons: {
                        添加: function () {
                            checkSensorAdd();
                        }, 关闭: function () {
                            $(this).dialog("close");
                        }
                    }
                });

                $("#dialog-edit").dialog({
                    autoOpen: false,
                    modal: true,
                    width: withs,
                    height: 350,
                    position: "top",
                    buttons: {
                        修改: function () {
                            editlamp();

                        }, 关闭: function () {
                            $(this).dialog("close");
                        }
                    }
                });

            });



        </script>


    </head>

    <body id="panemask">

        <div id="content" class="row-fluid">
            <form id="form1">
                <div class=" row " >
                    <div class="col-xs-12 col-sm-8 col-md-6 col-lg-12  ">
                        <table class="text-nowrap" style="  margin-top: 10px; align-content:  center;">
                            <tbody>
                                <tr>
                                    <td > &emsp;网关名称:</td>
                                    <td >
                                        <input id="l_comaddr2" class="easyui-combobox" name="l_comaddr" style="width:110px; height: 30px;" data-options="editable:true,valueField:'id', textField:'text' " />
                                    </td>

                                    <td style=" padding-left: 5px">
                                        最小值
                                    </td>
                                    <td style=" padding-left: 5px">
                                        <input id="minValue"  class="form-control" name="minValue" style="display: inline; width: 50px;" placeholder="最小值" type="text">
                                    </td>
                                    <td style=" padding-left: 5px">最大值</td>
                                    <td style=" padding-left: 5px">
                                        <input id="maxValue"  class="form-control" name="maxValue" style="display: inline; width: 50px;" placeholder="最大值" type="text">
                                    </td>
                                    <td style=" padding-left: 10px;">
                                        <button class="btn btn-success btn-sm ctrol"  type="button"  onclick="setWarning()" data-toggle="modal" data-target="#pjj33" id="add">
                                            设置
                                        </button>


                                        <button class="btn btn-success btn-sm ctrol"  type="button"  onclick="enablewarning(1)" data-toggle="modal" data-target="#pjj33" id="add">
                                            启用
                                        </button>



                                        <button class="btn btn-success btn-sm ctrol" type="button"   onclick="enablewarning(0)" data-toggle="modal" data-target="#pjj33" id="add">
                                            禁用
                                        </button>



                                    </td>

                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-xs-12 col-sm-6 col-md-5 col-lg-3" >

                    </div>


                </div>
            </form>
        </div>




        <table id="gravidaTable" style="width:100%;" class="text-nowrap table table-hover table-striped">
        </table>



        <div id="dialog-add"  class="bodycenter"  style=" display: none" title="传感器添加">                   
        </div>

        <div id="dialog-edit"  class="bodycenter" style=" display: none"  title="传感器编辑">

        </div>  


    </body>
</html>