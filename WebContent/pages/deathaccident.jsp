<div id="myChart" class="row">
	<!-- Car Type -->
	<div class="col-md-12">
		<!-- put chart here -->
		<!-- BAR CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Type of Car</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="chart">
					<canvas id="barChartByTypeOfCar"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->
	</div>

	<!-- DUI -->
	<div class="col-md-6">
		<!-- put chart here -->
		<!-- BAR CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Died while Driving Under the Influence</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="chart">
					<canvas id="pieChartByDui"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->	
	</div>	

	<!-- Alcohol -->
	<div class="col-md-6">
		<!-- put chart here -->
		<!-- BAR CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Manufacture Year</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="chart">
					<canvas id="barChartCarYear"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->	
	</div>

	<!-- Sex -->
	<div class="col-md-6">
		<!-- put chart here -->
		<!-- BAR CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Sex</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="chart">
					<canvas id="pieChartBySex"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->	
	</div>

	<!-- Age -->
	<div class="col-md-6">
		<!-- put chart here -->
		<!-- BAR CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Age</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="chart">
					<canvas id="pieChartByAge"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->	
	</div>

</div>

<script type="text/javascript">
var barChartByTypeOfCar = new Chart($("#barChartByTypeOfCar").get(0));
var pieChartBySex = new Chart($("#pieChartBySex").get(0));
var pieChartByAge = new Chart($("#pieChartByAge").get(0));
var pieChartByDui = new Chart($("#pieChartByDui").get(0));
var barChartCarYear = new Chart($("#barChartCarYear").get(0));

var url = "data?page=death";

var urlTmp = url + "&chart=cartype";
$.get(urlTmp, (data)=>{
	barChartByTypeOfCar.destroy();
	barChartByTypeOfCar = new Chart($("#barChartByTypeOfCar").get(0), {
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
	var datasetsArr = [];
	var background = [];
	$.each(data, (key, row)=>{
		dataArr.push(row.count);
		labelArr.push(row.description);
		background.push("rgba(" + 
			getRandomNumber() + "," +
			getRandomNumber() + "," +
			getRandomNumber() + ",0.4)");
	});
	datasetsArr.push({
		label: "",
		data: dataArr,
		backgroundColor: background
	});
	addData(barChartByTypeOfCar, labelArr, datasetsArr);
});

urlTmp = url + "&chart=sex";
$.get(urlTmp, (data)=>{
	pieChartBySex.destroy();
	pieChartBySex = new Chart($("#pieChartBySex").get(0), {
		type: "doughnut",
		data: {},
		options: {}
	});
	var labelArr = ["Male", "Female"];
	var dataArr = [];
	var background = [];
	$.each(data, (key, row)=>{
		dataArr.push(row.count);
		background.push("rgba(" + 
			getRandomNumber() + "," +
			getRandomNumber() + "," +
			getRandomNumber() + ",0.4)");
	});
	addData(pieChartBySex, labelArr, [{
		label: "",
		data: dataArr,
		backgroundColor: background
	}]);
});
urlTmp = url + "&chart=age";
$.get(urlTmp, (data)=>{
	pieChartByAge.destroy();
	pieChartByAge = new Chart($("#pieChartByAge").get(0), {
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
		labelArr[row.age] = row.age+"-"+(((row.age/10+1)*10)-1);
		dataArr[row.age] = row.count;
		background[row.age] = "rgba(" + 
			getRandomNumber() + "," +
			getRandomNumber() + "," +
			getRandomNumber() + ",0.4)";
	});
	labelArr = labelArr.filter((element) => { return element != null; });
	dataArr = dataArr.filter((element) => { return element != null; });
	background = background.filter((element) => { return element != null; });
	addData(pieChartByAge, labelArr, [{
		label: "",
		data: dataArr,
		backgroundColor: background
	}]);
});

urlTmp = url + "&chart=caryear";
$.get(urlTmp, (data)=>{
	barChartCarYear.destroy();
	barChartCarYear = new Chart($("#barChartCarYear").get(0), {
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
	var datasetsArr = [];
	var background = [];
	$.each(data, (key, row)=>{
		labelArr[row.year] = row.year+"-"+(((row.year/10+1)*10)-1);
		dataArr[row.year] = row.count;
		background[row.year] = "rgba(" + 
			getRandomNumber() + "," +
			getRandomNumber() + "," +
			getRandomNumber() + ",0.4)";
	});
	labelArr = labelArr.filter((element) => { return element != null; });
	dataArr = dataArr.filter((element) => { return element != null; });
	background = background.filter((element) => { return element != null; });
	labelArr[8] = "Not Report";
	datasetsArr.push({
		label: "",
		data: dataArr,
		backgroundColor: background
	});
	addData(barChartCarYear, labelArr, datasetsArr);
});

urlTmp = url + "&chart=num";
$.get(urlTmp, (data)=>{
	pieChartByDui.destroy();
	pieChartByDui = new Chart($("#pieChartByDui").get(0), {
		type: "pie",
		data: {},
		options: {}
	});
	var labelArr = ["Other", "Drug", "Alcohol"];
	var dataArr = [498, 224, 244];
	var background = [];
	var datasetsArr = [];
	$.each(dataArr, ()=>{
		background.push("rgba(" + 
			getRandomNumber() + "," +
			getRandomNumber() + "," +
			getRandomNumber() + ",0.4)");
	});
	datasetsArr.push({
		label: "",
		data: dataArr,
		backgroundColor: background
	});
	addData(pieChartByDui, labelArr, datasetsArr);
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