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
	return view('all');
});

Route::get('/county', function() {
	return view('county');
});

Route::get('/time', function() {
	return view('time');
});

Route::get('/weather', function() {
	return view('weather');
});

Route::get('/drugAlcohol', function() {
	return view('drugAlcohol');
});

Route::get('/car', function() {
	return view('car');
});

Route::get('/death', function() {
	return view('death');
});

Route::get('/speed', function() {
	return view('speed');
});

Route::get('/factor', function() {
	return view('county');
});

Route::get('/collision', function() {
	return view('county');
});


