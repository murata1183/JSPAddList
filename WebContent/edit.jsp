<%@ page import="java.sql.*, info.searchman.jsh_test"
    contentType="text/html; charset=UTF-8" %>

<%
//インスタンスの生成
jsh_test db = new jsh_test();

//データベースへのアクセス
db.open();

String strNO = request.getParameter("NO");

//登録内容の取得
ResultSet rs = db.getResultSet("SELECT name, address, number FROM tbl_meibo WHERE NO=" + strNO + "");

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
<title>住所録：編集</title>
</head>
<body>
<b style="position: relative; left: 50px; top: 5px">住所録管理システム：住所録編集</b>
<br>
<br>
<br>
<br>
<form action="edt_kakunin.jsp" method="post" style="position: relative; left: 90px;">

  <p>
      <label style="position: relative; right: 32px;">名 　前   　  ：</label>
      <input type="text" name="name"  size="60" value=<%= name %> maxlength="10" required><br>
      <label style="position: relative; right: 32px;">住 　所   　  ：</label>
      <input type="text" name="address"  size="60" value=<%= address %> maxlength="50" required><br>
      <label style="position: relative; right: 32px;">電話番号：</label>
      <input type="text" name="number"  size="60" style="position: relative; right: 0px;" value=<%= number %> pattern="\d{1,5}-\d{1,4}-\d{4,5}" title="電話番号は、市外局番からハイフン（-）を入れて半角で記入してください。" required>

      <input type=hidden name="NO" value=<%= strNO %>>
  </p>
  <br>
  <p>

<input type="submit" value="確認">
<input type="button" onclick="location.href='jsh_test.jsp?pageID=1'"value="もどる">

</form>
</body>
</html>