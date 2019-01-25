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
        <canvas id="c1" width="1123" height="762">
        </canvas>
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

            var sensor = {};
            var loopArr = {};
            var gaywayArr={};
            var movObject = [];
            $(function () {
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
                                sensor[id].img = this;
                                var index = name.substring(m1.length, name.length);
                                var index = parseInt(index);
                                sensor[id].posX = index * 40;
                                sensor[id].posY = 0;
                                this.posX = index * 40;
                                this.posY = 0;
                                this.model = 0;
                                this.ooo = o1;
                                movObject.push(this);
                                draw(this, index * 40, 0);

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
                                loopArr[id].posX = index * 40;
                                loopArr[id].posY = 0;

                                this.posX = index * 60;
                                this.posY = 80;
                                this.model = 1;
                                this.ooo = o1;
                                movObject.push(this);

                                draw(this, index * 60, 80);
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
                                gaywayArr[id].posX = index * 40;
                                gaywayArr[id].posY = 0;

                                this.posX = index * 60;
                                this.posY = 120;
                                this.model = 2;
                                this.ooo = o1;
                                movObject.push(this);
                                draw(this, index * 60, 120);
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
            var img2 = new Image();
            img.src = 'homeback.png';
            img1.src = "img/wzx.png";
            img2.src = "img/hll.png"
            img.onload = function () {
                console.log("aaa");
                draw(this, 0, 0);
            }

            function draw(obj, x, y) {
                ctx.drawImage(obj, x, y);
            }
            can.addEventListener('click', function (e) {
                var x = e.offsetX;
                var y = e.offsetY;

                var o = isHitImg(x, y);
                if (o != null) {
                    var s=o.ooo;
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
//                        ctx.clearRect(0, 0, img.width, img.height);
//                        ctx.drawImage(img, 0, 0);
//                        draw(this, img1, 180, 400);

                        ctx.drawImage(o, ax, ay);
                        o.posX = ax;
                        o.posY = ay;
                    };
                    //鼠标移开事件
                    can.onmouseup = function () {
                        console.log(o);
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
