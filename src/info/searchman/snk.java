package info.searchman;


import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/snk")

public class snk extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);

		request.setCharacterEncoding("UTF-8");
	    response.setContentType("text/html;charset=UTF-8");

	String strname =request.getParameter("name");
	String straddress =request.getParameter("address");
	String strnumber =request.getParameter("number");

	Connection conn = null;
    PreparedStatement ps = null;


    //DB接続情報を設定する
    String path = "jdbc:mysql://localhost:3306/db_jushoroku?serverTimezone=JST&useUnicode=true&characterEncoding=utf8";  //接続パス
    String id = "root";    //ログインID
    String pw = "";  //ログインパスワード


    //SQL文を定義する
    String sql = "INSERT INTO tbl_meibo(name,address,number) values(?,?,?)";{

    try {
        //JDBCドライバをロードする
        Class.forName("com.mysql.cj.jdbc.Driver");

        //DBへのコネクションを作成する
        conn = DriverManager.getConnection(path, id, pw);
        conn.setAutoCommit(false);  //オートコミットはオフ

        //実行するSQL文とパラメータを指定する
        ps = conn.prepareStatement(sql);
        ps.setString(1, strname );
        ps.setString(2, straddress );
        ps.setString(3, strnumber );

      //INSERT文を実行する



         ps.executeUpdate();




        //コミット
        conn.commit();


    } catch (Exception ex) {

    } finally {

    }

}



}
	protected void doGet(HttpServletRequest request,
		      HttpServletResponse response)
		      throws ServletException, IOException {
		    processRequest(request, response);
		    String url = "/project_test/jsh_test.jsp?pageID=1";
		    response.sendRedirect(url);

}
	private void processRequest(HttpServletRequest request, HttpServletResponse response) {
		// TODO 自動生成されたメソッド・スタブ

	}

}