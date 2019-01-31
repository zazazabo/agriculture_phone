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
        </style>
        <script type="text/javascript" src="js/genel.js"></script>
        <script type="text/javascript"  src="js/getdate.js"></script>
        <script>
            var u_name = "${param.name}";
            var o_pid = "${param.pid}";
            var infolist = {};
            var infoscene = {};
            function layerAler(str) {
                layer.alert(str, {
                    icon: 6,
                    offset: 'center'
                });
            }

            $(function () {
                $('#gravidaTable').bootstrapTable({
//                    showExport: true, //是否显示导出
                    exportDataType: "basic", //basic', 'a
                    //url: "loop.loopForm.getLoopList.action",
                    columns: [
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
                            title: '单选',
                            field: 'select',
                            //复选框
                            checkbox: true,
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        },
                        {
                            field: 'l_name',
                            title: '回路名称', //
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        },
                        {
                            field: 'l_worktype',
                            title: '工作模式', //合闸参数
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            formatter: function (value, row, index, field) {
                                var type = parseInt(value);
                                console.log(type);
                                var str = "";
                                if (type >> 1 & 0x1 == 1) {
                                    return "时间";
                                } else if (type >> 2 & 0x1 == 1) {
                                    return '场景';
                                } else if (type >> 3 & 0x1 == 1) {
                                    return '信息点';
                                } else {
                                    return  str;
                                }
                            }
                        }, {
                            field: 'l_plan',
                            title: '工作方案', //
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            formatter: function (value, row, index, field) {
                                var p_comaddr = row.l_comaddr;   //网关
                                var type = parseInt(row.l_worktype);
                                var str = "";
                                if (type >> 1 & 0x1 == 1) {
                                    var strtime = "";
                                    for (var i = 0; i < 5; i++) {
                                        var index = "l_val" + (i + 1).toString();
                                        var strobj = row[index];
                                        if (isJSON(strobj)) {
                                            var obj = eval('(' + strobj + ')');
                                            var s1 = obj.value == 1 ? "闭合" : "断开";
                                            strtime = strtime + obj.time + ":" + s1 + "&emsp;";
                                        }

                                    }
                                    return strtime;
                                } else if (type >> 2 & 0x1 == 1) {

                                    var strret = "";
                                    for (var i = 0; i < 5; i++) {
                                        var index = "l_val" + (i + 1).toString();
                                        var strobj = row[index];
                                        if (isJSON(strobj)) {
                                            var obj = eval('(' + strobj + ')');
                                            var scenename = infoscene[obj.scene.toString()];
                                            var s1 = obj.value == 1 ? "闭合" : "断开";
                                            strret = strret + scenename + ":" + s1 + "&emsp;";
                                        }
                                    }
                                    return  strret;
                                } else if (type >> 3 & 0x1 == 1) {

                                    var strret = "";
                                    for (var i = 0; i < 5; i++) {
                                        var index = "l_val" + (i + 1).toString();
                                        var strobj = row[index];
                                        if (isJSON(strobj)) {
                                            var obj = eval('(' + strobj + ')');
                                            if (i == 0) {
                                                strret = strret + infolist[obj.infonum.toString()] + "&emsp;偏差值:" + obj.offset + "&emsp;";
                                            } else
                                            {
                                                var s1 = obj.value == 1 ? "闭合" : "断开";
                                                strret = strret + obj.info + ":" + s1 + "&emsp;";
                                            }

                                        }
                                    }
                                    return  strret;
                                } else {
                                    return  str;
                                }
                                return value;
                            }
                        }, {
                            field: 'l_switch',
                            title: '状态', //
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
                        }
                    ],
                    clickToSelect: true,
                    searchAlign: 'right',
                    singleSelect: true,
                    search: true,
                    locale: 'zh-CN', //中文支持,
                    sortOrder: 'desc',
                    pagination: true,
                    sidePagination: 'server',
                    pageNumber: 1,
                    pageSize: 20,
                    showRefresh: true,
                    showColumns: true,
                    showToggle: true,
                    // 设置默认分页为 50
                    pageList: [20, 40, 80, 160, 320],
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
                    },
                });



                $.ajax({async: false, url: "gayway.GaywayForm.getComaddr.action?pid=${param.pid}", type: "get", datatype: "JSON", data: {},
                    success: function (data) {
                        if (data.length > 0) {
                            var ooo = {id: "", text: "--全部--", name: "--全部--"};
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
                                    $("#identify").val(record.identify);
                                    var l_comaddr = record.id;
                                    var vv = [];
                                    dealsend2("loop", "00", "loopcb", l_comaddr, 0, 0, 0, "${param.action}");

                                    var obj = {};
                                    obj.identify = record.identify;
                                    obj.pid = "${param.pid}";
                                    $.ajax({async: false, url: "sensor.sensorform.getInfoNumList2.action", type: "get", datatype: "JSON", data: obj,
                                        success: function (data) {
                                            for (var i = 0; i < data.length; i++) {
                                                var o = data[i];
                                                infolist[o.id] = o.text;
                                            }
                                        },
                                        error: function () {
                                            alert("提交失败！");
                                        }
                                    });


                                    $.ajax({async: false, url: "plan.planForm.getAllScennumName.action", type: "get", datatype: "JSON", data: obj,
                                        success: function (data) {
                                            for (var i = 0; i < data.length; i++) {
                                                var o = data[i];
                                                infoscene[o.id] = o.text;
                                            }
                                        },
                                        error: function () {
                                            alert("提交失败！");
                                        }
                                    });
                                    var opt = {
                                        url: "loop.loopForm.getLoopList.action",
                                        silent: false,
                                        query: obj
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




//
//                $("#l_comaddr").combobox({
//                    url: "gayway.GaywayForm.getComaddr.action?pid=${param.pid}",
//                    formatter: function (row) {
//                        var v1 = row.online == 1 ? "&nbsp;<img src='img/online1.png'>" : "&nbsp;<img src='img/off.png'>";
//                        var v = row.text + v1;
//                        row.id = row.id;
//                        row.text = v;
//                        var opts = $(this).combobox('options');
//                        return row[opts.textField];
//                    },
//                    onLoadSuccess: function (data) {
//                        if (Array.isArray(data) && data.length > 0) {
//                            for (var i = 0; i < data.length; i++) {
//                                data[i].text = data[i].name;
//                            }
//                            $(this).combobox('select', data[0].id);
//                        }
//
//                    },
//                    onSelect: function (record) {
//                        $("#identify").val(record.identify);
//                        var l_comaddr = record.id;
//                        var vv = [];
//                        dealsend2("loop", "00", "loopcb", l_comaddr, 0, 0, 0, "${param.action}");
//
//                        var obj = {};
//                        obj.identify = record.identify;
//                        obj.pid = "${param.pid}";
//                        $.ajax({async: false, url: "sensor.sensorform.getInfoNumList2.action", type: "get", datatype: "JSON", data: obj,
//                            success: function (data) {
//                                for (var i = 0; i < data.length; i++) {
//                                    var o = data[i];
//                                    infolist[o.id] = o.text;
//                                }
//                            },
//                            error: function () {
//                                alert("提交失败！");
//                            }
//                        });
//
//
//                        $.ajax({async: false, url: "plan.planForm.getAllScennumName.action", type: "get", datatype: "JSON", data: obj,
//                            success: function (data) {
//                                for (var i = 0; i < data.length; i++) {
//                                    var o = data[i];
//                                    infoscene[o.id] = o.text;
//                                }
//                            },
//                            error: function () {
//                                alert("提交失败！");
//                            }
//                        });
//
//
//
//                        var opt = {
//                            url: "loop.loopForm.getLoopList.action",
//                            silent: false,
//                            query: obj
//                        };
//                        $("#gravidaTable").bootstrapTable('refresh', opt);
//                    }
//                });
//                
//                






            });


            function switchloopCB(obj) {
                $('#panemask').hideLoading();
                if (obj.status == "success") {
                    var data = Str2BytesH(obj.data);
                    var v = "";
                    for (var i = 0; i < data.length; i++) {
                        v = v + sprintf("%02x", data[i]) + " ";
                    }
                    if (data[1] == 0x10) {
                        var infonum = (3000 + obj.val * 20 + 3) | 0x1000;
                        var high = infonum >> 8 & 0xff;
                        var low = infonum & 0xff;
                        if (data[2] == high && data[3] == low) {
                            var str = obj.type == 0 ? "断开成功" : "闭合成功";
                            var param = {id: obj.param, l_switch: obj.type};
                            $.ajax({async: false, url: "loop.loopForm.modifySwitch.action", type: "get", datatype: "JSON", data: param,
                                success: function (data) {
                                    var arrlist = data.rs;
                                    if (arrlist.length == 1) {
                                        layerAler(str);
                                        var o = {};
                                        o.l_comaddr = obj.comaddr;
                                        o.pid = "${param.pid}";
                                        o.l_deplayment = 1;
                                        var opt = {
                                            url: "loop.loopForm.getLoopList.action",
                                            silent: false,
                                            query: o
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

            function switchloop() {
                var l_comaddr = $("#l_comaddr").combobox('getValue');
                if (l_comaddr == "") {
                    layerAler('请勾选网关');  //请勾选网关
                    return;
                }

                var o1 = $("#form1").serializeObject();
                var selects = $('#gravidaTable').bootstrapTable('getSelections');
                if (selects.length == 0) {
                    layerAler('请勾选表格数据');  //
                    return;
                }
                var ele = selects[0];
                var star = "";
                if (o1.switch == "1") {
                    star = "闭合";
                } else {
                    star = "断开";
                }
                addlogon(u_name, "设置", o_pid, "回路监控", star + "回路【" + ele.l_name + "】", l_comaddr);
                var o = {};
                var vv = [];
                vv.push(1);
                vv.push(0x10);               //头指令 
                var info = parseInt(ele.l_info);
                var infonum = (3000 + info * 20 + 3) | 0x1000;
                vv.push(infonum >> 8 & 0xff); //起始地址
                vv.push(infonum & 0xff);

                vv.push(0);           //寄存器数目 2字节  
                vv.push(2);   //5
                vv.push(4);           //字节数目长度  1字节 10




                var worktype = parseInt(ele.l_worktype);
                worktype = worktype & 0xfe;
                vv.push(worktype >> 8 & 0xff)   //工作模式
                vv.push(worktype & 0xff);



                var val2 = parseInt(o1.switch);
                vv.push(val2 >> 8 & 0xff);   //控制值
                vv.push(val2 & 0xff);

                var data = buicode2(vv);
                console.log(data);
                dealsend2("10", data, "switchloopCB", l_comaddr, o1.switch, ele.lid, info, "${param.action}");
                $('#panemask').showLoading({
                    'afterShow': function () {
                        setTimeout("$('#panemask').hideLoading()", 10000);
                    }
                }
                );
            }
            function  restoreloopCB(obj) {
                $('#panemask').hideLoading();
                if (obj.status == "success") {
                    var data = Str2BytesH(obj.data);
                    var v = "";
                    for (var i = 0; i < data.length; i++) {
                        v = v + sprintf("%02x", data[i]) + " ";
                    }
                    console.log(v);
                    if (data[1] == 0x10) {
                        var infonum = (3000 + obj.val * 20 + 3) | 0x1000;
                        console.log(infonum);
                        var high = infonum >> 8 & 0xff;
                        var low = infonum & 0xff;
                        if (data[2] == high && data[3] == low) {
                            layerAler("恢复成功");
                        }

                    }

                }

                console.log(obj);
            }
            function restoreloop() {

                var l_comaddr = $("#l_comaddr").val();
                if (l_comaddr == "") {
                    layerAler('请勾选网关');  //请勾选网关
                    return;
                }
                var o1 = $("#form1").serializeObject();
                console.log(o1);
                var selects = $('#gravidaTable').bootstrapTable('getSelections');
                if (selects.length == 0) {
                    layerAler('请勾选表格数据');  //
                    return;
                }
                var ele = selects[0];
                addlogon(u_name, "恢复自动运行", o_pid, "回路监控", "回路【" + ele.l_name + "】");
                var o = {};
                o.l_comaddr = ele.l_comaddr;
                console.log(ele);
                var vv = [];
                vv.push(1);
                vv.push(0x10);               //头指令 
                var info = parseInt(ele.l_info);
                console.log(info);
                var infonum = (3000 + info * 20 + 3) | 0x1000;
                vv.push(infonum >> 8 & 0xff); //起始地址
                vv.push(infonum & 0xff);

                vv.push(0);           //寄存器数目 2字节  
                vv.push(1);   //5
                vv.push(2);           //字节数目长度  1字节 10


                var worktype = parseInt(ele.l_worktype);

                if (ele.l_mutex == 1) {
                    worktype = worktype | 0x8000
                }

                vv.push(worktype >> 8 & 0xff)   //工作模式
                vv.push(worktype & 0xff);

                var data = buicode2(vv);
                console.log(data);
                dealsend2("10", data, "restoreloopCB", ele.l_comaddr, 0, 0, info, "${param.action}");
                $('#panemask').showLoading({
                    'afterShow': function () {
                        setTimeout("$('#panemask').hideLoading()", 10000);
                    }
                }
                );

            }
            function readinfoCB(obj) {
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

                    var strw1 = w2 & 0x01 == 0x01 ? "自动" : "手动";

                    var strworktype = "";
                    if (w2 >> 1 & 0x1 == 1) {
                        strworktype = "时间模式";
                    } else if (w2 >> 2 & 1 == 1) {
                        strworktype = "场景模式";
                    } else if (w2 >> 2 & 0x1 == 1) {
                        strworktype = "信息点模式";
                    }
                    ; //                        var worktype = data[9] * 256 + data[10];
                    var dataval = data[11] * 256 + data[12];
                    var isclose = dataval == 0 ? "断开" : "闭合";
                    layerAler("控制点:" + info + "<br>" + "站号" + site + "<br>" + "数据位置"
                            + regpos + "<br>" + "工作模式:" + strw1 + "<br>" + "执行方式:"
                            + strworktype + "<br>" + "闭合状态：" + isclose);
                }
            }

            function readinfo() {
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
                vv.push(3);
                var info = parseInt(ele.l_info);
                var infonum = (3000 + info * 20) | 0x1000;
                vv.push(infonum >> 8 & 0xff);
                vv.push(infonum & 0xff);

                vv.push(0);
                vv.push(20); //寄存器数目 2字节                         
                var data = buicode2(vv);
                console.log(data);
                dealsend2("03", data, "readinfoCB", o.l_comaddr, 0, ele.id, info, "${param.action}");
            }
        </script>
    </head>
    <body id="panemask">
            <div id="content" class="row-fluid">

                <div class=" row" style=" margin-left: 2px;" >
                    <form id="form1">
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <table style="border-collapse:separate; border-spacing:0px 10px;border: 1px solid #16645629; margin-top: 10px; align-content:  center;">
                                <tbody>
                                    <tr>
                                        <td>网关名称：</td>
                                        <td style=" padding-left: 3px;">
                                            <input id="l_comaddr" class="easyui-combobox" name="l_comaddr" style="width:150px; height: 30px;" data-options="editable:true,valueField:'id', textField:'text' " />
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div  class="col-xs-12 col-sm-6 col-md-6">
                            <input type="hidden" name="identify" id="identify" value=""/>
                            <table style="border-collapse:separate; border-spacing:0px 10px;border: 1px solid #16645629; margin-top: 10px; align-content:  center;">
                                <tbody>
                                    <tr>

                                        <td style=" padding-left: 10px;" >
                                            <span  >
                                                回路控制
                                            </span>

                                        </td>
                                        <td style=" padding-left: 3px;">
                                            <select class="easyui-combobox" id="switch" name="switch" style=" width: 100px; margin-left: 3px;  height: 30px">
                                                <option value="0">断开</option>
                                                <option value="1">闭合</option>           
                                            </select>
                                        </td>
                                        <td>
                                            <button type="button" id="btnswitch" onclick="switchloop()" class="btn btn-success btn-sm  ">
                                                设置
                                            </button>
                                        </td>
                                        <td>
                                            <button type="button" id="btnswitch" onclick="readinfo()" class="btn btn-success btn-sm">
                                                读取
                                            </button>
                                        </td>
                                        <td>
                                            <button type="button" id="btnswitch" onclick="restoreloop()" class="btn btn-success btn-sm">
                                                恢复自动运行
                                            </button>

                                        </td>
                                    </tr>

                                </tbody>
                            </table>

                        </div>
                    </form>
                    <div style=" width: 100%;" >
                        <table id="gravidaTable"  class="text-nowrap table table-hover table-striped">
                        </table>
                    </div>
                </div>
            </div>
    </body>
</html>
