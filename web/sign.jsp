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
        <script type="text/javascript" src="js/getdate.js"></script>
    </head>

    <body>
        <input id="fscom" type="hidden" value=""/>
        <input id="fssen" type="hidden" value=""/>  

        <input id="ylcom" type="hidden" value=""/>
        <input id="ylsen" type="hidden" value=""/>  

        <input id="ylljcom" type="hidden" value=""/>
        <input id="ylljsen" type="hidden" value=""/>  
        <!--        土壤温度-->
        <input id="trwdcom" type="hidden" value=""/>
        <input id="trwdsen" type="hidden" value=""/>  
        <!--        大气温度网关-->
        <input id="dqwdcom" type="hidden" value=""/>
        <input id="dqwdsen" type="hidden" value=""/>  
        <!--        大气湿度-->
        <input id="dqsdcom" type="hidden" value=""/>
        <input id="dqsdsen" type="hidden" value=""/>  
        <!--        土壤湿度-->
        <input id="trsdcom" type="hidden" value=""/>   
        <input id="trsdsen" type="hidden" value=""/>  
        <!--        风向-->
        <input id="fxcom" type="hidden" value=""/>
        <input id="fxsen" type="hidden" value=""/>  
        <!--        照度-->
        <input id="zdcom" type="hidden" value=""/>
        <input id="zdsen" type="hidden" value=""/>  
        <!--        上右下左-->
        <div style=" text-align:right;margin:10px 10px 0px auto;"> 
            <button class="btn btn-primary ctrol btn-xm"   onclick="edit()"  id="update">
                <span class="glyphicon glyphicon-pencil"></span>&nbsp;<span>编辑</span>
            </button>
        </div>
        <div class="sd" style=" width: 160px;">
            <div style=" width: 35%; height: 100%;  float: left;">
                <img src="./img/fs.png">
            </div>
            <div style=" width: 65%; height: 100%;  float: left;">
                <div style=" height: 50%; width: 100%;  text-align: center;padding-top: 10%;font-size: 2em;position:relative">
                    风速
                </div>
                <div style=" height: 50%; text-align: center;padding-top: 10%;font-size: 1.6em;position:relative">
                    <span id="fsvalue">0.0</span>m/s
                </div>
            </div>
        </div>
        <div class="sd" style=" width: 160px;">
            <div style=" width: 35%; height: 100%;  float: left;">
                <img src="./img/yuliang.png">
            </div>
            <div style=" width: 65%; height: 100%;  float: left;">
                <div style=" height: 50%; width: 100%; text-align: center;padding-top: 10%;font-size: 2em;position:relative">
                    雨量
                </div>
                <div style=" height: 50%; text-align: center;padding-top: 10%;font-size: 1.6em;position:relative">
                    <span id="ylvalue">0</span>ml
                </div>
            </div>
        </div>
        <div class="sd" style=" width: 160px;">
            <div style=" width: 35%; height: 100%;  float: left;">
                <img src="./img/yuliang.png">
            </div>
            <div style=" width: 65%; height: 100%;  float: left;">
                <div style=" height: 50%; width: 100%;text-align: center;padding-top: 10%;font-size: 2em;position:relative">
                    雨量累计
                </div>
                <div style=" height: 50%; text-align: center;padding-top: 10%;font-size: 1.6em;position:relative">
                    <span id="ylljvalue">0</span>ml
                </div>
            </div>
        </div>
        <div class="sd" style=" width: 160px;">
            <div style=" width: 35%; height: 100%;  float: left;">
                <img src="./img/wd.png">
            </div>
            <div style=" width: 65%; height: 100%;  float: left;">
                <div style=" height: 50%; width: 100%;  text-align: center;padding-top: 10%;font-size: 2em;position:relative">
                    土壤温度
                </div>
                <div style=" height: 50%; text-align: center;padding-top: 10%;font-size: 1.6em;position:relative">
                    <span id="trwdvalue">0</span>℃
                </div>
            </div>
        </div>
        <div class="sd" style=" width: 160px;">
            <div style=" width: 35%; height: 100%;  float: left;">
                <img src="./img/sd.png">
            </div>
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
            <div style=" width: 35%; height: 100%;  float: left;">
                <img src="./img/wd.png">
            </div>
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
            <div style=" width: 35%; height: 100%;  float: left;">
                <img src="./img/sd.png">
            </div>
            <div style=" width: 65%; height: 100%;  float: left;">
                <div style=" height: 50%; width: 100%;  text-align: center;padding-top: 10%;font-size: 2em;position:relative">
                    大气湿度
                </div>
                <div style=" height: 50%; text-align: center;padding-top: 10%;font-size: 1.6em;position:relative">
                    <span id="dqsdvalue">0</span>%
                </div>
            </div>
        </div>
        <div class="sd" style=" width: 160px;">
            <div style=" width: 35%; height: 100%;  float: left;">
                <img src="./img/fx.png">
            </div>
            <div style=" width: 65%; height: 100%;  float: left;">
                <div style=" height: 50%; width: 100%; text-align: center;padding-top: 10%;font-size: 2em;position:relative">
                    风向
                </div>
                <div style=" height: 50%; width: 100%; text-align: center;padding-top: 10%;font-size: 1.6em;position:relative">
                    <span id="fxvalue"></span>
                </div>
            </div>
        </div>
        <div class="sd" style=" width: 160px;">
            <div style=" width: 35%; height: 100%;  float: left;">
                <img src="./img/zd.png">
            </div>
            <div style=" width: 65%; height: 100%;  float: left;">
                <div style=" height: 50%; width: 100%; text-align: center;padding-top: 10%;font-size: 2em;position:relative">
                    照度
                </div>
                <div style=" height: 50%; text-align: center;padding-top: 10%;font-size: 1.6em;position:relative">
                    <span id="zdvalue">0</span> lux
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
                    <td><input id="fs_l_comaddr" name="l_comaddr" class="easyui-combobox"  style=" height: 30px; width: 120px;"  data-options="editable:true,valueField:'id', textField:'text' " /></td>
                    <td><input id="fs_sensor"  class="easyui-combobox"  style=" height: 30px;width: 120px" data-options="editable:true,valueField:'id', textField:'text' " /></td>
                </tr>
                <tr>
                    <td>雨量</td>
                    <td><input id="yl_l_comaddr" name="l_comaddr" class="easyui-combobox"  style=" height: 30px; width: 120px"  data-options="editable:true,valueField:'id', textField:'text' " /></td>
                    <td><input id="yl_sensor" class="easyui-combobox"  style=" height: 30px;width: 120px"  data-options="editable:true,valueField:'id', textField:'text' " /></td>
                </tr>
                <tr>
                    <td>雨量累计</td>
                    <td><input id="yllj_l_comaddr" name="l_comaddr" class="easyui-combobox"  style=" height: 30px;width: 120px" data-options="editable:true,valueField:'id', textField:'text' " /></td>
                    <td><input id="yllj_sensor"  class="easyui-combobox"  style=" height: 30px;width: 120px"  data-options="editable:true,valueField:'id', textField:'text' " /></td>
                </tr>
                <tr>
                    <td>土壤温度</td>
                    <td><input id="trwd_l_comaddr" name="l_comaddr" class="easyui-combobox"  style=" height: 30px;width: 120px"  data-options="editable:true,valueField:'id', textField:'text' " /></td>
                    <td><input id="trwd_sensor"  class="easyui-combobox"  style=" height: 30px;width: 120px" data-options="editable:true,valueField:'id', textField:'text' " /></td>
                </tr>
                <tr>
                    <td>大气温度</td>
                    <td><input id="dqwd_l_comaddr" name="l_comaddr" class="easyui-combobox"  style=" height: 30px;width: 120px"  data-options="editable:true,valueField:'id', textField:'text' " /></td>
                    <td><input id="dqwd_sensor"  class="easyui-combobox"  style=" height: 30px;width: 120px"  data-options="editable:true,valueField:'id', textField:'text' " /></td>
                </tr>
                <tr>
                    <td>土壤湿度</td>
                    <td><input id="trsd_l_comaddr" name="l_comaddr" class="easyui-combobox"  style=" height: 30px;width: 120px"  data-options="editable:true,valueField:'id', textField:'text' " /></td>
                    <td><input id="trsd_sensor"  class="easyui-combobox"  style=" height: 30px;width: 120px"  data-options="editable:true,valueField:'id', textField:'text' " /></td>
                </tr>
                <tr>
                    <td>大气湿度</td>
                    <td><input id="dqsd_l_comaddr" name="l_comaddr" class="easyui-combobox"  style=" height: 30px;width: 120px"  data-options="editable:true,valueField:'id', textField:'text' " /></td>
                    <td><input id="dqsd_sensor"  class="easyui-combobox"  style=" height: 30px;width: 120px"  data-options="editable:true,valueField:'id', textField:'text' " /></td>
                </tr>
                <tr>
                    <td>风向</td>
                    <td><input id="fx_l_comaddr" name="l_comaddr" class="easyui-combobox"  style=" height: 30px;width: 120px"  data-options="editable:true,valueField:'id', textField:'text' " /></td>
                    <td><input id="fx_sensor"  class="easyui-combobox"  style=" height: 30px;width: 120px"  data-options="editable:true,valueField:'id', textField:'text' " /></td>
                </tr>
                <tr>
                    <td>照度</td>
                    <td><input id="zd_l_comaddr" name="l_comaddr" class="easyui-combobox"  style=" height: 30px;width: 120px"  data-options="editable:true,valueField:'id', textField:'text' " /></td>
                    <td><input id="zd_sensor"  class="easyui-combobox"  style=" height: 30px;width: 120px"  data-options="editable:true,valueField:'id', textField:'text' " /></td>
                </tr>


            </table>
        </div>
    </body>

    <script>
        var withs;
        var uname = parent.parent.getusername();
        var pid = parent.parent.getpojectId();
        function layerAler(str) {
            layer.alert(str, {
                icon: 6,
                offset: 'center'
            });
        }

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
                editable: false,
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
                        editable: false,
                        url: "homePage.sign.gettr_sdsensroList.action?s_identify=" + l_comaddr,
                        loadFilter: function (data) {
                            var obj = {};
                            obj.id = '';
                            obj.text = '-请选择-';
                            data.splice(0, 0, obj);//在数组0位置插入obj,不删除原来的元素
                            return  data;
                        },
                        onLoadSuccess: function (data) {
                            if (data.length > 0) {
                                if ($("#trsdsen").val() != "" && $("#trsdcom").val() == l_comaddr) {
                                    $(this).combobox('select', $("#trsdsen").val());
                                } else {
                                    // $(this).combobox('select', data[0].id);
                                }

                            }
                        }
                    });
                }
            });
            //大气温度
            $("#dqwd_l_comaddr").combobox({
                editable: false,
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
                        editable: false,
                        url: "homePage.sign.get_wdsensroList.action?s_identify=" + l_comaddr,
                        loadFilter: function (data) {
                            var obj = {};
                            obj.id = '';
                            obj.text = '-请选择-';
                            data.splice(0, 0, obj);//在数组0位置插入obj,不删除原来的元素
                            return  data;
                        },
                        onLoadSuccess: function (data) {
                            if (data.length > 0) {
                                if ($("#dqwdsen").val() != "" && $("#dqwdcom").val() == l_comaddr) {
                                    $(this).combobox('select', $("#dqwdsen").val());
                                }

                            }
                        }
                    });
                }
            });
            //风速
            $("#fs_l_comaddr").combobox({
                editable: false,
                url: "homePage.gayway.getComaddr.action?pid=${param.pid}",
                onLoadSuccess: function (data) {
                    //$(this).combobox('select', data[0].id);
                    if ($("#fscom").val() != "") {
                        $(this).combobox('select', $("#fscom").val());
                    } else {
                        $(this).combobox('select', data[0].id);
                    }
                },
                onSelect: function (record) {
                    var l_comaddr = record.id;
                    //风速传感器
                    $("#fs_sensor").combobox({
                        editable: false,
                        url: "homePage.sign.get_fssensroList.action?s_identify=" + l_comaddr,
                        loadFilter: function (data) {
                            var obj = {};
                            obj.id = '';
                            obj.text = '-请选择-';
                            data.splice(0, 0, obj);//在数组0位置插入obj,不删除原来的元素
                            return  data;
                        },
                        onLoadSuccess: function (data) {
                            if (data.length > 0) {
                                if ($("#fssen").val() != "" && $("#fscom").val() == l_comaddr) {
                                    $(this).combobox('select', $("#fssen").val());
                                }

                                //$(this).combobox('select', data[0].id);
                            }
                        }
                    });
                }
            });
            //雨量
            $("#yl_l_comaddr").combobox({
                editable: false,
                url: "homePage.gayway.getComaddr.action?pid=${param.pid}",
                onLoadSuccess: function (data) {
                    //$(this).combobox('select', data[0].id);
                    if ($("#ylcom").val() != "") {
                        $(this).combobox('select', $("#ylcom").val());
                    } else {
                        $(this).combobox('select', data[0].id);
                    }
                },
                onSelect: function (record) {
                    var l_comaddr = record.id;
                    //雨量传感器
                    $("#yl_sensor").combobox({
                        editable: false,
                        url: "homePage.sign.gesensroList.action?s_identify=" + l_comaddr,
                        loadFilter: function (data) {
                            var obj = {};
                            obj.id = '';
                            obj.text = '-请选择-';
                            data.splice(0, 0, obj);//在数组0位置插入obj,不删除原来的元素
                            return  data;
                        },
                        onLoadSuccess: function (data) {
                            if (data.length > 0) {
                                //$(this).combobox('select', data[0].id);
                                if ($("#ylsen").val() != "" && $("#ylcom").val() == l_comaddr) {
                                    $(this).combobox('select', $("#ylsen").val());
                                }
                            }
                        }
                    });
                }
            });
            //雨量累计
            $("#yllj_l_comaddr").combobox({
                editable: false,
                url: "homePage.gayway.getComaddr.action?pid=${param.pid}",
                onLoadSuccess: function (data) {
                    // $(this).combobox('select', data[0].id);
                    if ($("#ylljcom").val() != "") {
                        $(this).combobox('select', $("#ylljcom").val());
                    } else {
                        $(this).combobox('select', data[0].id);
                    }
                },
                onSelect: function (record) {
                    var l_comaddr = record.id;
                    $("#yllj_sensor").combobox({
                        editable: false,
                        url: "homePage.sign.gesensroList.action?s_identify=" + l_comaddr,
                        loadFilter: function (data) {
                            var obj = {};
                            obj.id = '';
                            obj.text = '-请选择-';
                            data.splice(0, 0, obj);//在数组0位置插入obj,不删除原来的元素
                            return  data;
                        },
                        onLoadSuccess: function (data) {
                            if (data.length > 0) {
                                //$(this).combobox('select', data[0].id);
                                if ($("#ylljsen").val() != "" && $("#ylljcom").val() == l_comaddr) {
                                    $(this).combobox('select', $("#ylljsen").val());
                                }
                            }
                        }
                    });
                }
            });
            //土壤温度
            $("#trwd_l_comaddr").combobox({
                editable: false,
                url: "homePage.gayway.getComaddr.action?pid=${param.pid}",
                onLoadSuccess: function (data) {
                    // $(this).combobox('select', data[0].id);
                    if ($("#trwdcom").val() != "") {
                        $(this).combobox('select', $("#trwdcom").val());
                    } else {
                        $(this).combobox('select', data[0].id);
                    }
                },
                onSelect: function (record) {
                    var l_comaddr = record.id;
                    $("#trwd_sensor").combobox({
                        editable: false,
                        url: "homePage.sign.get_wdsensroList.action?s_identify=" + l_comaddr,
                        loadFilter: function (data) {
                            var obj = {};
                            obj.id = '';
                            obj.text = '-请选择-';
                            data.splice(0, 0, obj);//在数组0位置插入obj,不删除原来的元素
                            return  data;
                        },
                        onLoadSuccess: function (data) {
                            if (data.length > 0) {
                                //$(this).combobox('select', data[0].id);
                                if ($("#trwdsen").val() != "" && $("#trwdcom").val() == l_comaddr) {
                                    $(this).combobox('select', $("#trwdsen").val());
                                }
                            }
                        }
                    });
                }
            });
            //大气湿度
            $("#dqsd_l_comaddr").combobox({
                editable: false,
                url: "homePage.gayway.getComaddr.action?pid=${param.pid}",
                onLoadSuccess: function (data) {
                    //$(this).combobox('select', data[0].id);
                    if ($("#dqsdcom").val() != "") {
                        $(this).combobox('select', $("#dqsdcom").val());
                    } else {
                        $(this).combobox('select', data[0].id);
                    }
                },
                onSelect: function (record) {
                    var l_comaddr = record.id;
                    $("#dqsd_sensor").combobox({
                        editable: false,
                        url: "homePage.sign.gettr_sdsensroList.action?s_identify=" + l_comaddr,
                        loadFilter: function (data) {
                            var obj = {};
                            obj.id = '';
                            obj.text = '-请选择-';
                            data.splice(0, 0, obj);//在数组0位置插入obj,不删除原来的元素
                            return  data;
                        },
                        onLoadSuccess: function (data) {
//                            var obj = {};
//                            obj.id = '';
//                            obj.text = '-请选择-';
//                            data.splice(0, 0, obj);//在数组0位置插入obj,不删除原来的元素
                            if (data.length > 0) {
                                // $(this).combobox('select', data[0].id);
                                if ($("#dqsdsen").val() != "" && $("#dqsdcom").val() == l_comaddr) {
                                    $(this).combobox('select', $("#dqsdsen").val());
                                }
                            }
                        }
                    });
                }
            });
            //风向
            $("#fx_l_comaddr").combobox({
                editable: false,
                url: "homePage.gayway.getComaddr.action?pid=${param.pid}",
                onLoadSuccess: function (data) {
                    // $(this).combobox('select', data[0].id);
                    if ($("#fxcom").val() != "") {
                        $(this).combobox('select', $("#fxcom").val());
                    } else {
                        $(this).combobox('select', data[0].id);
                    }
                },
                onSelect: function (record) {
                    var l_comaddr = record.id;
                    $("#fx_sensor").combobox({
                        editable: false,
                        url: "homePage.sign.get_fxsensroList.action?s_identify=" + l_comaddr,
                        loadFilter: function (data) {
                            var obj = {};
                            obj.id = '';
                            obj.text = '-请选择-';
                            data.splice(0, 0, obj);//在数组0位置插入obj,不删除原来的元素
                            return  data;
                        },
                        onLoadSuccess: function (data) {
                            if (data.length > 0) {
                                // $(this).combobox('select', data[0].id);
                                if ($("#fxsen").val() != "" && $("#fxcom").val() == l_comaddr) {
                                    $(this).combobox('select', $("#fxsen").val());
                                }
                            }
                        }
                    });
                }
            });
            //照度
            $("#zd_l_comaddr").combobox({
                editable: false,
                url: "homePage.gayway.getComaddr.action?pid=${param.pid}",
                onLoadSuccess: function (data) {
                    // $(this).combobox('select', data[0].id);
                    if ($("#zdcom").val() != "") {
                        $(this).combobox('select', $("#zdcom").val());
                    } else {
                        $(this).combobox('select', data[0].id);
                    }
                },
                onSelect: function (record) {
                    var l_comaddr = record.id;
                    $("#zd_sensor").combobox({
                        editable: false,
                        url: "homePage.sign.get_zdsensroList.action?s_identify=" + l_comaddr,
                        loadFilter: function (data) {
                            var obj = {};
                            obj.id = '';
                            obj.text = '-请选择-';
                            data.splice(0, 0, obj);//在数组0位置插入obj,不删除原来的元素
                            return  data;
                        },
                        onLoadSuccess: function (data) {
                            if (data.length > 0) {
                                // $(this).combobox('select', data[0].id);
                                if ($("#zdsen").val() != "" && $("#zdcom").val() == l_comaddr) {
                                    $(this).combobox('select', $("#zdsen").val());
                                }
                            }
                        }
                    });
                }
            });
            $('#faultDiv').dialog('open');
        }
        //修改气象站
        function update() {

            var fsid = $("#fs_sensor").val();  //风速传感器id
            var yl = $("#yl_sensor").val();   //雨量id;
            var yllj = $("#yllj_sensor").val(); //雨量累计
            var trwd = $("#trwd_sensor").val(); //土壤温度id;
            var trsd = $("#trsd_sensor").val(); //土壤湿度id
            var dqwd = $("#dqwd_sensor").val();  //大气温度
            var dqsd = $("#dqsd_sensor").val();  //大气湿度
            var fx = $("#fx_sensor").val();  //风向
            var zd = $("#zd_sensor").val(); //照度
            var obj = {};
            obj.pid = pid;

            if (fsid != "") {
                obj.id = fsid;
                $.ajax({url: "homePage.sign.fs_show.action", async: false, type: "get", datatype: "JSON", data: obj,
                    success: function (data) {
                        var rs1 = data.rs1;
                    },
                    error: function () {
                        alert("提交添加失败1！");
                    }
                });
            } else {
                $.ajax({url: "homePage.sign.fs_noshow.action", async: false, type: "get", datatype: "JSON", data: obj,
                    success: function (data) {
                        var rs1 = data.rs1;
                    },
                    error: function () {
                        alert("提交添加失败2！");
                    }
                });
            }
            //土壤温度
            if (trwd != "") {
                obj.id = trwd;
                $.ajax({url: "homePage.sign.trwd_show.action", async: false, type: "get", datatype: "JSON", data: obj,
                    success: function (data) {
                        var rs1 = data.rs1;
                    },
                    error: function () {
                        alert("提交添加失败1！");
                    }
                });
            } else {
                $.ajax({url: "homePage.sign.trwd_noshow.action", async: false, type: "get", datatype: "JSON", data: obj,
                    success: function (data) {
                        var rs1 = data.rs1;
                    },
                    error: function () {
                        alert("提交添加失败2！");
                    }
                });
            }
            //土壤湿度
            if (trsd != "") {
                obj.id = trsd;
                $.ajax({url: "homePage.sign.trsd_show.action", async: false, type: "get", datatype: "JSON", data: obj,
                    success: function (data) {
                        var rs1 = data.rs1;
                    },
                    error: function () {
                        alert("提交添加失败1！");
                    }
                });
            } else {
                $.ajax({url: "homePage.sign.trsd_noshow.action", async: false, type: "get", datatype: "JSON", data: obj,
                    success: function (data) {
                        var rs1 = data.rs1;
                    },
                    error: function () {
                        alert("提交添加失败2！");
                    }
                });
            }
            //大气温度
            if (dqwd == "") {
                $.ajax({url: "homePage.sign.dqwd_noshow.action", async: false, type: "get", datatype: "JSON", data: obj,
                    success: function (data) {
                        var rs1 = data.rs1;
                    },
                    error: function () {
                        alert("提交添加失败2！");
                    }
                });

            } else {
                obj.id = dqwd;
                $.ajax({url: "homePage.sign.dqwd_show.action", async: false, type: "get", datatype: "JSON", data: obj,
                    success: function (data) {
                        var rs1 = data.rs1;
                    },
                    error: function () {
                        alert("提交添加失败！");
                    }
                });
            }
            //大气湿度
            if (dqsd == "") {
                $.ajax({url: "homePage.sign.dqsd_noshow.action", async: false, type: "get", datatype: "JSON", data: obj,
                    success: function (data) {
                        var rs1 = data.rs1;
                    },
                    error: function () {
                        alert("提交添加失败2！");
                    }
                });

            } else {
                obj.id = dqsd;
                $.ajax({url: "homePage.sign.dqsd_show.action", async: false, type: "get", datatype: "JSON", data: obj,
                    success: function (data) {
                        var rs1 = data.rs1;
                    },
                    error: function () {
                        alert("提交添加失败！");
                    }
                });
            }
            //风向
            if (fx == "") {
                $.ajax({url: "homePage.sign.fx_noshow.action", async: false, type: "get", datatype: "JSON", data: obj,
                    success: function (data) {
                        var rs1 = data.rs1;
                    },
                    error: function () {
                        alert("提交添加失败2！");
                    }
                });

            } else {
                obj.id = fx;
                $.ajax({url: "homePage.sign.fx_show.action", async: false, type: "get", datatype: "JSON", data: obj,
                    success: function (data) {
                        var rs1 = data.rs1;
                    },
                    error: function () {
                        alert("提交添加失败！");
                    }
                });
            }
            //照度
            if (zd == "") {
                $.ajax({url: "homePage.sign.zd_noshow.action", async: false, type: "get", datatype: "JSON", data: obj,
                    success: function (data) {
                        var rs1 = data.rs1;
                    },
                    error: function () {
                        alert("提交添加失败2！");
                    }
                });

            } else {
                obj.id = zd;
                $.ajax({url: "homePage.sign.zd_show.action", async: false, type: "get", datatype: "JSON", data: obj,
                    success: function (data) {
                        var rs1 = data.rs1;
                    },
                    error: function () {
                        alert("提交添加失败！");
                    }
                });
            }
            addlogon(uname, "修改", pid, "气象台", "修改气象台传感器");
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
                    if (rs.length > 0) {
                        for (var i = 0; i < rs.length; i++) {
                            var rsv = rs[i];
                            if (rsv.show == 1) {
                                //风速
                                $("#fscom").val(rsv.s_identify);
                                $("#fssen").val(rsv.id);
                                if (parseInt(rsv.numvalue) > 0) {
                                    var value = parseInt(rsv.numvalue) / 10;
                                    $("#fsvalue").html(value);
                                }

                            } else if (rsv.show == 2) {
                                //雨量
                                $("#ylcom").val(rsv.s_identify);
                                $("#ylsen").val(rsv.id);
                                if (parseInt(rsv.numvalue) > 0) {
                                    var value = parseInt(rsv.numvalue) / 10;
                                    $("#ylvalue").html(value);
                                }

                            } else if (rsv.show == 3) {
                                //雨量累计
                                $("#ylljcom").val(rsv.s_identify);
                                $("#ylljsen").val(rsv.id);
                                if (parseInt(rsv.numvalue) > 0) {
                                    var value = parseInt(rsv.numvalue) / 10;
                                    $("#ylljvalue").html(value);
                                }

                            } else if (rsv.show == 4) {
                                //土壤温度
                                $("#trwdcom").val(rsv.s_identify);
                                $("#trwdsen").val(rsv.id);
                                if (parseInt(rsv.numvalue) > 0) {
                                    var value = parseInt(rsv.numvalue) / 10;
                                    $("#trwdvalue").html(value);
                                }

                            } else if (rsv.show == 5) {
                                //土壤湿度
                                $("#trsdcom").val(rsv.s_identify);
                                $("#trsdsen").val(rsv.id);
                                if (parseInt(rsv.numvalue) > 0) {
                                    var value = parseInt(rsv.numvalue) / 10;
                                    $("#trsd").html(value);
                                }
                            } else if (rsv.show == 6) {
                                //大气温度
                                $("#dqwdcom").val(rsv.s_identify);
                                $("#dqwdsen").val(rsv.id);
                                if (parseInt(rsv.numvalue) > 0) {
                                    var value = parseInt(rsv.numvalue) / 10;
                                    $("#dqwd").html(value);
                                }

                            } else if (rsv.show == 7) {
                                //大气湿度
                                $("#dqsdcom").val(rsv.s_identify);
                                $("#dqsdsen").val(rsv.id);
                                if (parseInt(rsv.numvalue) > 0) {
                                    var value = parseInt(rsv.numvalue) / 10;
                                    $("#dqsdvalue").html(value);
                                }

                            } else if (rsv.show == 8) {
                                //风向
                                $("#fxcom").val(rsv.s_identify);
                                $("#fxsen").val(rsv.id);
                                var v1 = parseFloat(rsv.numvalue);
                                 $("#fxvalue").html(getDirection(v1));
//                                if (parseInt(rsv.numvalue) > 0) {
//                                    var value = parseInt(rsv.numvalue);
//                                    $("#fxvalue").html(value);
//                                }

                            } else if (rsv.show == 9) {
                                //照度
                                $("#zdcom").val(rsv.s_identify);
                                $("#zdsen").val(rsv.id);
                                if (parseInt(rsv.numvalue) > 0) {
                                    var value = parseInt(rsv.numvalue) / 10;
                                    $("#zdvalue").html(value);
                                }

                            }
                        }
                    }
                },
                error: function () {
                    alert("提交添加失败！");
                }
            });
        }

        function getDirection(val)
        {
            console.log(val);
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
            console.log(str);
            return  str;
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
