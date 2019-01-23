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

        <style>

            .btn { margin-left: 10px;}
            /*            手机*/
            @media screen and (min-width:0px) and (max-width:666px) {  
                #l_comaddr{
                    width: 120px;
                }

                #type{
                    width: 100px;
                }

                #nowtime{
                    width: 100px;
                }

                .btn { margin-left: 5px;}


            }
            /*            手机横屏*/
            @media screen and (min-width:667px) {  
                #l_comaddr{
                    width: 150px;
                }

                #type{
                    width: 150px;
                }

                #nowtime{
                    width: 180px;
                }

                .btn { margin-left: 10px;}

            }
        </style>

        <script type="text/javascript" src="js/genel.js"></script>
        <script type="text/javascript" src="js/getdate.js"></script>
        <script>
            var u_name = parent.parent.getusername();
            var o_pid = parent.parent.getpojectId();
            var lang = '${param.lang}';//'zh_CN';

            function isValidIP(ip) {
                var iparr = ip.split(".");
                if (typeof iparr == "object") {
                    if (iparr.length == 4) {
                        var ret = true;
                        for (var i = 0; i < 4; i++) {
                            if (isNumber(iparr[i] == false)) {
                                ret = false;
                            }
                        }
                        return ret;
                    }
                }
                return false;
//                var reg = /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/  
//                return reg.test(ip);
            }
            function removeGayway() {
                var data = $("#l_comaddr").combobox('getData');
                var obj = $("#form1").serializeObject();
                for (var i = 0; i < data.length; i++) {
                    var o1 = data[i];
                    if (o1.id == obj.l_comaddr) {
                        console.log("find gayway");
                        console.log(data[i]);
                        if (data[i].online != "1") {
                            addlogon(u_name, "强制清除网关", o_pid, "网关参数设置", "强制清除网关【" + $("#l_comaddr").combobox('getText') + "】信息");
                            $.ajax({async: false, url: "gayway.GaywayForm.EmptyGayWay.action", type: "get", datatype: "JSON", data: obj,
                                success: function (data) {
                                    console.log(data);
                                },
                                error: function () {
                                    alert("提交失败！");
                                }
                            });


                        } else {
                            layerAler('在线的网关不能清除');
                        }
                        console.log(data[i]);
                    }
                }
            }
            function readControlCB(obj) {
                if (obj.status == "success") {
                    var data = Str2BytesH(obj.data);
                    var v = "";
                    for (var i = 0; i < data.length; i++) {

                        v = v + sprintf("%02x", data[i]) + " ";
                    }
                    var loopval = data[3] * 256 + data[4];
                    var str = "回路<br>";
                    for (var i = 0; i < 16; i++)
                    {
                        var val = loopval >> i & 1 == 1 ? "闭合" : "断开";
                        str = sprintf("%s%d:%s&nbsp;", str, i, val);
                    }
                    layerAler(str);
                    console.log(v);
                }

            }
            function readControl() {
                var obj = $("#form1").serializeObject();
                if (obj.l_comaddr == "") {
                    layerAler('网关不能为空'); //
                    return;
                }
                var obj1 = $("#form2").serializeObject();
                console.log(obj1);
                var vv = [];
                vv.push(0x01);
                vv.push(0x03);
                var infonum = 3901 | 0x1000;
                vv.push(infonum >> 8 & 0xff);
                vv.push(infonum & 0xff);
                vv.push(0);
                vv.push(1); //寄存器数目 2字节   
                var data = buicode2(vv);
                dealsend2("03", data, "readControlCB", obj.l_comaddr, 0, 0, 3901, "${param.action}");
            }

            function  readsiteCB(obj) {
                if (obj.status == "success") {
                    var data = Str2BytesH(obj.data);
                    var v = "";
                    for (var i = 0; i < data.length; i++) {

                        v = v + sprintf("%02x", data[i]) + " ";
                    }
                    console.log(v);
                    var site = data[3] * 256 + data[4];
                    console.log(site, obj.val);
                    if (site == obj.val) {
                        layerAler("站号:" + site);
                    }
                }
            }

            function  readsite() {
                var obj = $("#form1").serializeObject();
                if (obj.l_comaddr == "") {
                    layerAler('网关不能为空'); //
                    return;
                }
                var obj1 = $("#form2").serializeObject();
                var vv = [];
                if (isNumber(obj1.newsite) == false) {
                    layerAler("站号必须是数字");
                    return;
                }

                var newsite = parseInt(obj1.newsite);
                var pos = 0x100;
                vv.push(newsite);
                vv.push(0x03);
                vv.push(pos >> 8 & 0xff);
                vv.push(pos & 0xff);
                vv.push(0);
                vv.push(1);
                var data = buicode2(vv);
                dealsend2("03", data, "readsiteCB", obj.l_comaddr, 0, 0, newsite, "${param.action}");
            }


            function  editsiteCB(obj) {
                if (obj.status == "success") {
                    var data = Str2BytesH(obj.data);
                    var v = "";
                    for (var i = 0; i < data.length; i++) {

                        v = v + sprintf("%02x", data[i]) + " ";
                    }
                    var infonum = obj.val;
                    var high = infonum >> 8 & 0xff;
                    var low = infonum & 0xff;
                    if (data[2] == high && data[3] == low) {
                        layerAler("修改成功");
                    }

                    console.log(v);
                }
            }
            function  editsite() {
                var obj = $("#form1").serializeObject();
                if (obj.l_comaddr == "") {
                    layerAler('网关不能为空'); //
                    return;
                }
                var obj1 = $("#form2").serializeObject();
                var vv = [];
                if (isNumber(obj1.newsite) == false) {
                    layerAler("站号必须是数字");
                    return;
                }

                var newsite = parseInt(obj1.newsite);
                var pos = 0x100;
                if (newsite > 256) {
                    layerAler("站号最大是256");
                }


                vv.push(0xFD);
                vv.push(0x6);
                vv.push(pos >> 8 & 0xff);
                vv.push(pos & 0xff);
                vv.push(newsite >> 8 & 0xff);
                vv.push(newsite & 0xff);


//                vv.push(oldsite);
//                vv.push(0x10);
//                vv.push(pos >> 8 & 0xff);
//                vv.push(pos & 0xff);
//                vv.push(0);
//                vv.push(1);
//                vv.push(2);
//                vv.push(newsite >> 8 & 0xff);
//                vv.push(newsite & 0xff);
                var data = buicode2(vv);
                console.log(data);
                addlogon(u_name, "修改", o_pid, "网关参数设置", "修改网关【" + $("#l_comaddr").combobox('getText') + "】传感器站号");
                dealsend2("10", data, "editsiteCB", obj.l_comaddr, 0, 0, pos, "${param.action}");
            }
            function refreshControlCB(obj) {
                if (obj.status == "success") {
                    var data = Str2BytesH(obj.data);
                    var v = "";
                    for (var i = 0; i < data.length; i++) {

                        v = v + sprintf("%02x", data[i]) + " ";
                    }
                    var infonum = obj.val;
                    var infonum = infonum | 0x1000;
                    var high = infonum >> 8 & 0xff;
                    var low = infonum & 0xff;
                    if (data[2] == high && data[3] == low) {
                        layerAler("刷新成功");
                    }

                    console.log(v);
                }
            }

            function refreshControl() {
                var obj = $("#form1").serializeObject();
                if (obj.l_comaddr == "") {
                    layerAler('网关不能为空'); //
                    return;
                }
                var obj1 = $("#form2").serializeObject();
                console.log(obj1);
                var vv = [];
                vv.push(1);
                vv.push(0x10);
                var infonum = 3901 | 0x1000;
                vv.push(infonum >> 8 & 0xff);
                vv.push(infonum & 0xff);
                vv.push(0);
                vv.push(1); //寄存器数目 2字节   
                vv.push(2);
                var val = parseInt(obj1.controlval);

                vv.push(val >> 8 & 0xff);
                vv.push(val & 0xff);
                var data = buicode2(vv);
                addlogon(u_name, "刷新控制", o_pid, "网关参数设置", "刷新网关【" + $("#l_comaddr").combobox('getText') + "】控制");
                dealsend2("10", data, "refreshControlCB", obj.l_comaddr, 0, 0, 3901, "${param.action}");
            }

            function readTrueTimeCB(obj) {
                if (obj.status == "success") {
                    var data = Str2BytesH(obj.data);
                    var v = "";
                    for (var i = 0; i < data.length; i++) {

                        v = v + sprintf("%02x", data[i]) + " ";
                    }
                    console.log(v);
                    var infonum = obj.val;
                    var infonum = infonum | 0x1000;
                    var high = infonum >> 8 & 0xff;
                    var low = infonum & 0xff;

                    var yh = data[15];
                    var yl = data[16];
                    var mh = data[11];
                    var ml = data[12];

                    var dh = data[9];
                    var dl = data[10];
                    var hh = data[7];
                    var hl = data[8];

                    var minh = data[5];
                    var minl = data[6];
                    var sh = data[3];
                    var sl = data[4];
                    var y = sprintf("%d", yl);
                    var m = sprintf("%02d", ml);
                    var d = sprintf("%02d", dl);
                    var h = sprintf("%02d", hl);
                    var min = sprintf("%02d", minl);
                    var s = sprintf("%02d", sl);
                    var timestr = sprintf("%s-%s-%s %s:%s:%s", y, m, d, h, min, s);
                    $("#gaytime").val(timestr);
                    layerAler("读取成功");


                }
            }

            function readTrueTime() {

                var obj = $("#form1").serializeObject();
                if (obj.l_comaddr == "") {
                    layerAler('网关不能为空'); //
                    return;
                }


                var vv = [];
                vv.push(1);
                vv.push(3);
                var infonum = 1313 | 0x1000;
                vv.push(infonum >> 8 & 0xff);
                vv.push(infonum & 0xff);
                vv.push(0);
                vv.push(7); //寄存器数目 2字节                         
                var data = buicode2(vv);
                dealsend2("03", data, "readTrueTimeCB", obj.l_comaddr, 0, 0, 1313, "${param.action}");


            }

            function setCheckTimeCB(obj) {
                if (obj.status == "success") {
                    var data = Str2BytesH(obj.data);
                    var v = "";
                    for (var i = 0; i < data.length; i++) {

                        v = v + sprintf("%02x", data[i]) + " ";
                    }
                    var infonum = obj.val;
                    var infonum = infonum | 0x1000;
                    var high = infonum >> 8 & 0xff;
                    var low = infonum & 0xff;
                    if (data[2] == high && data[3] == low) {
                        layerAler("设置成功");
                    }

                    console.log(v);
                }

            }

            function setCheckTime() {


                var obj = $("#form1").serializeObject();
                if (obj.l_comaddr == "") {
                    layerAler('网关不能为空'); //
                    return;
                }

                var ooo = $("#form2").serializeObject();


                console.log(ooo);

                var vv = [];
                vv.push(1);
                vv.push(0x10);
                var infonum = 3900 | 0x1000;
                vv.push(infonum >> 8 & 0xff);
                vv.push(infonum & 0xff);
                vv.push(0);
                vv.push(1); //寄存器数目 2字节   
                vv.push(2);

                var time = ooo.checktime;
                var t = parseInt(time);

                vv.push(t >> 8 & 0xff);
                vv.push(t & 0xff);
                var data = buicode2(vv);
                addlogon(u_name, "设置", o_pid, "网关参数设置", "设置网关【" + $("#l_comaddr").combobox('getText') + "】巡测时间");
                dealsend2("10", data, "setCheckTimeCB", obj.l_comaddr, 0, 0, 3900, "${param.action}");
            }

            function  initDataCB(obj) {

                if (obj.status == "success") {
                    var data = Str2BytesH(obj.data);
                    var v = "";
                    for (var i = 0; i < data.length; i++) {

                        v = v + sprintf("%02x", data[i]) + " ";
                    }
                    var infonum = obj.val;
                    var infonum = infonum | 0x1000;
                    var high = infonum >> 8 & 0xff;
                    var low = infonum & 0xff;
                    if (data[2] == high && data[3] == low) {
                        layerAler("初始化成功");
                        var o2 = {pid: "${param.pid}", comaddr: obj.comaddr, l_deplayment: 0, identify: $("#identify").val()};
                        $.ajax({async: false, url: "gayway.GaywayForm.ClearData.action", type: "get", datatype: "JSON", data: o2,
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

                    console.log(v);
                }

            }

            function  initData() {
                var obj = $("#form1").serializeObject();
                if (obj.l_comaddr == "") {
                    layerAler('网关不能为空'); //
                    return;
                }


                console.log(obj);

                var vv = [];
                vv.push(1);
                vv.push(0x10);
                var infonum = 3928 | 0x1000;
                vv.push(infonum >> 8 & 0xff);
                vv.push(infonum & 0xff);
                vv.push(0);
                vv.push(1); //寄存器数目 2字节   
                vv.push(2);
                vv.push(0);
                vv.push(1);
                var data = buicode2(vv);
                addlogon(u_name, "传感器复位", o_pid, "网关参数设置", "网关【" + $("#l_comaddr").combobox('getText') + "】");
                dealsend2("10", data, "initDataCB", obj.l_comaddr, 0, 0, 3928, "${param.action}");
            }

            function dateFormatter(value) {
                var date = new Date(value);
                var year = date.getFullYear().toString();
                var month = (date.getMonth() + 1);
                var day = date.getDate().toString();
                var hour = date.getHours().toString();
                var minutes = date.getMinutes().toString();
                var seconds = date.getSeconds().toString();
                if (month < 10) {
                    month = "0" + month;
                }
                if (day < 10) {
                    day = "0" + day;
                }
                if (hour < 10) {
                    hour = "0" + hour;
                }
                if (minutes < 10) {
                    minutes = "0" + minutes;
                }
                if (seconds < 10) {
                    seconds = "0" + seconds;
                }
                return year + "-" + month + "-" + day + " " + hour + ":" + minutes + ":" + seconds;
            }

            function setNowtime() {
                var myDate = new Date();//获取系统当前时
                var y = myDate.getFullYear();
                var m = myDate.getMonth() + 1;
                var d = myDate.getDate();
                var h = myDate.getHours();
                var mm = myDate.getMinutes();
                var s = myDate.getSeconds();

                var str = y + "-" + m + "-" + d + " " + h + ":" + mm + ":" + s;
                console.log(str);
                $('#nowtime').datetimebox('setValue', str);

            }

            function  setTimeNowCB(obj) {
                if (obj.status == "success") {
                    var data = Str2BytesH(obj.data);
                    var v = "";
                    for (var i = 0; i < data.length; i++) {

                        v = v + sprintf("%02x", data[i]) + " ";
                    }
                    var infonum = obj.val;
                    var infonum = infonum | 0x1000;
                    var high = infonum >> 8 & 0xff;
                    var low = infonum & 0xff;
                    if (data[2] == high && data[3] == low) {
                        layerAler("设置成功");
                    }

                    console.log(v);
                }
                console.log(obj);
            }

            function setTimeNow() {
                var time = $('#nowtime').datetimebox('getValue');
                var myDate = new Date(time);

                var o = $("#form1").serializeObject();
                var obj = $("#form2").serializeObject();

                var y = sprintf("%d", myDate.getFullYear()).substring(2, 4);


                var m = sprintf("%d", myDate.getMonth() + 1);
                var d = sprintf("%d", myDate.getDate());
                var h = sprintf("%d", myDate.getHours());
                var mm = sprintf("%d", myDate.getMinutes());
                var s = sprintf("%d", myDate.getSeconds());

                var sunday = myDate.get

                var y1 = parseInt(y);
                var m1 = parseInt(m);
                var d1 = parseInt(d);
                var h1 = parseInt(h);
                var mm1 = parseInt(mm);
                var s1 = parseInt(s);

                var comaddr = o.l_comaddr;
                var vv = new Array();
                var vv = [];
                vv.push(1);
                vv.push(0x10);

                var infonum = 3920 | 0x1000;
                vv.push(infonum >> 8 & 0xff); //起始地址
                vv.push(infonum & 0xff);
                vv.push(0);           //寄存器数目 2字节  
                vv.push(8);
                vv.push(16);           //字节数目长度  1字节

                vv.push(y1 >> 8 & 0xff)   //年
                vv.push(y1 & 0xff);

                vv.push(0);
                vv.push(3);             //星期
                vv.push(m1 >> 8 & 0xff)   //寄存器变量值
                vv.push(m1 & 0xff);



                vv.push(d1 >> 8 & 0xff)   //寄存器变量值
                vv.push(d1 & 0xff);

                vv.push(h1 >> 8 & 0xff)   //寄存器变量值
                vv.push(h1 & 0xff);
                vv.push(mm1 >> 8 & 0xff)   //寄存器变量值
                vv.push(mm1 & 0xff);


                vv.push(s1 >> 8 & 0xff)   //寄存器变量值
                vv.push(s1 & 0xff);

                vv.push(0);
                vv.push(1);

                var data = buicode2(vv);
                console.log(data);
                addlogon(u_name, "设置", o_pid, "网关参数设置", "设置网关【" + $("#l_comaddr").combobox('getText') + "】时间");
                dealsend2("10", data, "setTimeNowCB", comaddr, 1, 0, 3920, "${param.action}");

            }

            $(function () {
                var aaa = $("span[name=xxx]");
                for (var i = 0; i < aaa.length; i++) {
                    var d = aaa[i];
                    var e = $(d).attr("id");
                    // $(d).html(langs1[e][lang]);
                }
                var d = [];
                for (var i = 0; i < 18; i++) {
                    var o = {"id": i + 1, "text": i + 1};
                    d.push(o);
                }
                $("#l_groupe").combobox({data: d, onLoadSuccess: function (data) {
                        $(this).combobox("select", data[0].id);
                    }, });


                $('#time4').timespinner('setValue', '00:00');
                $('#time3').timespinner('setValue', '00:00');

            })

            function layerAler(str) {
                layer.alert(str, {
                    icon: 6,
                    offset: 'center'
                });
            }

            function readSiteCB(obj) {

                if (obj.status == "success") {

                    var src = Str2BytesH(obj.data);
                    var v = "";
                    for (var i = 0; i < src.length; i++) {

                        v = v + sprintf("%02x", src[i]) + " ";
                    }
                    console.log(v);

                    var z = 18;
                    //dns解析的ip
                    var a = sprintf("%d.%d.%d.%d", src[z], src[z + 1], src[z + 2], src[z + 3]);
                    var aport = src[z + 5] * 256 + src[z + 4];
                    console.log(a, aport);

                    //备用dns解析的ip
                    z = z + 6;
                    var b = sprintf("%d.%d.%d.%d", src[z], src[z + 1], src[z + 2], src[z + 3]);
                    var bport = src[z + 5] * 256 + src[z + 4];
                    console.log(a, bport);
                    //主用ip
                    z = z + 6;
                    var c = sprintf("%d.%d.%d.%d", src[z], src[z + 1], src[z + 2], src[z + 3]);
                    var cport = src[z + 5] * 256 + src[z + 4];
                    console.log(c, cport);

                    //备用ip
                    z = z + 6;
                    var d = sprintf("%d.%d.%d.%d", src[z], src[z + 1], src[z + 2], src[z + 3]);
                    var dport = src[z + 5] * 256 + src[z + 4];
                    console.log(d, dport);

                    z = z + 6;
                    var apn = "";
                    for (var i = z; i < z + 16; i++) {
                        var s = src[i] == 0 ? "" : String.fromCharCode(src[i]);
                        apn = apn + s;
                    }
                    console.log(apn);
                    z = z + 16;

                    var lenarea = src[i];
                    console.log(lenarea);

                    z = z + 1;
                    var area = "";
                    for (var i = z; i < z + lenarea; i++) {

                        area = area + String.fromCharCode(src[i]);
                    }
                    console.log(area);
                    $("#apn").val(apn);




                    if (lenarea > 0) {
                        $("#ip").val(area);
                        $("#port").val(aport);
                        $("#sitetype").combobox('select', 0);
                    } else if (lenarea == 0) {
                        $("#ip").val(c);
                        $("#port").val(cport);
                        $("#sitetype").combobox('select', 1);
                    }

                }
            }
            function setRemoteAddrCB(obj) {
                console.log(obj);
                if (obj.status == "success") {

                    var str = "";
                    var data = Str2BytesH(obj.data);
                    for (var i = 0; i < data.length; i++) {
                        str += String.fromCharCode(data[i]);
                    }
                    console.log(str);
                    //var s1 = str.split("\r\n");
                    var substr = str.match(/\S*\r\n(\S*)\r\n/);
                   console.log(substr);
                    ;
                    if (typeof substr == "object") {
                        if (substr[1] == "OK") {
                            layerAler("设置成功");
                        }
                    }



                }

            }

            function setRemoteAddr() {
                var obj = $("#form1").serializeObject();
                var obj2 = $("#form2").serializeObject();
                if (obj.l_comaddr == "") {
                    layerAler('网关不能为空'); //
                    return;
                }
                console.log(obj, obj2);
                if (isNumber(obj2.port) == false) {
                    layerAler('端口只能是数字'); //
                    return;
                }


                var vv = [];
                if (obj2.sitetype == "1") {
                    if (isValidIP(obj2.ip) == false) {
                        layerAler('不是合法ip');  //不是合法ip
                        return;
                    }
                    // alert("验证成功");

                    var data = "@DTU:0000:DSCADDR:0,TCP, " + $("#ip").val() + "," + $("#port").val() + "\r\n";
                    var strtosend = "";
                    for (var i = 0; i < data.length; i++) {
                        var param1 = sprintf("%02x", data.charCodeAt(i));
                        strtosend = strtosend + param1 + " ";
                        // hexCharCode.push((data.charCodeAt(i)).toString(16));
                    }


                    addlogon(u_name, "设置", o_pid, "网关参数设置", "设置网关【" + $("#l_comaddr").combobox('getText') + "】主站信息");
                    dealsend2("@", strtosend, "setRemoteAddrCB", obj.l_comaddr, 0, 0, 0, "${param.action}");

                } else if (obj2.sitetype == "0") {
                    if (isValidIP(obj.ip) == true) {
                        layerAler('请填写正确的域名');  // 请填写正确的域名
                        return;
                    }
                    if (obj.ip != "") {

                        //dealsend2("A4", data, 1, "setSiteCB", comaddr, 0, 0, 0, "${param.action}");

                    }

                }

            }
            function readRemoteAddrCB(obj) {
                if (obj.status == "success") {
                    var str = "";
                    var data = Str2BytesH(obj.data);
                    for (var i = 0; i < data.length; i++) {
                        str += String.fromCharCode(data[i]);
                    }
                    console.log(str);
                    //var s1 = str.split("\r\n");
                    var substr = str.match(/\S*0,"TCP",(\S*) /);
//                    console.log(typeof substr);
//                    var substr1 = str.match(/\S*1,"TCP",(\S*)\r/);
                    if (typeof substr == "object") {
                        var ip = substr[1];
                        console.log(ip);
                        ip = ip.replace(/"/g, "");
                        var iparr = ip.split(",");

                        $("#ip").val(iparr[0]);
                        $("#port").val(iparr[1]);
                        layerAler("读取成功");
//                        console.log(substr[1]);
                    }
//                    console.log(substr, substr1);
                }

//                console.log(obj);
            }

            function readRemoteAddr() {
                var obj = $("#form1").serializeObject();
                if (obj.l_comaddr == "") {
                    layerAler('网关不能为空'); //
                    return;
                }


                console.log(obj);


                var vv = [];
                var data = "40 44 54 55 3A 30 30 30 30 3A 44 53 43 41 44 44 52 3F 0D 0A";
//                vv.push(1);
//                vv.push(3);
//                
//                var str="";
//                var infonum = 3928 | 0x1000;
//                vv.push(infonum >> 8 & 0xff);
//                vv.push(infonum & 0xff);
//                vv.push(0);
//                vv.push(1); //寄存器数目 2字节   
//                vv.push(2);
//                vv.push(0);
//                vv.push(1);
//                var data = buicode2(vv);
                dealsend2("@", data, "readRemoteAddrCB", obj.l_comaddr, 0, 0, 0, "${param.action}");
            }
            function readTimeCB(obj) {
                if (obj.status == "success") {

                    var src = Str2BytesH(obj.data);
                    var v = "";
                    for (var i = 0; i < src.length; i++) {

                        v = v + sprintf("%02x", src[i]) + " ";
                    }
                    console.log(v);

                    var z = 18;

                    var s = src[z] >> 4 & 0x0f;
                    var g = src[z + 0] & 0x0f;
                    var sw = src[z + 1] >> 4 & 0x0f;
                    var gw = src[z + 1] & 0x0f;
                    var timechg = sprintf("%d%d:%d%d", s, g, sw, gw);
                    $('#time4').spinner('setValue', timechg);
                    z += 2;
                    var s2 = src[z] >> 4 & 0x0f;
                    var g2 = src[z + 0] & 0x0f;
                    var sw2 = src[z + 1] >> 4 & 0x0f;
                    var gw2 = src[z + 1] & 0x0f;
                    var timefloze = sprintf("%d%d:%d%d", s2, g2, sw2, gw2);
                    $('#time3').spinner('setValue', timefloze);
                    var timestr = sprintf("换日时间 time:%s 冻结时间:%s", timechg, timefloze);
                    console.log(timestr);

                }

            }
            function readTime() {
                var obj = $("#form1").serializeObject();
                console.log(obj);
                var comaddr = obj.l_comaddr;
                var vv = [];
                var num = randnum(0, 9) + 0x70;
                var data = buicode(comaddr, 0x04, 0xAA, num, 0, 4, vv); //01 03 F24    
                dealsend2("AA", data, 4, "readTimeCB", comaddr, 0, 0, 0, "${param.action}");
            }


            $(function () {
                $("#l_comaddr").combobox({
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
                        var obj = {};
                        obj.l_comaddr = record.id;
                        obj.pid = "${param.pid}";
                        var opt = {
                            url: "sensor.sensorform.getSensorList.action",
                            query: obj,
                            silent: false
                        };
                        $("#gravidaTable").bootstrapTable('refresh', opt);
                    }
                });

                $('#type').combobox({
                    onLoadSuccess: function (data) {
                        if (Array.isArray(data) && data.length > 0) {
                            $(this).combobox("select", data[0].id);
                        }
                    },
                    onSelect: function (record) {
                        var rowdiv = $(".row");
                        for (var i = 0; i < rowdiv.length; i++) {
                            var row = rowdiv[i];
                            if (i == 0) {
                                continue;
                            }
                            $(row).hide();
                        }

                        var v = parseInt(record.id);
                        $(rowdiv[v]).show();

                    }
                });

            })
        </script>
    </head>
    <body>


        <div class="panel panel-default" >
            <div class="panel-heading">
                <h3 class="panel-title"><span >网关参数设置</span></h3>
            </div>
            <div class="panel-body" >
                <div class="container">



                    <div class="row" style=" padding-bottom: 20px;" >
                        <div class="col-xs-12">
                            <form id="form1">
                                <input type="hidden" value="" name="identify" id="identify" />
                                <table style="border-collapse:separate;  border-spacing:0px 10px;border: 1px solid #16645629;">
                                    <tbody>
                                        <tr>

                                            <td>
                                                <span style="margin-left:10px;" >网关</span>&nbsp;

                                                <span class="menuBox">

                                                    <input id="l_comaddr" class="easyui-combobox" name="l_comaddr" style=" height: 30px" 
                                                           data-options="editable:true,valueField:'id', textField:'text' " />
                                                </span>  
                                            </td>
                                            <td>
                                                <span style="margin-left:10px;" >功能选择</span>&nbsp;

                                                <span class="menuBox">
                                                    <select class="easyui-combobox" id="type" name="type" data-options="editable:false,valueField:'id', textField:'text' " style=" height: 30px">
                                                        <option value="1" >IP设置</option>
                                                        <option value="2">读取网关时间</option> 
                                                        <option value="3">数据初始化</option> 
                                                        <option value="4">设置巡测时间</option> 
                                                        <option value="5">刷新控制</option> 
                                                        <option value="6">设置传感器站号</option> 
                                                        <option value="7">设置控制器站号</option> 
                                                    </select>
                                                </span>  
                                            </td>

                                        </tr>
                                    </tbody>
                                </table> 
                            </form>
                        </div>
                    </div>

                    <form id="form2">
                        <div class="row" id="row1">
                            <div class="col-xs-12" >

                                <table style="border-collapse:separate; border-spacing:0px 10px;border: 1px solid #16645629; ">
                                    <tbody>
                                        <tr>
                                            <td>
                                                <span  style=" float: right; margin-right: 2px;" name="xxx" id="188">IP</span>
                                            </td>
                                            <td>

                                                <select class="easyui-combobox" id="sitetype" name="sitetype" style="width:150px; height: 30px">
                                                    <!--                                                    <option value="0">域名</option>-->
                                                    <option value="1">IP</option>            
                                                </select>   

                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <span  style=" float: right; margin-right: 2px;" name="xxx" id="189">主站IP</span>
                                            </td>
                                            <td>
                                                <input id="ip"  class="form-control" name="ip"  style="width:150px; " placeholder="输入主站IP" type="text">
                                            </td>
                                        </tr>

                                        <tr >
                                            <td>
                                                <span  style=" float: right; margin-right: 2px;" name="xxx" id="190" >端口</span>
                                            <td>

                                                <input id="port"  class="form-control" name="port" style="width:150px;"  placeholder="输入端口" type="text">
                                            </td>

                                        </tr>                                   

                                        <!--                                        <tr>
                                                                                    <td>
                                                                                        <span  style=" float: right; margin-right: 2px;" name="xxx" id="191" >运营商APN</span>
                                                                                    </td>
                                        
                                                                                    <td >
                                                                                        <input id="apn" class="form-control" name="apn" value="cmnet" style="width:150px;" placeholder="输入APN" type="text">
                                                                                    </td>
                                        
                                                                                </tr>-->
                                        <tr>
                                            <td colspan="2">
                                                &emsp;
                                                <button type="button"  onclick="setRemoteAddr()" class="btn  btn-success btn-sm" style="margin-left: 2px; "><span name="xxx" id="192">设置主站信息</span></button>
                                                <button  type="button" onclick="readRemoteAddr()" class="btn btn-success btn-sm"><span name="xxx" id="193">读取主站信息</span></button>&emsp;
                                                <!--<button  type="button"  onclick="setAPN()" class="btn btn-success btn-sm"><span name="xxx" id="194">设置运营商APN</span></button>-->
                                            </td>
                                        </tr>

                                    </tbody>
                                </table>
                            </div>
                        </div>


                        <div class="row" id="row2"  style=" display: none">
                            <div class="col-xs-12">
                                <table style="border-collapse:separate; border-spacing:0px 10px;border: 1px solid #16645629;">
                                    <tbody>
                                        <tr>
                                            <td>
                                                <span style="margin-left:10px;">当前时间</span>
                                                <span class="menuBox">
                                                    <input class="easyui-datetimebox" name="nowtime" id="nowtime"
                                                           data-options="formatter:dateFormatter,showSeconds:true" value="" style="">
                                                </span> 
                                                <button  type="button" onclick="setNowtime()"  class="btn btn-success btn-sm"><span >获取当前时间</sspan>
                                                </button>&nbsp; 

                                                <button  style="float:right; margin-right: 5px;" type="button" onclick="setTimeNow()" class="btn btn-success btn-sm"><span >设置</span></button>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>
                                                <span style="margin-left:10px; " name="xxx" id="202">网关终端时间</span>&nbsp;
                                                <input id="gaytime" readonly="true" class="form-control" name="gaytime" value="" style="width:150px;" placeholder="网关终端时间" type="text">
                                                <button  type="button" onclick="readTrueTime()" class="btn btn-success btn-sm">读取</button>&nbsp;
                                            </td>
                                        </tr>

                                    </tbody>
                                </table>
                            </div>
                        </div>


                        <div class="row" id="row3"  style=" display: none">
                            <div class="col-xs-12">
                                <table style="border-collapse:separate; border-spacing:0px 10px;border: 1px solid #16645629;">
                                    <tbody>
                                        <tr>
                                            <td>

                                                <button  type="button" onclick="initData()"  class="btn btn-success btn-sm"><span >传感器复位</sspan>
                                                </button>&ensp;
                                                <button  type="button" onclick="removeGayway()"  class="btn btn-success btn-sm"><span >强制清除网关</sspan>
                                                </button>&nbsp; 

                                            </td>
                                        </tr>

                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="row" id="row4"  style=" display: none">
                            <div class="col-xs-12">
                                <table style="border-collapse:separate; border-spacing:0px 10px;border: 1px solid #16645629;">
                                    <tbody>
                                        <tr>

                                            <td>
                                                <span  style="  margin-right: 2px;" >巡测时间:</span>
                                                <input id="checktime"  class="form-control" name="checktime" style="width:150px;"  placeholder="时间" type="text">
                                                <span  style="  margin-right: 2px;" >(秒)</span>
                                                <button  type="button" onclick="setCheckTime()"  class="btn btn-success btn-sm"><span >设置</sspan>
                                                </button>&nbsp; 
                                            </td>
                                        </tr>

                                    </tbody>
                                </table>
                            </div>
                        </div>                

                        <div class="row" id="row5"  style=" display: none">
                            <div class="col-xs-12">
                                <table style="border-collapse:separate; border-spacing:0px 10px;border: 1px solid #16645629;">
                                    <tbody>
                                        <tr>

                                            <td>
                                                <span  style=" margin-right: 2px;">刷新控制</span>
                                                <select class="easyui-combobox" id="controlval" name="controlval" style="width:150px; height: 30px">
                                                    <option value="0">互斥模式禁用</option>
                                                    <option value="1">互斥模式启用</option>
                                                    <option value="2">互斥模式恢复原始值</option>   
                                                </select>    

                                                <!--<input id="checktime"  class="form-control" name="checktime" style="width:150px;"  placeholder="时间" type="text">-->

                                                <button  type="button" onclick="refreshControl()"  class="btn btn-success btn-sm"><span >控制</sspan>
                                                </button>&nbsp; 
                                                <button  type="button" onclick="readControl()"  class="btn btn-success btn-sm"><span >读取</sspan>
                                                </button>&nbsp; 
                                            </td>
                                        </tr>

                                    </tbody>
                                </table>
                            </div>
                        </div>                      
                        <div class="row" id="row6"  style=" display: none">
                            <div class="col-xs-12">
                                <table style="border-collapse:separate; border-spacing:0px 10px;border: 1px solid #16645629;">
                                    <tbody>
                                        <tr>
<!--                                            <td> <span  style=" margin-left: 2px;"  >旧站号</span></td>
                                            <td>
                                                <input id="oldsite"  class="form-control" name="oldsite" style="width:50px;"  placeholder="站号" type="text"> 
                                            </td>-->
                                            <td>
                                                <span  >&emsp;站号:</span>
                                            </td>
                                            <td>
                                                <input id="newsite"  class="form-control" name="newsite" style="width:50px;"  placeholder="站号" type="text">
                                            </td>
                                            <td>
                                                <button  type="button" onclick="editsite()"  class="btn btn-success btn-sm"><span >修改</sspan>
                                                </button> 
                                            </td>
                                            <td>
                                                <button  type="button" onclick="readsite()"  class="btn btn-success btn-sm"><span >测试站号</sspan>
                                                </button>
                                                &emsp;
                                            </td>

                                            </td>
                                        </tr>

                                    </tbody>
                                </table>
                            </div>
                        </div>  


                        <div class="row" id="row7"  style=" display: none">
                            <div class="col-xs-12">
                                <table style="border-collapse:separate; border-spacing:0px 10px;border: 1px solid #16645629;">
                                    <tbody>
                                        <tr>

                                        </tr>

                                    </tbody>
                                </table>
                            </div>
                        </div>                      







                    </form>
                </div>



            </div>


    </body>
</html>
