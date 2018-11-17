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

$("form").submit(function(e){
	e.preventDefault();
	var barChartByTotal = new Chart($("#barChartByTotal").get(0), {
		type: "bar",
		data: {},
		options: {}
	});
	var barChartByWeatherLight = new Chart($("#barChartByWeatherLight").get(0), {
		type: "bar",
		data: {},
		options: {}
	});

	var barChartByWeatherRoute = new Chart($("#barChartByWeatherRoute").get(0), {
		type: "bar",
		data: {},
		options: {}
	});


	if($(":checked").length!=0){
		var url = "data?page=weather";
		$(":checked").each(function(){
			url += "&type=" + $(this).val();
		});

		var urlTmp = url + "&chart=total";
		// $.get(urlTmp, function(data){
		// 	addData(barChartByTotal, ["Winnie", "Andy"], [{
		// 		data: [1, 4]
		// 	}, {
		// 		data: [3, 6]
		// 	}]);
		// });
			addData(barChartByTotal, ["Hey"], [{
				label: "Winnie",
				data: [1]
			}, {
				label: "Andy",
				data: [3]
			}]);

		urlTmp = url + "&chart=light";
		// $.get(urlTmp, function(data){
			addData(barChartByWeatherLight, ["Winnie", "Andy"], [{
				label: "123",
				data: [3, 5]
			}, {
				label: "456",
				data: [10, 6]
			}]);
		// });

		urlTmp = url + "&chart=route";
		$.get(urlTmp, function(data){

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

    // chart.data.labels.push(label);
    // chart.data.datasets.forEach((dataset) => {
    //     dataset.data.push(data);
    // });
    chart.update();
}

function removeData(chart) {
    chart.data.labels.pop();
	chart.data.datasets.pop();    //my
    // chart.data.datasets.forEach((dataset) => {
    //     dataset.data.pop();
    // });
    chart.update();
}
</script>