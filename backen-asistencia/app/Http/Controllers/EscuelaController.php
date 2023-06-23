<?php

namespace App\Http\Controllers;

use App\Models\Escuela;
use Illuminate\Http\Request;

class EscuelaController extends Controller
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
    'data' => Escuela::all(),
    'message' => 'Lista de escuelas'
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
        Escuela::create($input);

        return response()->json([
            'success' => true,
            'data' => Escuela::all(),
            'message' => 'Lista de escuelas'
        ], 200);
    }

    /**
     * Display the specified resource.
     */
    public function show(Escuela $escuela)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Escuela $escuela)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Escuela $escuela)
    {
        $input = $request->all();
        $escuela->nombreeap = $input['nombreeap'];
        $escuela->estado = $input['estado'];
        $escuela->inicaleseap = $input['inicaleseap'];
        $escuela->facultad_id = $input['facultad_id'];
        $escuela->save();

        $escuelas = Escuela::all();
        return response()->json([
            'success' => true,
            'data' => $escuelas,
            'message' => 'Lista de escuelas'
        ], 200);
    }


    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Escuela $escuela)
    {
        $escuela->delete();

        $escuelas = Escuela::all();
        return response()->json([
            'success' => true,
            'data' => $escuelas,
            'message' => 'Lista de escuelas'
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
