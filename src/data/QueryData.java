package data;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/QueryData")
public class QueryData extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public QueryData() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

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

	private void all(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("{\n" + "	\"universities\": [\n" + "		{\n"
				+ "			\"title\": \"Aberystwyth University\",\n" + "			\"website\": \"www.aber.ac.uk\",\n"
				+ "			\"phone\": \"+44 (0)1970 623 111\",\n" + "			\"lat\": 52.415524,\n"
				+ "			\"lng\": -4.063066},\n" + "		{\n" + "			\"title\": \"Bangor University\",\n"
				+ "			\"website\": \"www.bangor.ac.uk\",\n" + "			\"phone\": \"+44 (0)1248 351 151\",\n"
				+ "			\"lat\": 53.229520,\n" + "			\"lng\": -4.129987},\n" + "		{\n"
				+ "			\"title\": \"Cardiff Metropolitan University\",\n"
				+ "			\"website\": \"www.cardiffmet.ac.uk\",\n"
				+ "			\"phone\": \"+44 (0)2920 416 138\",\n" + "			\"lat\": 51.482708,\n"
				+ "			\"lng\": -3.165881}\n" + "	]\n" + "}");
	}
}
