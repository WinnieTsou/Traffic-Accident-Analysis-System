package data;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import JSON.*;

@WebServlet("/QueryData")
public class QueryData extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public QueryData() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("application/json");

		switch (request.getParameter("page")) {

		case "all":
			all(request, response);
			break;
		case "time":
			time(request, response);
			break;
		default:
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

	private static JSONArray SQLQuery(String sqlStatement) {

		JSONArray result = new JSONArray();

		try {
			Class.forName("com.mysql.jdbc.Driver");

			Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306", "root", "root");
			System.out.println("DB Connected.");

			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery(sqlStatement);

			result = ResultSet2JSONArray.convert(rs);

			rs.close();
			stmt.close();
			connection.close();

		} catch (Exception err) {
			System.out.println(err.getStackTrace().toString());
			System.out.println("SQLQuery Error.");
		}
		return result;
	}

	private void all(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		JSONArray resultArray = SQLQuery("SELECT * FROM `CS485_Project`.`case` WHERE 1;");
		response.getWriter().append(resultArray.toString());
	}

	private void time(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String[] years = request.getParameterValues("year");
		StringBuilder sql;
		JSONArray resultArray;

		switch (request.getParameter("chart")) {
		case "total":
			sql = new StringBuilder();
			sql.append("SELECT YEAR(`accident_date`) AS 'year', count(*) AS 'count' ");
			sql.append(" FROM `CS485_Project`.`case` WHERE ");
			for (String year : years)
				sql.append("YEAR(`accident_date`) = " + year + " OR ");
			sql.replace(sql.lastIndexOf("OR"), sql.lastIndexOf("OR") + 2, "");
			sql.append("GROUP BY YEAR(`accident_date`);");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		case "month":
			sql = new StringBuilder();
			sql.append(
					"SELECT YEAR(`accident_date`) AS 'year', MONTH(`accident_date`) AS 'month', count(*) AS 'count' ");
			sql.append(" FROM `CS485_Project`.`case` WHERE ");
			for (String year : years)
				sql.append("YEAR(`accident_date`) = " + year + " OR ");
			sql.replace(sql.lastIndexOf("OR"), sql.lastIndexOf("OR") + 2, "");
			sql.append("GROUP BY YEAR(`accident_date`), MONTH(`accident_date`) ORDER BY `year`, `month`;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		case "holiday":
			break;
		case "death":
			break;
		}
	}
}
