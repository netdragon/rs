<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="edu.cup.rs.common.*"%>
<%@ page import="edu.cup.rs.log.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="edu.cup.rs.reg.*"%>

<%
request.setCharacterEncoding("UTF-8"); 
String file = BaseFunction.null2value(request.getParameter("curr_file"));
String root = request.getRealPath("/");

FileInputStream input = null;
InputStreamReader isr = null;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		 <style type="text/css" rel="stylesheet">
			form {
			margin: 0;
			}
			.editor {
			margin-top: 5px;
			margin-bottom: 5px;
			}
		  </style>
		<script charset="utf-8" src="/kindeditor/kindeditor.js"></script>
		<script>
			KE.show({
				id : 'editor',
				skinType: 'tinymce',
				cssPath : './index.css',
				imageUploadJson : '/kindeditor/jsp/upload_json.jsp',
				fileManagerJson : '/kindeditor/jsp/file_manager_json.jsp',
				allowFileManager : true,
				filterMode : true,
				items : [
					'source', '|', 'fullscreen', 'print', 'undo', 'redo', 'cut', 'copy', 'paste',
					'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
					'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
					'superscript', '|', 'emoticons', 'link', 'unlink', '-',
					'title', 'fontname', 'fontsize', '|', 'textcolor', 'bgcolor', 'bold',
					'italic', 'underline', 'strikethrough', 'removeformat', 'selectall', '|', 'image',
					'flash', 'media', 'table', 'preview'
				]
			});
		</script>
		<script>
			function act(){
				document.getElementById("editor").value = KE.util.getData("editor");
				//alert(document.getElementById("editor").value);
				document.forms[0].submit();
			}
		</script>
	</head>
	<body>
	<form method="post" action="/save_file">
	<table border="0" width="99%" align="center">
	<tr>
		<td>
		<input type="button" onclick="window.location.assign('edit_static_page.jsp?curr_file=jianzhang.html');" value="招生简章修改">&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" onclick="window.location.assign('edit_static_page.jsp?curr_file=bmlch.html');" value="报名流程修改">&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" onclick="window.location.assign('edit_static_page.jsp?curr_file=bmzysx.html');" value="注意事项修改">
		<input type="hidden" value="<%=file%>" name="edit_file">
		</td>
	</tr>
	<tr>
		<td>
		<textarea id="editor" name="content" style="width:100%;height:400px;visibility:hidden;">
<%
if(file.length() > 0){
	file = root + "/admin/" + file;
	try {
		char[] buff = new char[1024];
		input = new FileInputStream(file);
		isr = new InputStreamReader(input, "utf-8");
		int len = 0;
		while((len = isr.read(buff)) > 0) {
			out.write(buff, 0, len);
		}
	}
	catch(Exception e) {
		out.write(e.getMessage());
	}
	finally {
		if(null != isr) isr.close();
		if(null != input) input.close();
	}
}
%>
		</textarea>
		</td>
	</tr>
	<tr>
		<td>
		<input type="button" onclick="act();" value="提  交">&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" onclick="window.location('xtwh.jsp');" value="取  消">
		</td>
	</tr>
	</form>
	</body>
</html>
