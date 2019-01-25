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

        <script>
        </script>
        <title>JSP Page</title>
    </head>
    <body>



        <div id="content" class="row-fluid">

            <div class=" row " >

                <div class="col-xs-10 col-sm-10 col-md-10 col-lg-10  ">
                    <canvas id="c1" width="1123" height="762">
                    </canvas>
                </div>
                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2  ">
                    <div style=" width: 400px; height: 500px; border: 1px solid #000208">
                        <div id="info">

                        </div>

                    </div>
                </div>
            </div>

        </div>

    </div>







    <script type="text/javascript">
        function isInPos(x, y, posx, posy, obj) {
            var height = obj.height;
            var width = obj.width;
//                console.log(height, width);
            if (x >= posx && x <= posx + width && y >= posy && y <= posy + obj.height) {
                return true;
            } else {
                return false;
            }
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


        var sensor = {};
        var loopArr = {};
        var gaywayArr = {};
        var movObject = [];
        $(function () {

            $(document).contextmenu(function (e) {
                e.preventDefault();
                var x = e.offsetX;
                var y = e.offsetY;
                var o = isHitImg(x, y);
                console.log(o);
                if (o != null) {
                    var s = o.ooo;
                    if (o.model == 1) {

                        
//                        var o = {};
//                        var vv = [];
//                        vv.push(1);
//                        vv.push(0x10);               //头指令 
//                        var info = parseInt(o.l_info);
//                        var infonum = (3000 + info * 20 + 3) | 0x1000;
//                        vv.push(infonum >> 8 & 0xff); //起始地址
//                        vv.push(infonum & 0xff);
//
//                        vv.push(0);           //寄存器数目 2字节  
//                        vv.push(2);   //5
//                        vv.push(4);           //字节数目长度  1字节 10
//
//
//
//
//                        var worktype = parseInt(o.l_worktype);
//                        worktype = worktype & 0xfe;
//                        vv.push(worktype >> 8 & 0xff)   //工作模式
//                        vv.push(worktype & 0xff);
//
//
//
//                        var val2 = parseInt(o1.switch);
//                        vv.push(val2 >> 8 & 0xff);   //控制值
//                        vv.push(val2 & 0xff);
//
//                        var data = buicode2(vv);
//                        console.log(data);
//                        dealsend2("10", data, "switchloopCB", l_comaddr, o1.switch, ele.lid, info, "${param.action}");
//                        $('#panemask').showLoading({
//                            'afterShow': function () {
//                                setTimeout("$('#panemask').hideLoading()", 10000);
//                            }
//                        }
//                        );













//                        o.src="img/loopoff.png"
                    } else if (o.model == 0) {



                    }

                } else {
                    if (isInPos(x, y, 100, 200, img1)) {
                        layer.confirm('确定保存当前所布局位置信息？', {//确定要删除吗？
                            btn: ['确定', '取消'], //确定、取消按钮
                            icon: 3,
                            offset: 'center',
                            title: '提示'
                        }, function (index) {


                            for (var i = 0; i < movObject.length; i++) {
                                var type = movObject[i].model;
                                var ooo = movObject[i].ooo;
                                console.log(ooo);
                                var obj = {};
                                var url = "";
                                if (type == 0) {
                                    url = "gayway.GaywayForm.modifySensorPos.action";
                                    obj.id = ooo.sid;
                                    obj.posX = movObject[i].posX;
                                    obj.posY = movObject[i].posY;
                                } else if (type == 1) {
                                    url = "gayway.GaywayForm.modifyLoopPos.action";
                                    obj.id = ooo.lid;
                                    obj.posX = movObject[i].posX;
                                    obj.posY = movObject[i].posY;
                                } else if (type == 2) {
                                    url = "gayway.GaywayForm.modifyGayWayPos.action";
                                    obj.id = ooo.id;
                                    obj.posX = movObject[i].posX;
                                    obj.posY = movObject[i].posY;
                                }
                                $.ajax({async: false, url: url, type: "get", datatype: "JSON", data: obj,
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










                            layer.close(index);

                        });
                    }
                }



            });


            var obj = {pid: "P00001", page: "ALL", deplayment: 1};
            $.ajax({async: false, url: "sensor.sensorform.getSensorList.action", type: "get", datatype: "JSON", data: obj,
                success: function (data) {
                    console.log(data);
                    for (var i = 0; i < data.total; i++) {
                        var oo = data.rows[i];
                        sensor[oo.id] = oo;
                        var imgtemp = new Image();
                        imgtemp.src = "img/hll.png"
                        imgtemp.name = "imgimg" + i.toString();
                        imgtemp.alt = oo.id

                        imgtemp.onload = function () {
                            var m1 = "imgimg";
                            var name = this.name;
                            var id = this.alt;
                            var o1 = sensor[id];
                            console.log(o1);
                            var index = name.substring(m1.length, name.length);
                            var index = parseInt(index);
                            if (o1.posX != null && o1.posY != null) {
                                this.posX = o1.posX;
                                this.posY = o1.posY;
                            } else {
                                sensor[id].posX = index * 40;
                                sensor[id].posY = 0;
                                this.posX = index * 40;
                                this.posY = 0;
                            }
                            this.model = 0;
                            this.ooo = o1;
                            sensor[id].img = this;
                            movObject.push(this);
                            draw(this, this.posX, this.posY);

                        }
                    }

                },
                error: function () {
                    alert("提交失败！");
                }
            });

            var objloop = {pid: "P00001", page: "ALL", l_deplayment: 1};
            $.ajax({async: false, url: "loop.loopForm.getLoopList2.action", type: "get", datatype: "JSON", data: objloop,
                success: function (data) {
                    console.log(data);
                    for (var j = 0; j < data.total; j++) {
                        var oo = data.rows[j];
                        loopArr[oo.lid] = oo;
                        var imgtemp = new Image();
                        imgtemp.src = "img/loopon.png"
                        imgtemp.name = "looploop" + j.toString();
                        imgtemp.alt = oo.lid;
                        imgtemp.onload = function () {

                            var m1 = "looploop";
                            var name = this.name;
                            var id = this.alt;
                            var o1 = loopArr[id];
                            loopArr[id].img = this;
                            var index = name.substring(m1.length, name.length);
                            var index = parseInt(index);

                            if (o1.posX != null && o1.posY != null) {
                                this.posX = o1.posX;
                                this.posY = o1.posY;
                            } else {
                                loopArr[id].posX = index * 40;
                                loopArr[id].posY = 0;
                                this.posX = index * 60;
                                this.posY = 80;
                            }

                            this.model = 1;
                            this.ooo = o1;
                            movObject.push(this);

                            draw(this, this.posX, this.posY);
                        }
                    }
                },
                error: function () {
                    alert("提交失败！");
                }
            });



            var ooo = {pid: "P00001", page: "ALL"};
            $.ajax({async: false, url: "gayway.GaywayForm.List.action", type: "get", datatype: "JSON", data: ooo,
                success: function (data) {
                    console.log(data);
                    for (var j = 0; j < data.total; j++) {
                        var oo = data.rows[j];
                        gaywayArr[oo.id] = oo;
                        var imgtemp = new Image();
                        imgtemp.src = "img/wzx.png"
                        imgtemp.name = "gayway" + j.toString();
                        imgtemp.alt = oo.id;
                        imgtemp.onload = function () {

                            var m1 = "gayway";
                            var name = this.name;
                            var id = this.alt;
                            var o1 = gaywayArr[id];
                            gaywayArr[id].img = this;
                            var index = name.substring(m1.length, name.length);
                            var index = parseInt(index);
                            if (o1.posX != null && o1.posY != null) {
                                this.posX = o1.posX;
                                this.posY = o1.posY;
                            } else {
                                gaywayArr[id].posX = index * 40;
                                gaywayArr[id].posY = 0;
                                this.posX = index * 60;
                                this.posY = 120;
                            }
                            this.model = 2;
                            this.ooo = o1;
                            movObject.push(this);
                            draw(this, this.posX, this.posY);
                        }
                    }
                },
                error: function () {
                    alert("提交失败！");
                }
            });


        })
        var can = document.getElementById("c1");
        var ctx = can.getContext("2d");
        var X1 = 100;
        var Y1 = 350
        var img = new Image();
        var img1 = new Image();
        img.src = 'homeback.png';
        img1.src = "img/save.png"


        img.onload = function () {
            console.log("aaa");
            draw(this, 0, 0);
        }
        img1.onload = function () {
            draw(this, 100, 200);
        }

        function getFont(text) {
            var str = '<font color="#F3ADAD">' + text + '</font>';
            return str;
        }


        function draw(obj, x, y) {
            ctx.drawImage(obj, x, y);
        }
        can.addEventListener('click', function (e) {
            console.log("aaaa", e.button);
            var x = e.offsetX;
            var y = e.offsetY;

            var o = isHitImg(x, y);
            if (o != null) {
                var s = o.ooo;
                if (o.model == 2) {
                    var online = s.online == 1 ? "在线" : "离线";
                    var str = "网关名:" + getFont(s.name) + "<br>" + "网关地址:" + getFont(s.comaddr) + "<br>" + "在线状态:" + getFont(online);
                    $("#info").html(str);
                } else if (o.model == 1) {
                    console.log(s);
                    var l_switch = s.l_switch == 1 ? "闭合" : "断开";

                    var work = "";
                    if (s.l_worktype == 3) {
                        work = "时间";
                    } else if (s.l_worktype == 5) {
                        work = "场景";
                    } else if (s.l_worktype == 9) {
                        work = "信息点";
                    }
                    var l_worktype = s.l_worktype == 3 ? "闭合" : "断开";

                    var str = "网关名:" + getFont(s.commname) + "<br>" + "网关地址:" + getFont(s.comaddr) + "<br>" + "回路名:" + getFont(s.l_name) + "<br>" + "回路状态:" + getFont(l_switch);
                    str += "<br>" + "回路工作方式:" + getFont(work);
                    $("#info").html(str);
                } else if (o.model == 0) {

                    console.log(s);

                    var work = "";
                    switch (s.type) {
                        case "1":
                            work = "温度";
                            break;
                        case "2":
                            work = "湿度";
                            break;
                        case "3":
                            work = "开关";
                            break;
                        case "4":
                            work = "风速";
                            break;
                        case "5":
                            work = "风向";
                            break;
                        case "6":
                            work = "光照度";
                            break;

                        default :
                            break;
                    }
                    console.log(work);
                    var val = s.numval;
                    if (s.type != 5) {
                        var v1 = parseFloat(s.numvalue);
                        val = v1 / 10;
                        val = val.toFixed(2);
                    } else {
                        var v1 = parseFloat(s.numvalue);
                        var direct = getDirection(v1);
                        val = direct;
//                        val=direct + v1.toFixed(1) + "方位";
                    }
                    var str = "网关名:" + getFont(s.commname) + "<br>" + "网关地址:" + getFont(s.comaddr) + "<br>" + "传感器:" + getFont(s.name) + "<br>" + "类型:" + getFont(work);

                    str += "<br>" + "数值:" + getFont(val);

                    $("#info").html(str);


                }

            } else {
                if (isInPos(x, y, 100, 200, img1)) {
                    layer.confirm('确定保存当前所布局位置信息？', {//确定要删除吗？
                        btn: ['确定', '取消'], //确定、取消按钮
                        icon: 3,
                        offset: 'center',
                        title: '提示'
                    }, function (index) {


                        for (var i = 0; i < movObject.length; i++) {
                            var type = movObject[i].model;
                            var ooo = movObject[i].ooo;
                            console.log(ooo);
                            var obj = {};
                            var url = "";
                            if (type == 0) {
                                url = "gayway.GaywayForm.modifySensorPos.action";
                                obj.id = ooo.sid;
                                obj.posX = movObject[i].posX;
                                obj.posY = movObject[i].posY;
                            } else if (type == 1) {
                                url = "gayway.GaywayForm.modifyLoopPos.action";
                                obj.id = ooo.lid;
                                obj.posX = movObject[i].posX;
                                obj.posY = movObject[i].posY;
                            } else if (type == 2) {
                                url = "gayway.GaywayForm.modifyGayWayPos.action";
                                obj.id = ooo.id;
                                obj.posX = movObject[i].posX;
                                obj.posY = movObject[i].posY;
                            }
                            $.ajax({async: false, url: url, type: "get", datatype: "JSON", data: obj,
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










                        layer.close(index);

                    });
                }
            }
        }, false)

        //创建圆滑块

        //鼠标按下，将鼠标按下坐标保存在x,y中
        //createBlock(50, 50);
        can.onmousedown = function (ev) {
            var e = ev || event;
            var x = e.clientX;
            var y = e.clientY;
            console.log(x, y);
            console.log(X1, Y1);
            drag(x, y);
        };
        //拖拽函数
        function drag(x, y) {
            var o = isHitImg(x, y);
            if (o != null) {
                $("body").css('cursor', 'pointer');
                can.onmousemove = function (ev) {
                    var e = ev || event;
                    var ax = e.clientX;
                    var ay = e.clientY;
                    drawAll(o);
                    ctx.drawImage(o, ax, ay);
                    o.posX = ax;
                    o.posY = ay;
                };
                //鼠标移开事件
                can.onmouseup = function () {
                    console.log(o.posX, o.posY);
                    $("body").css('cursor', 'default');
                    can.onmousemove = null;
                    can.onmouseup = null;
                };
            }


//                if (isInPos(x, y, X1, Y1, img2)) {
//
//                }

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

            ctx.drawImage(img1, 100, 200);

            for (var i = 0; i < movObject.length; i++) {
                var o = movObject[i];
                if (o != imgobj) {
                    ctx.drawImage(o, o.posX, o.posY);
                }
            }

        }






    </script>        


</body>
</html>
