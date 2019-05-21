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
        $order = DB::table("case")
                    ->select(DB::raw("`case`.`casenum`, `longitude`, `latitude`, `accident_date`, `collision_code`.`description` AS 'collision', `light_condition_code`.`description` AS 'light_condition', `crash_factor_code`.`description` AS 'crash_factor', `weather_code`.`description` AS 'weather'"))
                    ->leftJoin('collision_code', 'collision_code.id', '=', 'case.collision_type')
                    ->leftJoin('light_condition_code', 'light_condition_code.id', '=', 'case.light_condition')
                    ->leftJoin('crash_factor', 'crash_factor.casenum', '=', 'case.casenum')
                    ->leftJoin('crash_factor_code', 'crash_factor.crash_factor_code', '=', 'crash_factor_code.id')
                    ->leftJoin('weather', 'weather.casenum', '=', 'case.casenum')
                    ->leftJoin('weather_code', 'weather.weather_code', '=', 'weather_code.id')
                    ->groupby('case.casenum')
                    ->get();

        return $order;
    }

    private function county(Request $request) {
        $chart = $request->input('chart');
        $counties = $request->input('county');

        if ($chart == null) {
            $order = DB::table('county_code')
                        ->select('id', DB::raw(" `description` AS 'name'"))
                        ->whereBetween('id', [1, 200])
                        ->get();
        } else {
            $sql = '';
            for ($i = 0; $i < count($counties) - 1; $i++) { 
                $sql .= "`county_id` = " . $counties[$i] . " OR ";
            }
            $sql .= "`county_id` = " . $counties[count($counties) - 1] . " ";

            if ($chart == 'total') {
                $order = DB::table('case')
                            ->select("county_id AS c_id",
                                     "county_code.description AS c_name",
                                     DB::raw("COUNT(*) AS 'count'"))
                            ->leftJoin('county_code', 'case.county_id', '=', 'county_code.id')
                            ->whereRaw($sql)
                            ->groupBy('county_id')
                            ->orderBy('county_id', 'asc')
                            ->get();
            } else if ($chart == 'speeding') {
                $sql = '(' . $sql . ')';

                $order = DB::table('vehicle')
                            ->select('county_id',
                                     'county_code.description AS c_name',
                                     DB::raw('COUNT(*) AS count'))
                            ->leftJoin('case', 'vehicle.casenum', '=', 'case.casenum')
                            ->leftJoin('county_code', 'case.county_id', '=', 'county_code.id')
                            ->whereRaw('`is_speeding` > 0  AND ' . $sql)
                            ->groupBy('county_id')
                            ->orderBy('county_id', 'asc')
                            ->get();
             } else if ($chart == 'intersection') {
            // sql.append("SELECT `county_id` AS 'c_id', `county_code`.`description` AS 'c_name', `intersection_type` AS 'i_code', `intersection_type_code`.`description` AS 'i_type', COUNT(*) AS 'count' ");
            // sql.append("FROM `CS485_Project`.`case` ");
            // sql.append("LEFT JOIN `CS485_Project`.`county_code` ON `case`.`county_id` = `county_code`.`id` ");
            // sql.append("LEFT JOIN `CS485_Project`.`intersection_type_code` ON `case`.`intersection_type` = `intersection_type_code`.`id` ");
            // sql.append("WHERE `intersection_type` < 11  AND (");
            // for (String county : counties)
                // sql.append("`county_id` = " + county + " OR ");
            // sql.replace(sql.lastIndexOf("OR"), sql.lastIndexOf("OR") + 2, "");
            // sql.append(") GROUP BY `county_id`, `intersection_type` ");
            // sql.append("ORDER BY `county_id`, `intersection_type`;");
                $sql = '(' . $sql . ')';
                $order = DB::table('case')
                            ->select('county_id as c_id',
                                     'county_code.description as c_name',
                                     'intersection_type as i_code',
                                     'intersection_type_code.description as i_type',
                                    DB::raw('COUNT(*) AS count'))
                            ->leftJoin('county_code', 'case.county_id', '=', 'county_code.id')
                            ->leftJoin('intersection_type_code', 'case.intersection_type', '=', 'intersection_type_code.id')
                            ->whereRaw('`intersection_type` < 11 AND ' . $sql)
                            ->groupBy('county_id', 'intersection_type')
                            // ->orderBy('county_id', 'intersection_type', 'asc')
                            ->orderByRaw('county_id, intersection_type asc')
                            ->get();
                }
            }
        return $order;
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
        $page = $request->input('page');

        switch ($page) {
            case "all":
                $content = $this->all($request); break;
            case "county":
                $content = $this->county($request); break;
            case "time":
                $content = $this->time($request); break;
            case "weather":
                $content = $this->weather($request); break;
            case "drugAlcohol":
                $content = $this->drugAlcohol($request); break;
            case "car":
                $content = $this->car($request); break;
            case "death":
                $content = $this->death($request); break;
            case "speed":
                $content = $this->speed($request); break;
            case "factor":
                $content = $this->factor($request); break;
            case "collision":
                $content = $this->collision($request); break;
            default: break;
        }

        return $content;
    }
}
