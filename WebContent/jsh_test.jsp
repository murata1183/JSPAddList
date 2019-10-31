<%@ page import="java.sql.*, info.searchman.jsh_test"
	contentType="text/html; charset=UTF-8"
	import="java.sql.*,
    java.text.*,
    java.util.ArrayList,
    javax.servlet.http.HttpSession,
    java.sql.Statement,
    java.sql.SQLException,
    java.io.UnsupportedEncodingException,
	java.net.URLEncoder,
	java.net.URLDecoder"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>住所録：一覧</title>
</head>
<style>
@media ( max-width : 320px) {
	div#sidebar {
		width: 100%;
	}
}

@media ( min-width : 321px) and (max-width: 768px) {
	div#sidebar {
		width: 768px;
	}
}

@media ( min-width : 769px) {
	div#sidebar {
		width: 960px;
	}
}
</style>
<body>
	<div
		style="width: 100%; text-overflow: ellipsis; overflow: hidden; white-space: nowrap;">
		<b>住所録管理システム：住所録一覧</b> <br> <br>

		<%
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");

			//Database Access
			jsh_test db = new jsh_test();
			db.open();
			Connection con = null;
			Statement stmt = null;
			ResultSet rs = null;

			//Variable declaration
			int NO;
			String name;
			String address;
			String number;
			String sort;
			String search;

			//pageID get
			String pageID = request.getParameter("pageID");
			int page_now = 1;
			if (pageID == null) {
				page_now = 1;
			} else {
				try {
					page_now = Integer.parseInt(pageID);
				} catch (NumberFormatException e) {
					page_now = 1;
				}
			}

			//sort get
			sort = request.getParameter("sort");
			if (sort == null)
				sort = "NO";

			//search results get
			search = request.getParameter("search");
			String search_enco = "";
			if (search == null)
				search = "";
			if (search != "")
				search_enco = URLEncoder.encode(search, "UTF-8");
			if (search.matches(".*%.*"))
				search = URLDecoder.decode(search, "UTF-8");
			if (search == null)
				search = ".*";

			//Connect to database
			con = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/db_jushoroku?serverTimezone=JST&useUnicode=true&characterEncoding=utf8",
					"root", "");

			//Database operation
			stmt = con.createStatement();

			// SQL(セレクト文)を実行して、結果を得る(ソート)
			if (sort.equals("NO")) {
				rs = stmt.executeQuery("select * from tbl_meibo ORDER BY NO ASC");
				rs = db.getResultSet("select * from tbl_meibo");
			} else if (sort.equals("address")) {
				rs = stmt.executeQuery("select * from tbl_meibo ORDER BY address ASC");

			} else if (sort.equals("number")) {
				rs = stmt.executeQuery("select * from tbl_meibo ORDER BY number ASC");
			}
		%>
		<%-- sign up --%>
		<a href=http://localhost:8080/project_test/touroku.jsp> <input
			type="button" name="a" style="width: 80px; height: 25px" value="新規登録"
			style="position: absolute; left: 15px; top: 50px" />
		</a>
		<%-- Search word --%>
		<form action="http://localhost:8080/project_test/jsh_test.jsp"
			accept-charset="UTF8" method="post"
			style="position: absolute; left: 430px; top: 60px">
			<span style="font-size: 12pt">住所：</span> <input type="search"
				name="search" placeholder="住所で検索""> <input type="submit"
				value="検索"> <input type="hidden" name=sort id=sort
				value="<%=sort%>">
		</form>
		<br> <br>

		<%
			//----Page link code------------
			String tableHTML = "<table border=1>";

			//Get all pages
			rs.last();
			int date = rs.getRow();
			int page_all = 1;

			if (date != 0)
				page_all += date / 10;

			if (page_all % 10 != 0)
				page_all++;

			rs.first();

			//Get deleted data and search exclusions
			int Determine;
			int p = 1;
			int sakujo_suu = 0;
			int jogai_suu = 0;
			int id;
			for (; p <= date; p++) {
				Determine = rs.getInt("Determine");
				address = rs.getString("address");
				if (Determine == 1)
					sakujo_suu++;
				else if (!address.matches(".*" + search + ".*"))
					jogai_suu++;
				rs.next();
			}
			rs.first();

			//Data other than deletion and search exclusion
			date -= sakujo_suu;
			date -= jogai_suu;
			if (sakujo_suu != 0)
				page_all -= (sakujo_suu / 10) + 1;
			if (jogai_suu != 0)
				page_all -= (jogai_suu / 10);

			//Link number 5 number decision
			int page_hiku2 = page_now - 2;
			int page_tasu2 = page_now + 2;

			if (page_hiku2 <= 1)
				;
			page_hiku2 = 1;
			if (page_tasu2 > page_all)
				page_tasu2 = page_all;

			int i = 1;
			int date_first = 1;
			int date_last = 10;
			int x = 0;

			//----------------paging------------------------------
			//<<
			if (page_now == 1)
				tableHTML += "<<";
			else
				tableHTML += "<a href=http://localhost:8080/project_test/jsh_test.jsp?pageID=" + 1 + "&search="
						+ search_enco + "&sort=" + sort + ">" + "<<" + "</a>";

			//<
			if (page_now == 1) {
				tableHTML += "&nbsp;";
				tableHTML += "&nbsp;";
				tableHTML += "<";
				tableHTML += "&nbsp;";
			}

			else {
				x = page_now - 1;
				tableHTML += "&nbsp;";
				tableHTML += "&nbsp;";
				tableHTML += "<a href=http://localhost:8080/project_test/jsh_test.jsp?pageID=" + x + "&search="
						+ search_enco + "&sort=" + sort + ">" + "<" + "</a>";
				tableHTML += "&nbsp;";

			}

			//Page link

			for (i = page_hiku2; page_hiku2 <= i && i <= page_tasu2; i++) {
				if (i == page_now) {
					tableHTML += "&nbsp;";
					tableHTML += i;
					tableHTML += "&nbsp;";
					tableHTML += "&nbsp;";
				} else {
					tableHTML += "&nbsp;";
					tableHTML += "<a href=http://localhost:8080/project_test/jsh_test.jsp?pageID=" + i + "&search="
							+ search_enco + "&sort=" + sort + ">" + i + "</a>";
					tableHTML += "&nbsp;";
					tableHTML += "&nbsp;";

				}

				if (page_now == 1 && i == 3 && page_all >= 4) {
					tableHTML += "&nbsp;";
					tableHTML += "<a href=http://localhost:8080/project_test/jsh_test.jsp?pageID=" + 4 + "&search="
							+ search_enco + "&sort=" + sort + ">" + 4 + "</a>";
					tableHTML += "&nbsp;";
					tableHTML += "&nbsp;";
				} else if (page_now == 1 && i == 3 && page_all >= 5) {
					tableHTML += "&nbsp;";
					tableHTML += "<a href=http://localhost:8080/project_test/jsh_test.jsp?pageID=" + 5 + "&search="
							+ search_enco + "&sort=" + sort + ">" + 5 + "</a>";
					tableHTML += "&nbsp;";
					tableHTML += "&nbsp;";
				} else if (page_now == 2 && i == 4 && page_all >= 5) {
					tableHTML += "&nbsp;";
					tableHTML += "<a href=http://localhost:8080/project_test/jsh_test.jsp?pageID=" + 5 + "&search="
							+ search_enco + "&sort=" + sort + ">" + 5 + "</a>";
					tableHTML += "&nbsp;";
					tableHTML += "&nbsp;";
				}
			}

			//>
			if (page_now == page_all) {
				tableHTML += "&nbsp;";
				tableHTML += ">";
			}

			else {
				x = page_now + 1;
				tableHTML += "&nbsp;";
				tableHTML += "&nbsp;";
				tableHTML += "<a href=http://localhost:8080/project_test/jsh_test.jsp?pageID=" + x + "&search="
						+ search_enco + "&sort=" + sort + ">" + ">" + "</a>";

			}

			//>>
			if (page_now == page_all) {
				tableHTML += "&nbsp;";
				tableHTML += "&nbsp;";
				tableHTML += ">>";
			} else {
				tableHTML += "&nbsp;";
				tableHTML += "&nbsp;";
				tableHTML += "<a href=http://localhost:8080/project_test/jsh_test.jsp?pageID=" + page_all + "&search="
						+ search_enco + "&sort=" + sort + ">" + ">>" + "</a>";
			}
		%>
		<%
			rs.first();
			//------------------List display-----------------------

			tableHTML += "<tr  height=40 bgcolor=cornflowerblue>"
					+ "<th width=3% >No<form method='post' action='http://localhost:8080/project_test/jsh_test.jsp?search="
					+ search_enco + "&sort=NO'>"
					+ "<input  name='submit' type='submit' value='▲'></form></th>"
					+ "<th width=16% >名前</th>"
					+ "<th width=46% >住所<form method='post' action='http://localhost:8080/project_test/jsh_test.jsp?search="
					+ search_enco + "&sort=address'>"
					+ "<input  name='submit' type='submit' value='▲'></form></th>"
					+ "<th width=20% >電話番号<form method='post' action='http://localhost:8080/project_test/jsh_test.jsp?search="
					+ search_enco + "&sort=number'>"
					+ "<input  name='submit' type='submit' value='▲'></form></th>"
					+ "<th width=6% ></th>"
					+ "<th width=6% ></th>"
					+ "</tr>";

			//First and last data of page
			date_first = 1;
			date_first += (page_now - 1) * 10;
			date_last = page_now * 10;
			if (date_last > date)
				date_last = date;
			//Move the cursor
			for (int k = 1; k < date_first; k++) {
				Determine = rs.getInt("Determine");
				address = rs.getString("address");
				if (Determine == 1)
					k--;
				else if (!address.matches(".*" + search + ".*"))
					k--;

				rs.next();
			}
			for (; date_first <= date_last; date_first++) {

				//Acquisition of data from DB
				NO = rs.getInt("NO");
				name = rs.getString("name");
				address = rs.getString("address");
				number = rs.getString("number");
				Determine = rs.getInt("Determine");
				if (Determine != 1) {
					if (address.matches(".*" + search + ".*")) {

						// Create table data HTML
						tableHTML += "<tr ><td align=\"right\" height=35 width=30>" + NO + "</td>"
								+ "<td width=120 align=center>"
								+ name + "</td> <td width=230>"
								+ address + "</td><td width=150 align=center>"
								+ number
								+ "</td><td width=50 bgcolor=\"999999\" align=center><a href=http://localhost:8080/project_test/edit.jsp?NO="
								+ NO
								+ "><b>編集<b/></a></td><td width=50 bgcolor=\"999999\" align=center><a href=http://localhost:8080/project_test/delete.jsp?NO="
								+ NO + "><b>削除</b></a></td></tr>";
					} else if (!address.matches(".*" + search + ".*")) {
						date_first--;
					}
				} else if (Determine == 1) {
					date_first--;
				}
				rs.next();

			}

			tableHTML += "</table><br>";
			db.close();
		%>
		<%
			//paging
			if (page_now == 1)
				tableHTML += "<<";
			else
				tableHTML += "<a href=http://localhost:8080/project_test/jsh_test.jsp?pageID=" + 1 + "&search="
						+ search_enco + "&sort=" + sort + ">" + "<<" + "</a>";

			//<
			if (page_now == 1) {
				tableHTML += "&nbsp;";
				tableHTML += "&nbsp;";
				tableHTML += "<";
				tableHTML += "&nbsp;";
			}

			else {
				x = page_now - 1;
				tableHTML += "&nbsp;";
				tableHTML += "&nbsp;";
				tableHTML += "<a href=http://localhost:8080/project_test/jsh_test.jsp?pageID=" + x + "&search="
						+ search_enco + "&sort=" + sort + ">" + "<" + "</a>";
				tableHTML += "&nbsp;";

			}

			//ページリンク表示

			for (i = page_hiku2; page_hiku2 <= i && i <= page_tasu2; i++) {
				if (i == page_now) {
					tableHTML += "&nbsp;";
					tableHTML += i;
					tableHTML += "&nbsp;";
					tableHTML += "&nbsp;";
				} else {
					tableHTML += "&nbsp;";
					tableHTML += "<a href=http://localhost:8080/project_test/jsh_test.jsp?pageID=" + i + "&search="
							+ search_enco + "&sort=" + sort + ">" + i + "</a>";
					tableHTML += "&nbsp;";
					tableHTML += "&nbsp;";

				}

				if (page_now == 1 && i == 3 && page_all >= 4) {
					tableHTML += "&nbsp;";
					tableHTML += "<a href=http://localhost:8080/project_test/jsh_test.jsp?pageID=" + 4 + "&search="
							+ search_enco + "&sort=" + sort + ">" + 4 + "</a>";
					tableHTML += "&nbsp;";
					tableHTML += "&nbsp;";
				} else if (page_now == 1 && i == 3 && page_all >= 5) {
					tableHTML += "&nbsp;";
					tableHTML += "<a href=http://localhost:8080/project_test/jsh_test.jsp?pageID=" + 5 + "&search="
							+ search_enco + "&sort=" + sort + ">" + 5 + "</a>";
					tableHTML += "&nbsp;";
					tableHTML += "&nbsp;";
				} else if (page_now == 2 && i == 4 && page_all >= 5) {
					tableHTML += "&nbsp;";
					tableHTML += "<a href=http://localhost:8080/project_test/jsh_test.jsp?pageID=" + 5 + "&search="
							+ search_enco + "&sort=" + sort + ">" + 5 + "</a>";
					tableHTML += "&nbsp;";
					tableHTML += "&nbsp;";
				}
			}

			//>
			if (page_now == page_all) {
				tableHTML += "&nbsp;";
				tableHTML += ">";
			}

			else {
				x = page_now + 1;
				tableHTML += "&nbsp;";
				tableHTML += "&nbsp;";
				tableHTML += "<a href=http://localhost:8080/project_test/jsh_test.jsp?pageID=" + x + "&search="
						+ search_enco + "&sort=" + sort + ">" + ">" + "</a>";

			}

			//>>
			if (page_now == page_all) {
				tableHTML += "&nbsp;";
				tableHTML += "&nbsp;";
				tableHTML += ">>";
			} else {
				tableHTML += "&nbsp;";
				tableHTML += "&nbsp;";
				tableHTML += "<a href=http://localhost:8080/project_test/jsh_test.jsp?pageID=" + page_all + "&search="
						+ search_enco + "&sort=" + sort + ">" + ">>" + "</a>";
			}
		%>


		<%=tableHTML%>

		</table>
	</div>
	<br>
	<p>
		<a href=http://localhost:8080/project_test/touroku.jsp> <input
			type="button" name="a" style="width: 80px; height: 25px" value="新規登録"
			style="position: absolute; left: 15px; top: 50px" />
	</p>
</body>
</html>



