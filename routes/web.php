<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('home');    
})->name('home');

Route::get('/details', function () {
    return view('details');
})->name('details');
