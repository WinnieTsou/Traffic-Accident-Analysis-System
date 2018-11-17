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
				<h3 class="box-title">Total</h3>
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
				<h3 class="box-title">Month</h3>
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
				<h3 class="box-title">Holiday</h3>
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
					scales: {
						yAxes: [{
							ticks: {
								beginAtZero:true
							}
						}]
					}
				}
			});
			var labelArr = [" "];
			var datasetsArr = [];

			$.each(data, (i)=>{
				var datatmp = {
					label: "",
					data: [],
					backgroundColor: {}
				}
				datatmp.label = data[i].year;
				datatmp.data.push(data[i].count);
				datatmp.backgroundColor = "rgba("+getRandomNumber()+","+getRandomNumber()+","+getRandomNumber()+",0.4)";
				datasetsArr.push(datatmp);			
			});

			addData(polarChartByTotal, labelArr, datasetsArr);
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
						}]
					}
				}
			});
			var labelArr = [];
			var datasetsArr = [];
			var dataTemp = {};

			$.each(data, (key, row)=>{
				if(labelArr.indexOf(row.holiday) == -1)
					labelArr.push(row.holiday);
			});
			console.log(labelArr);

			var length = $(":checked").length;
			var yearArr = [];

			$(":checked").each(function(i){
				yearArr.push($(this).val());
			});

			var datatmp2 = [];
			for(var j=0; j<yearArr.length; j++){
				datatmp2[yearArr[j]] = [];
			}

			for(var j=0; j<yearArr.length; j++){
				datatmp2[yearArr[j]] = [];
				$.each(labelArr, (i)=>{
					datatmp2[yearArr[j]][labelArr[i]] = 0;
				});
			}

			$.each(data, (key, row)=>{
				datatmp2[row.year][row.holiday] = row.count;
			});
			console.log(datatmp2);


			var numeric_array = new Array();
			for (var items in datatmp2["2017"]){
			    numeric_array.push( datatmp2["2017"][items] );
			}
			console.log(numeric_array);

			for(var i=0; i<length; i++){
				var numeric_array = new Array();
				for (var items in datatmp2[yearArr[i]]){
				    numeric_array.push( datatmp2[yearArr[i]][items] );
				}
				var datatmp = {
					label: yearArr[i],
					data: numeric_array
				}
				datatmp.backgroundColor = "rgba("+getRandomNumber()+","+getRandomNumber()+","+getRandomNumber()+",0.4)";
				console.log(datatmp);
				datasetsArr.push(datatmp);
			}

			addData(barChartByHoliday, labelArr, datasetsArr);
		});

		urlTmp = url + "&chart=death";
		$.get(urlTmp, function(data){
			barChartByDeath.destroy();
			barChartByDeath = new Chart($("#barChartByDeath").get(0),{
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
			var labelArr = [" "];
			var datasetsArr = [];

			$.each(data, (i)=>{
				var datatmp = {
					label: "",
					data: [],
					backgroundColor: {}
				}
				datatmp.label = data[i].year;
				datatmp.data.push(data[i].died);
				datatmp.backgroundColor = "rgba("+getRandomNumber()+","+getRandomNumber()+","+getRandomNumber()+",0.4)";
				datasetsArr.push(datatmp);			
			});

			addData(barChartByDeath, labelArr, datasetsArr);
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