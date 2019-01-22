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



            /*            手机*/

            @media screen and (min-width:0px) and (max-width:767px) {  
                #dialog-add{
                    font-size: 4px;
                }
                #dialog-add input{
                    width: 95px;
                }
                #dialog-edit input{
                    width: 90px;
                }
                #type{
                    width: 100px;
                }
                #type1{
                    width: 100px;
                }
                html{
                    font-size: 14px;
                }
                body{
                    font-size: 14px; 
                }
                #l_comaddr2 {
                    width: 140px;
                }
                #busu{
                    width: 85px;
                }
                #cz{
                    margin-top: 15px;
                }

            }
            /*ipad竖屏*/
            @media screen and (min-width:767px) and (max-width:1023px) {  
                #selectlist{
                    float: left;
                }
                #cz{
                    float: left;
                    margin-left: 10px;
                }
                #l_comaddr2 {
                    width: 130px;
                }
                #busu{
                    width: 85px;
                }
                #dialog-add input{
                    width: 100px;
                }
                #type{
                    width: 100px;
                }
                #dialog-edit input{
                    width: 100px; 
                }
                #type1{
                    width: 100px;
                }

            }

            @media screen and (min-width:1024px){  
                html{
                    font-size: 14px;
                }
                body{
                    font-size: 14px; 
                }
                #cz{
                    margin-left: 10px;
                }

                #l_comaddr2 {
                    width: 150px;
                }
                #busu{
                    width: 150px;

                }
                #selectlist{
                    float: left;
                }
                #cz{
                    margin-left: 10px;
                }
                html{
                    font-size: 14px;
                }
                body{
                    font-size: 14px; 
                }

                #dialog-add input{
                    width: 150px;
                }
                #dialog-edit input{
                    width: 150px;
                }
                #type{
                    width: 150px;
                }
            } 
        </style>
        <script>
            var withs;
            var u_name = parent.parent.getusername();
            var o_pid = "${param.pid}";
            function excel() {
                $('#dialog-excel').dialog('open');
                return false;

            }

            //导入excel的添加按钮事件
            function addexcel() {
                var selects = $('#warningtable').bootstrapTable('getSelections');
                var num = selects.length;
                if (num == 0) {
                    layerAler('请选择您要保存的数据');  //请选择您要保存的数据
                    return;
                }
                for (var i = 0; i < selects.length; i++) {
                    var select = selects[i];
                    var s_identify = select.网关编号;
//                    l_comaddr = l_comaddr.toString();
//                    var obj = {};
//                    while (l_comaddr.length < 18) {
//                        l_comaddr = "0" + l_comaddr;
//                    }
                    var obj = {};
                    obj.comaddr = s_identify;
                    obj.pid = o_pid;
                    $.ajax({async: false, url: "homePage.gayway.getwgbypid.action", type: "get", datatype: "JSON", data: obj,
                        success: function (data) {
                            var rs = data.rs;
                            if (rs.length > 0) {
                                obj.s_identify = s_identify;
                                var sitenum = select.站号;
                                var dreg = select.数据位置;
                                obj.sitenum = sitenum;
                                obj.dreg = dreg;
                                $.ajax({async: false, url: "homePage.sensormanage.getIsSiten.action", type: "get", datatype: "JSON", data: obj,
                                    success: function (data) {
                                        var rs = data.rs;
                                        if (rs.length > 0) {

                                        } else {
                                            // model,dreg,name,sitenum,l_comaddr,type
                                            var model = select.备注;
                                            var name = select.传感器名;
                                            var type = select.类型;
                                            obj.model = model;
                                            obj.name = name;
                                            obj.type = type;
                                            $.ajax({async: false, url: "homePage.sensormanage.add.action", type: "get", datatype: "JSON", data: obj,
                                                success: function (data) {
                                                    var rs = data.rs;
                                                    if (rs.length > 0) {
                                                        var ids = [];//定义一个数组
                                                        var xh = selects[i].序号;
                                                        ids.push(xh);//将要删除的id存入数组
                                                        addlogon(u_name, "添加", o_pid, "传感器管理", "添加传感器【" + name + "】", s_identify);
                                                        $("#warningtable").bootstrapTable('remove', {field: '序号', values: ids});
                                                    }
                                                },
                                                error: function () {
                                                    alert("提交失败！");
                                                }
                                            });

                                        }
                                    },
                                    error: function () {
                                        alert("提交失败！");
                                    }
                                });

                            }
                        },
                        error: function () {
                            alert("提交失败！");
                        }
                    });

                }
                var obj1 = {};
                obj1.identify = $("#identify1").val();
                obj1.pid = "${param.pid}";
                var opt = {
                    url: "sensor.sensorform.getSensorList.action",
                    query: obj1,
                    silent: false
                };
                $("#gravidaTable").bootstrapTable('refresh', opt);


            }
            function showDialog() {

                var data = $('#l_comaddr').combobox('getData');
                var commain = $("#l_comaddr2").combobox('getValue');
                for (var i = 0; i < data.length; i++) {
                    if (data[i].id == commain) {
                        $("#l_comaddr").combobox('select', data[i].id);
                    }
                }

                $('#dialog-add').dialog('open');
                return false;
            }

            function layerAler(str) {
                layer.alert(str, {
                    icon: 6,
                    offset: '10px'
                });
            }

            function deleteSensor() {
                var selects = $('#gravidaTable').bootstrapTable('getSelections');
                var num = selects.length;
                if (num == 0) {
                    layerAler('请勾选您要删除的数据');  //请勾选您要删除的数据
                    return;
                }
                layer.confirm('确认要删除吗？', {//确认要删除吗？
                    btn: ['确定', '取消'] //确定、取消按钮
                }, function (index) {
                    for (var i = 0; i < selects.length; i++) {
                        var ele = selects[i];
                        if (ele.deplayment == 1) {
                            continue;
                        } else {
                            $.ajax({url: "sensor.sensorform.deleteSensor.action", type: "POST", datatype: "JSON", data: {id: ele.id},
                                success: function (data) {
                                    addlogon(u_name, "删除", o_pid, "传感器管理", "删除传感器【" + ele.name + "】", ele.s_identify);
                                },
                                error: function () {
                                    layerAler("提交失败");
                                }
                            });
                        }
                    }
                    layer.close(index);
                    var obj = {};
                    obj.identify = $("#identify1").val();
                    obj.pid = "${param.pid}";
                    var opt = {
                        url: "sensor.sensorform.getSensorList.action",
                        query: obj,
                        silent: false
                    };
                    $("#gravidaTable").bootstrapTable('refresh', opt);
                    //此处请求后台程序，下方是成功后的前台处理……
                });
            }

            function  editlamp() {
                var o = $("#form2").serializeObject();
                addlogon(u_name, "修改", o_pid, "传感器管理", "修改传感器【" + o.name + "】");
                $.ajax({async: false, url: "sensor.sensorform.modifySensor.action", type: "get", datatype: "JSON", data: o,
                    success: function (data) {
                        var a = data.rs;
                        if (a.length == 1) {
                            var obj = {};
                            obj.identify = $("#identify1").val();
                            obj.pid = "${param.pid}";
                            var opt = {
                                url: "sensor.sensorform.getSensorList.action",
                                query: obj,
                                silent: false
                            };
                            $("#gravidaTable").bootstrapTable('refresh', opt);
                        }
                    },
                    error: function () {
                        alert("提交失败！");
                    }
                });
            }

            function editlampInfo() {
                var selects = $('#gravidaTable').bootstrapTable('getSelections');
                if (selects.length <= 0) {
                    layerAler('请勾选您要编辑的数据');  //请勾选您要编辑的数据
                    return;
                }
                var s = selects[0];
                $("#name1").val(s.name);
                $("#hide_id").val(s.id);
                $("#worktype1").combobox('setValue', s.worktype);
                $("#dreg1").val(s.dreg);
                $("#sitenum1").val(s.sitenum);
                $("#minValue1").val(s.minValue);
                $("#maxValue1").val(s.maxValue);
                if (s.type != "" && s.type != null) {
                    $("#type1").combobox('setValue', s.type);
                } else {
                    $("#type1").combobox('setValue', 1);
                }

                $("#model1").val(s.model);
                if (s.deplayment == 1) {
                    $("#sitenum1").attr("readOnly", true);
                    $("#dreg1").attr("readOnly", true);
                    $("#worktype1").combobox('disable');
                } else {
                    $("#sitenum1").attr("readOnly", false);
                    $("#dreg1").attr("readOnly", false);
                    $("#worktype1").combobox('enable');
                }
                $('#dialog-edit').dialog('open');

                return false;
            }

            function checkSensorAdd() {
                var o = $("#formadd").serializeObject();
                console.log(o);
                var l_comaddr = o.l_comaddr;
                var sitenum = o.sitenum; //站号
                var dreg = o.dreg;   //数据位置
                var iobj = {};
                iobj.l_comaddr = l_comaddr;
                iobj.sitenum = sitenum;
                iobj.dreg = dreg;
//                $.ajax({async: false, url: "homePage.sensormanage.getIsSiten.action", type: "get", datatype: "JSON", data: iobj,
//                    success: function (data) {
//                        var rs = data.rs;
//                        if (rs.length > 0) {
//                            layerAler("该网关下已存在相同的站号和数据位置");
//                            return;
//                        } else {
//                            $.ajax({async: false, url: "homePage.sensormanage.add.action", type: "get", datatype: "JSON", data: o,
//                                success: function (data) {
//                                    var rs = data.rs;
//                                    if (rs.length > 0) {
//                                        layerAler("添加成功");
//                                        var obj = {};
//                                        obj.l_comaddr = $("#l_comaddr2").val();
//                                        obj.pid = "${param.pid}";
//                                        var opt = {
//                                            url: "sensor.sensorform.getSensorList.action",
//                                            query: obj,
//                                            silent: false
//                                        };
//                                        $("#gravidaTable").bootstrapTable('refresh', opt);
//                                        $("#dialog-add").dialog("close");
//                                    }
//                                },
//                                error: function () {
//                                    alert("提交失败！");
//                                }
//                            });
//
//                        }
//                    },
//                    error: function () {
//                        alert("提交失败！");
//                    }
//                });
                //addlogon(u_name, "添加", o_pid, "传感器管理", "添加传感器");

                if (o.model == "JXBS-3001-TH") {
                    for (var i = 0; i < 2; i++) {
                        o.dreg = i;
                        $.ajax({url: "sensor.sensorform.existsite.action", async: false, type: "get", datatype: "JSON", data: o,
                            success: function (data) {
                                var rs = data;
                                if (rs.total == 0) {
                                    $.ajax({url: "sensor.sensorform.addsensor1.action", async: false, type: "get", datatype: "JSON", data: o,
                                        success: function (data) {
                                            console.log(data);
                                            var rs = data.rs;
                                            if (rs.length > 0) {
                                                $("#dialog-add").dialog("close");
                                                layerAler("添加成功");
                                                $("#gravidaTable").bootstrapTable('refresh');
                                            }
                                        },
                                        error: function () {
                                            alert("提交添加失败！");
                                        }
                                    });
                                }
                            },
                            error: function () {
                                alert("提交添加失败！");
                            }
                        });
                    }
                } else if (o.model == "JXBS-3001-TR") {
                    for (var i = 0; i < 2; i++) {
                        o.dreg = i + 2;
                        $.ajax({url: "sensor.sensorform.existsite.action", async: false, type: "get", datatype: "JSON", data: o,
                            success: function (data) {
                                var rs = data;
                                if (rs.total == 0) {
                                    $.ajax({url: "sensor.sensorform.addsensor1.action", async: false, type: "get", datatype: "JSON", data: o,
                                        success: function (data) {
                                            if (rs.length > 0) {
                                                $("#dialog-add").dialog("close");
                                                layerAler("添加成功");
                                                $("#gravidaTable").bootstrapTable('refresh');
                                            }
                                        },
                                        error: function () {
                                            alert("提交添加失败！");
                                        }
                                    });



                                }
                            },
                            error: function () {
                                alert("提交添加失败！");
                            }
                        });
                    }
                } else {

                    $.ajax({url: "sensor.sensorform.existsite.action", async: false, type: "get", datatype: "JSON", data: o,
                        success: function (data) {
                            console.log(data);

                            var rs = data;
                            if (rs.total == 0) {
                                o.pos = 2000;
                                $.ajax({url: "sensor.sensorform.addsensor.action", async: false, type: "get", datatype: "JSON", data: o,
                                    success: function (data) {
                                        var rs = data.rs;
                                        if (rs.length > 0) {
                                            $("#dialog-add").dialog("close");
                                            var obj = {};
                                            obj.identify = $("#identify1").val();
                                            obj.pid = "${param.pid}";
                                            var opt = {
                                                url: "sensor.sensorform.getSensorList.action",
                                                query: obj,
                                                silent: false
                                            };
                                            $("#gravidaTable").bootstrapTable('refresh', opt);
                                        }
                                    },
                                    error: function () {
                                        alert("提交添加失败！");
                                    }
                                });
                            }
                        },
                        error: function () {
                            alert("提交添加失败！");
                        }
                    });
                }
                addlogon(u_name, "添加", o_pid, "传感器管理", "添加传感器【" + o.name + "】", o.l_comaddr);
            }

            //搜索
            function  search() {
                var obj = {};
                var busu = $("#busu").val();
                if (busu != "-1") {
                    obj.deplayment = busu;
                }
                obj.l_comaddr = $("#identify1").val();
                var opt = {
                    url: "sensor.sensorform.getSensorList.action",
                    silent: false,
                    query: obj
                };
                $("#gravidaTable").bootstrapTable('refresh', opt);
            }


            function deploySensorCB(obj) {
                $('#panemask').hideLoading();
                if (obj.status == "success") {
                    var data = Str2BytesH(obj.data);
                    var v = "";
                    for (var i = 0; i < data.length; i++) {
                        v = v + sprintf("%02x", data[i]) + " ";
                    }
                    console.log(v);
                    if (data[1] == 0x10) {
                        var infonum = (2000 + obj.val * 10) | 0x1000;
                        console.log(infonum);
                        var high = infonum >> 8 & 0xff;
                        var low = infonum & 0xff;
                        if (data[2] == high && data[3] == low) {
                            var str = obj.type == 0 ? "移除成功" : "部署成功";
                            layerAler(str);
                            var obj1 = {id: obj.param, deplayment: obj.type};
                            console.log(obj1);
                            $.ajax({async: false, url: "sensor.sensorform.modifyDepayment.action", type: "get", datatype: "JSON", data: obj1,
                                success: function (data) {
                                    var arrlist = data.rs;
                                    if (arrlist.length == 1) {
                                        var obj = {};
                                        obj.identify = $("#identify1").val();
                                        obj.pid = "${param.pid}";
                                        var opt = {
                                            url: "sensor.sensorform.getSensorList.action",
                                            query: obj,
                                            silent: false
                                        };
                                        $("#gravidaTable").bootstrapTable('refresh', opt);
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

            function deploySensor() {
                var selects = $('#gravidaTable').bootstrapTable('getSelections');
                var o = $("#form1").serializeObject();
                var vv = new Array();
                if (selects.length == 0) {
                    layerAler('请勾选表格数据'); //请勾选表格数据
                    return;
                }
                var ele = selects[0];
                var vv = [];
                vv.push(1);
                vv.push(0x10);
                var info = parseInt(ele.infonum);
                var infonum = (2000 + info * 10) | 0x1000;
                vv.push(infonum >> 8 & 0xff); //起始地址
                vv.push(infonum & 0xff);
                vv.push(0);           //寄存器数目 2字节  
                vv.push(6);
                vv.push(12);           //字节数目长度  1字节


                vv.push(info >> 8 & 0xff);  //信息点
                vv.push(info & 0xff);

                var site = parseInt(ele.sitenum); //站点
                vv.push(site >> 8 & 0xff);
                vv.push(site & 0xff);

                var reg = parseInt(ele.dreg);
                vv.push(reg >> 8 & 0xff);  //寄存器变量值
                vv.push(reg & 0xff);

                var worktype = parseInt(ele.worktype);
                vv.push(worktype >> 8 & 0xff);   //工作模式
                vv.push(worktype & 0xff);

                vv.push(0);
                vv.push(0);  //数值

                vv.push(0); //
                vv.push(1);

                var data = buicode2(vv);
                dealsend2("10", data, "deploySensorCB", o.l_comaddr, 1, ele.id, info, "${param.action}");
                addlogon(u_name, "部署", o_pid, "传感器管理", "部署传感器【" + ele.name + "】");
                $('#panemask').showLoading({
                    'afterShow': function () {
                        setTimeout("$('#panemask').hideLoading()", 10000);
                    }
                }
                );
            }

            function removeSensor() {
                var selects = $('#gravidaTable').bootstrapTable('getSelections');
                var o = $("#form1").serializeObject();

                var vv = new Array();
                if (selects.length == 0) {
                    layerAler('请勾选表格数据'); //请勾选表格数据
                    return;
                }
                var ele = selects[0];
                var info1 = parseInt(ele.infonum);
                var obj = {identify: ele.identify, infonum: ele.infonum, pid: "${param.pid}"};
                var bremove = true;
                var bremov1 = true;
                var bremov2 = true;
                $.ajax({async: false, url: "sensor.planForm.querysceninfo.action", type: "get", datatype: "JSON", data: obj,
                    success: function (data) {
                        var rs = data.rs;
                        var rs1 = data.rs1;
                        for (var i = 0; i < rs.length; i++) {
                            for (var j = 0; j < 5; j++) {
                                var scene = "p_scene" + (i + 1).toString();
                                var t = rs[i][scene];
                                if (isJSON(t)) {
                                    var o4 = eval('(' + t + ')');
                                    if (o4.info == info1) {
                                        bremove = false;
                                        bremov1 = false;
                                    }
                                }

                            }
                        }

                        for (var i = 0; i < rs1.length; i++) {
                            var type = rs1[i].l_worktype;
                            if (type == "9") {
                                var info = "l_val1";
                                var t = rs1[i][info];
                                console.log(t);
                                if (isJSON(t)) {
                                    var o4 = eval('(' + t + ')');
                                    if (o4.infonum == info1) {
                                        bremove = false;
                                        bremov2 = false;
                                    }
                                }


                            }
                        }
                    },
                    error: function () {
                        alert("提交失败！");
                    }
                });


                console.log(bremove);
                if (bremove == false) {
                    if (bremov1 == false) {
                        layerAler("请删除场景配置中的对应的信息点方案");
                    }
                    if (bremov2 == false) {
                        layerAler("请删除回路中对应的信息点");
                    }
                    return;
                }
                var vv = [];
                vv.push(1);
                vv.push(0x10);
                var info = parseInt(ele.infonum);
                var infonum = (2000 + info * 10) | 0x1000;
                vv.push(infonum >> 8 & 0xff); //起始地址
                vv.push(infonum & 0xff);
                vv.push(0);           //寄存器数目 2字节  
                vv.push(4);
                vv.push(8);           //字节数目长度  1字节


                vv.push(0);  //信息点
                vv.push(0);


                vv.push(0); //站点
                vv.push(0);


                vv.push(0)   //寄存器变量值
                vv.push(0);


                vv.push(0);  //寄存器变量值
                vv.push(0);

                var data = buicode2(vv);
                dealsend2("10", data, "deploySensorCB", o.l_comaddr, 0, ele.id, info, "${param.action}");
                addlogon(u_name, "移除部署", o_pid, "传感器管理", "传感器【" + ele.name + "】");
                $('#panemask').showLoading({
                    'afterShow': function () {
                        setTimeout("$('#panemask').hideLoading()", 10000);
                    }
                }
                );
            }
            $(function () {
                size();
                $('#gravidaTable').bootstrapTable({
                    // url: 'lamp.lampform.getlampList.action',
                    //showExport: true, //是否显示导出
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
                        , {
                            field: 'dreg',
                            title: '数据位置', //控制方案
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            formatter: function (value, row, index, field) {
                                return  value.toString();
                            }
                        }, {
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
                                }else if (value == "4") {
                                    return  '风速';
                                }else if (value == "5") {
                                    return  '风向';
                                }
                            }
                        }, {
                            field: 'Longitude',
                            title: '经度',
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            field: 'latitude',
                            title: '纬度',
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        },
                        {
                            field: 'deplayment',
                            title: '部署情况', //部署情况
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            formatter: function (value, row, index, field) {
                                if (value == "1") {
                                    var str = "<span class='label label-success'>" + "已部署" + "</span>"; //已部署
                                    return  str;
                                } else {
                                    var str = "<span class='label label-warning'>" + "未部署" + "</span>"; //未部署
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
                            search: params.search,
                            skip: params.offset,
                            limit: params.limit,
                            sort: v1, //排序字段 和 （desc、ase）
                            sortOrder: params.order,
                            type_id: "1",
                            pid: "${param.pid}",
                            l_comaddr: $("#l_comaddr2").combobox('getValue')
//                            l_comaddr: $("#l_comaddr2").val()
                        };   
                        return temp;  
                    }
                });
                $('#warningtable').bootstrapTable({
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
                            title: "序号", //序号
                            field: '序号',
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            title: "网关编号",
                            field: '网关编号',
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            title: "站号",
                            field: '站号', //网关名称
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            title: "传感器名", //经度
                            field: '传感器名',
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            field: '数据位置', //纬度
                            title: "数据位置",
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            field: '类型', //纬度
                            title: "类型",
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            field: '备注', //纬度
                            title: "备注",
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }
                    ],
                    singleSelect: false,
                    locale: 'zh-CN', //中文支持,
                    pagination: true,
                    pageNumber: 1,
                    pageSize: 20,
                    pageList: [20, 40, 60, 'ALL']

                });

                $("#l_comaddr2").combobox({
                    url: "gayway.GaywayForm.getComaddr.action?pid=${param.pid}",
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
                        console.log(record);
                        $("#identify1").val(record.identify);
                        var obj = {};
                        obj.identify = record.identify;
                        obj.pid = "${param.pid}";
                        var opt = {
                            url: "sensor.sensorform.getSensorList.action",
                            query: obj,
                            silent: false
                        };
                        $("#gravidaTable").bootstrapTable('refresh', opt);
                    }
                });


                $('#l_comaddr').combobox({
                    url: "gayway.GaywayForm.getComaddr.action?pid=${param.pid}",
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
                        $("#identify").val(record.identify);
                    }

                });







                $('#excel-file').change(function (e) {
                    var files = e.target.files;
                    var fileReader = new FileReader();
                    fileReader.onload = function (ev) {
                        try {
                            var data = ev.target.result,
                                    workbook = XLSX.read(data, {
                                        type: 'binary'
                                    }), // 以二进制流方式读取得到整份excel表格对象
                                    persons = []; // 存储获取到的数据
                        } catch (e) {
                            alert('文件类型不正确');  //文件类型不正确
                            return;
                        }
                        // 表格的表格范围，可用于判断表头是否数量是否正确
                        var fromTo = '';
                        // 遍历每张表读取
                        for (var sheet in workbook.Sheets) {
                            if (workbook.Sheets.hasOwnProperty(sheet)) {
                                fromTo = workbook.Sheets[sheet]['!ref'];
                                console.log(fromTo);
                                persons = persons.concat(XLSX.utils.sheet_to_json(workbook.Sheets[sheet]));
                                // break; // 如果只取第一张表，就取消注释这行
                            }
                        }
                        var headStr = '序号,网关编号,站号,传感器名,数据位置,类型,备注';
                        var headStr2 = '序号,网关编号,站号,传感器名,数据位置,类型';
                        for (var i = 0; i < persons.length; i++) {
                            if (Object.keys(persons[i]).join(',') !== headStr && Object.keys(persons[i]).join(',') !== headStr2) {
                                alert('导入文件格式不正确');  //导入文件格式不正确
                                persons = [];
                            }
                        }
                        console.log("p2:" + persons.length);
                        $("#warningtable").bootstrapTable('load', []);
                        if (persons.length > 0) {
                            $('#warningtable').bootstrapTable('load', persons);

                        }
                    };
                    // 以二进制方式打开文件
                    fileReader.readAsBinaryString(files[0]);
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

                $("#dialog-excel").dialog({
                    autoOpen: false,
                    modal: true,
                    width: withs,
                    height: 500,
                    position: "top",
                    buttons: {
                        保存: function () {
                            addexcel();
                        }, 关闭: function () {
                            $(this).dialog("close");
                        }
                    }
                });



                //  $("#addexcel").attr("disabled", true);

            });

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

        <style>

            input[type="text"],input[type="radio"] { height: 30px; } 
            table td { line-height: 40px; } 
            .menuBox { position: relative; background: skyblue; } 
            .a-upload { padding: 4px 10px; height: 30px; line-height: 20px; position: relative; cursor: pointer; color: #888; background: #fafafa; border: 1px solid #ddd; border-radius: 4px; overflow: hidden; display: inline-block; *display: inline; *zoom: 1 } 
            .a-upload input { position: absolute; font-size: 100px; right: 0; top: 0; opacity: 0; filter: alpha(opacity = 0); cursor: pointer } 
            .a-upload:hover { color: #444; background: #eee; border-color: #ccc; text-decoration: none } 

            .bodycenter { text-align: -webkit-center; text-align: -moz-center; width: 600px; margin: auto; }        
        </style>

    </head>

    <body id="panemask">

        <div id="content" class="row-fluid">

            <div class=" row " >
                <form id="form1">
                    <div class="col-xs-12 col-sm-6 col-md-5 col-lg-4  ">
                        <table class="text-nowrap" style="  margin-top: 10px; align-content:  center;">
                            <tbody>
                                <tr>
                                    <td > &emsp;网关名称:</td>
                                    <td >
                                        <input id="l_comaddr2" class="easyui-combobox" name="l_comaddr" style="width:110px; height: 30px;" data-options="editable:true,valueField:'id', textField:'text' " />
                                        <input type="hidden" name="identify" id="identify" value=""/>
                                    </td>

                                    <td  >
                                        &emsp;部署情况:
                                    </td>
                                    <td >
                                        <select class="easyui-combobox" name="deplayment"  id="busu" style=" height: 30px; width: 80px;">
                                            <option value ="-1">全部</option>
                                            <option value="1">已部署</option>     
                                            <option value="0">未部署</option> 
                                        </select>
                                    </td>
                                    <td style=" padding-left: 2px;">
                                        <button class="btn btn-success btn-sm ctrol" type="button"     onclick="search()" >
                                            筛选
                                        </button>
                                    </td>

                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-xs-12 col-sm-6 col-md-7 col-lg-3" >

                        <table  style="  margin-top: 15px;  ">
                            <tbody>
                                <tr>
                                    <td >
                                        <div class="btn-group zuheanniu" id="zuheanniu" style="float:left;position:relative;z-index:100; margin-left: 10px;">

                                            <button class="btn btn-primary btn-sm ctrol"  type="button" onclick="deploySensor()"   >
                                                部署
                                            </button>
                                            <button class="btn btn-danger btn-sm ctrol" type="button"  onclick="removeSensor()" >
                                                移除
                                            </button>    
                                        </div> 
                                    </td>


                                </tr>
                            </tbody>
                        </table>

                </form>





                <!--                    <div style="  margin-top: 10px; align-content:  center;">
                                        <div class="btn-group zuheanniu" id="zuheanniu" style="float:left;position:relative;z-index:100; margin-left: 10px;">
                                            <button class="btn btn-success btn-sm ctrol"   onclick="search()" data-toggle="modal" data-target="#pjj33" id="add">
                                                <span class="glyphicon glyphicon-pencil"></span>筛选
                                            </button>
                                            <button class="btn btn-primary btn-sm ctrol" onclick="deploySensor()"   id="xiugai1">
                                                <span class="glyphicon glyphicon-pencil"></span>&nbsp;部署
                                            </button>
                                            <button class="btn btn-danger btn-sm ctrol" onclick="removeSensor()" id="shanchu">
                                                <span class="glyphicon glyphicon-pencil"></span>&nbsp;移除
                                            </button>    
                                        </div>  
                                    </div>-->

            </div>
            <!--                                       <div id="cz">
                                        <button  type="button" style="margin-left:20px;" onclick="search()" class="btn btn-success btn-sm">
                                            筛选
                                        </button>
                    
                                        <button style="margin-left:10px;" id="btndeploySensor" onclick="deploySensor()" type="button" class="btn btn-success btn-sm">部署</button>
                    
                                        <button style="margin-left:10px;" id="btnremoveSensor" type="button" onclick="removeSensor()" class="btn btn-success btn-sm">移除</button>
                                    </div>-->

        </div>

    </div>




    <!--        <form id="formsearch">
                <div style=" margin-left: 10px; margin-top: 10px; align-content:  center">
                    <div id="selectlist">
                        <span style="margin-left:10px;">
                            网关名称
                            &nbsp;</span>
                        <span class="menuBox">
                            <input id="l_comaddr2" name="l_comaddr" class="easyui-combobox"  style=" height: 30px" data-options="editable:true,valueField:'id', textField:'text' " />
                        </span>  
    
                        <span style="margin-left:5px;">
                            部署情况
                            &nbsp;</span>
                        <select class="easyui-combobox" name="deplayment"  id="busu" style=" height: 30px">
                            <option value ="-1">全部</option>
                            <option value="1">已部署</option>     
                            <option value="0">未部署</option> 
                        </select>
                    </div>
                    <div id="cz">
                        <button  type="button" style="margin-left:20px;" onclick="search()" class="btn btn-success btn-sm">
                            筛选
                        </button>
    
                        <button style="margin-left:10px;" id="btndeploySensor" onclick="deploySensor()" type="button" class="btn btn-success btn-sm">部署</button>
    
                        <button style="margin-left:10px;" id="btnremoveSensor" type="button" onclick="removeSensor()" class="btn btn-success btn-sm">移除</button>
                    </div>
    
                </div>
            </form>-->
    <div class="btn-group zuheanniu" id="zuheanniu" style="float:left;position:relative;z-index:100; margin-left: 10px; margin-top: 10px;">
        <button class="btn btn-success  btn-sm  ctrol"  onclick="showDialog();" data-toggle="modal" data-target="#pjj33" id="add">
            <span class="glyphicon glyphicon-plus-sign"></span>&nbsp;添加
        </button>
        <button class="btn btn-primary  btn-sm ctrol" onclick="editlampInfo()"   id="xiugai1">
            <span class="glyphicon glyphicon-pencil"></span>&nbsp;编辑
        </button>
        <button class="btn btn-danger  btn-sm ctrol" onclick="deleteSensor();" id="shanchu">
            <span class="glyphicon glyphicon-trash"></span>&nbsp;删除
        </button>    
    </div>
    <div class="btn-group"  style="float:left;position:relative;z-index:100; margin-left: 10px; margin-top: 10px;">
        <button type="button" id="btn_download" class="btn  btn-primary  btn-sm" onClick ="$('#cgqmb').tableExport({type: 'excel', escape: 'false'})">
            导出模板
        </button>
        <button class="btn btn-success  btn-sm ctrol" onclick="excel()" id="addexcel" >
            <span class="glyphicon glyphicon-plus-sign"></span>&nbsp;
            导入Excel
        </button>          
        <button type="button" id="btn_download" class="btn btn-primary  btn-sm" onClick ="$('#gravidaTable').tableExport({type: 'excel', escape: 'false'})">
            导出Excel
        </button>
    </div>
    <!--        <div class="btn-group"  style="float:left;position:relative;z-index:100; margin-left: 10px; margin-top: 10px;">
                <button class="btn btn-success ctrol"  onclick="addshow()">
                    <span class="glyphicon glyphicon-plus-sign"></span>&nbsp;添加到首页显示
                </button>
                <button class="btn btn-danger ctrol" onclick="removeshow();">
                    <span class="glyphicon glyphicon-trash"></span>&nbsp;移除首页显示
                </button>
            </div>-->

    <table id="gravidaTable" style="width:100%;" class="text-nowrap table table-hover table-striped">
    </table>


    <!-- 添加 -->

    <!--        <div id="dialog_simple" title="Dialog Simple Title">
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
            </div>-->

    <div id="dialog-add"  class="bodycenter"  style=" display: none" title="传感器添加">

        <form action="" method="POST" id="formadd">      
            <input type="hidden" name="identify" id="identify1" value=""/>
            <table>
                <tbody>
                    <tr>
                        <td>
                            <span style="margin-left:0px;" >网关名称</span>&nbsp;
                            <span class="menuBox">

                                <input id="l_comaddr"  class="easyui-combobox" name="l_comaddr" style="height: 30px" 
                                       data-options='editable:false,valueField:"id", textField:"text"' />
                            </span>  

                        <td></td>
                        <td>
                            <span style="margin-left:20px;" >传感器名</span>
                            <input id="name" class="form-control"  name="name" style="display: inline;" placeholder="传感器名" type="text">

                        </td>
                    </tr>

                    <tr>
                        <td>
                            <span style="margin-left:0px;" >&#8195;&#8195;站号</span>&nbsp;
                            <input id="sitenum" class="form-control" name="sitenum" style="display: inline;" placeholder="站号" type="text">
                        </td>
                        <td></td>
                        <td>
                            <!--                                <span style="margin-left:10px;" >工作模式</span>&nbsp;
                                                                                            <input id="worktype" class="form-control" value="0"  name="worktype" style="width:150px;display: inline;" placeholder="工作模式" type="text">
                                                            <select class="easyui-combobox" id="worktype" name="worktype" style="width:150px; height: 30px">
                                                                <option value="0" >模拟量</option>
                                                                <option value="1" >开关量</option>  
                                                            </select>-->
                            <span style="margin-left:20px;" >&#8195;&#8195;类型</span>&nbsp;
                            <select class="easyui-combobox" id="type" name="type" style=" height: 30px">
                                <option value="1" >温度</option>
                                <option value="2" >湿度</option>  
                                <option value="3" >开关</option>  
                                <option value="4" >风速</option>  
                                <option value="5" >风向</option>  
                            </select>
                        </td>

                    </tr>    


                    <tr>
                        <td>
                            <span style="margin-left:0px;" >数据位置</span>&nbsp;
                            <input id="dreg" class="form-control" name="dreg" style="display: inline;" placeholder="数据位置" type="text">
                        </td>
                        <td></td>
                        <td>
                            <span style="margin-left:20px;" >&#8195;&#8195;备注</span>&nbsp;
                            <!--                                <input id="worktype" class="form-control" value="0"  name="worktype" style="width:150px;display: inline;" placeholder="工作模式" type="text">-->
                            <input id="model" value="" class="form-control" name="model" style="display: inline;" placeholder="备注" type="text">
                        </td>
                    </tr>  



                </tbody>
            </table>
        </form>                        
    </div>

    <div id="dialog-edit"  class="bodycenter" style=" display: none"  title="传感器编辑">
        <form action="" method="POST" id="form2" onsubmit="return editlamp()">  
            <input type="hidden" id="hide_id" name="id" />
            <input type="hidden" id="deployment" name="deployment" />
            <table>
                <tbody>

                    <tr>
                        <td>
                            <span style="margin-left:0px;" >&#8195;&#8195;站号</span>&nbsp;
                            <input id="sitenum1"  class="form-control" name="sitenum" style="display: inline;" placeholder="站号" type="text">
                        </td>
                        <td></td>
                        <td>
                            <span style="margin-left:20px;" >传感器名</span>&nbsp;
                            <input id="name1" class="form-control"  name="name" style="display: inline;" placeholder="传感器名" type="text">

                        </td>
                    </tr>    
                    <tr>
                        <td>
                            <span style="margin-left:0px;" >数据位置</span>&nbsp;
                            <input id="dreg1" class="form-control" name="dreg" style="display: inline;" placeholder="数据位置" type="text">
                        </td>
                        <td></td>
                        <!--                            <td>
                                                        <span style="margin-left:10px;" >工作模式</span>&nbsp;
                                                                                        <input id="worktype1" class="form-control"  name="worktype" style="width:150px;display: inline;" placeholder="工作模式" type="text">
                                                        <select class="easyui-combobox" id="worktype1" name="worktype" style="width:150px; height: 30px">
                                                            <option value="0" >模拟量</option>
                                                            <option value="1" >开关量</option>  
                                                        </select>
                                                    </td>-->
                        <td>
                            <span style="margin-left:20px;" >&#8195;&#8195;类型</span>&nbsp;
                            <select class="easyui-combobox" id="type1" name="type" style="height: 30px">
                                <option value="1" >温度</option>
                                <option value="2" >湿度</option>  
                                <option value="3" >开关</option> 
                                <option value="4" >风速</option>  
                                <option value="5" >风向</option>  
                            </select>

                        </td>  

                    </tr>                  

                    <tr>

                        <td>
                            <span style="margin-left:0px;" >&#8195;&#8195;备注</span>&nbsp;
                            <input id="model1"  class="form-control" name="model" style="display: inline;" placeholder="备注" type="text">
                        </td>
                        <td></td>
                        <td></td>



                    </tr> 
                </tbody>
            </table>
        </form>
    </div>  

    <div id="dialog-excel"  class="bodycenter"  style=" display: none" title="导入Excel">
        <input type="file" id="excel-file" style=" height: 40px;">
        <table id="warningtable"></table>

    </div>

    <div  style=" top:-60%;position:absolute; z-index:9999;background-color:#FFFFFF;">
        <table id="cgqmb" style=" border: 1px">
            <tr>
                <td>序号</td>
                <td>网关编号</td>
                <td>站号</td>
                <td>传感器名</td>
                <td>数据位置</td>
                <td>类型</td>
                <td>备注</td>
            </tr>
            <tr>
                <td>如1、2、3</td>
                <td>网关编号必须是已存在的</td>
                <td>网关下站号不可重复</td>
                <td>传感器名</td>
                <td>数据位置</td>
                <td>类型 1代表温度 2代表湿度 3代表开关 填入1或2或3即可</td>
                <td>备注</td>
            </tr>
        </table>
    </div>
</body>
</html>