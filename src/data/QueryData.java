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

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("application/json");

		switch (request.getParameter("page")) {

		case "all":
			all(request, response);
			break;
		case "county":
			county(request, response);
			break;
		case "time":
			time(request, response);
			break;
		case "weather":
			weather(request, response);
			break;
		case "drugAlcohol":
			drugAlcohol(request, response);
			break;
		case "car":
			car(request, response);
			break;
		case "death":
			death(request, response);
			break;
		case "speed":
			speed(request, response);
			break;
		case "factor":
			factor(request, response);
			break;
		case "collision":
			collision(request, response);
			break;
		default:
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

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

		StringBuilder sql= new StringBuilder();

		sql.append("SELECT `case`.`casenum`, `longitude`, `latitude`, `accident_date`, `collision_code`.`description` AS 'collision', `light_condition_code`.`description` AS 'light_condition', `crash_factor_code`.`description` AS 'crash_factor', `weather_code`.`description` AS 'weather' ");
		sql.append("FROM `CS485_Project`.`case` ");
		sql.append("LEFT JOIN `CS485_Project`.`collision_code` ON `collision_code`.`id` = `case`.`collision_type` ");
		sql.append("LEFT JOIN `CS485_Project`.`light_condition_code` ON `light_condition_code`.`id` = `case`.`light_condition` ");
		sql.append("LEFT JOIN `CS485_Project`.`crash_factor` ON `crash_factor`.`casenum` = `case`.`casenum` ");
		sql.append("LEFT JOIN `CS485_Project`.`crash_factor_code` ON `crash_factor`.`crash_factor_code` = `crash_factor_code`.`id` ");
		sql.append("LEFT JOIN `CS485_Project`.`weather` ON `weather`.`casenum` = `case`.`casenum` ");
		sql.append("LEFT JOIN `CS485_Project`.`weather_code` ON `weather`.`weather_code` = `weather_code`.`id` ");
		sql.append("GROUP BY `case`.`casenum`");
		System.out.println(sql.toString());
		JSONArray resultArray = SQLQuery(sql.toString());
		response.getWriter().append(resultArray.toString());
	}

	private void county(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String[] counties = request.getParameterValues("county");
		StringBuilder sql;
		JSONArray resultArray;

		if (request.getParameter("chart") == null) {
			resultArray = SQLQuery("SELECT `id`, `description` AS 'name' FROM `CS485_Project`.`county_code` WHERE `id` BETWEEN 1 AND 200;");
			response.getWriter().append(resultArray.toString());
			return;
		}

		switch (request.getParameter("chart")) {
		case "total":
			sql = new StringBuilder();
			sql.append("SELECT `county_id` AS 'c_id', `county_code`.`description` AS 'c_name', COUNT(*) AS 'count' ");
			sql.append("FROM `CS485_Project`.`case` ");
			sql.append("LEFT JOIN `CS485_Project`.`county_code` ON `case`.`county_id` = `county_code`.`id` WHERE ");
			for (String county : counties)
				sql.append("`county_id` = " + county + " OR ");
			sql.replace(sql.lastIndexOf("OR"), sql.lastIndexOf("OR") + 2, "");
			sql.append("GROUP BY `county_id` ");
			sql.append("ORDER BY `county_id`;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		case "speeding":
			sql = new StringBuilder();
			sql.append("SELECT `county_id`, `county_code`.`description` AS 'c_name', COUNT(*) AS 'count' ");
			sql.append("FROM `CS485_Project`.`vehicle` ");
			sql.append("LEFT JOIN `CS485_Project`.`case` ON `vehicle`.`casenum` = `case`.`casenum` ");
			sql.append("LEFT JOIN `CS485_Project`.`county_code` ON `case`.`county_id` = `county_code`.`id` ");
			sql.append("WHERE `is_speeding` > 0  AND (");
			for (String county : counties)
				sql.append("`county_id` = " + county + " OR ");
			sql.replace(sql.lastIndexOf("OR"), sql.lastIndexOf("OR") + 2, "");
			sql.append(") GROUP BY `county_id` ");
			sql.append("ORDER BY `county_id`;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		case "intersection":
			sql = new StringBuilder();
			sql.append("SELECT `county_id` AS 'c_id', `county_code`.`description` AS 'c_name', `intersection_type` AS 'i_code', `intersection_type_code`.`description` AS 'i_type', COUNT(*) AS 'count' ");
			sql.append("FROM `CS485_Project`.`case` ");
			sql.append("LEFT JOIN `CS485_Project`.`county_code` ON `case`.`county_id` = `county_code`.`id` ");
			sql.append("LEFT JOIN `CS485_Project`.`intersection_type_code` ON `case`.`intersection_type` = `intersection_type_code`.`id` ");
			sql.append("WHERE `intersection_type` < 11  AND (");
			for (String county : counties)
				sql.append("`county_id` = " + county + " OR ");
			sql.replace(sql.lastIndexOf("OR"), sql.lastIndexOf("OR") + 2, "");
			sql.append(") GROUP BY `county_id`, `intersection_type` ");
			sql.append("ORDER BY `county_id`, `intersection_type`;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		default:
			response.getWriter().append("");
			break;
		}
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
			sql.append("SELECT YEAR(`accident_date`) AS 'year', MONTH(`accident_date`) AS 'month', count(*) AS 'count' ");
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
			sql.append("SELECT YEAR(`accident_date`) AS 'year', `holiday_code`.`id` AS 'h_id', `holiday_code`.`description` AS 'holiday', count('holiday') AS 'count' ");
			sql.append("FROM `CS485_Project`.`case` ");
			sql.append("LEFT JOIN `CS485_Project`.`holiday_code` ON `CS485_Project`.`case`.`holiday_related` = `holiday_code`.`id` ");
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

	private void weather(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

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

	private void drugAlcohol(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		StringBuilder sql;
		JSONArray resultArray;

		switch (request.getParameter("chart")) {
		case "total":
			sql = new StringBuilder("SELECT SUBSTRING(`casenum`, 1, 4) AS 'year', count(`result`) AS 'drug_count' FROM `CS485_Project`.`drug_test` WHERE `result` BETWEEN 100 AND 996 GROUP BY `year` ORDER BY `year`;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());

			sql = new StringBuilder("SELECT SUBSTRING(`casenum`, 1, 4) AS 'year', count(`result`) AS 'alcohol_count' FROM `CS485_Project`.`alcohol_test` WHERE `result` BETWEEN 1 AND 995 GROUP BY `year` ORDER BY `year`;");
			System.out.println(sql.toString());
			for (Object object : SQLQuery(sql.toString()))
				resultArray.put((JSONObject) object);

			response.getWriter().append(resultArray.toString());
			break;
		case "injury":
			sql = new StringBuilder("SELECT `injury` AS 'i_id', `description`, count(*) AS 'd_count' FROM `CS485_Project`.`person` LEFT JOIN `CS485_Project`.`injury_severity` ON `person`.`injury` = `injury_severity`.`id` LEFT JOIN `CS485_Project`.`drug_test` ON `person`.`casenum` = `drug_test`.`casenum` AND `person`.`vnumber` = `drug_test`.`vnumber` AND `person`.`pnumber` = `drug_test`.`pnumber` WHERE `result` BETWEEN 100 AND 996 GROUP BY `injury` ORDER BY `injury`;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());

			sql = new StringBuilder("SELECT `injury` AS 'i_id', `description`, count(*) AS 'a_count' FROM `CS485_Project`.`person` LEFT JOIN `CS485_Project`.`injury_severity` ON `person`.`injury` = `injury_severity`.`id` LEFT JOIN `CS485_Project`.`alcohol_test` ON `person`.`casenum` = `alcohol_test`.`casenum` AND `person`.`vnumber` = `alcohol_test`.`vnumber` AND `person`.`pnumber` = `alcohol_test`.`pnumber` WHERE `result` BETWEEN 1 AND 995 GROUP BY `injury` ORDER BY `injury`;");
			System.out.println(sql.toString());
			for (Object object : SQLQuery(sql.toString()))
				resultArray.put((JSONObject) object);

			response.getWriter().append(resultArray.toString());
			break;
		case "dsex":
			sql = new StringBuilder("SELECT `sex` AS 'drug_sex', count(*) AS 'count' FROM `CS485_Project`.`drug_test` LEFT JOIN `CS485_Project`.`person` ON `drug_test`.`casenum` = `person`.`casenum` AND `drug_test`.`vnumber` = `person`.`vnumber` AND `drug_test`.`pnumber` = `person`.`pnumber` WHERE `result` BETWEEN 100 AND 996 GROUP BY `sex` ORDER BY `sex`;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		case "asex":
			sql = new StringBuilder("SELECT `sex` AS 'alcohol_sex', count(*) AS 'count' FROM `CS485_Project`.`alcohol_test` LEFT JOIN `CS485_Project`.`person` ON `alcohol_test`.`casenum` = `person`.`casenum` AND `alcohol_test`.`vnumber` = `person`.`vnumber` AND `alcohol_test`.`pnumber` = `person`.`pnumber` WHERE `result` BETWEEN 1 AND 995 GROUP BY `sex` ORDER BY `sex`;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		default:
			response.getWriter().append("");
			break;
		}
	}

	private void car(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String[] types = request.getParameterValues("type");
		StringBuilder sql;
		JSONArray resultArray;

		if (request.getParameter("chart") == null) {
			resultArray = SQLQuery("SELECT * FROM `CS485_Project`.`vehicle_manufacturer_code` WHERE `id` BETWEEN 0 AND 95 ORDER BY `description`;");
			response.getWriter().append(resultArray.toString());
			return;
		}
		switch (request.getParameter("chart")) {
		case "total":
			sql = new StringBuilder();
			sql.append("SELECT `manufacturer` AS 'm_id', `description` AS 'm_name', count(*) AS 'count'");
			sql.append("FROM `CS485_Project`.`vehicle` ");
			sql.append("LEFT JOIN `CS485_Project`.`vehicle_manufacturer_code` ON `vehicle`.`manufacturer` = `vehicle_manufacturer_code`.`id` WHERE ");
			for (String type : types)
				sql.append("`manufacturer` = " + type + " OR ");
			sql.replace(sql.lastIndexOf("OR"), sql.lastIndexOf("OR") + 2, "");
			sql.append("GROUP BY `manufacturer` ORDER BY `manufacturer`;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		case "airbag":
			sql = new StringBuilder();
			sql.append("SELECT `airbag_deployed` AS 'a_id', `airbag_deployed_code`.`description` AS 'a_name', `manufacturer` AS 'm_id', `vehicle_manufacturer_code`.`description` AS 'm_name', count(*) AS 'count' ");
			sql.append("FROM `CS485_Project`.`vehicle` ");
			sql.append("LEFT JOIN `CS485_Project`.`vehicle_manufacturer_code` ON `vehicle`.`manufacturer` = `vehicle_manufacturer_code`.`id` ");
			sql.append("LEFT JOIN `CS485_Project`.`airbag_deployed_code` ON `vehicle`.`airbag_deployed` = `airbag_deployed_code`.`id` ");
			sql.append("WHERE (`airbag_deployed` BETWEEN 1 AND 98) AND (");
			for (String type : types)
				sql.append("`manufacturer` = " + type + " OR ");
			sql.replace(sql.lastIndexOf("OR"), sql.lastIndexOf("OR") + 2, "");
			sql.append(") GROUP BY `airbag_deployed`, `manufacturer` ORDER BY `airbag_deployed`, `manufacturer`;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		case "age":
			sql = new StringBuilder();
			sql.append("SELECT `manufacturer` AS 'm_id', `vehicle_manufacturer_code`.`description`, `age` DIV 10 * 10 AS 'age', count(*) AS 'count' ");
			sql.append("FROM `CS485_Project`.`vehicle` ");
			sql.append("LEFT JOIN `CS485_Project`.`vehicle_manufacturer_code` ON `vehicle`.`manufacturer` = `vehicle_manufacturer_code`.`id` ");
			sql.append("LEFT JOIN `CS485_Project`.`person` ON `vehicle`.`casenum` = `person`.`casenum` AND `vehicle`.`vnumber` = `person`.`vnumber` ");
			sql.append("WHERE (`age` BETWEEN 1 AND 100) AND (");
			for (String type : types)
				sql.append("`manufacturer` = " + type + " OR ");
			sql.replace(sql.lastIndexOf("OR"), sql.lastIndexOf("OR") + 2, "");
			sql.append(") GROUP BY `manufacturer`, `age` DIV 10 ORDER BY `manufacturer`, `age` DIV 10;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		case "sex":
			sql = new StringBuilder();
			sql.append("SELECT `manufacturer` AS 'm_id', `vehicle_manufacturer_code`.`description`, `sex`, count(*) AS 'count' ");
			sql.append("FROM `CS485_Project`.`vehicle` ");
			sql.append("LEFT JOIN `CS485_Project`.`vehicle_manufacturer_code` ON `vehicle`.`manufacturer` = `vehicle_manufacturer_code`.`id` ");
			sql.append("LEFT JOIN `CS485_Project`.`person` ON `vehicle`.`casenum` = `person`.`casenum` AND `vehicle`.`vnumber` = `person`.`vnumber` ");
			sql.append("WHERE (`age` BETWEEN 1 AND 100) AND (`sex` BETWEEN 1 AND 2) AND (");
			for (String type : types)
				sql.append("`manufacturer` = " + type + " OR ");
			sql.replace(sql.lastIndexOf("OR"), sql.lastIndexOf("OR") + 2, "");
			sql.append(") GROUP BY `manufacturer`, `sex` ORDER BY `manufacturer`, `sex`;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		case "drug":
			sql = new StringBuilder();
			sql.append("SELECT `manufacturer` AS 'm_id', `vehicle_manufacturer_code`.`description`, `sex`, count(*) AS 'count' ");
			sql.append("FROM `CS485_Project`.`vehicle` ");
			sql.append("LEFT JOIN `CS485_Project`.`vehicle_manufacturer_code` ON `vehicle`.`manufacturer` = `vehicle_manufacturer_code`.`id` ");
			sql.append("LEFT JOIN `CS485_Project`.`person` ON `vehicle`.`casenum` = `person`.`casenum` AND `vehicle`.`vnumber` = `person`.`vnumber` ");
			sql.append("WHERE (`age` BETWEEN 1 AND 100) AND (`sex` BETWEEN 1 AND 2) AND (");
			for (String type : types)
				sql.append("`manufacturer` = " + type + " OR ");
			sql.replace(sql.lastIndexOf("OR"), sql.lastIndexOf("OR") + 2, "");
			sql.append(") GROUP BY `manufacturer`, `sex` ORDER BY `manufacturer`, `sex`;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		default:
			response.getWriter().append("");
			break;
		}
	}

	private void death(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		StringBuilder sql;
		JSONArray resultArray;

		switch (request.getParameter("chart")) {
		case "cartype":
			sql = new StringBuilder();
			sql.append("SELECT `manufacturer` AS 'm_id', `vehicle_manufacturer_code`.`description`, count(*) AS 'count' ");
			sql.append("FROM `CS485_Project`.`died` ");
			sql.append("LEFT JOIN `CS485_Project`.`vehicle` ON `died`.`casenum` = `vehicle`.`casenum` AND `died`.`vnumber` = `vehicle`.`vnumber` ");
			sql.append("LEFT JOIN `CS485_Project`.`vehicle_manufacturer_code` ON `vehicle`.`manufacturer` = `vehicle_manufacturer_code`.`id` ");
			sql.append("GROUP BY `manufacturer` ORDER BY `description`;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		case "caryear":
			sql = new StringBuilder("SELECT `year` DIV 10 * 10 AS 'year', count(*) AS 'count' FROM `CS485_Project`.`died` LEFT JOIN `CS485_Project`.`vehicle` ON `died`.`casenum` = `vehicle`.`casenum` AND `died`.`vnumber` = `vehicle`.`vnumber` GROUP BY `year` DIV 10 ORDER BY `year` DIV 10;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		case "num":
			sql = new StringBuilder("SELECT count(*) AS 'total_died' FROM `CS485_Project`.`died`;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());

			sql = new StringBuilder("SELECT count(*) AS 'drug_died' FROM `CS485_Project`.`died` LEFT JOIN `CS485_Project`.`drug_test` ON `died`.`casenum` = `drug_test`.`casenum` AND `died`.`vnumber` = `drug_test`.`vnumber` AND `died`.`pnumber` = `drug_test`.`pnumber` WHERE `drug_test`.`vnumber` BETWEEN 0 AND 999 AND `result` BETWEEN 100 AND 996;");
			System.out.println(sql.toString());
			for (Object object : SQLQuery(sql.toString()))
				resultArray.put((JSONObject) object);

			sql = new StringBuilder("SELECT count(*) AS 'alcohol_died' FROM `CS485_Project`.`died` LEFT JOIN `CS485_Project`.`alcohol_test` ON `died`.`casenum` = `alcohol_test`.`casenum` AND `died`.`vnumber` = `alcohol_test`.`vnumber` AND `died`.`pnumber` = `alcohol_test`.`pnumber` WHERE `alcohol_test`.`vnumber` BETWEEN 0 AND 999 AND `result` BETWEEN 1 AND 995;");
			System.out.println(sql.toString());
			for (Object object : SQLQuery(sql.toString()))
				resultArray.put((JSONObject) object);

			response.getWriter().append(resultArray.toString());
			break;
		case "sex":
			sql = new StringBuilder();
			sql.append("SELECT `sex`, count(*) AS 'count' ");
			sql.append("FROM `CS485_Project`.`died` ");
			sql.append("LEFT JOIN `CS485_Project`.`person` ON `died`.`casenum` = `person`.`casenum` AND `died`.`vnumber` = `person`.`vnumber` AND `died`.`pnumber` = `person`.`pnumber` ");
			sql.append("GROUP BY `sex` ORDER BY `sex`;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		case "age":
			sql = new StringBuilder();
			sql.append("SELECT `age` DIV 10 * 10 AS 'age', count(*) AS 'count' ");
			sql.append("FROM `CS485_Project`.`died` ");
			sql.append("LEFT JOIN `CS485_Project`.`person` ON `died`.`casenum` = `person`.`casenum` AND `died`.`vnumber` = `person`.`vnumber` AND `died`.`pnumber` = `person`.`pnumber` ");
			sql.append("GROUP BY `age` DIV 10 ORDER BY `age` DIV 10;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		default:
			response.getWriter().append("");
			break;
		}
	}

	private void speed(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		StringBuilder sql;
		JSONArray resultArray;

		switch (request.getParameter("chart")) {
		case "weather":
			sql = new StringBuilder();
			sql.append("SELECT `weather_code` AS 'w_code', `description` AS 'weather', AVG(`speed`) AS 'avg' ");
			sql.append("FROM `CS485_Project`.`vehicle` ");
			sql.append("LEFT JOIN `CS485_Project`.`weather` ON `weather`.`casenum` = `vehicle`.`casenum` ");
			sql.append("LEFT JOIN `CS485_Project`.`weather_code` ON `weather`.`weather_code` = `weather_code`.`id` ");
			sql.append("WHERE `speed` BETWEEN 1 AND 151 AND `weather_code` BETWEEN 1 AND 97 ");
			sql.append("GROUP BY `weather_code` ORDER BY `weather_code`;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		case "route":
			sql = new StringBuilder();
			sql.append("SELECT `route_signing` AS 'r_id', `route_signing_code`.`description` AS 'route', AVG(`speed`) AS 'avg' ");
			sql.append("FROM `CS485_Project`.`case` ");
			sql.append("LEFT JOIN `CS485_Project`.`vehicle` ON `case`.`casenum` = `vehicle`.`casenum` ");
			sql.append("LEFT JOIN `CS485_Project`.`route_signing_code` ON `case`.`route_signing` = `route_signing_code`.`id` ");
			sql.append("WHERE `speed` BETWEEN 1 AND 151 AND `route_signing` BETWEEN 1 AND 8 ");
			sql.append("GROUP BY `route_signing` ORDER BY `route_signing`;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		case "injury":
			sql = new StringBuilder();
			sql.append("SELECT `injury` AS 'i_id', `injury_severity`.`description`, `speed` ");
			sql.append("FROM `CS485_Project`.`person` ");
			sql.append("LEFT JOIN `CS485_Project`.`vehicle` ON `person`.`casenum` = `vehicle`.`casenum` AND `person`.`vnumber` = `vehicle`.`vnumber` ");
			sql.append("LEFT JOIN `CS485_Project`.`injury_severity` ON `person`.`injury` = `injury_severity`.`id` ");
			sql.append("WHERE `speed` BETWEEN 1 AND 151 ");
			sql.append("ORDER BY `injury`;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		case "death":
			sql = new StringBuilder();
			sql.append("SELECT AVG(`speed`) DIV 10 * 10 AS 'avg_speed', count(*) AS 'count' ");
			sql.append("FROM `CS485_Project`.`person` ");
			sql.append("LEFT JOIN `CS485_Project`.`vehicle` ON `person`.`casenum` = `vehicle`.`casenum` AND `person`.`vnumber` = `vehicle`.`vnumber` ");
			sql.append("LEFT JOIN `CS485_Project`.`died` ON `person`.`casenum` = `died`.`casenum` AND `person`.`vnumber` = `died`.`vnumber` AND `person`.`pnumber` = `died`.`pnumber` ");
			sql.append("WHERE `speed` BETWEEN 1 AND 151 AND `time` IS NOT NULL ");
			sql.append("GROUP BY `speed` DIV 10 ORDER BY `speed` DIV 10;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		default:
			response.getWriter().append("");
			break;
		}
	}

	private void factor(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		StringBuilder sql;
		JSONArray resultArray;

		switch (request.getParameter("chart")) {
		case "total":
			sql = new StringBuilder();
			sql.append("SELECT `crash_factor_code`.`id` AS 'c_id', `description`, count(*) AS 'count' ");
			sql.append("FROM `CS485_Project`.`crash_factor` ");
			sql.append("LEFT JOIN `CS485_Project`.`crash_factor_code` ON `crash_factor`.`crash_factor_code` = `crash_factor_code`.`id` ");
			sql.append("WHERE `crash_factor_code`.`id` < 90 ");
			sql.append("GROUP BY `crash_factor_code`.`id` ORDER BY `description`;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		default:
			response.getWriter().append("");
			break;
		}
	}

	private void collision(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		StringBuilder sql;
		JSONArray resultArray;

		switch (request.getParameter("chart")) {
		case "total":
			sql = new StringBuilder();
			sql.append("SELECT `collision_code`.`id` AS 'c_id', `description`, count(*) AS 'count' ");
			sql.append("FROM `CS485_Project`.`case` ");
			sql.append("LEFT JOIN `CS485_Project`.`collision_code` ON `case`.`collision_type` = `collision_code`.`id` ");
			sql.append("WHERE `collision_code`.`id` < 97 ");
			sql.append("GROUP BY `collision_code`.`id` ORDER BY `collision_code`.`id`;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		case "injury":
			sql = new StringBuilder();
			sql.append("SELECT `collision_code`.`id` AS 'c_id', `collision_code`.`description` AS 'c_description', `injury`, `injury_severity`.`description` AS 'i_description', count(*) AS 'count' ");
			sql.append("FROM `CS485_Project`.`person` ");
			sql.append("LEFT JOIN `CS485_Project`.`case` ON `person`.`casenum` = `case`.`casenum` ");
			sql.append("LEFT JOIN `CS485_Project`.`injury_severity` ON `person`.`injury` = `injury_severity`.`id` ");
			sql.append("LEFT JOIN `CS485_Project`.`collision_code` ON `case`.`collision_type` = `collision_code`.`id` ");
			sql.append("WHERE `collision_code`.`id` < 97 AND `injury` < 9 ");
			sql.append("GROUP BY `collision_code`.`id`, `injury` ORDER BY `collision_code`.`id`, `injury`;");
			System.out.println(sql.toString());
			resultArray = SQLQuery(sql.toString());
			response.getWriter().append(resultArray.toString());
			break;
		case "death":
			sql = new StringBuilder();
			sql.append("SELECT `collision_code`.`id` AS 'c_id', `description`, count(*) AS 'count' ");
			sql.append("FROM `CS485_Project`.`died` ");
			sql.append("LEFT JOIN `CS485_Project`.`case` ON `died`.`casenum` = `case`.`casenum` ");
			sql.append("LEFT JOIN `CS485_Project`.`collision_code` ON `case`.`collision_type` = `collision_code`.`id` ");
			sql.append("WHERE `collision_code`.`id` < 97 ");
			sql.append("GROUP BY `collision_code`.`id` ORDER BY `collision_code`.`id`;");
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
