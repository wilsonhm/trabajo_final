<?php

namespace App\Http\Controllers;

use App\Models\Periodo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;


class PeriodoController extends Controller
{
    /**s
     * Display a listing of the resource.
     */
    public function __construct()
    {
        $this->middleware('auth:api');
    }


    public function index()
    {
        Log::channel('stderr')->info("Si llega aqui");

        $periodos = Periodo::all();
        $mappedcollection = $periodos->map(function ($periodo, $key) {
            return [
                'id' =>$periodo->id,
                'nombre' =>$periodo->nombre,
                'estado'=>$periodo->estado,
                'eventos'=>$periodo->eventos,
                'matriculas'=>$periodo->matriculas,
            ];
        });
        return response()->json([
            'success' => true,
            'data' => $mappedcollection,
            //'data' => Persona::all(),
            'message' => 'lista de periodos'
        ], 200);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {
        Log::channel('stderr')->info($request);
        $input = $request->all();
        $periodo=Periodo::find($id);
        $periodo->nombre = $input['nombre'];
        $periodo->estado = $input['estado'];
        $periodo->save();
        return response()->json([
            'success' => true,
            'data' => Periodo::all(),
            'message' => 'Lista de Periodos'
        ], 200);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $input = $request->all();
        Log::channel('stderr')->info($request);
        Periodo::create($input);
        return response()->json([
            'success' => true,
            'data' => Periodo::all(),
            'message' => 'Lista de Periodo'
        ], 200);
    }

    /**
     * Display the specified resource.
     */
    public function show(Periodo $periodo)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Periodo $periodo)
    {
        //
    }



    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Request $request, $id)
    {
        Log::channel('stderr')->info($id);
        Periodo::find($id)->delete();
        return response()->json(['success' => true,
        'data' => Periodo::all(),
        'message' => 'Lista de Periodo'], 200);
    }
}
