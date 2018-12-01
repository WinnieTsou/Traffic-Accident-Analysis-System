<script type="text/javascript">
$(document).ready(function() {
    $('.js-example-basic-multiple').select2();
});
$(document).ready(function(){
	var url = "data?page=car";
	$.get(url, function(data){
		var select = $("#select");
		$.each(data, (key, row)=>{
			select.append("<option value='"+row.id+"'>"+row.description+"</option>");
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
				<label>Type of Car</label>
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
		<!-- PIE CHART -->
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
					<canvas id="pieChartByTotal"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->
	</div>


	<!-- Airbag -->
	<div class="col-md-6">
		<!-- BAR CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Accident Car with Airbag Installed</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="chart">
					<canvas id="barChartByAirbag"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->
	</div>

	<!-- SEX -->
	<!-- BAR CHART -->
	<div class="col-md-6">
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
					<canvas id="barChartBySex"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->
	</div>

	<!-- BAR CHART -->
	<div class="col-md-6">
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
					<canvas id="barChartByAge"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->
	</div>
</div>

<script type="text/javascript">
var pieChartByTotal = new Chart($("#pieChartByTotal").get(0));
var barChartByAirbag = new Chart($("#barChartByAirbag").get(0));
var barChartBySex = new Chart($("#barChartBySex").get(0));
var barChartByAge = new Chart($("#barChartByAge").get(0));
$("form").submit(function(e){
	e.preventDefault();

	if($(":selected").length!=0){
		var url = "data?page=car";
		$(":selected").each(function(){
			url += "&type=" + $(this).val();
		});

		var urlTmp = url + "&chart=total";
		$.get(urlTmp, (data)=>{
			pieChartByTotal.destroy();
			pieChartByTotal = new Chart($("#pieChartByTotal").get(0), {
				type: "pie",
				data: {},
				options: {}
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
						if(i == row.m_id){
							dataTmp = row.count;
						}
					});
					dataArr[i] = dataTmp;
				}
			});
			labelArr = labelArr.filter((element) => { return element != null; });
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

			addData(pieChartByTotal, labelArr, datasetsArr);
		});

		urlTmp = url + "&chart=airbag";
		$.get(urlTmp, (data)=>{
			barChartByAirbag.destroy();
			barChartByAirbag = new Chart($("#barChartByAirbag").get(0),{
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

			// $(":selected").each(function(){
			// 	labelArr[$(this).val()] = $(this).text();
			// });

			$.each(data, (key, row)=>{
				if(labelArr.indexOf(row.a_name)==-1){
					labelArr[row.a_id] = row.a_name;
				}
			});

			console.log(labelArr);	
			console.log(data);
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