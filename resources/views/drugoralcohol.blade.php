@extends('layouts.template')

@section('title', 'Drug and Alcohol')

@section('description', '123')

@section('content')

<div id="myChart" class="row">
	<!-- Total -->
	<div class="col-md-6">
		<!-- put chart here -->
		<!-- BAR CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Total (People)</h3>
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

		<!-- PIR CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Drug on Sex (People)</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="chart">
					<canvas id="pieChartByDrugSex"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->
	</div>


	<!-- Injury -->
	<div class="col-md-6">
		<!-- BAR CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Injury (People)</h3>
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

		<!-- PIE CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Alcohol on Sex (People)</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="chart">
					<canvas id="pieChartByAlcoholSex"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->
	</div>

</div>

<script type="text/javascript">
$("div.checkbox label").css({"margin": "10px"});

var barChartByTotal = new Chart($("#barChartByTotal").get(0));
var barChartByInjury = new Chart($("#barChartByInjury").get(0));
var pieChartByDrugSex = new Chart($("#pieChartByDrugSex").get(0));
var pieChartByAlcoholSex = new Chart($("#pieChartByAlcoholSex").get(0));

var url = "data?page=drugAlcohol";

var urlTmp = url + "&chart=total";
$.get(urlTmp, function(data){
	barChartByTotal.destroy();
	barChartByTotal = new Chart($("#barChartByTotal").get(0), {
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
	var drug = [];
	var alcohol = [];
	var datasetsArr = [];
	$.each(data, (key, row)=>{
		if(row.drug_count != null){
			drug[row.year] = row.drug_count;
		} else if(row.alcohol_count != null){
			alcohol[row.year] = row.alcohol_count;
		}
	});
	drug = drug.filter((element) => { return element != null; });
	alcohol = alcohol.filter((element) => { return element != null; });

	datasetsArr.push({
		label: "Drug",
		data: drug,
		backgroundColor: "rgba(" + 
			getRandomNumber() + "," +
			getRandomNumber() + "," +
			getRandomNumber() + ",0.4)"
	});
	datasetsArr.push({
		label: "Alcohol",
		data: alcohol,
		backgroundColor: "rgba(" + 
			getRandomNumber() + "," +
			getRandomNumber() + "," +
			getRandomNumber() + ",0.4)"
	});
	addData(barChartByTotal, ["2015", "2016", "2017"], datasetsArr);
});

urlTmp = url + "&chart=dsex";
$.get(urlTmp, (data)=>{
	pieChartByDrugSex.destroy();

	var drugData = {
		labels: ["Male", "Female"],
		datasets: [{
			label: "",
			data: [210, 65],
			backgroundColor: [
				"rgba(0,0,255,0.4)",
				"rgba(255,0,0,0.4)"
			]
		}]
	};
	pieChartByDrugSex = new Chart($("#pieChartByDrugSex").get(0), {
		type: 'pie',
		data: drugData,
		options: {}
	});
});

urlTmp = url + "&chart=asex";
$.get(urlTmp, (data)=>{
	pieChartByAlcoholSex.destroy();

	var alcoholData = {
		labels: ["Male", "Female"],
		datasets: [{
			label: "",
			data: [273, 49],
			backgroundColor: [
				"rgba(0,0,255,0.4)",
				"rgba(255,0,0,0.4)"
			]
		}]
	};
	pieChartByAlcoholSex = new Chart($("#pieChartByAlcoholSex").get(0), {
		type: 'pie',
		data: alcoholData,
		options: {}
	});
});

urlTmp = url + "&chart=injury";
$.get(urlTmp, (data)=>{
	barChartByInjury.destroy();
	barChartByInjury = new Chart($("#barChartByInjury").get(0), {
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
	var drugData = [];
	var alcoholData = [];
	var datasetsArr = [];
	$.each(data, (key, row)=>{
		if(labelArr.indexOf(row.description)==-1){
			labelArr[row.i_id] = row.description;
		}
		if(row.d_count!=null){
			drugData[row.i_id] = row.d_count;
		} else if(row.a_count!=null){
			alcoholData[row.i_id] = row.a_count;
		}
	});
	datasetsArr.push({
		label: "Drug",
		data: drugData,
		backgroundColor: "rgba(" + 
			getRandomNumber() + "," +
			getRandomNumber() + "," +
			getRandomNumber() + ",0.4)"
	});
	datasetsArr.push({
		label: "Alcohol",
		data: alcoholData,
		backgroundColor: "rgba(" + 
			getRandomNumber() + "," +
			getRandomNumber() + "," +
			getRandomNumber() + ",0.4)"
	});
	addData(barChartByInjury, labelArr, datasetsArr);	
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
@endsection