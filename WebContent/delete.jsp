<%@ page import="java.sql.*, info.searchman.jsh_test"
    contentType="text/html; charset=UTF-8" %>
<%



//インスタンスの生成
jsh_test db = new jsh_test();

//データベースへのアクセス
db.open();

String strNO = request.getParameter("NO");

//登録内容の取得
ResultSet rs = db.getResultSet("SELECT name, address, number FROM tbl_meibo WHERE NO=" + strNO + ";");

rs.next();
String name      = rs.getString("name"); // 名前を取得
String address      = rs.getString("address"); // 住所を取得
String number      = rs.getString("number"); // 電話番号を取得

//データベースへのコネクションを閉じる
db.close();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>住所録：削除</title>
</head>
<body>

<b style="position: relative; left: 50px; top: 30px">下記の住所録を削除します。よろしいですか？</b>
<br>
<br>
<br>
<br>
<form action="http://localhost:8080/project_test/dlt"
      method="post"
      style="position: relative; left: 90px;"
      >

  <p>
     <label style="position: relative; right: 32px;">名 　前   　  ：</label>
     <label><%= name %></label><br>
     <label style="position: relative; right: 32px;">住 　所   　  ：</label>
     <label><%= address %></label><br>
     <label style="position: relative; right: 32px;">電話番号：</label>
     <label><%= number %></label><br>

     <input type=hidden name="NO" value=<%= strNO %>>
  </p>
  <br>
  <p>

<input type="submit"  style="width:100px" value="OK">
<input type="button" style="width:100px" onclick="location.href='jsh_test.jsp?pageID=1'"value="キャンセル">

</form>
</body>
</html>