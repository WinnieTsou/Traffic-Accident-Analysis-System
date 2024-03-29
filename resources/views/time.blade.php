@extends('layouts.template')

@section('title', 'Time')

@section('description', '123')

@section('content')
<div class="box box-primary">
	<!-- form start -->
	<form role="form">
		<div class="box-body">
			<div class="form-group">
				<label>Year</label>
				<div class="checkbox">
					<label><input type="checkbox" name="year" value="2017">2017</label>
					<label><input type="checkbox" name="year" value="2016">2016</label>
					<label><input type="checkbox" name="year" value="2015">2015</label>
				</div>     
			</div>
		</div>
		<div class="box-footer">
			<button type="submit" class="btn btn-primary">Submit</button>
		</div>
	</form>
</div>

<div id="myChart" class="row" style="display: none;">
	<!-- Left Hand Side -->
	<div class="col-md-6">
		<!-- put chart here -->
		<!-- POLAR CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Total (Case)</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="chart">
					<canvas id="polarChartByTotal"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->

		<!-- LINE CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Month (Case)</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="chart">
					<canvas id="lineChartByMonth"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->
	</div>


	<!-- Right Hand Side -->
	<div class="col-md-6">
		<!-- BAR CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Holiday (Case)</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="chart">
					<canvas id="barChartByHoliday"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->

		<!-- BAR CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Death (People)</h3>
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
</div>
<script type="text/javascript">
$("div.checkbox label").css({"margin": "10px"});

var polarChartByTotal = new Chart($("#polarChartByTotal").get(0));
var lineChartByMonth = new Chart($("#lineChartByMonth").get(0));
var barChartByHoliday = new Chart($("#barChartByHoliday").get(0));
var barChartByDeath = new Chart($("#barChartByDeath").get(0));


$("form").submit(function(e){
	e.preventDefault();
	if($(":checked").length!=0){
		var url = "data?page=time";
		$(":checked").each(function(){
			url += "&year=" + $(this).val();
		});
		var urlTmp = url + "&chart=total";

		$.get(urlTmp, function(data){
			polarChartByTotal.destroy();
			polarChartByTotal = new Chart($("#polarChartByTotal").get(0),{
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
						}]
					}
				}
			});
			var labelArr = [];
			var dataArr = [];
			var background = [];

			$(":checked").each(function(){
				labelArr[$(this).val()] = $(this).val();
				dataArr[$(this).val()] = 0;
				background.push("rgba("
					+getRandomNumber()+","
					+getRandomNumber()+","
					+getRandomNumber()+",0.4)");
			});

			$.each(data, (key, row)=>{
				dataArr[row.year] = row.count;
			});
			labelArr = labelArr.filter((element) => { return element != null; });
			dataArr = dataArr.filter((element) => { return element != null; });

			addData(polarChartByTotal, labelArr, [{
				label: "",
				data: dataArr,
				backgroundColor: background
			}]);
		});

		urlTmp = url + "&chart=month";
		$.get(urlTmp, function(data){
			lineChartByMonth.destroy();
			lineChartByMonth = new Chart($("#lineChartByMonth").get(0),{
				type: "bar",
				data: {},
				options: {
					scales: {
						yAxes: [{
							ticks: {
								beginAtZero:true
							}
						}]
					}
				}
			});
			var labelArr = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'June', 'July', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'];
			var datasetsArr = [];

			var dataTemp = {};


			$.each(data, (key, row)=>{
				if(!Array.isArray(dataTemp[row.year]))
					dataTemp[row.year] = [];
				dataTemp[row.year][row.month - 1] = row.count;	
			});
			$.each(dataTemp, (key, row)=>{
				var datatmp = {
					label: key,
					data: row
				}
				datatmp.backgroundColor = "rgba("+getRandomNumber()+","+getRandomNumber()+","+getRandomNumber()+",0.4)";

				datasetsArr.push(datatmp);
			});

			addData(lineChartByMonth, labelArr, datasetsArr);
		});

		urlTmp = url + "&chart=holiday";
		$.get(urlTmp, function(data){
			barChartByHoliday.destroy();
			barChartByHoliday = new Chart($("#barChartByHoliday").get(0),{
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
			var datasetsArr = [];
			var dataTemp = [];

			$.each(data, (key, row) => {
				if(labelArr.indexOf(row.holiday) == -1)
					labelArr[row.h_id] = row.holiday;
			});


			$.each(data, (key, row) => {
				if(!Array.isArray(dataTemp[row.year]))
					dataTemp[row.year] = [];
				dataTemp[row.year][row.h_id] = row.count;
			});

			$.each(dataTemp, (key, row) => {
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
						label: key,
						data: dataRow,
						backgroundColor: "rgba(" + 
							getRandomNumber() + "," +
							getRandomNumber() + "," +
							getRandomNumber() + ",0.4)"
					});
				}
			});

			labelArr = labelArr.filter((element) => { return element != null; });

			addData(barChartByHoliday, labelArr, datasetsArr);
		});

		urlTmp = url + "&chart=death";
		$.get(urlTmp, function(data){
			barChartByDeath.destroy();
			barChartByDeath = new Chart($("#barChartByDeath").get(0),{
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
						}]
					}
				}
			});
			var labelArr = [];
			var dataArr = [];
			var background = [];
			$(":checked").each(function(){
				labelArr[$(this).val()] = $(this).val();
				dataArr[$(this).val()] = 0;
				background.push("rgba("
					+getRandomNumber()+","
					+getRandomNumber()+","
					+getRandomNumber()+",0.4)");
			});
			$.each(data, (key, row)=>{
				dataArr[row.year] = row.died;
			});
			labelArr = labelArr.filter((element) => { return element != null; });
			dataArr = dataArr.filter((element) => { return element != null; });
			addData(barChartByDeath, labelArr, [{
				label: "",
				data: dataArr,
				backgroundColor: background
			}]);
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
	$.each(datasetArray, (i)=>{
		chart.data.datasets.push(datasetArray[i]);
	});

    chart.update();
}

function getRandomNumber(){
	return Math.floor(Math.random()*256);
}
</script>
@endsection