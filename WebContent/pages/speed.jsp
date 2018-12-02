<div id="myChart" class="row">
	<!-- Weather -->
	<div class="col-md-6">
		<!-- put chart here -->
		<!-- BAR CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Weather</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="chart">
					<canvas id="barChartByWeather"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->
	</div>
</div>
<script type="text/javascript">

var barChartByWeather = new Chart($("#barChartByWeather").get(0));

var url = "data?page=speed";

var urlTmp = url + "&chart=weather";
$.get(urlTmp, (data)=>{
	barChartByWeather.destroy();
	barChartByWeather = new Chart($("#barChartByWeather").get(0), {
		type: "bar",
		data: {},
		options: {
			legend: {
				display: false
			},
			scales: {
				yAxes: [{
					ticks: {
						beginAtZero:true
					}
				}],
				xAxes: [{
					ticks: {
						autoSkip: false,
						fontSize: 12,
						padding: 0
					}
				}]
			}
		}
	});
	var labelArr = [];
	var dataArr = [];
	var background = [];

	$.each(data, (key, row)=>{
		labelArr[row.w_code] = row.weather;
		dataArr[row.w_code] = row.avg;
		background[row.w_code] = "rgba(" + 
			getRandomNumber() + "," +
			getRandomNumber() + "," +
			getRandomNumber() + ",0.4)";
	});
	labelArr = labelArr.filter((element) => { return element != null; });
	dataArr = dataArr.filter((element) => { return element != null; });
	background = background.filter((element) => { return element != null; });

	console.log(labelArr);
	console.log(dataArr);
	console.log(data);
	addData(barChartByWeather, labelArr, [{
		label: "",
		data: dataArr,
		backgroundColor: background
	}]);
});

</script>
<script type="text/javascript">	
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