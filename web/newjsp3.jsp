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
                console.log(height, width);
                if (x >= posx && x <= posx + width && y >= posy && y <= posy + obj.height) {
                    return true;
                } else {
                    return false;
                }
            }
        </script>






        <title>JSP Page</title>
    </head>
    <body>
        <canvas id="c1" width="1200" height="800">
        </canvas>
        <script type="text/javascript">

            var oC = document.getElementById("c1");
            var oGC = oC.getContext("2d");
            var img = new Image();
            var img1 = new Image();
            img.src = 'homeback.png';
            img1.src = "img/wzx.png";
            img.onload = function () {
                draw(this, img, 0, 0);
            }
            img1.onload = function () {
                console.log(img1.width);
                console.log(img1.height);
                draw(this, img1, 180, 400);

            }

            oC.addEventListener('click', function (e) {
                var x = e.offsetX;
                var y = e.offsetY;
                console.log(x, y);
                if (isInPos(x, y, 180, 400, img1)) {
                    alert("点击网关");
                }
            }, false)
            function draw(obj, img, x, y) {
                oGC.drawImage(img, x, y);
            }

        </script>        


    </body>
</html>
