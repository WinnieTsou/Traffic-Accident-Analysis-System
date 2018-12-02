<div id="myChart" class="row">
	<!-- Total -->
	<div class="col-md-6">
		<!-- put chart here -->
		<!-- PIE CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Total(Case)</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="chart">
					<canvas id="pieChartByTotal"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->
	</div>

	<!-- Death -->
	<div class="col-md-6">
		<!-- put chart here -->
		<!-- BAR CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Death</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="chart">
					<canvas id="barChartByDeath"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->
	</div>
	<!-- Injury -->
	<div class="col-md-12">
		<!-- put chart here -->
		<!-- BAR CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Injury</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="chart">
					<canvas id="barChartByInjury"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->
	</div>

</div>
<script type="text/javascript">
var pieChartByTotal = new Chart($("#pieChartByTotal").get(0));
var barChartByInjury = new Chart($("#barChartByInjury").get(0));
var barChartByDeath = new Chart($("#barChartByDeath").get(0));

var url = "data?page=collision";
var urlTmp = url + "&chart=total";
$.get(urlTmp, (data)=>{
	pieChartByTotal.destroy();
	pieChartByTotal = new Chart($("#pieChartByTotal").get(0), {
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
		labelArr.push(row.description);
		dataArr.push(row.count);
		background.push("rgba(" + 
			getRandomNumber() + "," +
			getRandomNumber() + "," +
			getRandomNumber() + ",0.4)");
	});
	labelArr.push(labelArr.shift());
	dataArr.push(dataArr.shift());

	addData(pieChartByTotal, labelArr, [{
		label: "",
		data: dataArr,
		backgroundColor: background
	}]);
});

urlTmp = url + "&chart=injury";
$.get(urlTmp, (data)=>{
	barChartByInjury.destroy();
	barChartByInjury = new Chart($("#barChartByInjury").get(0), {
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
	$.each(data, (key, row)=>{
		labelArr[""+row.c_id] = row.c_description;
		if(!Array.isArray(dataArr[row.i_description])){
			dataArr[row.i_description] = [];
		}
	});
	$.each(labelArr, (i)=>{
		if(labelArr[i]!=null){
			for( var key in dataArr){
				if(dataArr[key] != null)
					dataArr[key][i] = 0;
			}			
		}
	});
	$.each(data, (key, row)=>{
		dataArr[row.i_description][row.c_id] = row.count;
	});
	labelArr = labelArr.filter((element) => { return element != null; });
	labelArr.push(labelArr.shift());
	for( var key in dataArr ){
		var dataRow = [];

		dataRow = dataArr[key].filter((element) => { return element != null; });

		dataRow.push(dataRow.shift());
		datasetsArr.push({
			label: key,
			data: dataRow,
			backgroundColor: "rgba(" + 
				getRandomNumber() + "," +
				getRandomNumber() + "," +
				getRandomNumber() + ",0.4)"
		});
	}
	addData(barChartByInjury, labelArr, datasetsArr);
});
urlTmp = url + "&chart=death";
$.get(urlTmp, (data)=>{
	barChartByDeath.destroy();
	barChartByDeath = new Chart($("#barChartByDeath").get(0), {
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
		labelArr[row.c_id] = row.description;
		dataArr[row.c_id] = row.count;
		background.push("rgba(" + 
			getRandomNumber() + "," +
			getRandomNumber() + "," +
			getRandomNumber() + ",0.4)");
	});
	labelArr = labelArr.filter((element) => { return element != null; });
	dataArr = dataArr.filter((element) => { return element != null; });
	labelArr.push(labelArr.shift());
	dataArr.push(dataArr.shift());
	console.log(data);
	addData(barChartByDeath, labelArr, [{
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