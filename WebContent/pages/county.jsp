<script type="text/javascript">
$(document).ready(function() {
    $('.js-example-basic-multiple').select2();
});
$(document).ready(function(){
	var url = "data?page=county";
	$.get(url, function(data){
		var select = $("#select");
		$.each(data, (key, row)=>{
			select.append("<option value='"+row.id+"'>"+row.name+"</option>");
		});
	});
});
</script>
<div class="box box-primary">
	<!-- form start -->
	<form role="form">
		<div class="box-body">
			<!-- select -->
			<div class="form-group">
				<label>County</label>
				<select id="select" class="form-control js-example-basic-multiple" multiple="multiple" name="state">
				</select>
			</div>
		</div>
		
		<div class="box-footer">
			<button type="submit" class="btn btn-primary">Submit</button>
		</div>
	</form>
</div>

<div id="myChart" class="row" style="display: none;">
	<!-- Total -->
	<div class="col-md-6">
		<!-- put chart here -->
		<!-- BAR CHART -->
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
					<canvas id="barChartByTotal"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->
	</div>


	<!-- Speeding -->
	<div class="col-md-6">
		<!-- DOUGHNUT CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Speeding (Vechicle)</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="chart">
					<canvas id="doughnutChartBySpeeding"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->
	</div>


	<!-- BAR CHART -->
	<div class="col-md-12">
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Intersection (Case)</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="chart">
					<canvas id="barChartByIntersection"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->
	</div>
</div>
<script type="text/javascript">

var barChartByTotal = new Chart($("#barChartByTotal").get(0));
var doughnutChartBySpeeding = new Chart($("#doughnutChartBySpeeding").get(0));
var barChartByIntersection = new Chart($("#barChartByIntersection").get(0));


$("form").submit(function(e){
	e.preventDefault();

	if($(":selected").length!=0){
		var url = "data?page=county";
		$(":selected").each(function(){
			url += "&county=" + $(this).val();
		});

		var urlTmp = url + "&chart=total";
		$.get(urlTmp, function(data){
			barChartByTotal.destroy();
			barChartByTotal = new Chart($("#barChartByTotal").get(0),{
				type: "bar",
				data: {},
				options: {
					legend: {
						display: false
					},
					scales: {
						yAxes: [{
							ticks: {
								beginAtZero: true,
								stepSize: 5
							}
						}]
					}
				}
			});
			var labelArr = [];
			var dataArr = [];
			var background = [];


			$(":selected").each(function(){
				labelArr[$(this).val()] = $(this).text();
				dataArr[$(this).val()] = 0;
				background.push("rgba(" + 
					getRandomNumber() + "," +
					getRandomNumber() + "," +
					getRandomNumber() + ",0.4)");
			});
			$.each(data, (key, row)=>{
				dataArr[row.c_id] = row.count;
			});
			dataArr = dataArr.filter((element) => { return element != null; });
			labelArr = labelArr.filter((element) => { return element != null; });
			addData(barChartByTotal, labelArr, [{
				label: "",
				data: dataArr,
				backgroundColor: background
			}]);
		});

		urlTmp = url + "&chart=speeding";
		$.get(urlTmp, function(data){
			doughnutChartBySpeeding.destroy();
			doughnutChartBySpeeding = new Chart($("#doughnutChartBySpeeding").get(0), {
				type: "doughnut",
				data: {},
				options: {

				}
			});

			var labelArr = [];
			var dataArr = [];
			var datasetsArr = [];

			$(":selected").each(function(){
				labelArr[$(this).val()] = $(this).text();
			});
			$.each(labelArr, (i)=>{
				if(labelArr[i] != null){
					var dataTmp = 0;
					$.each(data, (key, row)=>{
						if(i == row.county_id){
							dataTmp = row.count;
						}
					});
					dataArr.push(dataTmp);
				}
			});
			dataArr = dataArr.filter((element) => { return element != null; });

			var background = [];
			$.each(labelArr, (i)=>{
				background.push("rgba(" + getRandomNumber() + "," + getRandomNumber() + "," + getRandomNumber() + ",0.4)");
			});

			datasetsArr.push({
				label: "",
				data: dataArr,
				backgroundColor: background
			});
			addData(doughnutChartBySpeeding, labelArr, datasetsArr);
		});

		urlTmp = url + "&chart=intersection";
		$.get(urlTmp, (data)=>{
			barChartByIntersection.destroy();
			barChartByIntersection = new Chart($("#barChartByIntersection").get(0), {
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
			var labels = [];
			var datasetsArr = [];

			$.each(data, (key, row)=>{
				if(labelArr.indexOf(row.i_type)==-1){
					labelArr[row.i_code] = row.i_type;
				}
				if(!Array.isArray(dataArr[row.c_id])){
					dataArr[row.c_id] = [];
				}
				dataArr[row.c_id][row.i_code] = row.count;
				if(labels.indexOf(row.c_name)==-1){
					labels[row.c_id] = row.c_name;
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
			addData(barChartByIntersection, labelArr, datasetsArr);
		});

		$("#myChart").css({"display": "block"});
	} else {
		$("#myChart").css({"display": "none"});

	}
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