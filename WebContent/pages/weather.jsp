<div class="box box-primary">
	<!-- form start -->
	<form role="form">
		<div class="box-body">
			<div class="form-group">
				<label>Weather</label>
				<div class="checkbox">
					<label><input type="checkbox" name="weather" value="1">Clear</label>
					<label><input type="checkbox" name="weather" value="2">Rain</label>
					<label><input type="checkbox" name="weather" value="3">Hail</label>
					<label><input type="checkbox" name="weather" value="4">Snow</label>
					<label><input type="checkbox" name="weather" value="5">Fog</label>
					<label><input type="checkbox" name="weather" value="6">Crosswinds</label>
					<label><input type="checkbox" name="weather" value="7">Blowing Dirt</label>
					<label><input type="checkbox" name="weather" value="10">Cloudy</label>
					<label><input type="checkbox" name="weather" value="11">Blowing Snow</label>
					<label><input type="checkbox" name="weather" value="12">Freezing Rain/Drizzle</label>
				</div>     
			</div>
		</div>
		<div class="box-footer">
			<button type="submit" class="btn btn-primary">Submit</button>
		</div>
	</form>
</div>

<div id="myChart" class="row" style="display: none;">
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

	<div class="col-md-12">
		<!-- put chart here -->
		<!-- BAR CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Weather & Light</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="chart">
					<canvas id="barChartByWeatherLight"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->
	</div>

	<div class="col-md-12">
		<!-- put chart here -->
		<!-- BAR CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Weather & Route</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="chart">
					<canvas id="barChartByWeatherRoute"></canvas>
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
		var url = "data?page=weather";
		$(":checked").each(function(){
			url += "&condition=" + $(this).val();
		});
		var urlTmp = url + "&chart=total";

		$.get(urlTmp, function(data){
			var total = $("#barChartByTotal").get(0);
			var totalData = data.barChartByTotal;
			var barChartByTotal = new Chart(total, totalData);
		});
		console.log(urlTmp);

		urlTmp = url + "&chart=light";
		$.get(urlTmp, function(data){
			var weatherLight = $("#barChartByWeatherLight").get(0);
			var weatherLightData = data.barChartByWeatherLight;
			var barChartByWeatherLight = new Chart(weatherLight, weatherLightData);
		});
		console.log(urlTmp);

		urlTmp = url + "&chart=route";
		$.get(urlTmp, function(data){
			var weatherRoute = $("#barChartByWeatherRoute").get(0);
			var weatherRouteData = data.barChartByWeatherRoute;
			var barChartByWeatherRoute = new Chart(weatherRoute, weatherRouteData);
		});
		console.log(urlTmp);

		$("#myChart").css({"display": "block"});
	} else {
		$("#myChart").css({"display": "none"});
	}
});
</script>