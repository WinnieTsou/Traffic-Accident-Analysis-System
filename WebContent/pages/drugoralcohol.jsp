<div class="box box-primary">
	<!-- form start -->
	<form role="form" action="ShowByDrugOrAlcohol">
		<div class="box-body">
			<div class="form-group">
				<label>Drug/Alcohol</label>
				<div class="checkbox">
					<label><input type="checkbox" name="type" value="drug">Drug</label>
					<label><input type="checkbox" name="type" value="alcohol">Alcohol</label>
				</div>     
			</div>
		</div>
		<div class="box-footer">
			<button type="submit" class="btn btn-primary">Submit</button>
		</div>
	</form>
</div>

<script type="text/javascript">
$("div.checkbox label").css({"margin": "10px"});

$("form").submit(function(e){
	e.preventDefault();
	// var barChartByTotal = new Chart($("#barChartByTotal").get(0));
	// var barChartByWeatherLight = new Chart($("#barChartByWeatherLight").get(0));
	// var barChartByWeatherRoute = new Chart($("#barChartByWeatherRoute").get(0));


	if($(":checked").length!=0){
		var url = "data?page=drugAlcohol";
		$(":checked").each(function(){
			url += "&type=" + $(this).val();
		});
		console.log(url);

		// var urlTmp = url + "&chart=total";
		// $.get(urlTmp, function(data){
		// 	barChartByTotal.destroy();
		// 	barChartByTotal = new Chart($("#barChartByTotal").get(0),{
		// 		type: "bar",
		// 		data: {},
		// 		options: {
		// 			scales: {
		// 				yAxes: [{
		// 					ticks: {
		// 						beginAtZero:true
		// 					}
		// 				}],
		// 				xAxes: [{
		// 					ticks: {
		// 						autoSkip: false,
		// 						fontSize: 10,
		// 						padding: 0
		// 					}
		// 				}]
		// 			}
		// 		}
		// 	});

		// 	var labelArr = [];
		// 	var dataArr = [];
		// 	var datasetsArr = [];

		// 	$.each(data, (key, row)=>{
		// 		if(labelArr.indexOf(row.weather) == -1){
		// 			labelArr[row.w_code] = row.weather;
		// 		}
		// 	});

		// 	$.each(data, (key, row)=>{
		// 		if(!Array.isArray(dataArr[row.year])){
		// 			dataArr[row.year] = [];
		// 		}
		// 		dataArr[row.year][row.w_code] = row.count;
		// 	});

		// 	$.each(dataArr, (key, row)=>{
		// 		if(row!=null){

		// 			var dataRow = [];

		// 			$.each(labelArr, (key, value)=>{
		// 				if(value != null){
		// 					if(row[key] == null){
		// 						dataRow[key] = 0;
		// 					} else {
		// 						dataRow[key] = row[key];
		// 					}
		// 				}
		// 			});
		// 			dataRow = dataRow.filter((element) => { return element != null; });

		// 			datasetsArr.push({
		// 				label: key,
		// 				data: dataRow,
		// 				backgroundColor: "rgba(" + 
		// 					getRandomNumber() + "," +
		// 					getRandomNumber() + "," +
		// 					getRandomNumber() + ",0.4)"
		// 			});
		// 		}
		// 	});
		// 	addData(barChartByTotal, labelArr, datasetsArr);
		// });


		// urlTmp = url + "&chart=light";
		// $.get(urlTmp, (data)=>{
		// 	barChartByWeatherLight.destroy();
		// 	barChartByWeatherLight = new Chart($("#barChartByWeatherLight").get(0),{
		// 		type: "bar",
		// 		data: {},
		// 		options: {
		// 			scales: {
		// 				yAxes: [{
		// 					ticks: {
		// 						beginAtZero:true
		// 					}
		// 				}],
		// 				xAxes: [{
		// 					ticks: {
		// 						autoSkip: false,
		// 						fontSize: 10,
		// 						padding: 0
		// 					}
		// 				}]
		// 			}
		// 		}
		// 	});
		// 	var labelArr = [];
		// 	var dataArr = [];
		// 	var datasetsArr = [];
		// 	var labels = [];
		// 	$.each(data, (key, row)=>{
		// 		if(labelArr.indexOf(row.description) == -1){
		// 			labelArr[row.l_condition] = row.description;
		// 		}
		// 		if(!Array.isArray(dataArr[row.w_code])){
		// 			dataArr[row.w_code] = [];
		// 		}
		// 		dataArr[row.w_code][row.l_condition] = row.count;
		// 		if(labels.indexOf(row.weather) == -1 ){
		// 			labels[row.w_code] = row.weather;
		// 		}
		// 	});

		// 	$.each(dataArr, (key, row)=>{
		// 		if (row != null) {

		// 			var dataRow = [];

		// 			$.each(labelArr, (key, value) => {
		// 				if(value != null) {
		// 					if(row[key] != null)
		// 						dataRow[key] = row[key];
		// 					else
		// 						dataRow[key] = 0;
		// 				}
		// 			});

		// 			dataRow = dataRow.filter((element) => { return element != null; });

		// 			console.log(labels[key]);
		// 			console.log(dataRow);

		// 			datasetsArr.push({
		// 				label: labels[key],
		// 				data: dataRow,
		// 				backgroundColor: "rgba(" + 
		// 					getRandomNumber() + "," +
		// 					getRandomNumber() + "," +
		// 					getRandomNumber() + ",0.4)"
		// 			});
		// 		}
		// 	});
		// 	addData(barChartByWeatherLight, labelArr, datasetsArr);
		// });

		// urlTmp = url + "&chart=route";
		// $.get(urlTmp, function(data){

		// });

		$("#myChart").css({"display": "block"});
	} else {
		$("#myChart").css({"display": "none"});
	}
});
</script>
<script>
function addData(chart, labelArray, datasetArray) {

	labelArray.forEach((label) => {
		chart.data.labels.push(label);
	});

	datasetArray.forEach((datasetObject) => {
		chart.data.datasets.push(datasetObject);
	});
    chart.update();
}

function removeData(chart) {
    chart.data.labels.pop();
	chart.data.datasets.pop();
    chart.update();
}


function getRandomNumber(){
	return Math.floor(Math.random()*256);
}
</script>