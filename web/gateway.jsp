<%-- 
    Document   : table
    Created on : 2018-6-29, 17:48:10
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %> 
<!DOCTYPE html>
<html>
    <head>
        <%@include  file="js.jspf" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


        <!--<style>* { margin: 0; padding: 0; } body, html { width: 100%; height: 100%; } .zuheanniu { margin-top: 2px; margin-left: 10px; } table { font-size: 14px; } .modal-body input[type="text"], .modal-body select, .modal-body input[type="radio"] { height: 30px; } .modal-body table td { line-height: 40px; } .menuBox { position: relative; background: skyblue; } .getMenu { z-index: 1000; display: none; background: white; list-style: none; border: 1px solid skyblue; width: 150px; height: auto; max-height: 200px; position: absolute; left: 0; top: 25px; overflow: auto; } .getMenu li { width: 148px; padding-left: 10px; line-height: 22px; font-size: 14px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis; } .getMenu li:hover { background: #eee; cursor: pointer; } .a-upload { padding: 4px 10px; height: 30px; line-height: 20px; position: relative; cursor: pointer; color: #888; background: #fafafa; border: 1px solid #ddd; border-radius: 4px; overflow: hidden; display: inline-block; *display: inline; *zoom: 1 } .a-upload input { position: absolute; font-size: 100px; right: 0; top: 0; opacity: 0; filter: alpha(opacity = 0); cursor: pointer } .a-upload:hover { color: #444; background: #eee; border-color: #ccc; text-decoration: none } .pagination-info { float: left; margin-top: -4px; } .modal-body { text-align: -webkit-center; text-align: -moz-center; width: 600px; margin: auto; } .btn-primary { color: #fff; background-color: #0099CC; border-color: #0099CC; }</style></head>-->
        <style>* { margin: 0; padding: 0; } body, html { width: 100%; height: 100%; } 

            input[type="text"],input[type="radio"] { height: 30px; } 
            table td { line-height: 40px; } 
            .menuBox { position: relative; background: skyblue; } 
            .a-upload { padding: 4px 10px; height: 30px; line-height: 20px; position: relative; cursor: pointer; color: #888; background: #fafafa; border: 1px solid #ddd; border-radius: 4px; overflow: hidden; display: inline-block; *display: inline; *zoom: 1 } 
            .a-upload input { position: absolute; font-size: 100px; right: 0; top: 0; opacity: 0; filter: alpha(opacity = 0); cursor: pointer } 
            .a-upload:hover { color: #444; background: #eee; border-color: #ccc; text-decoration: none } 

            .bodycenter { text-align: -webkit-center; text-align: -moz-center; width: 600px; margin: auto; } 
            @media screen and (max-width:767px) {  
                #dialog-add{
                    font-size: 4px;
                }
                html{
                    font-size: 14px;
                }
                body{
                    font-size: 14px; 
                }
                #dialog-add input {
                    width: 100px;
                }
                #model{
                    width: 100px;

                }
                #model_{
                    width: 100px;
                }
                #name_{
                    width: 100px;
                }
                #comaddr_{
                    width: 100px;
                }
                #namediv{
                    margin-top: 10px;
                }
                #modeldiv{
                    margin-top: 10px;
                }
                #jwddiv{
                     margin-top: 10px;
                }
                #comaddrdiv{
                     margin-top: 10px;
                }
                #wddiv{
                     margin-top: 10px;
                }
                .jwd{
                    width: 50px;
                }

            }

            @media screen and (min-width:768px) {  
                #dialog-add{
                    font-size: 14px;
                }
                html{
                    font-size: 14px;
                }
                body{
                    font-size: 14px; 
                }
                #dialog-add input {
                    width: 120px;
                }
                #model{
                    width: 120px;
                }
                
                 #model_{
                    width: 150px;
                }
                #name_{
                    width: 150px;
                }
                #comaddr_{
                    width: 150px;
                }
                #namediv{
                    margin-top: 10px;
                }
                #modeldiv{
                    margin-top: 10px;
                }
                #jwddiv{
                     margin-top: 10px;
                }
                #comaddrdiv{
                     margin-top: 10px;
                }
                #wddiv{
                     margin-top: 10px;
                }
                .jwd{
                    width: 80px;
                }

            }
            @media screen and (min-width:1024px) {  
                #dialog-add{
                    font-size: 14px;
                }
                html{
                    font-size: 14px;
                }
                body{
                    font-size: 14px; 
                }
                #dialog-add input {
                    width: 150px;
                }
                #model{
                    width: 150px;
                }
            }

        </style>

        <script type="text/javascript" src="SheetJS-js-xlsx/dist/xlsx.core.min.js"></script>
        <script type="text/javascript" src="js/genel.js"></script>
        <script type="text/javascript" src="js/getdate.js"></script>
        <script>
            var withs;
            var u_name = "${param.name}";
            var o_pid = "${param.pid}";
            var lang = '${param.lang}';//'zh_CN';
            function excel() {
                $('#dialog-excel').dialog('open');
                return false;

            }

            function layerAler(str) {
                layer.alert(str, {
                    icon: 6,
                    offset: 'center'
                });
            }
            function deleteGateway() {
                var selects = $('#gravidaTable').bootstrapTable('getSelections');
                var num = selects.length;
                if (num == 0) {
                    layerAler("请选择您要删除的数据");//请选择您要删除的数据
                } else {
                    layer.confirm('确认要删除吗？', {//确认要删除吗？
                        btn: ['确定', '取消'] //确定、取消按钮
                    }, function (index) {
                        var o = {identify: selects[0].identify, id: selects[0].id};
                        $.ajax({url: "gayway.GaywayForm.existcomaddr.action", type: "POST", datatype: "JSON", data: o,
                            success: function (data) {
                                console.log(data);
                                var arrlist = data.rs;
                                if (arrlist.length > 0) {
                                    layerAler("该网关下存在回路或传感器不能删除");
                                } else {
                                    $.ajax({url: "gayway.GaywayForm.deleteGateway.action", type: "POST", datatype: "JSON", data: o,
                                        success: function (data) {
                                            
                                            var arrlist = data.rs;
                                            if (arrlist.length == 1) {
                                                //删除成功
                                                layerAler("删除成功");
                                                addlogon(u_name, "删除", o_pid, "网关管理", "删除网关【"+selects[0].name+"】");
                                                $("#gravidaTable").bootstrapTable('refresh');
                                            }

                                            //                                    
                                        },
                                        error: function () {
                                            alert("提交失败！");
                                        }
                                    });
                                }
                            }
                        });
                        layer.close(index);
                    });
                }
            }



            function showDialog() {

                $('#dialog-add').dialog('open');
                return false;
            }

            function modifyModal() {

                var selectRow1 = $("#gravidaTable").bootstrapTable("getSelections");
                if (selectRow1.length > 1) {
                    //只能选择一行进行修改
                    layer.alert("只能选择一行进行修改", {
                        icon: 6,
                        offset: 'center'
                    });
                } else if (selectRow1.length == 0) {
                    //请勾选表格数据
                    layer.alert("请勾选表格数据", {
                        icon: 6,
                        offset: 'center'
                    });
                } else {
                    var s = $("#gravidaTable").bootstrapTable("getSelections")[0];
                    console.log(s);

                    $("#name_").val(s.name);

                    $("#model_").combobox('setValue', s.model);
                    $("#connecttype_").combobox('setValue', s.connecttype);
                    $("#setupaddr_").val(s.setupaddr);

                    $("#id_").val(s.id);
                    $("#comaddr_").val(s.comaddr);
                    $("#multpower_").val(s.multpower);
                    $("#comaddr_").val(s.comaddr.replace(/\b(0+)/gi, ""));

                    var arrlatitude = s.latitude.split(".");
                    var arrLongitude = s.Longitude.split(".");
                    $("#longitudem26d_").val(arrLongitude[0]);
                    $("#longitudem26m_").val(arrLongitude[1]);
                    $("#longitudem26s_").val(arrLongitude[2]);



                    $("#latitudem26d_").val(arrlatitude[0]);
                    $("#latitudem26m_").val(arrlatitude[1]);
                    $("#latitudem26s_").val(arrlatitude[2]);

                    $('#dialog-edit').dialog('open');
                    return false;
                }
            }


            function  editComplete() {
                var obj = $("#form2").serializeObject();
                var latitudemstr = obj.latitudem26d + "." + obj.latitudem26m + "." + obj.latitudem26s;
                obj.latitude = latitudemstr;
                var longitudemstr = obj.longitudem26d + "." + obj.longitudem26m + "." + obj.longitudem26s;
                obj.longitude = longitudemstr;
                addlogon(u_name, "修改", o_pid, "网关管理", "修改网关【"+obj.name+"】");
                $.ajax({async: false, cache: false, url: "gayway.GaywayForm.modifyGateway.action", type: "GET", data: obj,
                    success: function (data) {
                        // namesss = true;
                        $("#gravidaTable").bootstrapTable('refresh');
                    },
                    error: function () {
                        layer.alert('系统错误，刷新后重试', {
                            icon: 6,
                            offset: 'center'
                        });
                    }
                });

                return false;
            }

            $(function () {
                size();
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
                            title: "网关名称",
                            field: '网关名称',
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            title: "网关编号",
                            field: '网关编号', //网关名称
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            title: "经度", //经度
                            field: '经度',
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            field: '纬度', //纬度
                            title: "纬度",
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }
                    ],
                    singleSelect: false,
                    locale: 'zh-CN', //中文支持,
                    pagination: true,
                    pageNumber: 1,
                    pageSize: 40,
                    pageList: [20, 40, 80, 160]

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
                            alert("文件类型不正确");  //文件类型不正确
                            return;
                        }
                        // 表格的表格范围，可用于判断表头是否数量是否正确
                        var fromTo = '';
                        // 遍历每张表读取
                        for (var sheet in workbook.Sheets) {
                            if (workbook.Sheets.hasOwnProperty(sheet)) {
                                fromTo = workbook.Sheets[sheet]['!ref'];
                                persons = persons.concat(XLSX.utils.sheet_to_json(workbook.Sheets[sheet]));
                                // break; // 如果只取第一张表，就取消注释这行
                            }
                        }
                        var headStr = '序号,网关名称,网关编号,型号,经度,纬度';
                        var headStr2 = '序号,网关名称,网关编号';
                        var headStr3 = '序号,网关名称,网关编号,经度,纬度';
                        var headStr4 = '序号,网关名称,网关编号,型号';
                        for (var i = 0; i < persons.length; i++) {
                            if (Object.keys(persons[i]).join(',') !== headStr && Object.keys(persons[i]).join(',') !== headStr2 && Object.keys(persons[i]).join(',') !== headStr3 && Object.keys(persons[i]).join(',') !== headStr4) {
                                alert("导入文件格式不正确"); //导入文件格式不正确
                                persons = [];
                            }
                        }
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
                    height: 350,
                    position: ["top", "top"],
                    buttons: {
                        添加: function () {
                            $("#formadd").submit();
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
                            editComplete();
                            //$(this).dialog("close");
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


                $('#pid').combobox({
                    url: "gayway.GaywayForm.getProject.action?code=${param.pid}",
                    onLoadSuccess: function (data) {
                        if (Array.isArray(data) && data.length > 0) {
                            $(this).combobox('select', data[0].id)
                        }
                    }
                });
                $('#gravidaTable').bootstrapTable({
                    columns: [
                        {
                            title: '单选',
                            field: 'select',
                            //复选框
                            checkbox: true,
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }
                        , {
                            field: 'name',
                            title: '名称', //名称
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
                            field: 'comaddr',
                            title: '编号',
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            formatter: function (value, row, index) {
                                return  value.replace(/\b(0+)/gi, "");

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
                        }, {
                            field: 'online',
                            title: '在线状态', //在线状态
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            formatter: function (value, row, index) {
                                if (value == 1) {
                                    return "<img  src='img/online1.png'/>";  //onclick='hello()'

                                } else {
                                    return "<img  src='img/off.png'/>";  //onclick='hello()'
                                }

                            },
                        }],
                    showExport: true, //是否显示导出
                    singleSelect: true,
                    clickToSelect: true,
                    sortName: 'id',
                    locale: 'zh-CN', //中文支持,
                    showColumns: true,
                    sortOrder: 'desc',
                    pagination: true,
                    sidePagination: 'server',
                    pageNumber: 1,
                    pageSize: 5,
                    showRefresh: true,
                    showToggle: true,
                    // 设置默认分页为 50
                    pageList: [5, 10, 15, 20, 25],
                    onLoadSuccess: function (data) {  //加载成功时执行  表格加载完成时 获取集中器在线状态
                    },
                    url: 'gayway.GaywayForm.List.action',
                    //服务器url
                    queryParams: function (params)  {   //配置参数     
                        var temp  =   {    //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的 
                            search: params.search,
                            skip: params.offset,
                            limit: params.limit,
                            type_id: "1",
                            pid: "${param.pid}" 
                        };      
                        return temp;  
                    },
                });


            });

            //导入excel的添加按钮事件
            function addexcel() {
                var selects = $('#warningtable').bootstrapTable('getSelections');
                var num = selects.length;
                if (num == 0) {
                    layerAler("请选择您要保存的数据");  //请选择您要保存的数据
                    return;
                }
                var pid = "${param.pid}";
                for (var i = 0; i <= selects.length - 1; i++) {
                    var comaddr = selects[i].网关编号;
                    while (comaddr.length < 18) {
                        comaddr = "0" + comaddr;
                    }
                    var obj = {};
                    obj.comaddr = comaddr;
                    $.ajax({url: "homePage.gatewaymanage.existence.action", async: false, type: "get", datatype: "JSON", data: obj,
                        success: function (data) {
                            var arrlist = data.rs;
                            if (arrlist.length > 0) {  //网关编号是合法编号
                                $.ajax({async: false, url: "login.gateway.iscomaddr.action", type: "POST", datatype: "JSON", data: obj,
                                    success: function (data) {
                                        var arrlist = data.rs;
                                        if (arrlist.length == 0) {  //网关编号未使用
                                             var adobj = {};
                                                adobj.model = "";
                                                adobj.comaddr = comaddr;
                                                adobj.name = selects[i].网关名称;
                                                adobj.Longitude = selects[i].经度;
                                                adobj.latitude = selects[i].纬度;
                                                adobj.pid = pid;
                                                $.ajax({url: "login.gateway.addbase.action", async: false, type: "get", datatype: "JSON", data: adobj,
                                                    success: function (data) {
                                                        var arrlist = data.rs;
                                                        if (arrlist.length == 1) {
                                                            var ids = [];//定义一个数组
                                                            var xh = selects[i].序号;
                                                            ids.push(xh);//将要删除的id存入数组
                                                            addlogon(u_name, "添加", o_pid, "网关管理", "添加网关【" + selects[i].网关名称 + "】");
                                                            $("#warningtable").bootstrapTable('remove', {field: '序号', values: ids});
                                                        }
                                                    },
                                                    error: function () {
                                                        alert("提交添加失败！");
                                                    }
                                                });
//                                            var model = selects[i].型号;
//                                            if (model == "L-30MT-ES2") {
//                                                for (var i = 0; i < 16; i++) {
//                                                    var z = i + 4100;
//                                                    var j = i >= 8 ? 10 + (i - 8) : i;
//                                                    var ooo = {};
//                                                    ooo.sitenum = 1;
//                                                    ooo.name = "X" + j.toString();
//                                                    ooo.worktype = 0;
//                                                    ooo.dreg = z;
//                                                    ooo.type = 3;
//                                                    ooo.model = obj.model;
//                                                    ooo.l_comaddr = obj.comaddr;
//                                                    $.ajax({url: "sensor.sensorform.addsensor.action", async: false, type: "get", datatype: "JSON", data: ooo,
//                                                        success: function (data) {
//                                                            var arrlist = data.rs;
//                                                            if (arrlist.length == 1) {
//                                                            }
//                                                        },
//                                                        error: function () {
//                                                            alert("提交添加失败！");
//                                                        }
//                                                    });
//                                                }
//
//
//                                                //添加回路
//                                                for (var i = 0; i < 14; i++) {
//                                                    var z = i + 4200;
//                                                    var j = i >= 8 ? 10 + (i - 8) : i;
//                                                    var ooo = {};
//                                                    ooo.l_site = 1;
//                                                    ooo.l_name = "Y" + j.toString();
//                                                    ooo.l_comaddr = comaddr;
//                                                    ooo.l_pos = z;
//                                                    ooo.l_port = i;
//
//                                                    //ooo.l_worktype = 2;
////                                    ooo.l_plan = 1;
//                                                    ooo.l_val1 = 0;
//                                                    ooo.l_val2 = 0;
//                                                    ooo.l_val3 = 0;
//                                                    ooo.l_val4 = 0;
//                                                    ooo.l_val5 = 0;
////                                    ooo.l_info = i
//                                                    console.log(ooo);
//                                                    $.ajax({url: "loop.loopForm.addLoop.action", async: false, type: "get", datatype: "JSON", data: ooo,
//                                                        success: function (data) {
//                                                            var arrlist = data.rs;
//                                                            if (arrlist.length == 1) {
//                                                            }
//                                                        },
//                                                        error: function () {
//                                                            alert("提交添加失败！");
//                                                        }
//                                                    });
//                                                }
//
//
//                                                $.ajax({async: false, cache: false, url: "gayway.GaywayForm.addGateway.action", type: "GET", data: obj,
//                                                    success: function (data) {
//                                                        var arrlist = data.rs;
//                                                        if (arrlist.length == 1) {
//                                                            var ids = [];//定义一个数组
//                                                            var xh = selects[i].序号;
//                                                            ids.push(xh);//将要删除的id存入数组
//                                                            addlogon(u_name, "添加", o_pid, "网关管理", "添加网关【" + selects[i].网关名称 + "】");
//                                                            $("#warningtable").bootstrapTable('remove', {field: '序号', values: ids});
//                                                        }
//                                                    },
//                                                    error: function () {
//                                                        layer.alert('系统错误，刷新后重试', {
//                                                            icon: 6,
//                                                            offset: 'center'
//                                                        });
//                                                    }
//                                                });
//
//                                            } else {
//                                                var adobj = {};
//                                                adobj.model = "";
//                                                adobj.comaddr = comaddr;
//                                                adobj.name = selects[i].网关名称;
//                                                adobj.Longitude = selects[i].经度;
//                                                adobj.latitude = selects[i].纬度;
//                                                adobj.pid = pid;
//                                                $.ajax({url: "login.gateway.addbase.action", async: false, type: "get", datatype: "JSON", data: adobj,
//                                                    success: function (data) {
//                                                        var arrlist = data.rs;
//                                                        if (arrlist.length == 1) {
//                                                            var ids = [];//定义一个数组
//                                                            var xh = selects[i].序号;
//                                                            ids.push(xh);//将要删除的id存入数组
//                                                            addlogon(u_name, "添加", o_pid, "网关管理", "添加网关【" + selects[i].网关名称 + "】");
//                                                            $("#warningtable").bootstrapTable('remove', {field: '序号', values: ids});
//                                                        }
//                                                    },
//                                                    error: function () {
//                                                        alert("提交添加失败！");
//                                                    }
//                                                });
//                                            }

                                        }
                                    },
                                    error: function () {
                                        layerAler("提交失败");
                                    }
                                });
                            }
                        }
                    });
                }
                $("#gravidaTable").bootstrapTable('refresh');
            }


            function checkAdd() {
                var obj = $("#formadd").serializeObject();
                console.log(obj);
                obj.pid = parent.parent.getpojectId();
                if (obj.comaddr == "") {
                    layerAler("请填写网关地址");
                    return;
                }
                if (obj.comaddr.length > 18) {
                    layerAler("网关地址不能大于18长度");
                    return;
                }
                var comaddr = obj.comaddr;
                while (comaddr.length < 18) {
                    comaddr = "0" + comaddr;
                }
                obj.comaddr = comaddr;
                obj.l_plan = "";
                var namesss = false;
                $.ajax({async: false, cache: false, url: "homePage.gatewaymanage.existence.action", type: "GET", data: obj,
                    success: function (data) {
                        var rs = data.rs;
                        if (rs.length > 0) {
                            $.ajax({async: false, cache: false, url: "gayway.GaywayForm.queryGateway.action", type: "GET", data: obj,
                                success: function (data) {
                                    var arrlist = data.rs;
                                    if (arrlist.length == 1) {
                                        layer.alert('此网关已存在', {
                                            icon: 6,
                                            offset: 'center'
                                        });
                                        namesss = false;
                                        return;
                                    } else if (arrlist.length == 0) {
                                        console.log(obj);
                                        if (obj.model == "L-30MT-ES2") {
                                            //添加传感器

                                            for (var i = 0; i < 16; i++) {
                                                var z = i + 4100;
                                                var j = i >= 8 ? 10 + (i - 8) : i;
                                                var ooo = {};
                                                ooo.sitenum = 1;
                                                ooo.name = "X" + j.toString();
                                                ooo.worktype = 0;
                                                ooo.dreg = z;
                                                ooo.type = 3;
                                                ooo.model = obj.model;
                                                ooo.l_comaddr = obj.comaddr;
                                                $.ajax({url: "sensor.sensorform.addsensor.action", async: false, type: "get", datatype: "JSON", data: ooo,
                                                    success: function (data) {
                                                        var arrlist = data.rs;
                                                        if (arrlist.length == 1) {
                                                        }
                                                    },
                                                    error: function () {
                                                        alert("提交添加失败！");
                                                    }
                                                });
                                            }


                                            //添加回路
                                            for (var i = 0; i < 14; i++) {
                                                var z = i + 4200;
                                                var j = i >= 8 ? 10 + (i - 8) : i;
                                                var ooo = {};
                                                ooo.l_site = 1;
                                                ooo.l_name = "Y" + j.toString();
                                                ooo.l_comaddr = comaddr;
                                                ooo.l_pos = z;
                                                ooo.l_port = i;

                                                //ooo.l_worktype = 2;
//                                    ooo.l_plan = 1;
                                                ooo.l_val1 = 0;
                                                ooo.l_val2 = 0;
                                                ooo.l_val3 = 0;
                                                ooo.l_val4 = 0;
                                                ooo.l_val5 = 0;
//                                    ooo.l_info = i
                                                console.log(ooo);
                                                $.ajax({url: "loop.loopForm.addLoop.action", async: false, type: "get", datatype: "JSON", data: ooo,
                                                    success: function (data) {
                                                        var arrlist = data.rs;
                                                        if (arrlist.length == 1) {
                                                          
                                                        }
                                                    },
                                                    error: function () {
                                                        alert("提交添加失败！");
                                                    }
                                                });
                                            }


                                            $.ajax({async: false, cache: false, url: "gayway.GaywayForm.addGateway.action", type: "GET", data: obj,
                                                success: function (data) {
                                                    namesss = true;
                                                    addlogon(u_name, "添加", o_pid, "网关管理", "添加网关【" +obj.name + "】");
                                                    $("#gravidaTable").bootstrapTable('refresh');
                                                 
                                                },
                                                error: function () {
                                                    layer.alert('系统错误，刷新后重试', {
                                                        icon: 6,
                                                        offset: 'center'
                                                    });
                                                }
                                            });



                                        } else {
                                            $.ajax({async: false, cache: false, url: "gayway.GaywayForm.addGateway.action", type: "GET", data: obj,
                                                success: function (data) {
                                                    namesss = true;
                                                    addlogon(u_name, "添加", o_pid, "网关管理", "添加网关【" +obj.name + "】");
                                                    $("#gravidaTable").bootstrapTable('refresh');
                                                },
                                                error: function () {
                                                    layer.alert('系统错误，刷新后重试', {
                                                        icon: 6,
                                                        offset: 'center'
                                                    });
                                                }
                                            });
                                        }
                                        return  false;
                                    }

                                },
                                error: function () {
                                    layer.alert('系统错误，刷新后重试', {
                                        icon: 6,
                                        offset: 'center'
                                    });
                                }
                            });

                        } else {
                            layerAler("此网关编号为非法编号");
                            namesss = false;
                            return;
                        }
                    },
                    error: function () {
                        layer.alert('系统错误，刷新后重试', {
                            icon: 6,
                            offset: 'center'
                        });
                    }
                });

                return namesss;
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
    <body>
        <!--<div id="content" class="row-fluid">-->

        <div class="row" >
            <div class="col-xs-12 col-sm-12 col-md-12  ">
            </div>
        </div>
    </div>
</div>


<div class="btn-group"  style="float:left;position:relative;z-index:100;margin-left: 10px; margin-top: 10px;">
    <button class="btn btn-success btn-sm  ctrol" onclick="showDialog()" data-toggle="modal" data-target="#pjj33" id="add">
        <span class="glyphicon glyphicon-plus-sign">&nbsp;添加</span>
    </button>
    <button class="btn btn-primary btn-sm ctrol" onclick="modifyModal()" id="xiugai1">
        <span class="glyphicon glyphicon-pencil">&nbsp;编辑</span>
    </button>
    <button class="btn btn-danger btn-sm ctrol" onclick="deleteGateway()" id="shanchu">
        <span class="glyphicon glyphicon-trash">&nbsp;删除</span>
    </button>
</div>
<div class="btn-group"  style="float:left;position:relative;z-index:100; margin-left: 10px; margin-top: 10px;">
    <button type="button" id="btn_download" class="btn btn-sm btn-primary" onClick ="$('#wgmb').tableExport({type: 'excel', escape: 'false'})">
        <span>导出模板</span>
    </button>
    <button class="btn btn-success btn-sm ctrol" onclick="excel()" id="addexcel" >
        <span class="glyphicon glyphicon-plus-sign">导入Excel</span>
    </button>
    <button type="button" id="btn_download" class="btn btn-primary btn-sm" onClick ="$('#gravidaTable').tableExport({type: 'excel', escape: 'false'})">
        <span name="xxx" id="110">导出Excel</span>
    </button>
</div>

<table id="gravidaTable" >
</table>




<div id="dialog-add"  class="bodycenter"  style=" display: none" title="网关添加">

    <form action="" method="POST" id="formadd" onsubmit="return checkAdd()">   
        <input id="id" name="id" type="hidden">
        <table>
            <tbody>

                <tr>
                    <td>
                        <span>网关名称</span>&nbsp;
                        <input id="name" class="form-control" name="name" style="display: inline;" placeholder="请输入网关名称" type="text">
                    </td>
                    <td></td>
                    <td>
                        <span style="margin-left:4px;" >网关编号</span>&nbsp;
                        <input id="comaddr" class="form-control" name="comaddr" style="display: inline;" placeholder="请输入网关地址" type="text">
                    </td>
                </tr>

                <tr>
                    <td>
                        <span>&#8195;&#8195;经度</span>&nbsp;
                        <input id="Longitude" class="form-control" name="Longitude" style="display: inline;" placeholder="经度" type="text">
                    </td>
                    <td></td>
                    <td>
                        <span style="margin-left:4px;" >&#8195;&#8195;纬度</span>&nbsp;
                        <input id="latitude" class="form-control" name="latitude" style="display: inline;" placeholder="纬度" type="text">
                    </td>
                </tr>
                <tr>
                    <td>
                        <span style="">&#8195;&#8195;站号</span>&nbsp;
                        <input id="sitenum" value="1" readonly="true" class="form-control" name="sitenum" style="display: inline;" placeholder="站号" type="text">
                    </td>
                    <td></td>
                    <td>
                        <span style="margin-left:4px;" >网关型号</span>&nbsp;


                        <span class="menuBox">

                            <!--<input id="model" class="easyui-combobox" readonly="true" name="model" style="width:150px; height: 30px" data-options="editable:false" />-->
                            <select class="easyui-combobox" data-options="editable:true"  id="model" name="model" style="height: 30px">
                                <option value=""></option>
                                <!--<option value="L-30MT-ES2">L-30MT-ES2</option>-->
                            </select>
                        </span>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>                        
</div>

<div id="dialog-edit"  class="bodycenter" style=" display: none"  title="网关修改">
    <form action="" method="POST" id="form2" onsubmit="return editComplete()">  
        <div id="namediv">
            <span>网关名称</span>&nbsp;
            <input id="name_" class="form-control" name="name" style="display: inline;" placeholder="请输入网关名称" type="text">
            <input id="id_" name="id" type="hidden">
        </div>
        <div id="modeldiv">
            <span style="margin-left:4px;">网关型号</span>&nbsp;
            <span class="menuBox">
                <!--<input id="model_" class="easyui-combobox" name="model" style="width:150px; height: 30px" data-options="editable:true,valueField:'id', textField:'text',url:'test1.f5.h2.action'" />-->
                <select class="easyui-combobox" readonly="true" id="model_" name="model" style="height: 30px">
                    <option value="L-30MT-ES2">L-30MT-ES2</option>
                </select>
            </span>
        </div>
        <div id="comaddrdiv">
            <span>网关编号</span>&nbsp;
            <input id="comaddr_" class="form-control" name="comaddr" style="display: inline;" placeholder="请输入网关名称" type="text" readonly="readonly">
        </div>


        <div id="jwddiv">
            <!--                        51/45/45-->
            <div id="jddiv">
                <span>经度</span>&nbsp;
                <input id="longitudem26d_" class="form-control jwd" name="longitudem26d" style="display: inline;" type="text">&nbsp;°
                <input id="longitudem26m_" class="form-control jwd" name="longitudem26m" style=" display: inline;" type="text">&nbsp;'
                <input id="longitudem26s_" class="form-control jwd" name="longitudem26s" style=" display: inline;" type="text">&nbsp;"
            </div>

            <div id="wddiv">
                <span style="margin-left:4px;">纬度</span>&nbsp;
                <input id="latitudem26d_" class="form-control jwd" name="latitudem26d" style=" display: inline;" type="text">&nbsp;°
                <input id="latitudem26m_" class="form-control jwd" name="latitudem26m" style=" display: inline;" type="text">&nbsp;'
                <input id="latitudem26s_" class="form-control jwd" name="latitudem26s" style=" display: inline;" type="text">&nbsp;"</div>

        </div>
    </form>
</div>

<div id="dialog-excel"  class="bodycenter"  style=" display: none" title="导入Excel">
    <input type="file" id="excel-file" style=" height: 40px;">
    <table id="warningtable"></table>

</div>


<div  style=" top:-60%;position:absolute; z-index:9999;background-color:#FFFFFF;">
    <table id="wgmb" style=" border: 1px">
        <tr>
            <td>序号</td>
            <td>网关名称</td>
            <td>网关编号</td>
            <td>型号</td>
            <td>经度</td>
            <td>纬度</td>
        </tr>
        <tr>
            <td>如1、2、3</td>
            <td>网关名称</td>
            <td>网关编号不可重复</td>
            <td>可以不输入</td>
            <td>可以不输入</td>
            <td>可以不输入</td>
        </tr>
    </table>
</div>




</body>
</html>
