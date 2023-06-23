<?php

namespace App\Http\Controllers;

use App\Models\Matricula;
use Illuminate\Http\Request;

class MatriculaController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function __construct() {
        $this->middleware('auth:api');
            }
    public function index(Request $request)
    {
        $matriculas = Matricula::all();
        return response()->json([
            'success' => true,
            'data' => $matriculas,
            'message' => 'Lista de matriculas'
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
        Matricula::create($input);

        return response()->json([
            'success' => true,
            'data' => Matricula::all(),
            'message' => 'Lista de matriculas'
        ], 200);
    }


    /**
     * Display the specified resource.
     */
    public function show(Matricula $matricula)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Matricula $matricula)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Matricula $matricula)
    {
        $input = $request->all();
        $matricula->estado = $input['estado'];
        $matricula->periodo()->associate($input['periodo_id']);
        $matricula->persona()->associate($input['persona_id']);

        $matricula->save();

        return response()->json([
            'success' => true,
            'data' => $matricula,
            'message' => 'Matricula actualizada exitosamente'
        ], 200);
    }


    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Matricula $matricula)
    {
        $matricula->delete();

        $matriculas = Matricula::all();
        return response()->json([
            'success' => true,
            'data' => $matriculas,
            'message' => 'Lista de matriculas'
        ], 200);
    }
    public function sendError($error, $errorMessages = [], $code = 404)
    {
        $response = [
            'success' => false,
            'message' => $error,
        ];

        if (!empty($errorMessages)) {
            $response['data'] = $errorMessages;
        }

        return response()->json($response, $code);
    }
}
