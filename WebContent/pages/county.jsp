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


	<!-- Drug -->
	<div class="col-md-6">
		<!-- PIE CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Drug</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="chart">
					<canvas id="pieChartByDrug"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->
	</div>

	<!-- Alcohol -->
	<div class="col-md-6">
		<!-- PIE CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Alcohol</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="chart">
					<canvas id="pieChartByAlcohol"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->
	</div>

	<!-- Speeding -->
	<div class="col-md-12">
		<!-- DOUGHNUT CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Speeding</h3>
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
</div>
<script type="text/javascript">

var barChartByTotal = new Chart($("#barChartByTotal").get(0));
var pieChartByDrug = new Chart($("#pieChartByDrug").get(0));
var pieChartByAlcohol = new Chart($("#pieChartByAlcohol").get(0));
var doughnutChartBySpeeding = new Chart($("#doughnutChartBySpeeding").get(0));


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
			var datasetsArr = [];

			$.each(data, (key, row)=>{
				datasetsArr.push({
					label: row.c_name,
					data: [row.count],
					backgroundColor: "rgba(" + 
						getRandomNumber() + "," +
						getRandomNumber() + "," +
						getRandomNumber() + ",0.4)"
				});
			});

			addData(barChartByTotal, labelArr, datasetsArr);
		});

		urlTmp = url + "&chart=drug";
		$.get(urlTmp, function(data){
			pieChartByDrug.destroy();
			pieChartByDrug = new Chart($("#pieChartByDrug").get(0),{
				type: "pie",
				data: {},
				options: {}
			});
		});

		urlTmp = url + "&chart=alcohol";

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