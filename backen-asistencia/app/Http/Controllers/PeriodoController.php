<?php

namespace App\Http\Controllers;

use App\Models\Periodo;
use Illuminate\Http\Request;

class PeriodoController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function __construct() {
        $this->middleware('auth:api');
            }
            public function index(Request $request)
            {
                return response()->json([
                    'success' => true,
                    'data' => Periodo::all(),
                    'message' => 'Lista de periodos'
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
        Periodo::create($input);

        return response()->json([
            'success' => true,
            'data' => Periodo::all(),
            'message' => 'Lista de periodos'
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
     * Update the specified resource in storage.
     */
    public function update(Request $request, Periodo $periodo)
    {
        $input = $request->all();
        $periodo->nombre = $input['nombre'];
        $periodo->estado = $input['estado'];
        $periodo->save();

        return response()->json([
            'success' => true,
            'data' => $periodo,
            'message' => 'Periodo actualizado exitosamente'
        ], 200);
    }

    public function destroy(Periodo $periodo)
    {
        $periodo->delete();

        $periodos = Periodo::all();
        return response()->json([
            'success' => true,
            'data' => $periodos,
            'message' => 'Lista de periodos'
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
