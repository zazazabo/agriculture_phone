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
            var lang = '${param.lang}';//'zh_CN';
            var infolist = {};
            var scenenum = null;
            function layerAler(str) {
                layer.alert(str, {
                    icon: 6,
                    offset: 'center'
                });
            }

            $(function () {
                $('#table0').bootstrapTable({
//                    url: 'sensor.planForm.getSensorPlan.action',
                    clickToSelect: true,
                    rowStyle: function (row, index) {
                        if (scenenum == row.p_scenenum) {
                           
                            return {css: {"color": "green"}};
                        }

                        return row;
                    },
                    columns: [
                        {
                            field: 'p_name',
                            title: '场景名', //信息点
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            colspan: 1,
                            formatter: function (value, row, index, field) {
                                return value;
                            }
                        },
                        {
                            field: 'p_scene',
                            title: '条件1', //信息点
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            colspan: 1,
                            formatter: function (value, row, index, field) {
                                if (isJSON(row.p_scene1)) {
                                    var obj = eval('(' + row.p_scene1 + ')');
                                    var o1 = obj.info.toString();
                                    var str = infolist[o1] + "&emsp;" + "下限:" + obj.down.toString() + "&emsp;" + "上限:" + obj.up.toString();
                                    return str;
                                }
                            }
                        }, {
                            field: 'p_scene',
                            title: '条件2', //信息点
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            colspan: 1,
                            formatter: function (value, row, index, field) {
                                if (isJSON(row.p_scene2)) {
                                    var obj = eval('(' + row.p_scene2 + ')');
                                    var o1 = obj.info.toString();
                                    var str = infolist[o1] + "&emsp;" + "下限:" + obj.down.toString() + "&emsp;" + "上限:" + obj.up.toString();
                                    return str;
                                }
                            }
                        }, {
                            field: 'p_scene',
                            title: '条件3', //信息点
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            colspan: 1,
                            formatter: function (value, row, index, field) {
                                if (isJSON(row.p_scene3)) {
                                    var obj = eval('(' + row.p_scene3 + ')');
                                    var o1 = obj.info.toString();
                                    var str = infolist[o1] + "&emsp;" + "下限:" + obj.down.toString() + "&emsp;" + "上限:" + obj.up.toString();
                                    return str;
                                }
                            }
                        }, {
                            field: 'p_scene',
                            title: '条件4', //信息点
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            colspan: 1,
                            formatter: function (value, row, index, field) {
                                if (isJSON(row.p_scene4)) {
                                    var obj = eval('(' + row.p_scene4 + ')');
                                    var o1 = obj.info.toString();
                                    var str = infolist[o1] + "&emsp;" + "下限:" + obj.down.toString() + "&emsp;" + "上限:" + obj.up.toString();
                                    return str;
                                }
                            }
                        }, {
                            field: 'p_scene',
                            title: '条件5', //信息点
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            colspan: 1,
                            formatter: function (value, row, index, field) {
                                if (isJSON(row.p_scene5)) {
                                    var obj = eval('(' + row.p_scene5 + ')');
                                    var o1 = obj.info.toString();
                                    var str = infolist[o1] + "&emsp;" + "下限:" + obj.down.toString() + "&emsp;" + "上限:" + obj.up.toString();
                                    return str;
                                }
                            }
                        }
                    ],
                    singleSelect: false,
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
                    pageList: [10, 20, 40, 80, 160],
                    onLoadSuccess: function () {  //加载成功时执行  表格加载完成时 获取集中器在线状态
                    },
                    //服务器url
                    queryParams: function (params)  {   //配置参数     
                        var temp  =   {    //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的 
                            search: params.search,
                            skip: params.offset,
                            limit: params.limit,
                            p_attr: 1,
                            p_type: 1,
                            p_show: 1,
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
                                    var obj = {};
                                    obj.identify = record.identify;
                                    obj.pid = "${param.pid}";
                                    $.ajax({async: false, url: "sensor.sensorform.getInfoNumList2.action", type: "get", datatype: "JSON", data: obj,
                                        success: function (data) {
                                            for (var i = 0; i < data.length; i++) {
                                                var o = data[i];
                                                infolist[o.id] = o.text;
                                            }
                                            var ooo = {};
                                            ooo.pid = "${param.pid}";
                                            ooo.identify = record.identify;
                                            console.log(ooo);
                                            var opt = {url: "plan.planForm.getSensorPlan.action", query: ooo, silent: true};
                                            $("#table0").bootstrapTable('refresh', opt);
                                        },
                                        error: function () {
                                            alert("提交失败！");
                                        }
                                    });

                                    $('#scenenum').combobox({
                                        url: "sensor.planForm.getSensorPlanBynum1.action?p_identify=" + record.identify,
                                        onLoadSuccess: function (data) {
                                            if (Array.isArray(data) && data.length > 0) {
                                                $(this).combobox('select', data[0].id);
                                            }
                                        }, onSelect: function (record) {
                                            $("#scennum").val(record.text);
                                        }
                                    });

//                                    var data = $("#table0").bootstrapTable('getData');
//                                    console.log(data.length)
//                                    getSceneNum(l_comaddr);










//                                    $("#identify").val(record.identify);
//                                    var l_comaddr = record.id;
//                                    var vv = [];
//                                    dealsend2("loop", "00", "loopcb", l_comaddr, 0, 0, 0, "${param.action}");
//
//                                    var obj = {};
//                                    obj.identify = record.identify;
//                                    obj.pid = "${param.pid}";
//                                    $.ajax({async: false, url: "sensor.sensorform.getInfoNumList2.action", type: "get", datatype: "JSON", data: obj,
//                                        success: function (data) {
//                                            for (var i = 0; i < data.length; i++) {
//                                                var o = data[i];
//                                                var str=o.identify + "_" + o.id;
//                                                infolist[str] = o.text;
//                                            }
//                                            console.log(infolist);
//                                        },
//                                        error: function () {
//                                            alert("提交失败！");
//                                        }
//                                    });
//                                    $.ajax({async: false, url: "plan.planForm.getAllScennumName.action", type: "get", datatype: "JSON", data: obj,
//                                        success: function (data) {
//                                            for (var i = 0; i < data.length; i++) {
//                                                var o = data[i];
//                                                infoscene[o.id] = o.text;
//                                            }
//                                        },
//                                        error: function () {
//                                            alert("提交失败！");
//                                        }
//                                    });
//                                    var opt = {
//                                        url: "loop.loopForm.getLoopList.action",
//                                        silent: false,
//                                        query: obj
//                                    };
//                                    $("#gravidaTable").bootstrapTable('refresh', opt);


                                }
                            });

                        }
                    },
                    error: function () {
                        alert("提交失败！");
                    }
                });







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
//                        var obj = {};
//                        obj.identify = record.identify;
//                        obj.pid = "${param.pid}";
//                        $.ajax({async: false, url: "sensor.sensorform.getInfoNumList2.action", type: "get", datatype: "JSON", data: obj,
//                            success: function (data) {
//                                for (var i = 0; i < data.length; i++) {
//                                    var o = data[i];
//                                    infolist[o.id] = o.text;
//                                }
//                                var ooo = {};
//                                ooo.pid = "${param.pid}";
//                                ooo.identify = record.identify;
//                                console.log(ooo);
//                                var opt = {url: "plan.planForm.getSensorPlan.action", query: ooo, silent: true};
//                                $("#table0").bootstrapTable('refresh', opt);
//                            },
//                            error: function () {
//                                alert("提交失败！");
//                            }
//                        });
//
//                        $('#scenenum').combobox({
//                            url: "sensor.planForm.getSensorPlanBynum1.action?p_identify=" + record.identify,
//                            onLoadSuccess: function (data) {
//                                if (Array.isArray(data) && data.length > 0) {
//                                    $(this).combobox('select', data[0].id);
//                                }
//                            }, onSelect: function (record) {
//                                $("#scennum").val(record.text);
//                            }
//                        });
//
//                        var data = $("#table0").bootstrapTable('getData');
//                        console.log(data.length)
//                        getSceneNum(l_comaddr);
//                    }
//                });











            })

            function getSceneNumCB(obj) {
                var data = Str2BytesH(obj.data);
                var v = "";
                for (var i = 0; i < data.length; i++) {
                    v = v + sprintf("%02x", data[i]) + " ";
                }
                console.log(v);
                var sceneval = data[3] * 256 + data[4];
                console.log(scenenum, sceneval);
                var data = $("#table0").bootstrapTable('getData');

                if (data.length > 0) {
                    if (scenenum != sceneval) {
                        scenenum = sceneval;
                        $("#table0").bootstrapTable('refresh');
                    }
                }
            }

            function getSceneNum(l_comaddr) {
                var vv = [];
                vv.push(1);
                vv.push(3);
                var infonum = 3800 | 0x1000;
                vv.push(infonum >> 8 & 0xff);
                vv.push(infonum & 0xff);

                vv.push(0);
                vv.push(2); //寄存器数目 2字节   

                var data = buicode2(vv);
                console.log(data);
                dealsend2("03", data, "getSceneNumCB", l_comaddr, 0, 0, 3800, "${param.action}");
            }

            function switchloopCB(obj) {
                $('#panemask').hideLoading();
                if (obj.status == "success") {
                    var data = Str2BytesH(obj.data);
                    var v = "";
                    for (var i = 0; i < data.length; i++) {
                        v = v + sprintf("%02x", data[i]) + " ";
                    }
                    console.log(v);
                    if (data[1] == 0x10) {
                        var infonum = 3800 | 0x1000;
                        var high = infonum >> 8 & 0xff;
                        var low = infonum & 0xff;
                        if (data[2] == high && data[3] == low) {

                            layerAler("设置成功");

                        }

                    }

                }

            }
            function switchloop() {
                var l_comaddr = $("#l_comaddr").val();
                if (l_comaddr == "") {
                    layerAler('请勾选网关');  //请勾选网关
                    return;
                }
                var obj = $("#form1").serializeObject();
                console.log(l_comaddr);
                console.log(obj);
                var o = {};
                var vv = [];
                vv.push(1);
                vv.push(0x10);               //头指令 
                var infonum = 3800 | 0x1000;
                vv.push(infonum >> 8 & 0xff); //起始地址
                vv.push(infonum & 0xff);

                vv.push(0);           //寄存器数目 2字节  
                vv.push(2);   //5
                vv.push(4);           //字节数目长度  1字节 10


                var val2 = parseInt(obj.scenenum);
                vv.push(val2 >> 8 & 0xff);   //场景值
                vv.push(val2 & 0xff);



                var worktype = 0;
                worktype = worktype & 0xfe;
                vv.push(worktype >> 8 & 0xff)   //工作模式
                vv.push(worktype & 0xff);





                var data = buicode2(vv);
                console.log(data);
                dealsend2("10", data, "switchloopCB", l_comaddr, 0, 0, 3800, "${param.action}");
                addlogon(u_name, "设置", o_pid, "场景监控", "设置【" + $("#scenenum").combobox('getText') + "】", obj.identify);
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
                        var infonum = 3801 | 0x1000;
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

                var obj = $("#form1").serializeObject();

                var o = {};
                var vv = [];
                vv.push(1);
                vv.push(0x10);               //头指令 
                var infonum = 3801 | 0x1000;
                vv.push(infonum >> 8 & 0xff); //起始地址
                vv.push(infonum & 0xff);

                vv.push(0);           //寄存器数目 高字节  
                vv.push(1);   //寄存器数目,低字节
                vv.push(2);           //字节数目长度  1字节 


                var val2 = parseInt(1);
                vv.push(val2 >> 8 & 0xff);   //场景值
                vv.push(val2 & 0xff);




                var data = buicode2(vv);
                console.log(data);
                dealsend2("10", data, "restoreloopCB", l_comaddr, 0, 0, 3801, "${param.action}");
                addlogon(u_name, "恢复自动运行", o_pid, "场景监控", "恢复自动运行", obj.identify);
                $('#panemask').showLoading({
                    'afterShow': function () {
                        setTimeout("$('#panemask').hideLoading()", 10000);
                    }
                }
                );

            }


        </script>
    </head>
    <body id="panemask">





        <div id="content" class="row-fluid"  style=" margin-left: 30px;">

            <div class="row">
                <form id="form1" >
                    <input type="hidden" name="identify" id="identify" value=""/>
                    <div class="col-xs-12 col-sm-4 col-md-3" style=" ">
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
                    <div class="col-xs-12 col-sm-6 col-md-6">
                        <table style="border-collapse:separate; border-spacing:0px 10px;border: 1px solid #16645629; margin-top: 10px; align-content:  center;">
                            <tbody>
                                <tr>
                                    <td>&nbsp;场景控制</td>
                                    <td style=" padding-left: 3px;">

                                        <select id="scenenum" class="easyui-combobox" data-options="editable:false,valueField:'id', textField:'text'" id="info11" name="scenenum" style="width:100px;  height: 30px">
                                        </select>
                                    </td>
                                    <td>
                                        <button type="button" id="btnswitch" onclick="switchloop()" class="btn btn-success btn-sm">
                                            设置
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
                <div style=" width: 100%;">
                    <table id="table0" style="width:100%; " class="text-nowrap table table-hover table-striped">
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
