package data;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import JSON.JSONArray;
import JSON.JSONObject;

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

		JSONObject locationObj = new JSONObject();

		JSONArray resultArray = SQLQuery("SELECT * FROM `CS485_Project`.`case` WHERE 1;");

		locationObj.append("test", resultArray);

		response.getWriter().append(resultArray.toString() + "\n\n\n");

		locationObj = new JSONObject();
		
		JSONObject location;

		location = new JSONObject();
		location.put("title", "Aberystwyth University");
		location.put("website", "www.aber.ac.uk");
		location.put("phone", "+44 (0)1970 623 111");
		location.put("lat", "52.415524");
		location.put("lng", "-4.063066");
		locationObj.append("location", location);

		location = new JSONObject();
		location.put("title", "Bangor University");
		location.put("website", "www.bangor.ac.uk");
		location.put("phone", "+44 (0)1248 351 151");
		location.put("lat", "53.229520");
		location.put("lng", "-4.129987");
		locationObj.append("location", location);

		location = new JSONObject();
		location.put("title", "This is a title.");
		location.put("website", "Titile www.cardiffmet.ac.uk");
		location.put("phone", "+44 (0)2920 416 138");
		location.put("lat", "51.482708");
		location.put("lng", "-3.165881");
		locationObj.append("location", location);

//		response.getWriter().append(locationObj.toString());
	}
}
