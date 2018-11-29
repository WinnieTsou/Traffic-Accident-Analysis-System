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
		case "weather":
			weather(request, response);
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
			sql.append("FROM `CS485_Project`.`case` WHERE ");
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
			sql.append("FROM `CS485_Project`.`case` WHERE ");
			for (String year : years)
				sql.append("YEAR(`accident_date`) = " + year + " OR ");
			sql.replace(sql.lastIndexOf("OR"), sql.lastIndexOf("OR") + 2, "");
			sql.append("GROUP BY YEAR(`accident_date`), MONTH(`accident_date`) ORDER BY `year`, `month`;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		case "holiday":
			sql = new StringBuilder();
			sql.append(
					"SELECT YEAR(`accident_date`) AS 'year', `holiday_code`.`id` AS 'h_id', `holiday_code`.`description` AS 'holiday', count('holiday') AS 'count' ");
			sql.append("FROM `CS485_Project`.`case` ");
			sql.append(
					"LEFT JOIN `CS485_Project`.`holiday_code` ON `CS485_Project`.`case`.`holiday_related` = `holiday_code`.`id` ");
			sql.append("WHERE `holiday_related` > 0  AND (");
			for (String year : years)
			sql.append("YEAR(`accident_date`) = " + year + " OR ");
			sql.replace(sql.lastIndexOf("OR"), sql.lastIndexOf("OR") + 2, "");
			sql.append(") GROUP BY YEAR(`accident_date`), `holiday` ");
			sql.append("ORDER BY `year`, `case`.`holiday_related`;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		case "death":
			sql = new StringBuilder();
			sql.append("SELECT YEAR(`time`) AS 'year', count(*) AS 'died' ");
			sql.append("FROM `CS485_Project`.`died` WHERE ");
			for (String year : years)
				sql.append("YEAR(`time`) = " + year + " OR ");
			sql.replace(sql.lastIndexOf("OR"), sql.lastIndexOf("OR") + 2, "");
			sql.append("GROUP BY YEAR(`time`) ORDER BY YEAR(`time`);");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		default:
			response.getWriter().append("");
			break;
		}
	}

	private void weather(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String[] types = request.getParameterValues("type");
		StringBuilder sql;
		JSONArray resultArray;

		switch (request.getParameter("chart")) {
		case "total":
			sql = new StringBuilder();
			sql.append("SELECT SUBSTRING(`casenum`, 1, 4) AS 'year', `weather_code` AS 'w_code', `description` AS 'weather', COUNT(`description`) AS 'count' ");
			sql.append("FROM `CS485_Project`.`weather` ");
			sql.append("LEFT JOIN `CS485_Project`.`weather_code` ON `weather`.`weather_code` = `weather_code`.`id` WHERE ");
			for (String type : types)
				sql.append("`weather_code` = " + type + " OR ");
			sql.replace(sql.lastIndexOf("OR"), sql.lastIndexOf("OR") + 2, "");
			sql.append("GROUP BY `year`, `w_code` ORDER BY `year`, `w_code`;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		case "light":
			sql = new StringBuilder();
			sql.append("SELECT `weather_code` AS 'w_code', `weather_code`.`description` AS 'weather', `case`.`light_condition` AS 'l_condition', `light_condition_code`.`description`, COUNT(*) AS 'count' ");
			sql.append("FROM `CS485_Project`.`weather` ");
			sql.append("LEFT JOIN `CS485_Project`.`weather_code` ON `weather`.`weather_code` = `weather_code`.`id` ");
			sql.append("LEFT JOIN `CS485_Project`.`case` ON `weather`.`casenum` = `case`.`casenum` ");
			sql.append("LEFT JOIN `CS485_Project`.`light_condition_code` ON `case`.`light_condition` = `light_condition_code`.`id` ");
			sql.append("WHERE (`case`.`light_condition` BETWEEN 0 AND 6) AND (");
			for (String type : types)
				sql.append("`weather_code` = " + type + " OR ");
			sql.replace(sql.lastIndexOf("OR"), sql.lastIndexOf("OR") + 2, "");
			sql.append(") GROUP BY `w_code`, `case`.`light_condition` ");
			sql.append("ORDER BY `w_code`, `case`.`light_condition`;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		case "route":
			sql = new StringBuilder();
			sql.append("SELECT `weather_code` AS 'w_code', `weather_code`.`description` AS 'weather', `case`.`route_signing` AS 'r_code', `route_signing_code`.`description` AS 'route_signing', COUNT(*) AS 'count'");
			sql.append("FROM `CS485_Project`.`weather` ");
			sql.append("LEFT JOIN `CS485_Project`.`weather_code` ON `weather`.`weather_code` = `weather_code`.`id` ");
			sql.append("LEFT JOIN `CS485_Project`.`case` ON `weather`.`casenum` = `case`.`casenum` ");
			sql.append("LEFT JOIN `CS485_Project`.`route_signing_code` ON `case`.`route_signing` = `route_signing_code`.`id` ");
			sql.append("WHERE (`weather_code`.`id` > 0) AND (`case`.`route_signing` BETWEEN 0 AND 8) AND (");
			for (String type : types)
				sql.append("`weather_code` = " + type + " OR ");
			sql.replace(sql.lastIndexOf("OR"), sql.lastIndexOf("OR") + 2, "");
			sql.append(") GROUP BY `w_code`, `case`.`route_signing` ");
			sql.append("ORDER BY `w_code`, `case`.`route_signing`;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		default:
			response.getWriter().append("");
			break;
		}
	}
}
