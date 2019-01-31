<%-- 
    Document   : newjsp3
    Created on : 2019-1-24, 14:24:33
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@include  file="js.jspf" %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="js/getdate.js"></script>
        <script type="text/javascript" src="js/genel.js"></script>
        <title>自控页面</title>
        <style>
            .divbody{
                margin-left: 10px;
                margin-top: 10px;
                float: left;
                width: 150px;
                height: 200px;
                border: 1px solid #e8e8e8;

            }
            .div1{
                display: flex;
                justify-content:center;
                align-items:Center;
                width: 70%; height: 50%; float: left;text-align: center; font-size: 18px;
            }
            .div2{ 
                display: flex;
                justify-content:center;
                align-items:Center;
                width: 30%; height: 50%; float: left;text-align: center; font-size: 24px;
                border: 1px solid #e8e8e8
            }
            .div3{
                display: flex;
                justify-content:center;
                align-items:Center;
                width: 50%; height: 50%; float: left; text-align: center;}
            #c1{
                /*                cursor: pointer;*/
            }
            .sd{
                border: 1px solid black; width: 160px; float: left; height: 200px;margin-left: 3%; margin-top: 2% ; 
                background:rgba(144, 238 ,144,0.4); filter:alpha(opacity=40);
            }
            img{ width:100%;height:70%; margin-top: 30px;}
        </style>
    </head>
    <body id="panemask">
        <canvas id="c1" width="1200" height="800">
        </canvas>
        <div id="faultDiv"  class="bodycenter"  style=" display: none" title="网关信息">
            <div id="wgname" style=" width: 100%; height: 10%; font-size: 24px;"></div>
            <div style=" width: 70%; height: 90%; float: left; border: 1px solid #e8e8e8;overflow-y: scroll;" id="loopinfo">
                <!--                <div style=" width: 150px; border: 1px solid red; height: 200px;">
                                    <div style=" width:70%; height: 50%; border: 1px solid green; float: left;"></div>
                                    <div style=" width:30%; height: 50%; border: 1px solid gray; float: left;"></div>
                                    <div style=" width:50%; height: 50%; border: 1px solid green; float: left;"></div>
                                    <div style=" width:50%; height: 50%; border: 1px solid gray; float: left;"></div>
                                </div>-->
            </div>
            <div style=" width: 30%;height: 90%; float: left; border: 1px solid #e8e8e8;" id="sensorinfo">

            </div>
        </div>

        <div id="signDiv"  class="bodycenter"  style=" display: none" title="气象站">
            <div class="sd" style=" width: 150px;">
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
            <div class="sd" style=" width: 150px;">
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
            <div class="sd" style=" width: 150px;">
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
            <div class="sd" style=" width: 150px;">
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
            <div class="sd" style=" width: 150px;">
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
            <div class="sd" style=" width: 150px;">
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
            <div class="sd" style=" width: 150px;">
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
            <div class="sd" style=" width: 150px;">
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
            <div class="sd" style=" width: 150px;">
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
        </div>


    </body>
    <script type="text/javascript">
        var u_name = "${param.name}";
        var o_pid = "${param.pid}";

        function layerAler(str) {
            layer.alert(str, {
                icon: 6,
                offset: 'center'
            });
        }
        var isok = true;
        var wg = {};
        var movObject = [];
        var oC = document.getElementById("c1");
        var ctx = oC.getContext("2d");
        var img = new Image();
        img.src = 'img/masterhome.png';
        // img1.src = "img/wzx.png";
        img.onload = function () {
            draw(this, 0, 0);
        };
        $(function () {

            var obj = {pid: o_pid, page: "ALL"};
            $.ajax({async: false, url: "homePage.masterhome.getcomaddrSlist.action", type: "get", datatype: "JSON", data: obj,
                success: function (data) {

                    var rs = data.comaddrrs;
                    for (var i = 0; i < rs.length; i++) {
                        var cmd = rs[i];
                        wg[cmd.id] = cmd;
                        var imgtemp = new Image();
                        imgtemp.src = "img/wzx.png";
                        imgtemp.name = "imgimg" + i.toString();
                        imgtemp.alt = cmd.id;
                        imgtemp.onload = function () {
                            var m1 = "imgimg";
                            var name = this.name;

                            var id = this.alt;
                            var o1 = wg[id];
                            wg[id].img = this;
                            var index = name.substring(m1.length, name.length);
                            var index = parseInt(index);
                            if (o1.posX != null && o1.posY != null) {
                                this.posX = o1.posX;
                                this.posY = o1.posY;
                            } else {
                                wg[id].posX = index * 40;
                                wg[id].posY = 0;
                                this.posX = index * 40;
                                this.posY = 0;

                            }
                            this.model = 2;
                            this.ooo = o1;
                            movObject.push(this);
                            draw(this, this.posX, this.posY);


                        };
                    }

                },
                error: function () {
                    alert("提交失败！");
                }
            });

            $("#faultDiv").dialog({
                autoOpen: false,
                modal: true,
                width: 550,
                height: 580,
                position: ["top", "top"],
                buttons: {
                    关闭: function () {
                        $("#faultDiv").dialog("close");
                    }
                }
            });

            $("#signDiv").dialog({
                autoOpen: false,
                modal: true,
                width: 550,
                height: 580,
                position: ["top", "top"],
                buttons: {
                    关闭: function () {
                        $("#signDiv").dialog("close");
                    }
                }
            });
        });


        oC.addEventListener('click', function (e) {
            var x = e.offsetX;
            var y = e.offsetY;
            var o = isHitImg(x, y);
            if (o != null) {
                if (isok) {
                    var s = o.ooo;
                    if (isInPos(x, y, o.posX, o.posY, s.img)) {

                        // alert(wg[s].name);
                        var identify = s.identify;
                        var obj = {};
                        obj.identify = identify;
                        $.ajax({url: "homePage.masterhome.getCSlist.action", async: false, type: "get", datatype: "JSON", data: obj,
                            success: function (data) {
                                var looprs = data.looprs;
                                var sensorrs = data.sensorrs;
                                $("#sensorinfo").html("");
                                $("#loopinfo").html("");
                                $("#wgname").html("");
                                $("#wgname").html(s.name);
                                var sen = document.createElement("h3");
                                sen.innerHTML = "传感器信息";
                                var loop = document.createElement("h3");
                                loop.innerHTML = "回路信息";
                                $("#sensorinfo").append(sen);
                                $("#loopinfo").append(loop);
                                //回路
                                if (looprs.length > 0) {
                                    var comaddr;
                                    $.ajax({async: false, url: "homePage.gayway.getcomaddrbyidentify.action", type: "post", datatype: "JSON", data: {identify: identify},
                                        success: function (data) {
                                            var rs = data.rs;
                                            if (rs.length > 0) {
                                                comaddr = rs[0].comaddr;
                                            }
                                        },
                                        error: function () {
                                            alert("提交失败！");
                                        }
                                    });
                                    for (var i = 0; i < looprs.length; i++) {
                                        (function (x) {
                                            var loop = looprs[i];
                                            var obj = loop;
                                            var str = "";
                                            if (loop.l_switch == 1) {
                                                str = "闭合";
                                            } else {
                                                str = "断开";
                                            }
                                            var divbordy = document.createElement("div");
                                            var div1 = document.createElement("div");
                                            var div2 = document.createElement("div");
                                            var div3 = document.createElement("div");
                                            var div4 = document.createElement("div");
                                            var bhbtn = document.createElement("button");
                                            var dkbtn = document.createElement("button");
                                            div2.setAttribute("id", "bh" + i);
                                            bhbtn.innerHTML = '闭合';
                                            dkbtn.innerHTML = '断开';
                                            //闭合
                                            bhbtn.onclick = function () {                          //绑定点击事件
                                                close(obj, comaddr, $(div2).attr('id'));
                                            };
                                            //断开
                                            dkbtn.onclick = function () {
                                                discon(obj, comaddr, $(div2).attr('id'));
                                            };
                                            divbordy.setAttribute("class", "divbody");
                                            div1.setAttribute("class", "div1");
                                            div2.setAttribute("class", "div2");
                                            div3.setAttribute("class", "div3");
                                            div4.setAttribute("class", "div3");
                                            div1.innerHTML = loop.l_name;
                                            div2.innerHTML = str;
                                            div3.appendChild(bhbtn);
                                            div4.appendChild(dkbtn);
                                            divbordy.appendChild(div1);
                                            divbordy.appendChild(div2);
                                            divbordy.appendChild(div3);
                                            divbordy.appendChild(div4);
                                            $("#loopinfo").append(divbordy);

                                        })(i);

                                    }
                                }
                                ;
                                //传感器
                                if (sensorrs.length > 0) {
                                    for (var i = 0; i < sensorrs.length; i++) {
                                        var sensor = sensorrs[i];
                                        var p = document.createElement("p");
                                        var span1 = document.createElement("span");
                                        var span2 = document.createElement("span");
                                        var name = sensor.name;
                                        var val = "";
                                        if (sensor.type == "1") {
                                            var num;
                                            if (sensor.numvalue > 0) {
                                                num = sensor.numvalue / 10;
                                            } else {
                                                num = 0;
                                            }
                                            val = num.toString() + "℃";
                                        } else if (sensor.type == "2") {
                                            var num;
                                            if (sensor.numvalue > 0) {
                                                num = sensor.numvalue / 10;
                                            } else {
                                                num = 0;
                                            }
                                            val = num.toString() + "%RH";
                                        } else if (sensor.type == "3") {
                                            if (sensor.numvalue == "1") {
                                                val = "闭合";
                                            } else {
                                                val = "断开";
                                            }
                                        } else if (sensor.type == "4") {
                                            var num;
                                            if (sensor.numvalue > 0) {
                                                num = sensor.numvalue / 10;
                                            } else {
                                                num = 0;
                                            }
                                            val = num.toString() + "m/s";
                                        } else if (sensor.type == "5") {
                                            val = getDirection(sensor.numvalue);
                                        } else if (sensor.type == "6") {
                                            var num;
                                            if (sensor.numvalue > 0) {
                                                num = sensor.numvalue / 10;
                                            } else {
                                                num = 0;
                                            }
                                            val = num.toString() + "    lux";
                                        }
                                        span1.innerHTML = name + ":&nbsp ";
                                        span2.innerHTML = val;
                                        span2.setAttribute("style", "color: green;");
                                        p.appendChild(span1);
                                        p.appendChild(span2);
                                        // p.innerHTML = name + ":      " + val;
                                        $("#sensorinfo").append(p);
                                    }

                                }
                                ;
                            },
                            error: function () {
                                alert("提交添加失败！");
                            }
                        });
                        $('#faultDiv').dialog('open');
                    }
                }


            } else {
                if (x >= 390 && x <= 425 && y >= 115 && y <= 180) {
                    getrs();
                    $("#signDiv").dialog("open");
                }
            }

        }, false);

        //鼠标按下，将鼠标按下坐标保存在x,y中
        //createBlock(50, 50);
        oC.onmousedown = function (ev) {
            var e = ev || event;
            var x = e.clientX;
            var y = e.clientY;
            drag(x, y);
            isok = true;
        };
        //拖拽函数
        function drag(x, y) {
            var o = isHitImg(x, y);
            if (o != null) {
                $("body").css('cursor', 'pointer');
                oC.onmousemove = function (ev) {
                    var e = ev || event;
                    var ax = e.clientX;
                    var ay = e.clientY;
                    if (ax >= 1100) {
                        ax = 1100;
                    }
                    if (ay >= 700) {
                        ay = 700;
                    }
                    drawAll(o);
                    o.posX = ax;
                    o.posY = ay;

                    ctx.drawImage(o, ax, ay);
                    isok = false;
                    var obj = {};
                    obj.posX = ax;
                    obj.posY = ay;
                    obj.identify = o.ooo.identify;

                    $.ajax({async: false, url: "homePage.masterhome.upXY.action", type: "post", datatype: "JSON", data: obj,
                        success: function (data) {

                        },
                        error: function () {
                            alert("提交失败！");
                        }
                    });

                };
                //鼠标移开事件
                oC.onmouseup = function (ev) {
                    $("body").css('cursor', 'default');
                    oC.onmousemove = null;
                    oC.onmouseup = null;
                };
            }
        }

        function draw(img, x, y) {
            ctx.drawImage(img, x, y);
        }

        //闭合
        function close(obj, comaddr, divid) {
            var ele = obj;
            addlogon(u_name, "设置", o_pid, "实图主页", "闭合回路【" + ele.l_name + "】", obj.l_identify);
            var o = {};
            o.l_comaddr = ele.l_comaddr;
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
            vv.push(worktype >> 8 & 0xff);  //工作模式
            vv.push(worktype & 0xff);



            var val2 = parseInt(0);
            vv.push(val2 >> 8 & 0xff);   //控制值
            vv.push(val2 & 0xff);

            var data = buicode2(vv);
            dealsend3("10", data, "switchloopCB", comaddr, 1, ele.id, info, "${param.action}", divid);
            $('#panemask').showLoading({
                'afterShow': function () {
                    setTimeout("$('#panemask').hideLoading()", 10000);
                }
            }
            );
        }

        //断开
        function discon(obj, comaddr, divid) {
            var ele = obj;
            addlogon(u_name, "设置", o_pid, "实图主页", "断开回路【" + ele.l_name + "】", obj.l_identify);
            var o = {};
            o.l_comaddr = ele.l_comaddr;
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
            vv.push(worktype >> 8 & 0xff);   //工作模式
            vv.push(worktype & 0xff);



            var val2 = parseInt(0);
            vv.push(val2 >> 8 & 0xff);   //控制值
            vv.push(val2 & 0xff);

            var data = buicode2(vv);
            dealsend3("10", data, "switchloopCB", comaddr, 0, ele.id, info, "${param.action}", divid);
            $('#panemask').showLoading({
                'afterShow': function () {
                    setTimeout("$('#panemask').hideLoading()", 10000);
                }
            }
            );
        }

        //回路设置回调函数
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
                        if (obj.type == 0) {
                            document.getElementById(obj.divid).innerHTML = "断开";
                        } else {
                            document.getElementById(obj.divid).innerHTML = "闭合";
                        }
                        var param = {id: obj.param, l_switch: obj.type};
                        $.ajax({async: false, url: "loop.loopForm.modifySwitch.action", type: "get", datatype: "JSON", data: param,
                            success: function (data) {
                                var arrlist = data.rs;
                                if (arrlist.length == 1) {
                                    layerAler(str);

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

        //判断是否点中图标
        function isInPos(x, y, posx, posy, obj) {
            var height = obj.height;
            var width = obj.width;
            if (x >= posx && x <= posx + width && y >= posy && y <= posy + obj.height) {
                return true;
            } else {
                return false;
            }
        }

        function isHitImg(x, y) {
            for (var i = 0; i < movObject.length; i++) {
                var o1 = movObject[i];
                if (isInPos(x, y, o1.posX, o1.posY, o1)) {
                    return o1;
                }
            }
            return null;
        }

        function drawAll(imgobj) {
            ctx.clearRect(0, 0, img.width, img.height);
            ctx.drawImage(img, 0, 0);
            for (var i = 0; i < movObject.length; i++) {
                var o = movObject[i];
                if (o != imgobj) {
                    ctx.drawImage(o, o.posX, o.posY);
                }
            }

        }

        //计算风向
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

            return  str;
        }

        //获取数值
        function getrs() {
            var obj = {};
            obj.pid = o_pid;
            $.ajax({url: "homePage.sign.getdqwd_value.action", async: false, type: "get", datatype: "JSON", data: obj,
                success: function (data) {
                    var rs = data.rs;
                    if (rs.length > 0) {
                        for (var i = 0; i < rs.length; i++) {
                            var rsv = rs[i];
                            if (rsv.show == 1) {
                                if (parseInt(rsv.numvalue) > 0) {
                                    var value = parseInt(rsv.numvalue) / 10;
                                    $("#fsvalue").html(value);
                                }

                            } else if (rsv.show == 2) {
                                //雨量
                                if (parseInt(rsv.numvalue) > 0) {
                                    var value = parseInt(rsv.numvalue) / 10;
                                    $("#ylvalue").html(value);
                                }

                            } else if (rsv.show == 3) {
                                //雨量累计

                                if (parseInt(rsv.numvalue) > 0) {
                                    var value = parseInt(rsv.numvalue) / 10;
                                    $("#ylljvalue").html(value);
                                }

                            } else if (rsv.show == 4) {
                                //土壤温度

                                if (parseInt(rsv.numvalue) > 0) {
                                    var value = parseInt(rsv.numvalue) / 10;
                                    $("#trwdvalue").html(value);
                                }

                            } else if (rsv.show == 5) {
                                //土壤湿度

                                if (parseInt(rsv.numvalue) > 0) {
                                    var value = parseInt(rsv.numvalue) / 10;
                                    $("#trsd").html(value);
                                }
                            } else if (rsv.show == 6) {
                                //大气温度

                                if (parseInt(rsv.numvalue) > 0) {
                                    var value = parseInt(rsv.numvalue) / 10;
                                    $("#dqwd").html(value);
                                }

                            } else if (rsv.show == 7) {
                                //大气湿度

                                if (parseInt(rsv.numvalue) > 0) {
                                    var value = parseInt(rsv.numvalue) / 10;
                                    $("#dqsdvalue").html(value);
                                }

                            } else if (rsv.show == 8) {
                                //风向

                                var v1 = parseFloat(rsv.numvalue);
                                $("#fxvalue").html(getDirection(v1));
//                                if (parseInt(rsv.numvalue) > 0) {
//                                    var value = parseInt(rsv.numvalue);
//                                    $("#fxvalue").html(value);
//                                }

                            } else if (rsv.show == 9) {
                                //照度

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

    </script> 
</html>
