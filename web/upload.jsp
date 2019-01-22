<%-- 
    Document   : newjsp1
    Created on : 2018-11-23, 13:03:35
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="Huploadify.css"/>
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/jquery.Huploadify.js"></script>
    <style type="text/css">
    </style>
    <script type="text/javascript">
        $(function () {
            $('#upload').Huploadify({
                auto: false,
                fileTypeExts: '*.jpg;*.png;*.exe;*.jsp;*.xml;*.doc;*.txt;*.eXe',
                multi: true,
                formData: {fname: 'uu.txt', fpath: 'upload1', filedesc: 'aaaa'},
                fileSizeLimit: 9999,
                showUploadedPercent: true, //是否实时显示上传的百分比，如20%
                showUploadedSize: true,
                removeTimeout: 9999999,
                uploader: 'gayway.UPLOAD.h1.action',
                onUploadStart: function () {
                    //alert('开始上传');
                    var fpath = $("#path").val();
                    option.formData = {fname: 'uu.txt', fpath: fpath, filedesc: 'aaaa'};
                },
                onInit: function () {
                    //alert('初始化');
                },
                onUploadComplete: function () {
                    //alert('上传完成');
                },
                onUploadSuccess: function (file, data, response) {
                    console.log(data);
                    alert(data);
                },
                onDelete: function (file) {
                    console.log('删除的文件：' + file);
                    ;
                }
            });
        });
        
        //js 读取文件
    function jsReadFiles(files) {
        console.log(files);
        if (files.length) {
            var file = files[0];
            var reader = new FileReader();//new一个FileReader实例
            if (/text+/.test(file.type)) {//判断文件类型，是不是text类型
                reader.onload = function() {
                    $('#reddiv').append('<pre>' +this.result+ '</pre>');
                };
                reader.readAsText(file);
            } else if(/image+/.test(file.type)) {//判断文件是不是imgage类型
                reader.onload = function() {
                    $('#reddiv').append('<img src="' + this.result + '"/>');
                };
                reader.readAsDataURL(file);
            }
        }
    }
    </script>
</head>

<body>
    <div id="upload"></div>
    <form id="form1">
        上传的路径:<input type="text" id="path" name="path" value="" >
    </form>
    <!--    读取文件-->
    <input type="file" onchange="jsReadFiles(this.files)"/>
    <div id="reddiv"></div>

</body>
</html>
