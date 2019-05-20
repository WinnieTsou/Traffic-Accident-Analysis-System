<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('/all', function() {
	return view('all', ['id' => 'all']);
});

Route::get('/county', function() {
	return view('county', ['id' => 'county']);
});

Route::get('/time', function() {
	return view('time', ['id' => 'time']);
});

Route::get('/weather', function() {
	return view('weather', ['id' => 'weather']);
});

Route::get('/drugalcohol', function() {
	return view('drugalcohol', ['id' => 'drugoralcohol']);
});

Route::get('/car', function() {
	return view('typeofcar', ['id' => 'car']);
});

Route::get('/death', function() {
	return view('death', ['id' => 'death']);
});

Route::get('/speed', function() {
	return view('speed', ['id' => 'speed']);
});

Route::get('/factor', function() {
	return view('factor', ['id' => 'factor']);
});

Route::get('/collision', function() {
	return view('mannerofcollision', ['id' => 'collision']);
});

Route::get('/data', 'DataController@fetchData');

