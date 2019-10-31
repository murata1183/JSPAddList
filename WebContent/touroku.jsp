<%@ page import="java.sql.*, info.searchman.jsh_test"
    contentType="text/html; charset=UTF-8"  %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>住所録：新規登録</title>
</head>
<body>
<b style="position: relative; left: 50px; top: 5px">住所録管理システム：住所録登録</b>
<br>
<br>
<br>
<br>
<form action="snk_kakunin.jsp" method="post" style="position: relative; left: 90px;">

  <p>
      <label for="nm">名前：</label>
      <input type="text" name="name"  size="60" maxlength="10" required><br>
      <label for="ju">住所：</label>
      <input type="text" name="address"  size="60" maxlength="50" required><br>
      <label for="nu"style="position: relative; right: 32px;">電話番号：</label>
      <input type="text" name="number"  size="60" style="position: relative; right: 32px;"  pattern="\d{1,5}-\d{1,4}-\d{4,5}" title="電話番号は、市外局番からハイフン（-）を入れて半角で記入してください。" required>
  </p>
  <br>
  <p>

<input type="submit" value="確認">
<input type="button" onclick="location.href='jsh_test.jsp?pageID=1'"value="もどる">

</form>

</body>
</html>