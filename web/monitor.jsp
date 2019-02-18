<%-- 
    Document   : deplayment
    Created on : 2018-7-4, 15:32:48
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>     
        <%@include  file="js.jspf" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            .btn { margin-left: 10px;}
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
        <script type="text/javascript" src="js/genel.js"></script>
        <script type="text/javascript"  src="js/getdate.js"></script>
        <script>
            var u_name = "${param.name}";
            var o_pid = "${param.pid}";
            function layerAler(str) {
                layer.alert(str, {
                    icon: 6,
                    offset: '5px'
                });
            }

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
                            readSensor(obj.comaddr, obj.val, obj.param);
                        }

                    }

                }
            }

            function  dealfault() {
                var selects = $("#gravidaTable").bootstrapTable('getSelections');
                if (selects.length == 0) {
                    layerAler("请勾选表格");

                }

                var comaddr = $("#l_comaddr").combobox('getValue');
                var ele = selects[0];

                if (ele.errflag == "1") {
                    var vv = [];
                    vv.push(1);
                    vv.push(0x10);
                    var info = parseInt(ele.infonum);
                    var infonum = (2000 + info * 10 + 6) | 0x1000;
                    vv.push(infonum >> 8 & 0xff);
                    vv.push(infonum & 0xff);
                    vv.push(0);
                    vv.push(1); //寄存器数目 2字节     
                    vv.push(2); //字节数目（寄存器数目*2）
                    vv.push(0); //控制数据值高字节
                    vv.push(0); //控制数据值低字节
                    var data = buicode2(vv);
                    console.log(data);

                    $('#panemask').showLoading({
                        'afterShow': function () {
                            setTimeout("$('#panemask').hideLoading()", 60000);
                        }
                    }
                    );

                    dealsend2("10", data, "dealfaultCB", comaddr, 0, ele.id, info, "${param.action}");
                    addlogon(u_name, "处理故障", o_pid, "传感器监视", "处理【" + ele.name + "】", ele.s_identify);
                } else {
                    layerAler("请处理有故障的传感器");
                }
            }

            function  readSensorCB(obj) {

                $('#panemask').hideLoading();
                if (obj.status == "success") {
                    var data = Str2BytesH(obj.data);
                    var v = "";
                    for (var i = 0; i < data.length; i++) {
                        v = v + sprintf("%02x", data[i]) + " ";
                    }
                    console.log(v);
                    
                    if (data[1] == 0x03) {
                        layerAler("读取成功");
                        var len = data[2];
                        var info = data[3] * 256 + data[4];
                        var site = data[5] * 256 + data[6];
                        var regpos = data[7] * 256 + data[8];
                        var w1 = data[9];
                        var w2 = data[10];
                        var strw1 = w1 & 0x01 == 0x01 ? "开关量" : "模拟量";
                        var strw2 = w2 & 0x01 == 0x01 ? "打开" : "关闭";
                        ; //                        var worktype = data[9] * 256 + data[10];
                        var dataval = data[11] * 256 + data[12];
                        var f1 = data[13] * 256 + data[14];            //故障设置标志
                        var strw3 = f1 & 0x01 == 0x01 ? "开" : "关";

                        var fault = data[15] * 256 + data[16];        //故障出错标志
                        var faulttip = fault == 1 ? "有" : "无";
                        var faultnum = data[17] * 256 + data[18];        //故障出错次数

                        layerAler("信息点:" + info + "<br>" + "站号:" + site + "<br>" + "数据位置："
                                + regpos + "<br>" + "工作模式:" + strw1 + "<br>" + "通信故障参数:"
                                + strw3 + "<br>" + "探测值：" + dataval + "<br>" + "是否有故障:" + faulttip + "<br>"
                                + "通信故障出错次数:" + faultnum);

                        var o = {errflag: fault, errcount: faultnum, numvalue: dataval, id: obj.param};
                        $.ajax({async: false, url: "sensor.sensorform.upvalue.action", type: "get", datatype: "JSON", data: o,
                            success: function (data) {
                                var arrlist = data.rs;
                                if (arrlist.length == 1) {
                                    var obj = {};
                                    obj.l_comaddr = obj.comaddr;
                                    obj.pid = "${param.pid}";
                                    var opt = {
                                        url: "monitor.monitorForm.getSensorList.action",
                                        silent: true,
                                        query: obj
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
                console.log(obj);
            }

            function readSensor(comaddr, infonum, id) {
                console.log(id);
                var vv = [];
                vv.push(1);
                vv.push(3);
                var info = parseInt(infonum);
                var infonum = (2000 + info * 10) | 0x1000;
                vv.push(infonum >> 8 & 0xff);
                vv.push(infonum & 0xff);
                vv.push(0);
                vv.push(8); //寄存器数目 2字节                         
                var data = buicode2(vv);
                $('#panemask').showLoading({
                    'afterShow': function () {
                        setTimeout("$('#panemask').hideLoading()", 10000);
                    }
                }
                );
                dealsend2("03", data, "readSensorCB", comaddr, 0, id, infonum, "${param.action}");
            }

            function tourSensor() {
                var comaddr = $("#l_comaddr").combobox('getValue');
                if(comaddr == ""){
                    layerAler("请选择网关");
                    return ;
                }
               
                var vv = [];
                dealsend2("sensor", "00", "sensorCB", comaddr, 0, 0, 0);
            }

            function getDirection(val) {
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


            $(function () {
                $('#gravidaTable').bootstrapTable({
                    // showExport: true, //是否显示导出
                    exportDataType: "basic", //basic', 'a
                    //url: "loop.loopForm.getLoopList.action",
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
                            //field: 'Number',//可不加  
                            title: '序号', //标题  可不加  
                            align: "center",
                            width: "132px",
                            visible: false,
                            formatter: function (value, row, index) {
                                row.index = index;
                                return index + 1;
                            }
                        },
                        {
                            field: 'commname',
                            title: '网关名称',
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        },


                        {
                            field: 'name',
                            title: '名称',
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            field: 'numvalue',
                            title: '数值',
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            formatter: function (value, row, index, field) {
                                if (row.type == 3) {
                                    if (value == 0) {
                                        return "关";
                                    } else {
                                        return "开";
                                    }
                                } else if (row.type == 5) {


                                    var v1 = parseFloat(value);
                                    var fx = getDirection(v1);
                                    //if(v1>=337.5&&v1<=360)
                                    return fx;
                                } else {
                                    return value / 10;
                                }
                            }
                        }, {
                            field: 'unit1',
                            title: '单位',
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            formatter: function (value, row, index, field) {
                                if (row.type == null) {
                                    return value;
                                }

                                if (row.type == "1") {
                                    return  "℃";
                                } else if (row.type == "2") {
                                    return  "%RH";
                                } else if (row.type == 3) {
                                    return  "开/关";
                                } else if (row.type == 4) {
                                    return  "m/s";
                                } else if (row.type == 5) {
                                    return  "方位";
                                } else if (row.type == 6) {
                                    return  "Lux";
                                }
                            }
                        }, {
                            field: 'onlinetime',
                            title: '运行状态',
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            formatter: function (value, row, index, field) {
                                var str = value;
                                if (row.online == "1") {
                                    if (row.errflag == "1") {
                                        var str = '<img   src="img/fault.png" onclick="readSensor(\'' + row.comaddr + '\',\'' + row.infonum + '\',\'' + row.id + '\'' + ')"/>';
                                        return  str;
                                    } else {
                                        var str = '<img   src="img/online1.png" onclick="readSensor(\'' + row.comaddr + '\',\'' + row.infonum + '\',\'' + row.id + '\'' + ')"/>';
                                        return  str;
                                    }
                                } else {
                                    var str = '<img   src="img/off.png" onclick="readSensor(\'' + row.comaddr + '\',\'' + row.infonum + '\',\'' + row.id + '\'' + ')"/>';
                                    return  str;
                                }
                                return  str;
                            }
                        }],
                    clickToSelect: false,
                    singleSelect: true,
                    search: true,
                    locale: 'zh-CN', //中文支持,
                    sortOrder: 'desc',
                    pagination: true,
                    sidePagination: 'server',
                    pageNumber: 1,
                    pageSize: 50,
                    showRefresh: true,
                    showToggle: true,
                    showColumns: true,
                    // 设置默认分页为 50
                    pageList: [50, 100, 150, 200, 250],
                    onLoadSuccess: function () {  //加载成功时执行  表格加载完成时 获取集中器在线状态
//                        console.info("加载成功");
                    },
                    //服务器url
                    queryParams: function (params)  {   //配置参数 
                        var search = encodeURI(params.search);
                        var temp  =   {    //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的 
                            search: search,
                            skip: params.offset,
                            limit: params.limit,
                            type_id: "1",
                            pid: "${param.pid}",
                            identify: $("#identify").val()

                        };      
                        return temp;  
                    }
                });

                $.ajax({async: false, url: "gayway.GaywayForm.getComaddr.action?pid=${param.pid}", type: "get", datatype: "JSON", data: {},
                    success: function (data) {
                        console.log(data);
                        if (data.length > 0) {
                            var ooo = {id: "", text: "----全部----", name: "--全部--"};
                            data.splice(0, 0, ooo);

                            $("#l_comaddr").combobox({
                                // url: "gayway.GaywayForm.getComaddr.action?pid=${param.pid}",
                                data: data,
                                formatter: function (row) {
                                    var v1 = row.online == 1 ? "&nbsp;<img src='img/online1.png'>" : "&nbsp;<img src='img/off.png'>";
                                    var v = row.text.indexOf("全部") >= 0 ? row.text : row.text + v1;

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
                                    var l_comaddr = record.id;

                                    $("#identify").val(record.identify);
                                    var obj = {};
                                    obj.identify = record.identify;
                                    obj.pid = "${param.pid}";
                                    obj.deplayment = 1;
                                    var opt = {
                                        url: "monitor.monitorForm.getSensorList.action",
                                        query: obj,
                                        silent: false
                                    };
                                    $("#gravidaTable").bootstrapTable('refresh', opt);
                                }
                            });

                        }
                    },
                    error: function () {
                        alert("提交失败！");
                    }
                });






            });
            //定时刷新数据
            //setInterval('getcominfo()', 6000);
            function  getcominfo() {
                var selects = $('#gayway').bootstrapTable('getSelections');
                var l_comaddr = selects[0].comaddr;
                var obj = {};
                obj.l_comaddr = l_comaddr;
                obj.pid = "${param.pid}";
                var opt = {
                    url: "monitor.monitorForm.getSensorList.action",
                    silent: true,
                    query: obj
                };
                $("#gravidaTable").bootstrapTable('refresh', opt);
            }


        </script>
    </head>
    <body id="panemask">
        <div>
            <div  style=" width: 100% ; margin-top: 10px;" >
                <span style=" margin-left:1%;">网关名称:</span>
                <input type="hidden" name="identify" id="identify" value=""/>
                <input id="l_comaddr" class="easyui-combobox" name="l_comaddr" style="width:120px; height: 30px" 
                       data-options="editable:true,valueField:'id', textField:'text' ">



                <button type="button" id="btnswitch" onclick="tourSensor()" class="btn btn-success btn-sm">
                    巡测数据
                </button>
                <button type="button" id="btnswitch" onclick="dealfault()" class="btn btn-success btn-sm">
                    处理故障
                </button>

            </div>   
            <div  style=" width: 100%;">

                <table id="gravidaTable" style="width:100%;" class="text-nowrap table table-hover table-striped">
                </table>
            </div>
        </div>



    </body>
</html>
