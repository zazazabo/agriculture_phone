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
            var loopArr={};
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
                            imgtemp.src = "img/k.png"
                            imgtemp.name="looploop" + j.toString();
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
                                draw(this, index * 60, 80);   
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
            img1.onload = function () {
//                console.log(img1.width);
//                console.log(img1.height);
                draw(this, 180, 400);
            }
            img2.onload = function () {
                draw(this, X1, Y1);
            }
            function draw(obj, x, y) {
                ctx.drawImage(obj, x, y);
            }
            can.addEventListener('click', function (e) {
                var x = e.offsetX;
                var y = e.offsetY;

                for (var s in sensor) {
//                    console.log(sensor[s]);
                    if (isInPos(x, y, sensor[s].posX, sensor[s].posY, sensor[s].img)) {
                         console.log(sensor[s]);
                         alert(sensor[s].name);
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
                if (isInPos(x, y, X1, Y1, img2)) {
                    $("body").css('cursor', 'pointer');
                    can.onmousemove = function (ev) {
                        var e = ev || event;
                        var ax = e.clientX;
                        var ay = e.clientY;
                        ctx.clearRect(0, 0, img.width, img.height);
                        ctx.drawImage(img, 0, 0);
                        draw(this, img1, 180, 400);
                        ctx.drawImage(img2, ax, ay);
                        X1 = ax;
                        Y1 = ay;
                    };
                    //鼠标移开事件
                    can.onmouseup = function () {
                        $("body").css('cursor', 'default');
                        can.onmousemove = null;
                        can.onmouseup = null;
                    };
                }

                // 按下鼠标判断鼠标位置是否在圆上，当画布上有多个路径时，isPointInPath只能判断最后那一个绘制的路径
//                if (ctx.isPointInPath(x, y)) {
//                      $("body").css('cursor','pointer');
//                    //路径正确，鼠标移动事件
//                    can.onmousemove = function (ev) {
//                      
//                        
//                        
//                        
//                        var e = ev || event;
//                        var ax = e.clientX;
//                        var ay = e.clientY;
//                        //鼠标移动每一帧都清楚画布内容，然后重新画圆
//                        ctx.clearRect(0, 0, can.width, can.height);
//                        createBlock(ax, ay);
//                    };
//                    //鼠标移开事件
//                    can.onmouseup = function () {
//                        $("body").css('cursor','default');
//                        can.onmousemove = null;
//                        can.onmouseup = null;
//                    };
//                };
            }



        </script>        


    </body>
</html>
