<%-- 
    Document   : sign
    Created on : 2019-1-10, 9:16:01
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include  file="js.jspf" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>气象站</title>
        <style>
            body {
                /*               background:url(./img/ny.jpg)  no-repeat; background-size:contain; -moz-background-size:100% 100%;*/
                background:url(./img/jdbj.jpg)  no-repeat center center;

                background-size:cover;

                background-attachment:fixed;

                background-color:#CCCCCC;

            } 
            .sd{
                border: 1px solid black; width: 160px; float: left; height: 200px;margin-left: 3%; margin-top: 2% ; 
                background:rgba(144, 238 ,144,0.4); filter:alpha(opacity=40);
            }
            img{ width:100%;height:70%; margin-top: 30px;}
            #uptable tr td{
                height: 40px;
                border: 1px solid;
            }
            #uptable tr th{
                height: 40px;
                border: 1px solid;
                text-align: center;
            }

        </style>
    </head>

    <body>
        <!--        大气温度网关-->
        <input id="dqwdcom" type="hidden" value=""/>
        <!--        大气温度传感器-->
        <input id="dqwdsen" type="hidden" value=""/>  
        <!--        土壤湿度网关-->
        <input id="trsdcom" type="hidden" value=""/>   
        <!--        土壤湿度传感器-->
        <input id="trsdsen" type="hidden" value=""/>   
        <!--        上右下左-->
        <div style=" text-align:right;margin:10px 10px 0px auto;"> 
            <button class="btn btn-primary ctrol btn-xm"   onclick="edit()"  id="update">
                <span class="glyphicon glyphicon-pencil"></span>&nbsp;<span>编辑</span>
            </button>
        </div>
        <div class="sd" style=" width: 160px;">
            <div style=" width: 35%; height: 100%;  float: left;">
                <img src="./img/wd.png">
            </div>
            <div style=" width: 65%; height: 100%;  float: left;">
                <div style=" height: 50%; width: 100%;  text-align: center;padding-top: 10%;font-size: 2em;position:relative">
                    风速
                </div>
                <div style=" height: 50%; text-align: center;padding-top: 10%;font-size: 1.6em;position:relative">
                    <span id="fsvalue">3.6m/s</span> 
                </div>
            </div>
        </div>
        <div class="sd" style=" width: 160px;">
            <div style=" width: 35%; height: 100%;  float: left;"></div>
            <div style=" width: 65%; height: 100%;  float: left;">
                <div style=" height: 50%; width: 100%; text-align: center;padding-top: 10%;font-size: 2em;position:relative">
                    雨量
                </div>
                <div style=" height: 50%; text-align: center;padding-top: 10%;font-size: 1.6em;position:relative">
                    3.6m/s
                </div>
            </div>
        </div>
        <div class="sd" style=" width: 160px;">
            <div style=" width: 35%; height: 100%;  float: left;"></div>
            <div style=" width: 65%; height: 100%;  float: left;">
                <div style=" height: 50%; width: 100%;text-align: center;padding-top: 10%;font-size: 2em;position:relative">
                    雨量累计
                </div>
                <div style=" height: 50%; text-align: center;padding-top: 10%;font-size: 1.6em;position:relative">
                    3.6m/s
                </div>
            </div>
        </div>
        <div class="sd" style=" width: 160px;">
            <div style=" width: 35%; height: 100%;  float: left;"></div>
            <div style=" width: 65%; height: 100%;  float: left;">
                <div style=" height: 50%; width: 100%;  text-align: center;padding-top: 10%;font-size: 2em;position:relative">
                    土壤温度
                </div>
                <div style=" height: 50%; text-align: center;padding-top: 10%;font-size: 1.6em;position:relative">
                    3.6m/s
                </div>
            </div>
        </div>
        <div class="sd" style=" width: 160px;">
            <div style=" width: 35%; height: 100%;  float: left;"></div>
            <div style=" width: 65%; height: 100%;  float: left;">
                <div style=" height: 50%; width: 100%;  text-align: center;padding-top: 10%;font-size: 2em;position:relative">
                    大气温度
                </div>
                <div style=" height: 50%; text-align: center;padding-top: 10%;font-size: 1.6em;position:relative">
                    <span id="dqwd">0</span>℃
                </div>
            </div>
        </div>
        <div class="sd" style=" width: 160px;">
            <div style=" width: 35%; height: 100%;  float: left;"></div>
            <div style=" width: 65%; height: 100%;  float: left;">
                <div style=" height: 50%; width: 100%;  text-align: center;padding-top: 10%;font-size: 2em;position:relative">
                    大气湿度
                </div>
                <div style=" height: 50%; text-align: center;padding-top: 10%;font-size: 1.6em;position:relative">
                    <span id="dqsd">0</span>%
                </div>
            </div>
        </div>
        <div class="sd" style=" width: 160px;">
            <div style=" width: 35%; height: 100%;  float: left;"></div>
            <div style=" width: 65%; height: 100%;  float: left;">
                <div style=" height: 50%; width: 100%; text-align: center;padding-top: 10%;font-size: 2em;position:relative">
                    土壤湿度
                </div>
                <div style=" height: 50%; text-align: center;padding-top: 10%;font-size: 1.6em;position:relative">
                    <span id="trsd">0</span>%
                </div>
            </div>
        </div>
        <div class="sd" style=" width: 160px;">
            <div style=" width: 35%; height: 100%;  float: left;"></div>
            <div style=" width: 65%; height: 100%;  float: left;">
                <div style=" height: 50%; width: 100%; text-align: center;padding-top: 10%;font-size: 2em;position:relative">
                    风向
                </div>
                <div style=" height: 50%; width: 100%; text-align: center;padding-top: 10%;font-size: 1.6em;position:relative">
                    13.6m/s
                </div>
            </div>
        </div>
        <div class="sd" style=" width: 160px;">
            <div style=" width: 35%; height: 100%;  float: left;"></div>
            <div style=" width: 65%; height: 100%;  float: left;">
                <div style=" height: 50%; width: 100%; text-align: center;padding-top: 10%;font-size: 2em;position:relative">
                    照度
                </div>
                <div style=" height: 50%; text-align: center;padding-top: 10%;font-size: 1.6em;position:relative">
                    3.6m/s
                </div>
            </div>
        </div>

        <div id="faultDiv"  class="bodycenter"  style=" display: none" title="编辑气象站信息">
            <table id="uptable" style=" border: 1px solid; width: 100%; text-align: center;">
                <tr>
                    <th></th>
                    <th>网关</th>
                    <th>传感器</th> 
                </tr>
                <tr>
                    <td>风速</td>
                    <td><input id="fs_l_comaddr" name="l_comaddr" class="easyui-combobox"  style=" height: 30px; width: 120px" data-options="editable:true,valueField:'id', textField:'text' " /></td>
                    <td><input id="fs_sensor"  class="easyui-combobox"  style=" height: 30px;width: 120px" data-options="editable:true,valueField:'id', textField:'text' " /></td>
                </tr>
                <tr>
                    <td>雨量</td>
                    <td><input id="yl_l_comaddr" name="l_comaddr" class="easyui-combobox"  style=" height: 30px; width: 120px" data-options="editable:true,valueField:'id', textField:'text' " /></td>
                    <td><input id="yl_sensor" class="easyui-combobox"  style=" height: 30px;width: 120px" data-options="editable:true,valueField:'id', textField:'text' " /></td>
                </tr>
                <tr>
                    <td>雨量累计</td>
                    <td><input id="yllj_l_comaddr" name="l_comaddr" class="easyui-combobox"  style=" height: 30px;width: 120px" data-options="editable:true,valueField:'id', textField:'text' " /></td>
                    <td><input id="yllj_sensor"  class="easyui-combobox"  style=" height: 30px;width: 120px" data-options="editable:true,valueField:'id', textField:'text' " /></td>
                </tr>
                <tr>
                    <td>土壤温度</td>
                    <td><input id="trwd_l_comaddr" name="l_comaddr" class="easyui-combobox"  style=" height: 30px;width: 120px" data-options="editable:true,valueField:'id', textField:'text' " /></td>
                    <td><input id="trwd_sensor"  class="easyui-combobox"  style=" height: 30px;width: 120px" data-options="editable:true,valueField:'id', textField:'text' " /></td>
                </tr>
                <tr>
                    <td>大气温度</td>
                    <td><input id="dqwd_l_comaddr" name="l_comaddr" class="easyui-combobox"  style=" height: 30px;width: 120px" data-options="editable:true,valueField:'id', textField:'text' " /></td>
                    <td><input id="dqwd_sensor"  class="easyui-combobox"  style=" height: 30px;width: 120px" data-options="editable:true,valueField:'id', textField:'text' " /></td>
                </tr>
                <tr>
                    <td>土壤湿度</td>
                    <td><input id="trsd_l_comaddr" name="l_comaddr" class="easyui-combobox"  style=" height: 30px;width: 120px" data-options="editable:true,valueField:'id', textField:'text' " /></td>
                    <td><input id="trsd_sensor"  class="easyui-combobox"  style=" height: 30px;width: 120px" data-options="editable:true,valueField:'id', textField:'text' " /></td>
                </tr>
                <tr>
                    <td>大气湿度</td>
                    <td><input id="dqsd_l_comaddr" name="l_comaddr" class="easyui-combobox"  style=" height: 30px;width: 120px" data-options="editable:true,valueField:'id', textField:'text' " /></td>
                    <td><input id="dqsd_sensor"  class="easyui-combobox"  style=" height: 30px;width: 120px" data-options="editable:true,valueField:'id', textField:'text' " /></td>
                </tr>
                <tr>
                    <td>风向</td>
                    <td><input id="fx_l_comaddr" name="l_comaddr" class="easyui-combobox"  style=" height: 30px;width: 120px" data-options="editable:true,valueField:'id', textField:'text' " /></td>
                    <td><input id="fx_sensor"  class="easyui-combobox"  style=" height: 30px;width: 120px" data-options="editable:true,valueField:'id', textField:'text' " /></td>
                </tr>
                <tr>
                    <td>照度</td>
                    <td><input id="zd_l_comaddr" name="l_comaddr" class="easyui-combobox"  style=" height: 30px;width: 120px" data-options="editable:true,valueField:'id', textField:'text' " /></td>
                    <td><input id="zd_sensor"  class="easyui-combobox"  style=" height: 30px;width: 120px" data-options="editable:true,valueField:'id', textField:'text' " /></td>
                </tr>


            </table>
        </div>
    </body>

    <script>
        var withs;
        function layerAler(str) {
            layer.alert(str, {
                icon: 6,
                offset: 'center'
            });
        }
        var pid = parent.parent.getpojectId();
        $(function () {
            getrs();
            size();
            $("#faultDiv").dialog({
                autoOpen: false,
                modal: true,
                width: withs,
                height: 580,
                position: ["top", "top"],
                buttons: {
                    修改: function () {
                        update();
                    }, 关闭: function () {
                        $("#faultDiv").dialog("close");
                    }
                }
            });

        });
        function  edit() {
            //土壤湿度
            $("#trsd_l_comaddr").combobox({
                url: "homePage.gayway.getComaddr.action?pid=" + pid,
                onLoadSuccess: function (data) {
                    if ($("#trsdcom").val() != "") {
                        $(this).combobox('select', $("#trsdcom").val());
                    } else {
                        $(this).combobox('select', data[0].id);
                    }

                },
                onSelect: function (record) {
                    var l_comaddr = record.id;
                    $("#trsd_sensor").combobox({
                        url: "homePage.sign.gettr_sdsensroList.action?l_comaddr=" + l_comaddr,
                        onLoadSuccess: function (data) {
                            if (data.length > 0) {
                                if ($("#trsdsen").val() != "") {
                                    $(this).combobox('select', $("#trsdsen").val());
                                } else {
                                    $(this).combobox('select', data[0].id);
                                }

                            }
                        }
                    });
                }
            });
            //大气温度
            $("#dqwd_l_comaddr").combobox({
                url: "homePage.gayway.getComaddr.action?pid=" + pid,
                onLoadSuccess: function (data) {
                    if ($("#dqwdcom").val() != "") {
                        $(this).combobox('select', $("#dqwdcom").val());
                    } else {
                        $(this).combobox('select', data[0].id);
                    }

                },
                onSelect: function (record) {
                    var l_comaddr = record.id;
                    $("#dqwd_sensor").combobox({
                        url: "homePage.sign.getdq_wdsensroList.action?l_comaddr=" + l_comaddr,
                        onLoadSuccess: function (data) {
                            if (data.length > 0) {
                                if ($("#dqwdsen").val() != "") {
                                    $(this).combobox('select', $("#dqwdsen").val());
                                } else {
                                    $(this).combobox('select', data[0].id);
                                }

                            }
                        }
                    });
                }
            });
            //风速
            $("#fs_l_comaddr").combobox({
                url: "homePage.gayway.getComaddr.action?pid=${param.pid}",
                onLoadSuccess: function (data) {
                    $(this).combobox('select', data[0].id);
                },
                onSelect: function (record) {
                    var l_comaddr = record.id;
                    //风速传感器
                    $("#fs_sensor").combobox({
                        url: "homePage.sign.getfs_sensroList.action?l_comaddr=" + l_comaddr,
                        onLoadSuccess: function (data) {
                            if (data.length > 0) {
                                $(this).combobox('select', data[0].id);
                            }
                        }
                    });
                }
            });
             //雨量
             $("#yl_l_comaddr").combobox({
                url: "homePage.gayway.getComaddr.action?pid=${param.pid}",
                onLoadSuccess: function (data) {
                    $(this).combobox('select', data[0].id);
                },
                onSelect: function (record) {
                    var l_comaddr = record.id;
                    //风速传感器
                    $("#fs_sensor").combobox({
                        url: "homePage.sign.getfs_sensroList.action?l_comaddr=" + l_comaddr,
                        onLoadSuccess: function (data) {
                            if (data.length > 0) {
                                $(this).combobox('select', data[0].id);
                            }
                        }
                    });
                }
            });
            //雨量累计
            $("#yllj_l_comaddr").combobox({
                url: "homePage.gayway.getComaddr.action?pid=${param.pid}",
                onLoadSuccess: function (data) {
                    $(this).combobox('select', data[0].id);
                },
                onSelect: function (record) {
                    var l_comaddr = record.id;
                    //风速传感器
                    $("#fs_sensor").combobox({
                        url: "homePage.sign.getfs_sensroList.action?l_comaddr=" + l_comaddr,
                        onLoadSuccess: function (data) {
                            if (data.length > 0) {
                                $(this).combobox('select', data[0].id);
                            }
                        }
                    });
                }
            });
            //土壤温度
            $("#trwd_l_comaddr").combobox({
                url: "homePage.gayway.getComaddr.action?pid=${param.pid}",
                onLoadSuccess: function (data) {
                    $(this).combobox('select', data[0].id);
                },
                onSelect: function (record) {
                    var l_comaddr = record.id;
                    //风速传感器
                    $("#fs_sensor").combobox({
                        url: "homePage.sign.getfs_sensroList.action?l_comaddr=" + l_comaddr,
                        onLoadSuccess: function (data) {
                            if (data.length > 0) {
                                $(this).combobox('select', data[0].id);
                            }
                        }
                    });
                }
            });
            //大气湿度
            $("#dqsd_l_comaddr").combobox({
                url: "homePage.gayway.getComaddr.action?pid=${param.pid}",
                onLoadSuccess: function (data) {
                    $(this).combobox('select', data[0].id);
                },
                onSelect: function (record) {
                    var l_comaddr = record.id;
                    //风速传感器
                    $("#fs_sensor").combobox({
                        url: "homePage.sign.getfs_sensroList.action?l_comaddr=" + l_comaddr,
                        onLoadSuccess: function (data) {
                            if (data.length > 0) {
                                $(this).combobox('select', data[0].id);
                            }
                        }
                    });
                }
            });
            //风向
            $("#fx_l_comaddr").combobox({
                url: "homePage.gayway.getComaddr.action?pid=${param.pid}",
                onLoadSuccess: function (data) {
                    $(this).combobox('select', data[0].id);
                },
                onSelect: function (record) {
                    var l_comaddr = record.id;
                    //风速传感器
                    $("#fs_sensor").combobox({
                        url: "homePage.sign.getfs_sensroList.action?l_comaddr=" + l_comaddr,
                        onLoadSuccess: function (data) {
                            if (data.length > 0) {
                                $(this).combobox('select', data[0].id);
                            }
                        }
                    });
                }
            });
            //照度
            $("#zd_l_comaddr").combobox({
                url: "homePage.gayway.getComaddr.action?pid=${param.pid}",
                onLoadSuccess: function (data) {
                    $(this).combobox('select', data[0].id);
                },
                onSelect: function (record) {
                    var l_comaddr = record.id;
                    //风速传感器
                    $("#fs_sensor").combobox({
                        url: "homePage.sign.getfs_sensroList.action?l_comaddr=" + l_comaddr,
                        onLoadSuccess: function (data) {
                            if (data.length > 0) {
                                $(this).combobox('select', data[0].id);
                            }
                        }
                    });
                }
            });
            $('#faultDiv').dialog('open');
        }

        function update() {

            var fsid = $("#fs_sensor").val();  //风速传感器id
            var trsd = $("#trsd_sensor").val(); //土壤湿度id
            var dqsd = $("#dqwd_sensor").val();  //大气湿度
            var obj = {};
            obj.pid = pid;

            if (fsid != "") {
                console.log("null");
            }
            if (trsd != "") {
                obj.id = trsd;
                $.ajax({url: "homePage.sign.trsd_show.action", async: false, type: "get", datatype: "JSON", data: obj,
                    success: function (data) {
                        var rs1 = data.rs1;
                    },
                    error: function () {
                        alert("提交添加失败！");
                    }
                });
            }

            if (dqsd != "") {
                obj.id = dqsd;
                $.ajax({url: "homePage.sign.dqwd_show.action", async: false, type: "get", datatype: "JSON", data: obj,
                    success: function (data) {
                        var rs1 = data.rs1;
                    },
                    error: function () {
                        alert("提交添加失败！");
                    }
                });
            }

            $('#faultDiv').dialog('close');
            layerAler("成功");
            getrs();
        }
        //获取数值
        function getrs() {
            var obj = {};
            obj.pid = pid;
            $.ajax({url: "homePage.sign.getdqwd_value.action", async: false, type: "get", datatype: "JSON", data: obj,
                success: function (data) {
                    var rs = data.rs;
                    var trsdrs = data.trsdrs;
                    if (rs.length > 0) {
                        var sen = rs[0];
                        $("#dqwdcom").val(sen.l_comaddr);
                        $("#dqwdsen").val(sen.id);
                        if (parseInt(sen.numvalue) > 0) {
                            var value = parseInt(sen.numvalue) / 10;
                            $("#dqwd").html(value);
                        }
                    }
                    if (trsdrs.length > 0) {
                        var trsd = trsdrs[0];
                        $("#trsdcom").val(trsd.l_comaddr);
                        $("#trsdsen").val(trsd.id);
                        if (parseInt(trsd.numvalue) > 0) {
                            var value = parseInt(trsd.numvalue) / 10;
                            $("#trsd").html(value);
                        }
                    }
                },
                error: function () {
                    alert("提交添加失败！");
                }
            });
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

</html>
