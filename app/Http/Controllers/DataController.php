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

            if ($chart === 'total') {
                $order = DB::table('case')
                            ->select("county_id AS c_id",
                                     "county_code.description AS c_name",
                                     DB::raw("COUNT(*) AS 'count'"))
                            ->leftJoin('county_code', 'case.county_id', '=', 'county_code.id')
                            ->whereRaw($sql)
                            ->groupBy('county_id')
                            ->orderBy('county_id', 'asc')
                            ->get();
            } else if ($chart === 'speeding') {
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
             } else if ($chart === 'intersection') {
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
                            ->orderByRaw('county_id, intersection_type asc')
                            ->get();
                }
            }
        return $order;
    }

    private function time(Request $request) {
        $chart = $request->query('chart');
        $query = explode('&', $_SERVER['QUERY_STRING']);
        $condition = "";


        foreach ($query as $year) {
            if (strpos($year, 'year') !== false) {
                $condition .= "YEAR(accident_date) = " . substr($year, strpos($year, '=')+1, strlen($year)) . " OR ";
            }
        }

        $condition = substr($condition, 0, strrpos($condition ,'OR'));

        if ($chart === 'total') {
            
            $order = DB::table('case')
                    ->select(DB::raw("YEAR(`accident_date`) AS 'year', count(*) AS 'count'"))
                    ->whereRaw($condition)
                    ->groupBy(DB::raw('YEAR(`accident_date`)'))
                    ->get();

        } else if ($chart === 'month') {

            $order = DB::table('case')
                    ->select(DB::raw("YEAR(`accident_date`) AS 'year', MONTH(`accident_date`) AS 'month', count(*) AS 'count'"))
                    ->whereRaw($condition)
                    ->groupBy(DB::raw("YEAR(`accident_date`), MONTH(`accident_date`)"))
                    ->orderBy('year')
                    ->orderBy('month')
                    ->get();
        } else if ($chart === 'holiday') {

            $order = DB::table('case')
                    ->select(DB::raw("YEAR(`accident_date`) AS 'year', `holiday_code`.`id` AS 'h_id', `holiday_code`.`description` AS 'holiday', count('holiday') AS 'count'"))
                    ->leftJoin('holiday_code', 'case.holiday_related', '=', 'holiday_code.id')
                    ->whereRaw('holiday_related > 0 AND ' . $condition)
                    ->groupBy(DB::raw('YEAR(accident_date), holiday'))
                    ->orderBy('year', 'asc')
                    ->orderBy('case.holiday_related', 'asc')
                    ->get();
        } else if ($chart === 'death') {

            $condition = str_replace('accident_date', 'time', $condition);
            $order = DB::table('died')
                    ->select(DB::raw("YEAR(`time`) AS 'year', count(*) AS 'died'"))
                    ->whereRaw($condition)
                    ->groupBy(DB::raw('YEAR(time)'))
                    ->orderBy(DB::raw('YEAR(time)'))
                    ->get();
        }


        return $order;
    }

    private function weather(Request $request) {
        $chart = $request->query('chart');
        $queryString = explode('&', $_SERVER['QUERY_STRING']);
        $typeArray = [1, 2, 3, 4, 5, 6, 7, 10, 11, 12];
        $condition = "";

        foreach ($queryString as $type) {
            $type = substr($type, strpos($type, '=')+1, strlen($type));
            if ( array_search($type, $typeArray) !== false ) {
                $condition .= "`weather_code` = " . $type . " OR ";
            }
        }
        $condition = substr($condition, 0, strrpos($condition ,'OR'));

        if ($chart === 'total') {
            $order = DB::table('weather')
                    ->select(DB::raw("SUBSTRING(`casenum`, 1, 4) AS 'year', `weather_code` AS 'w_code', `description` AS 'weather', COUNT(`description`) AS 'count' "))
                    ->leftJoin('weather_code', 'weather.weather_code', '=', 'weather_code.id')
                    ->whereRaw($condition)
                    ->groupby('year')
                    ->groupby('w_code')
                    ->orderBy('year', 'asc')
                    ->orderBy('w_code', 'asc')
                    ->get();
        } else if ($chart === 'light') {
            $order = DB::table('weather')
                    ->select(DB::raw("`weather_code` AS 'w_code', `weather_code`.`description` AS 'weather', `case`.`light_condition` AS 'l_condition', `light_condition_code`.`description`, COUNT(*) AS 'count' "))
                    ->leftJoin('weather_code', 'weather.weather_code', '=', 'weather_code.id')
                    ->leftJoin('case', 'weather.casenum', '=', 'case.casenum')
                    ->leftJoin('light_condition_code', 'case.light_condition', '=', 'light_condition_code.id')
                    ->whereRaw('(`case`.`light_condition` BETWEEN 0 AND 6) AND ' . $condition)
                    ->groupby('w_code')
                    ->groupby('case.light_condition')
                    ->orderBy('w_code', 'asc')
                    ->orderBy('case.light_condition', 'asc')
                    ->get();
        } else if ($chart === 'route') {
            $order = DB::table('weather')
                    ->select(DB::raw("`weather_code` AS 'w_code', `weather_code`.`description` AS 'weather', `case`.`route_signing` AS 'r_code', `route_signing_code`.`description` AS 'route_signing', COUNT(*) AS 'count'"))
                    ->leftJoin('weather_code', 'weather.weather_code', '=', 'weather_code.id')
                    ->leftJoin('case', 'weather.casenum', '=', 'case.casenum')
                    ->leftJoin('route_signing_code', 'case.route_signing', '=', 'route_signing_code.id')
                    ->whereRaw('(`weather_code`.`id` > 0) AND (`case`.`route_signing` BETWEEN 0 AND 8) AND ' . $condition)
                    ->groupby('w_code')
                    ->groupby('case.route_signing')
                    ->orderBy('w_code', 'asc')
                    ->orderBy('case.route_signing', 'asc')
                    ->get();
        }
        return $order;
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
