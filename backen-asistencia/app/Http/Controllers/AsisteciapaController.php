<?php

namespace App\Http\Controllers;

use App\Models\Asisteciapa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class AsisteciapaController extends Controller
{

    public function __construct() {
        $this->middleware('auth:api');
        }

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        return response()->json(['success' => true,
        'data' => Asisteciapa::all(),
        'message' => 'lista de asisteenciasPa'], 200);
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
        Asisteciapa::create($input);

        return response()->json([
            'success' => true,
            'data' => Asisteciapa::all(),
            'message' => 'Lista de asistencias'
        ], 200);
    }


    /**
     * Display the specified resource.
     */
    public function show(Asisteciapa $asisteciapa)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Asisteciapa $asisteciapa)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Asisteciapa $asisteciapa)
    {
        $input = $request->all();
        $asisteciapa->fecha = $input['fecha'];
        $asisteciapa->hora_reg = $input['hora_reg'];
        $asisteciapa->latituda = $input['latituda'];
        $asisteciapa->longituda = $input['longituda'];
        $asisteciapa->tipo = $input['tipo'];
        $asisteciapa->calificacion = $input['calificacion'];
        $asisteciapa->cui = $input['cui'];
        $asisteciapa->tipo_cui = $input['tipo_cui'];
        $asisteciapa->actividad_id = $input['actividad_id'];
        $asisteciapa->save();

        $asistecias = Asisteciapa::all();
        return response()->json([
            'success' => true,
            'data' => $asistecias,
            'message' => 'Lista de asistencias'
        ], 200);
    }


    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Asisteciapa $asisteciapa)
    {
        $asisteciapa->delete();

        $asistecias = Asisteciapa::all();
        return response()->json([
            'success' => true,
            'data' => $asistecias,
            'message' => 'Lista de asistencias'
        ], 200);
    }

}
