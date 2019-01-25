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

            $(function () {
                console.log("ddd");
                
                
            })



        </script>






        <title>JSP Page</title>
    </head>
    <body>
        <canvas id="c1" width="1123" height="762">
        </canvas>
        <script type="text/javascript">

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
            var imgarr = [];
            img.onload = function () {
//                draw(this, img, 0, 0);
                imgarr.push(img);
                if (imgarr.length == 3) {
                    ctx.drawImage(img, 0, 0);
                    draw(this, img1, 180, 400);
                    ctx.drawImage(img2, X1, Y1);
                }
            }
            img1.onload = function () {
                imgarr.push(img1);
                if (imgarr.length == 3) {
                    ctx.drawImage(img, 0, 0);
                    draw(this, img1, 180, 400);
                    ctx.drawImage(img2, X1, Y1);
                }
            }
            img2.onload = function () {
                imgarr.push(img2);
                if (imgarr.length == 3) {
                    ctx.drawImage(img, 0, 0);
                    draw(this, img1, 180, 400);
                    ctx.drawImage(img2, X1, Y1);
                }
                console.log("ccc");
            }

            function draw(obj, img, x, y) {
                ctx.drawImage(img, x, y);
            }
            can.addEventListener('click', function (e) {
                var x = e.offsetX;
                var y = e.offsetY;
//                console.log(x, y);
                if (isInPos(x, y, 180, 400, img1)) {
                    alert("点击网关");
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
