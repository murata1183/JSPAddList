<%@ page import="java.sql.*, info.searchman.jsh_test"
    contentType="text/html; charset=UTF-8" %>

<%
//文字コードの決定
request.setCharacterEncoding("UTF-8");
//
jsh_test db = new jsh_test();


//データベース接続
db.open();


//各データの取得
String strname =request.getParameter("name");
String straddress =request.getParameter("address");
String strnumber =request.getParameter("number");


//コンソールに出力
//System.out.println(strname);
//System.out.println(straddress);
//System.out.println(strnumber);

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登録確認</title>
</head>
<body>
<b style="position: relative; left: 50px; top: 30px">住所録管理システム：住所録登録</b>
<br>
<br>
<br>
<br>
	<form action="http://localhost:8080/project_test/snk" method="post"
		style="position: relative; left: 90px;">

		<p>

			<label>名前：</label>
			<%
				out.print(strname);
			%><br> <label>住所：</label>
			<%
				out.print(straddress);
			%><br> <label
				style="position: relative; right: 32px;">電話番号：</label>
			<%
				out.print(strnumber);
			%>


			<input type=hidden name="name" value=<%=strname%>> <input
				type=hidden name="address" value=<%=straddress%>> <input
				type=hidden name="number" value=<%=strnumber%>>
		<p>

			<input type="submit" style="width: 100px" ; value="登録"> <input
				type="button" style="width: 100px"
				onclick="location.href='touroku.jsp'" value="もどる">
	</form>
</body>
</html>