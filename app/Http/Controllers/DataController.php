<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;

class DataController extends Controller
{
    /**
     * Handle the incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function all($request) {
        // $sql = "SELECT `case`.`casenum`, `longitude`, `latitude`, `accident_date`, `collision_code`.`description` AS 'collision', `light_condition_code`.`description` AS 'light_condition', `crash_factor_code`.`description` AS 'crash_factor', `weather_code`.`description` AS 'weather' ";
        // $sql .= "FROM `case` ";
        // $sql .= "LEFT JOIN `collision_code` ON `collision_code`.`id` = `case`.`collision_type` ";
        // $sql .= "LEFT JOIN `light_condition_code` ON `light_condition_code`.`id` = `case`.`light_condition` ";
        // $sql .= "LEFT JOIN `crash_factor` ON `crash_factor`.`casenum` = `case`.`casenum` ";
        // $sql .= "LEFT JOIN `crash_factor_code` ON `crash_factor`.`crash_factor_code` = `crash_factor_code`.`id` ";
        // $sql .= "LEFT JOIN `weather` ON `weather`.`casenum` = `case`.`casenum` ";
        // $sql .= "LEFT JOIN `weather_code` ON `weather`.`weather_code` = `weather_code`.`id` ";
        // $sql .= "GROUP BY `case`.`casenum`";
        $sql = "SELECT `case`.`casenum`, `longitude`, `latitude`, `accident_date`, `collision_code`.`description` AS 'collision', `light_condition_code`.`description` AS 'light_condition', `crash_factor_code`.`description` AS 'crash_factor', `weather_code`.`description` AS 'weather' FROM `case` LEFT JOIN `collision_code` ON `collision_code`.`id` = `case`.`collision_type` LEFT JOIN `light_condition_code` ON `light_condition_code`.`id` = `case`.`light_condition` LEFT JOIN `crash_factor` ON `crash_factor`.`casenum` = `case`.`casenum` LEFT JOIN `crash_factor_code` ON `crash_factor`.`crash_factor_code` = `crash_factor_code`.`id` LEFT JOIN `weather` ON `weather`.`casenum` = `case`.`casenum` LEFT JOIN `weather_code` ON `weather`.`weather_code` = `weather_code`.`id` GROUP BY `case`.`casenum`";

        $content = DB::select($sql);
        $content = json_encode($content);

        return $content;
    }

    private function county(Request $request) {
        
    }

    private function time(Request $request) {
        
    }

    private function weather(Request $request) {
        
    }

    private function drugAlcohol(Request $request) {
        
    }

    private function car(Request $request) {
        
    }

    private function death(Request $request) {
        
    }
    
    private function speed(Request $request) {
        
    }
    
    private function factor(Request $request) {
        
    }
    
    private function collision(Request $request) {
        
    }

    public function fetchData(Request $request) {
        // $content = DB::select('show databases');
        $page = $request->input('page');

        switch ($page) {
            case "all":
                $content = $this->all($request); break;
            case "county":
                county($request); break;
            case "time":
                time($request); break;
            case "weather":
                weather($request); break;
            case "drugAlcohol":
                drugAlcohol($request); break;
            case "car":
                car($request); break;
            case "death":
                death($request); break;
            case "speed":
                speed($request); break;
            case "factor":
                factor($request); break;
            case "collision":
                collision($request); break;
            default: break;
        }

        return $content;
    }
}
