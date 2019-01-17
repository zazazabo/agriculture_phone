<%-- 
    Document   : warnning
    Created on : 2018-8-6, 9:10:54
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include  file="js.jspf" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="select2/css/select2.min.css">
        <script type="text/javascript" src="js/md5.js"></script>
        <script type="text/javascript" src="js/genel.js"></script>
        <script type="text/javascript" src="select2/js/select2.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
        <script type="text/javascript"  src="js/getdate.js"></script>
        <title>用户管理页面</title>

        <style>
            * { margin: 0; padding: 0; } 
            body, html { width: 100%; height: 100%; }
            .zuheanniu { margin-top: 2px; margin-left: 10px; } 
            table { font-size: 14px; } 
            .modal-body input[type="text"],.modal-body select, .modal-body input[type="radio"] { height: 30px; } .modal-body table td { line-height: 40px; } .menuBox { position: relative; background: skyblue; } .getMenu { z-index: 1000; display: none; background: white; list-style: none; border: 1px solid skyblue; width: 150px; height: auto; max-height: 200px; position: absolute; left: 0; top: 25px; overflow: auto; } .getMenu li { width: 148px; padding-left: 10px; line-height: 22px; font-size: 14px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis; } .getMenu li:hover { background: #eee; cursor: pointer; } .a-upload { padding: 4px 10px; height: 30px; line-height: 20px; position: relative; cursor: pointer; color: #888; background: #fafafa; border: 1px solid #ddd; border-radius: 4px; overflow: hidden; display: inline-block; *display: inline; *zoom: 1 } .a-upload input { position: absolute; font-size: 100px; right: 0; top: 0; opacity: 0; filter: alpha(opacity = 0); cursor: pointer } .a-upload:hover { color: #444; background: #eee; border-color: #ccc; text-decoration: none } .pagination-info { float: left; margin-top: - 4px; } .modal-body { text-align:-webkit-center; text-align:-moz-center; width: 600px; margin: auto; } .btn-primary { color: #fff; background-color: #0099CC; border-color: #0099CC; }
            @media screen and (min-width:0px) and (max-width:666px) {  
                #addutable{
                    margin-left: -240px;
                }
                #updatetable{
                    margin-left: -240px;
                }
                #adddiv{
                    width: 350px;
                }
                #adddiv input{

                    width: 100px;
                }

                #sex{
                    width: 100px;
                }
                #sex_edit{
                    width: 100px;  
                }
                #sel_menu2{
                    width: 200px;
                }
                #sel_menu1{
                    width: 200px;
                }

                #updatediv {
                    width: 350px;
                }


                #name_edit{
                    width: 100px;
                }

                #phone_edit{
                    width: 100px;
                }

                #email_edit{
                    width: 100px;
                }

                #department_edit{
                    width: 100px;
                }

                #updaterole{
                    width: 100px;
                }


            }
            /*            手机横屏*/
            @media screen and (min-width:667px) and (max-width:767px) {  
                #adddiv{
                    width: 500px;
                }
                #adddiv input{

                    width: 150px;
                }

                #sex{
                    width: 150px;
                }
                #sel_menu2{
                    width: 250px;
                }
                #updatediv{
                    width: 500px;
                }

                #sel_menu1{
                    width: 250px;
                }

                #name_edit{
                    width: 150px;
                }

                #phone_edit{
                    width: 150px;
                }

                #email_edit{
                    width: 150px;
                }

                #department_edit{
                    width: 150px;
                }

                #updaterole{
                    width: 150px;
                }

                #sex_edit{
                    width: 150px;  
                }


            }

            /*           ipad竖屏*/
            @media screen and (min-width:767px) and (max-width:1023px) {  
                #adddiv{
                    width: 500px;
                }
                #adddiv input{
                    width: 150px;
                }

                #sex{
                    width: 150px;
                }
                #sel_menu2{
                    width: 250px;
                }

                #updatediv{
                    width: 500px;
                }

                #sel_menu1{
                    width: 250px;
                }

                #name_edit{
                    width: 150px;
                }

                #phone_edit{
                    width: 150px;
                }

                #email_edit{
                    width: 150px;
                }

                #department_edit{
                    width: 150px;
                }

                #updaterole{
                    width: 150px;
                }

                #sex_edit{
                    width: 150px;  
                }

            }

            @media screen and (min-width:1024px){  
                #adddiv{
                    width: 500px;
                }
                #updatediv{
                    width: 500px;
                }
                #adddiv input{
                    width: 150px;
                }

                #sex{
                    width: 150px;
                }
                #sel_menu2{
                    width: 350px;
                }

                #updatediv{
                    width: 500px;
                }

                #sel_menu1{
                    width: 350px;
                }

                #name_edit{
                    width: 150px;
                }

                #phone_edit{
                    width: 150px;
                }

                #email_edit{
                    width: 150px;
                }

                #department_edit{
                    width: 150px;
                }

                #updaterole{
                    width: 150px;
                }

                #sex_edit{
                    width: 150px;  
                }

            } 
        </style>


        <script>

            var u_name = "${param.name}";
            var o_pid = "${param.pid}";
            $(function () {

                $("#sel_menu2").select2();
                $("#sel_menu1").select2();


                //获取所有项目
                var pid;
                var id = "${param.userId}";
                $.ajax({url: "login.project.getuserProject.action", async: false, type: "get", datatype: "JSON", data: {id: id},
                    success: function (data) {
                        pid = data.rs[0].pid;
                    },
                    error: function () {
                        alert("出现异常！");
                    }
                });
                var pids = pid.split(",");   //项目编号
                var pname = [];   //项目名称
                for (var i = 0; i < pids.length; i++) {
                    var obj = {};
                    obj.code = pids[i];
                    $.ajax({url: "login.main.getpojcetname.action", async: false, type: "get", datatype: "JSON", data: obj,
                        success: function (data) {
                            pname.push(data.rs[0].name);
                        },
                        error: function () {
                            alert("出现异常！");
                        }
                    });
                }

                for (var i = 0; i < pids.length; i++) {
                    var options;
                    options += "<option value=\"" + pids[i] + "\">" + pname[i] + "</option>";
                    $("#sel_menu2").html(options);
                    $("#sel_menu1").html(options);
                }

                var userid = "${param.userId}";
                $('#gravidaTable').bootstrapTable({
                    url: 'login.usermanage.query.action?u_parent_id=' + userid,
                    columns: [
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
                            field: 'name',
                            title: '用户名', //用户名
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            field: 'department',
                            title: '部门', //部门
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            field: 'phone',
                            title: '电话', //电话
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            field: 'sex',
                            title: '性别', //性别
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            field: 'email',
                            title: '邮箱', //邮箱
                            width: 25,
                            align: 'center',
                            valign: 'middle'
                        }, {
                            field: 'pid',
                            title: '管理项目', //管理项目
                            width: 25,
                            align: 'center',
                            valign: 'middle',
                            formatter: function (value, row, index, field) {
                                var pids = [];
                                if (value != "") {
                                    pids = value.split(",");   //项目编号 
                                }
                                // $("#pojects").val(pids[0]);
                                var pname = "";   //项目名称
                                for (var i = 0; i < pids.length; i++) {
                                    var obj = {};
                                    obj.code = pids[i];
                                    $.ajax({url: "login.main.getpojcetname.action", async: false, type: "get", datatype: "JSON", data: obj,
                                        success: function (data) {
                                            if (i == pids.length - 1) {
                                                pname += data.rs[0].name;
                                            } else {
                                                pname = pname + data.rs[0].name + "、";
                                            }
                                        },
                                        error: function () {
                                            alert("出现异常！");
                                        }
                                    });
                                }
                                return pname;
                            }
                        }],
                    clickToSelect: true,
                    singleSelect: true,
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
                    pageList: [10, 15],
                    onLoadSuccess: function () {  //加载成功时执行  表格加载完成时 获取集中器在线状态
                        //                        console.info("加载成功");
                    },
                    //服务器url
                    queryParams: function (params)  {   //配置参数     
                        var temp  =   {    //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的 
                            search: params.search,
                            skip: params.offset,
                            limit: params.limit,
                            type_id: "1"    
                        };      
                        return temp;  
                    },
                });
                //添加用户
                $("#tianjia1").click(function () {
                    var userid = "${param.id}";  //调用首页的getuserId方法
                    //alert( $("#userid").val());
                    var obj = $("#Form_User").serializeObject();
                    if (obj.name == "") {
                        layerAler('用户名不能为空'); // 用户名不能为空
                        return false;
                    }

                    var nobj = {};
                    nobj.name = obj.name;
                    var isok = true;
                    $.ajax({async: false, url: "login.usermanage.isusername.action", type: "POST", datatype: "JSON", data: nobj,
                        success: function (data) {
                            var arrlist = data.rs;
                            if (arrlist.length > 0) {
                                alert('该用户名已存在，请输入新的用户名');  //该用户名已存在，请输入新的用户名
                                isok = false;
                            }
                        },
                        error: function () {
                            alert("提交失败！");
                        }
                    });
                    if (isok) {
                        var pid = $("#sel_menu2").val(); //项目
                        var pids = "";
                        if (pid != "" && pid != null) {
                            for (var i = 0; i < pid.length; i++) {
                                if (i == pid.length - 1) {
                                    pids += pid[i];
                                } else {
                                    pids += pid[i] + ",";
                                }

                            }
                        }


                        obj.pid = pids;
                        obj.u_parent_id = userid;  //用户的父id
                        obj.password = hex_md5("123");
                        $.ajax({url: "login.usermanage.addUser.action", async: false, type: "get", datatype: "JSON", data: obj,
                            success: function (data) {
                                var arrlist = data.rs;
                                if (arrlist.length == 1) {
                                    layerAler('添加成功'); //添加成功
                                    $("#gravidaTable").bootstrapTable('refresh');
                                    $("#pjj").modal('hide'); //手动关闭
                                    addlogon(u_name, "添加", o_pid, "用户管理", "添加用户【" + obj.name + "】");
                                }
                            },
                            error: function () {
                                alert("提交添加失败！");
                            }
                        });

                    }
                });
            });

            function layerAler(str) {
                layer.alert(str, {
                    icon: 6,
                    offset: 'center'
                });
            }


            function edituser() {
                var selects = $('#gravidaTable').bootstrapTable('getSelections');
                if (selects.length <= 0) {
                    layerAler('请勾选表格数据'); //请勾选表格数据
                    return;
                }
                var select = selects[0];
                $("#name_edit").val(select.name);
                $("#sex_edit").val(select.sex);
                $("#department_edit").val(select.department);
                $("#email_edit").val(select.email);
                $("#phone_edit").val(select.phone);
                $("#id").val(select.id);
                $("#pjj2").modal();
                $("#updaterole").combobox('setValue', select.m_code);
                var pid = select.pid;
                $("#hpid").val(pid);
                var pid2 = pid.split(",");
                $('#sel_menu1').val(pid2).trigger('change');
            }
            //修改
            function editaction() {
                var pid = $("#sel_menu1").val(); //项目
                var pids = "";
                if (pid != null) {
                    for (var i = 0; i < pid.length; i++) {
                        if (i == pid.length - 1) {
                            pids += pid[i];
                        } else {
                            pids += pid[i] + ",";
                        }

                    }
                }

                var formobj = $("#Form_Edit").serializeObject();
                formobj.email = formobj.email_edit;
                formobj.department = formobj.department_edit;
                formobj.name = formobj.name_edit;
                formobj.phone = formobj.phone_edit;
                formobj.sex = formobj.sex_edit;
                formobj.pid = pids;
                formobj.m_code = formobj.up_role;
                $.ajax({url: "login.usermanage.editUser.action", async: false, type: "get", datatype: "JSON", data: formobj,
                    success: function (data) {
                        var arrlist = data.rs;
                        if (arrlist.length == 1) {
                            layerAler("修改成功"); //修改成功
                            $("#gravidaTable").bootstrapTable('refresh');
                            $("#pjj2").modal('hide'); //手动关闭
                            addlogon(u_name, "修改", o_pid, "用户管理", "修改用户【" + formobj.name_edit + "】信息");
                        }
                    },
                    error: function () {
                        alert("提交添加失败！");
                    }
                });
                //查看是否存在子孙用户
                var uid = formobj.id;
                $.ajax({async: false, url: "login.usermanage.loopsunuser.action", type: "POST", datatype: "JSON", data: {id: uid},
                    success: function (data) {
                        var arrlist = data.rs;
                        if (arrlist.length > 0) {
                            for (var i = 0; i < arrlist.length; i++) {
                                var id = arrlist[i].id;
                                upsunmUserP(id, pid);
                            }
                        }
                    },
                    error: function () {
                        layerAler("提交失败");
                    }
                });
            }

            //修改子孙用户权限
            function upsunmUserP(id, pid) {
                //pid 为父项目id
                //查看子用户管理的项目
                var sumpid = []; //子用户项目id
                $.ajax({async: false, url: "login.project.getuserProject.action", type: "POST", datatype: "JSON", data: {id: id},
                    success: function (data) {
                        var rs = data.rs;
                        console.log("p:" + rs[0].pid);
                        if(pid == null || pid == ""){
                            sumpid = [];
                        }else if (rs[0].pid != "" && rs[0].pid != null) {
                            sumpid = rs[0].pid.split(",");
                            console.log("0" + sumpid);
                            for (var i = 0; i < sumpid.length; i++) {
                                for (var j = 0; j < pid.length; j++) {
                                    if (pid[j] == sumpid[i]) {
                                        continue;
                                    } else if (j == pid.length - 1) {
                                        sumpid.splice(i, 1);  //移除不相同的；
                                    }
                                }

                            }
                        }

                        console.log("l:" + sumpid.length);
                        console.log("list:" + sumpid);
                        var sumpids = "";  //子用户管理项目字符串
                        if (sumpid.length > 0) {
                            for (var k = 0; k < sumpid.length; k++) {
                                if (k == sumpid.length - 1) {
                                    sumpids += pid[k];
                                } else {
                                    sumpids += sumpid[k] + ",";
                                }
                            }
                        }
                        //修改子用户项目
                        var obj = {};
                        obj.id = id;
                        obj.pid = sumpids;
                        $.ajax({async: false, url: "login.usermanage.editUpid.action", type: "POST", datatype: "JSON", data: obj,
                            success: function (data) {

                            },
                            error: function () {
                                layerAler("提交失败1");
                            }
                        });
                    },
                    error: function () {
                        layerAler("提交失败2");
                    }
                });

                //查看是否存在子用户
                $.ajax({async: false, url: "login.usermanage.loopsunuser.action", type: "POST", datatype: "JSON", data: {id: id},
                    success: function (data) {
                        var arrlist = data.rs;
                        if (arrlist.length > 0) {
                            for (var i = 0; i < arrlist.length; i++) {
                                var uid = arrlist[i].id;
                                upsunmUserP(uid, pid);
                            }
                        }
                    },
                    error: function () {
                        layerAler("提交失败");
                    }
                });

            }

            function deleteUser() {
                var selects = $('#gravidaTable').bootstrapTable('getSelections');
                var num = selects.length;
                if (num == 0) {
                    layerAler('请勾选表格数据'); //请勾选表格数据
                    return;
                }
                layer.confirm("确定要删除吗？", {//确定要删除吗？
                    btn: ["确定", "取消"]//确定、取消按钮
                }, function (index) {
                    var select = selects[0];
                    var uid = select.id;
                    $.ajax({async: false, url: "login.usermanage.deleteUser.action", type: "POST", datatype: "JSON", data: {id: select.id},
                        success: function (data) {
                            var arrlist = data.rs;
                            if (arrlist.length == 1) {
                                $("#gravidaTable").bootstrapTable('refresh');
                                addlogon(u_name, "删除", o_pid, "用户管理", "删除用户【" + select.name + "】");
                            }
                        },
                        error: function () {
                            layerAler("提交失败");
                        }
                    });

                    $.ajax({async: false, url: "login.usermanage.loopsunuser.action", type: "POST", datatype: "JSON", data: {id: uid},
                        success: function (data) {
                            var arrlist = data.rs;
                            if (arrlist.length > 0) {
                                for (var i = 0; i < arrlist.length; i++) {
                                    var id = arrlist[i].id;
                                    deletesumUser(id);
                                }
                            }
                        },
                        error: function () {
                            layerAler("提交失败");
                        }
                    });
                    layer.close(index);
                    //此处请求后台程序，下方是成功后的前台处理……
                });
            }
            //删除子孙用户
            function  deletesumUser(id) {

                $.ajax({async: false, url: "login.usermanage.loopsunuser.action", type: "POST", datatype: "JSON", data: {id: id},
                    success: function (data) {
                        var arrlist = data.rs;
                        var uid = id;
                        if (arrlist.length > 0) {
                            for (var i = 0; i < arrlist.length; i++) {
                                uid = arrlist[i].id;
                                deletesumUser(uid);
                            }
                        }
                    },
                    error: function () {
                        layerAler("提交失败");
                    }
                });

                $.ajax({async: false, url: "login.usermanage.deleteUser.action", type: "POST", datatype: "JSON", data: {id: id},
                    success: function (data) {
                        var arrlist = data.rs;
                        if (arrlist.length == 1) {
                            $("#gravidaTable").bootstrapTable('refresh');
                           // addlogon(u_name, "删除", o_pid, "用户管理", "删除用户");
                        }
                    },
                    error: function () {
                        layerAler("提交失败");
                    }
                });
            }
            //重置密码
            function  chongzhimima() {
                var selects = $('#gravidaTable').bootstrapTable('getSelections');
                var select = selects[0];
                var id = select.id;
                var pwd = hex_md5("123");
                var pwdobj = {};
                pwdobj.id = id;
                pwdobj.password = pwd;
                $.ajax({url: "login.usermanage.updatePwd.action", async: false, type: "get", datatype: "JSON", data: pwdobj,
                    success: function (data) {
                        var arrlist = data.rs;
                        if (arrlist.length == 1) {
                            layerAler('重置成功');  //重置成功
                            addlogon(u_name, "重置密码", o_pid, "用户管理>编辑", "重置用户密码");
                        } else {
                            layerAler('重置失败');  //重置失败
                        }
                    },
                    error: function () {
                        alert("提交添加失败！");
                    }
                });
            }




        </script>

    </head>
    <body>

        <div class="btn-group zuheanniu" id="zuheanniu" style="float:left;position:relative;z-index:100;margin:12px 0 0 10px;">
            <button class="btn btn-success ctrol" data-toggle="modal" data-target="#pjj" name="8000101" id="add">
                <span class="glyphicon glyphicon-plus-sign"></span>&nbsp;<span name="xxx" id="65">添加</span>
            </button>
            <button class="btn btn-primary ctrol"   onclick="edituser()"  id="update">
                <span class="glyphicon glyphicon-pencil"></span>&nbsp;<span name="xxx" id="66">编辑</span>
            </button>
            <button class="btn btn-danger ctrol" onclick="deleteUser();" id="del" >
                <span class="glyphicon glyphicon-trash"></span>&nbsp;<span name="xxx" id="67">删除</span>
            </button>       

        </div>
        <div class="bootstrap-table">
            <div class="fixed-table-container">
                <table id="gravidaTable" style="width:100%;" class="table table-hover table-striped">
                </table>  
            </div>
        </div>



        <!-- 添加 -->
        <div class="modal" id="pjj" data-backdrop="static">
            <div class="modal-dialog">
                <div class="modal-content" id="adddiv">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            <span style="font-size:20px ">×</span></button>
                        <span class="glyphicon glyphicon-floppy-disk" style="font-size: 20px"></span>
                        <h4 class="modal-title" style="display: inline;"><span>添加用户</span></h4></div>

                    <form action="" method="POST" id="Form_User">      
                        <div class="modal-body">
                            <table id="addutable">
                                <tbody>
                                    <tr>
                                        <td>
                                            <span style="margin-left:-15px;"><span name="xxx" id="223">用户名</span>&nbsp;</span>
                                            <input id="name"    class="form-control"  name="name" style="display: inline;" placeholder="请输入名字" type="text"></td>
                                        <td></td>
                                        <td>
                                            <span style="margin-left:10px;" name="xxx" id="225">姓别</span>&nbsp;
                                            <span class="menuBox">
                                                <select name="sex" id="sex">
                                                    <option value="男">男</option>
                                                    <option value="女">女</option>
                                                </select>
                                            </span>    
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <span style="margin-left:0px;" name="xxx" id="136">电话</span>&nbsp;
                                            <input id="phone" class="form-control"  name="phone" style="display: inline;" placeholder="请输入电话" type="text"></td>
                                        <td></td>
                                        <td>
                                            <span style="margin-left:10px;" name="xxx" id="137" >邮箱</span>&nbsp;
                                            <input id="email" class="form-control" name="email" style="display: inline;" placeholder="请输入邮箱" type="text"></td>
                                        </td>
                                    </tr>                                   

                                    <tr>
                                        <td>
                                            <span style="margin-left:0px;" name="xxx" id="224">部门</span>&nbsp;
                                            <input id="department" class="form-control"  name="department" style="display: inline;" placeholder="请输入部门名称" type="text"></td>
                                        <td></td>
                                        <td>
                                            <span style="margin-left:10px;" name="xxx" id="233">角色</span>&nbsp;
                                            <input id="role" class="easyui-combobox" name="m_code" style=" height: 34px" data-options="editable:true,valueField:'id', textField:'text',url:'login.usermanage.rolemenu.action?parent_id=${param.role}'" />
                                        </td>
                                    </tr> 
                                    <tr>
                                        <td colspan="3">
                                            <span style="margin-left:0px;" name="xxx" id="1">项目</span>&nbsp;
                                            <select id="sel_menu2" multiple="multiple">

                                            </select>
                                        </td>

                                    </tr>


                                </tbody>
                            </table>
                        </div>
                        <!-- 注脚 -->
                        <div class="modal-footer">
                            <!-- 添加按钮 -->
                            <button id="tianjia1" type="button" class="btn btn-primary"><span name="xxx" id="65">添加</span></button>
                            <!-- 关闭按钮 -->
                            <button type="button" class="btn btn-default" data-dismiss="modal"><span name="xxx" id="57">关闭</span></button></div>
                    </form>
                </div>
            </div>
        </div>

        <!-- 修改 -->
        <div class="modal" id="pjj2" data-backdrop="static">
            <div class="modal-dialog">
                <div class="modal-content" style="updatediv">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            <span style="font-size:20px ">×</span></button>
                        <span class="glyphicon glyphicon-floppy-disk" style="font-size: 20px"></span>
                        <h4 class="modal-title" style="display: inline;"><span name="xxx" id="234">修改用户信息</span></h4></div>
                    <form action="" method="POST" id="Form_Edit" onsubmit="return checkLampModify()">     
                        <input type="hidden" id="id" name="id" />
                        <input type="hidden" id="hpid"  />
                        <div class="modal-body">
                            <table id="updatetable">
                                <tbody>
                                    <tr>
                                        <td>
                                            <span style="margin-left:5px;" name="xxx" id="223">用户名</span>&nbsp;
                                            <input id="name_edit" readonly="true"   class="form-control"  name="name_edit" style="display: inline;"  type="text" readonly="readonly"></td>
                                        <td></td>
                                        <td>
                                            <span style="margin-left:10px;" name="xxx" id="225">姓别</span>&nbsp;
                                            <span class="menuBox">
                                                <select name="sex_edit" id="sex_edit">
                                                    <option value="男">男</option>
                                                    <option value="女">女</option>
                                                </select>
                                            </span>    
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <span style="margin-left:20px;" name="xxx" id="136">电话</span>&nbsp;
                                            <input id="phone_edit" class="form-control"  name="phone_edit" style="display: inline;" placeholder="请输入电话" type="text"></td>
                                        <td></td>
                                        <td>
                                            <span style="margin-left:10px;" name="xxx" id="137">邮箱</span>&nbsp;
                                            <input id="email_edit" class="form-control" name="email_edit" style="display: inline;" placeholder="请输入邮箱" type="text"></td>
                                        </td>
                                    </tr>                                   

                                    <tr>
                                        <td>
                                            <span style="margin-left:20px;" name="xxx" id="224">部门</span>&nbsp;
                                            <input id="department_edit" class="form-control"  name="department_edit" style="display: inline;" placeholder="请输入部门名称" type="text"></td>
                                        <td></td>
                                        <td>
                                            <span style="margin-left:10px;" name="xxx" id="233">角色</span>&nbsp;
                                            <input id="updaterole" class="easyui-combobox" name="up_role" style="height: 34px" data-options="editable:true,valueField:'id', textField:'text',url:'login.usermanage.rolemenu.action?parent_id=${param.role}'" />
                                        </td>
                                    </tr>
                                    <tr>                                
                                        <td colspan='3' >
                                            <span style="margin-left:10px;" name="xxx" id="1">项目</span>&nbsp;
                                            <select id="sel_menu1" multiple="multiple">

                                            </select>
                                        </td>
                                    </tr> 

                                </tbody>
                            </table>
                        </div>
                        <!-- 注脚 -->
                        <div class="modal-footer" id="modal_footer_edit" >
                            <!-- 添加按钮 -->
                            <button  type="button" onclick="chongzhimima()" class="btn btn-primary"><span id="235" name="xxx">重置密码</span></button>
                            <!-- 添加按钮 -->
                            <button id="xiugai" type="button" onclick="editaction()" class="btn btn-primary"><span id="151" name="xxx">修改</span></button>
                            <!-- 关闭按钮 -->
                            <button type="button" class="btn btn-default" data-dismiss="modal"><span id="57" name="xxx">关闭</span></button>
                        </div>
                    </form>
                </div>
            </div>
        </div>




    </body>
</html>
