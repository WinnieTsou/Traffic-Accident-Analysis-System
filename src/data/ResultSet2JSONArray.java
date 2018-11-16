package data;

import java.sql.ResultSet;
import JSON.*;

public class ResultSet2JSONArray {

	public static JSONArray convert(ResultSet resultSet) throws Exception {

		JSONArray jsonArray = new JSONArray();

		while (resultSet.next()) {

			int total_rows = resultSet.getMetaData().getColumnCount();

			JSONObject obj = new JSONObject();

			for (int i = 0; i < total_rows; i++)
				obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), resultSet.getObject(i + 1));

			jsonArray.put(obj);
		}
		return jsonArray;
	}
}