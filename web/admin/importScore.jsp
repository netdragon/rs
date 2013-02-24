<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="edu.cup.rs.reg.*" %>
<%@ page import="edu.cup.rs.reg.sys.*" %>
<%@include file="../common/access_control.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>导入考生成绩</title>
</head>
<body>
<form action="/input_score" enctype="multipart/form-data" method="post" >
<input name="scorefile" type="file" id="scorefile" />&nbsp;&nbsp;<span class="p1"></span>
<input value="提交" type="submit"/>
</form>

</body>
</html>
