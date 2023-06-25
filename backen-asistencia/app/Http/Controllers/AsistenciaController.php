<?php

namespace App\Http\Controllers;

use App\Models\Asistencia;
use Illuminate\Http\Request;

class AsistenciaController extends Controller
{
    /**
     * Display a listing of the resource.
     */

     public function __construct() {
        $this->middleware('auth:api');
            }
    public function index(Request $request)
{
    $asistencias = Asistencia::all();
    return response()->json([
        'success' => true,
        'data' => $asistencias,
        'message' => 'Lista de asistencias'
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
        Asistencia::create($input);

        return response()->json([
            'success' => true,
            'data' => Asistencia::all(),
            'message' => 'Lista de asistencias'
        ], 200);
    }


    /**
     * Display the specified resource.
     */
    public function show(Asistencia $asistencia)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Asistencia $asistencia)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {
        $input = $request->all();
        $asistencia = Asistencia::find($id);

        if (!$asistencia) {
            return response()->json([
                'success' => false,
                'message' => 'Asistencia no encontrada'
            ], 404);
        }

        $asistencia->fecha = $input['fecha'];
        $asistencia->hora = $input['hora'];
        $asistencia->latituda = $input['latituda'];
        $asistencia->longituda = $input['longituda'];
        $asistencia->tipo = $input['tipo'];
        $asistencia->tipo_reg = $input['tipo_reg'];
        $asistencia->id_matricula = $input['id_matricula'];
        $asistencia->id_evento = $input['id_evento'];
        $asistencia->id_persona = $input['id_persona'];
        $asistencia->calificacion = $input['calificacion'];
        $asistencia->offlinex = $input['offlinex'];
        $asistencia->save();

        return response()->json([
            'success' => true,
            'data' => $asistencia,
            'message' => 'Asistencia actualizada exitosamente'
        ], 200);
    }



    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        $asistencia = Asistencia::find($id);

        if (!$asistencia) {
            return response()->json([
                'success' => false,
                'message' => 'Asistencia no encontrada'
            ], 404);
        }

        $asistencia->delete();

        return response()->json([
            'success' => true,
            'message' => 'Asistencia eliminada exitosamente'
        ], 200);
    }

}
