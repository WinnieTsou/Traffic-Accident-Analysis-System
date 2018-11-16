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

$("form").submit(function(e){
	e.preventDefault();

	if($(":checked").length!=0){
		var url = "data?page=time";
		$(":checked").each(function(){
			url += "&year=" + $(this).val();
		});
		var urlTmp = url + "&chart=total";

		$.get(urlTmp, function(data){
			var total = $("#polarChartByTotal").get(0);
			var totalData = data.polarChartByTotal;
			var polarChartByTotal = new Chart(total, totalData);
		});

		urlTmp = url + "&chart=month";
		$.get(urlTmp, function(data){
			var month = $("#lineChartByMonth").get(0);
			var monthData = data.lineChartByMonth;
			var lineChartByMonth = new Chart(month, monthData);
		});

		urlTmp = url + "&chart=holiday";
		$.get(urlTmp, function(data){
			var holiday = $("#barChartByHoliday").get(0);
			var holidayData = data.barChartByHoliday;
			var barChartByHoliday = new Chart(holiday, holidayData);
		});

		urlTmp = url + "&chart=death";
		$.get(urlTmp, function(data){
			var death = $("#barChartByDeath").get(0);
			var deathData = data.barChartByDeath;
			var barChartByDeath = new Chart(death, deathData);
		});

		$("#myChart").css({"display": "block"});
	} else {
		$("#myChart").css({"display": "none"});
	}
});
</script>