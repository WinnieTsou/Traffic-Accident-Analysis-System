<div id="myChart" class="row">
	<!-- Total -->
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
</div>
<script type="text/javascript">
var barChartByTotal = new Chart($("#barChartByTotal").get(0));
var url = "data?page=factor";
var urlTmp = "&chart=total";
$.get(urlTmp, (data)=>{
	barChartByTotal.destroy();
	barChartByTotal = new Chart($("#barChartByTotal").get(0), {
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
						fontSize: 9,
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
		labelArr.push(row.description);
		dataArr.push(row.c_id);
		background.push("rgba(" + 
			getRandomNumber() + "," +
			getRandomNumber() + "," +
			getRandomNumber() + ",0.4)");
	});
	addData(barChartByTotal, labelArr, [{
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