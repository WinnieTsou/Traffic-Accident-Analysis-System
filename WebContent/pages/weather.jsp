<div class="box box-primary">
	<!-- form start -->
	<form role="form">
		<div class="box-body">
			<div class="form-group">
				<label>Weather</label>
				<div class="checkbox">
					<label><input type="checkbox" name="weather" value="1">Clear</label>
					<label><input type="checkbox" name="weather" value="2">Rain</label>
					<label><input type="checkbox" name="weather" value="3">Hail</label>
					<label><input type="checkbox" name="weather" value="4">Snow</label>
					<label><input type="checkbox" name="weather" value="5">Fog</label>
					<label><input type="checkbox" name="weather" value="6">Crosswinds</label>
					<label><input type="checkbox" name="weather" value="7">Blowing Dirt</label>
					<label><input type="checkbox" name="weather" value="10">Cloudy</label>
					<label><input type="checkbox" name="weather" value="11">Blowing Snow</label>
					<label><input type="checkbox" name="weather" value="12">Freezing Rain/Drizzle</label>
				</div>     
			</div>
		</div>
		<div class="box-footer">
			<button type="submit" class="btn btn-primary">Submit</button>
		</div>
	</form>
</div>

<div id="myChart" class="row" style="display: none;">
	<div class="col-md-12">
		<!-- put chart here -->
		<!-- BAR CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Total</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="chart">
					<canvas id="barChartByTotal"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->
	</div>

	<div class="col-md-12">
		<!-- put chart here -->
		<!-- BAR CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Weather & Light</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="chart">
					<canvas id="barChartByWeatherLight"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->
	</div>
	<div class="col-md-12">
		<!-- put chart here -->
		<!-- BAR CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Weather & Route</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="chart">
					<canvas id="barChartByWeatherRoute"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->
	</div>
</div>

<script type="text/javascript">
$("div.checkbox label").css({"margin": "10px"});

var barChartByTotal = new Chart($("#barChartByTotal").get(0));
var barChartByWeatherLight = new Chart($("#barChartByWeatherLight").get(0));
var barChartByWeatherRoute = new Chart($("#barChartByWeatherRoute").get(0));

$("form").submit(function(e){
	e.preventDefault();


	if($(":checked").length!=0){
		var url = "data?page=weather";
		$(":checked").each(function(){
			url += "&type=" + $(this).val();
		});

		var urlTmp = url + "&chart=total";
		$.get(urlTmp, function(data){
			barChartByTotal.destroy();
			barChartByTotal = new Chart($("#barChartByTotal").get(0),{
				type: "bar",
				data: {},
				options: {
					scales: {
						yAxes: [{
							ticks: {
								beginAtZero:true
							}
						}],
						xAxes: [{
							ticks: {
								autoSkip: false,
								fontSize: 10,
								padding: 0
							}
						}]
					}
				}
			});

			var labelArr = [];
			var dataArr = [];
			var datasetsArr = [];

			$.each(data, (key, row)=>{
				if(labelArr.indexOf(row.weather) == -1){
					labelArr[row.w_code] = row.weather;
				}
			});

			$.each(data, (key, row)=>{
				if(!Array.isArray(dataArr[row.year])){
					dataArr[row.year] = [];
				}
				dataArr[row.year][row.w_code] = row.count;
			});

			$.each(dataArr, (key, row)=>{
				if(row!=null){

					var dataRow = [];

					$.each(labelArr, (key, value)=>{
						if(value != null){
							if(row[key] == null){
								dataRow[key] = 0;
							} else {
								dataRow[key] = row[key];
							}
						}
					});
					dataRow = dataRow.filter((element) => { return element != null; });

					datasetsArr.push({
						label: key,
						data: dataRow,
						backgroundColor: "rgba(" + 
							getRandomNumber() + "," +
							getRandomNumber() + "," +
							getRandomNumber() + ",0.4)"
					});
				}
			});
			addData(barChartByTotal, labelArr, datasetsArr);
		});


		urlTmp = url + "&chart=light";
		$.get(urlTmp, (data)=>{
			barChartByWeatherLight.destroy();
			barChartByWeatherLight = new Chart($("#barChartByWeatherLight").get(0),{
				type: "bar",
				data: {},
				options: {
					scales: {
						yAxes: [{
							ticks: {
								beginAtZero:true
							}
						}],
						xAxes: [{
							ticks: {
								autoSkip: false,
								fontSize: 10,
								padding: 0
							}
						}]
					}
				}
			});
			var labelArr = [];
			var dataArr = [];
			var datasetsArr = [];
			var labels = [];
			$.each(data, (key, row)=>{
				if(labelArr.indexOf(row.description) == -1){
					labelArr[row.l_condition] = row.description;
				}
				if(!Array.isArray(dataArr[row.w_code])){
					dataArr[row.w_code] = [];
				}
				dataArr[row.w_code][row.l_condition] = row.count;
				if(labels.indexOf(row.weather) == -1 ){
					labels[row.w_code] = row.weather;
				}
			});

			$.each(dataArr, (key, row)=>{
				if (row != null) {

					var dataRow = [];

					$.each(labelArr, (key, value) => {
						if(value != null) {
							if(row[key] != null)
								dataRow[key] = row[key];
							else
								dataRow[key] = 0;
						}
					});

					dataRow = dataRow.filter((element) => { return element != null; });

					datasetsArr.push({
						label: labels[key],
						data: dataRow,
						backgroundColor: "rgba(" + 
							getRandomNumber() + "," +
							getRandomNumber() + "," +
							getRandomNumber() + ",0.4)"
					});
				}
			});
			addData(barChartByWeatherLight, labelArr, datasetsArr);
		});

		urlTmp = url + "&chart=route";
		$.get(urlTmp, function(data){
			barChartByWeatherRoute.destroy();
			barChartByWeatherRoute = new Chart($("#barChartByWeatherRoute").get(0),{
				type: "bar",
				data: {},
				options: {
					scales: {
						yAxes: [{
							ticks: {
								beginAtZero:true
							}
						}],
						xAxes: [{
							ticks: {
								autoSkip: false,
								fontSize: 10,
								padding: 0
							}
						}]
					}
				}
			});
			var labelArr = [];
			var dataArr = [];
			var datasetsArr = [];
			var labels = [];
			$.each(data, (key, row)=>{
				if(labelArr.indexOf(row.route_signing) == -1){
					labelArr[row.r_code] = row.route_signing;
				}
				if(!Array.isArray(dataArr[row.w_code])){
					dataArr[row.w_code] = [];
				}
				dataArr[row.w_code][row.r_code] = row.count;
				if(labels.indexOf(row.weather) == -1 ){
					labels[row.w_code] = row.weather;
				}
			});

			$.each(dataArr, (key, row)=>{
				if (row != null) {

					var dataRow = [];

					$.each(labelArr, (key, value) => {
						if(value != null) {
							if(row[key] != null)
								dataRow[key] = row[key];
							else
								dataRow[key] = 0;
						}
					});

					dataRow = dataRow.filter((element) => { return element != null; });

					datasetsArr.push({
						label: labels[key],
						data: dataRow,
						backgroundColor: "rgba(" + 
							getRandomNumber() + "," +
							getRandomNumber() + "," +
							getRandomNumber() + ",0.4)"
					});
				}
			});
			addData(barChartByWeatherRoute, labelArr, datasetsArr);			
		});

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