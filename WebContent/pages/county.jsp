<script type="text/javascript">
$(document).ready(function() {
    $('.js-example-basic-multiple').select2();
});
</script>
<div class="box box-primary">
	<!-- form start -->
	<form role="form">
		<div class="box-body">
			<!-- select -->
			<div class="form-group">
				<label>County</label>
				<select class="form-control js-example-basic-multiple" multiple="multiple" name="state">
  					<option value="AL">Alabama</option>
					<option value="WY">Wyoming</option>
				</select>
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

		<!-- BAR CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Weather</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="chart">
					<canvas id="barChartByWeather"></canvas>
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


	<!-- Right Hand Side -->
	<div class="col-md-6">
		<!-- Area CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Season</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="chart">
					<canvas id="areaChartBySeason"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->

		<!-- Radar CHART -->
		<div class="box box-success">
			<div class="box-header with-border">
				<h3 class="box-title">Drug/Alcohol</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				</div>
			</div>
			<div class="box-body">
				<div class="chart">
					<canvas id="radarChartByDrugOrAlcohol"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->

		<!-- Doughnut CHART -->
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
					<canvas id="doughnutChartBySpeed"></canvas>
				</div>
			</div>
		</div>
		<!-- /.box -->
	</div>
</div>
<script type="text/javascript">

$("form").submit(function(e){
	e.preventDefault();

	if($(":selected").length!=0){
		var url = "data?page=county";
		$(":selected").each(function(){
			url += "&county=" + $(this).val();
		});
		console.log(url);


		$("#myChart").css({"display": "block"});
	} else {
		$("#myChart").css({"display": "none"});

	}
});

</script>