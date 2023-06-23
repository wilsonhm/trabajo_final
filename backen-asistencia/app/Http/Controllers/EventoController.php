<?php

namespace App\Http\Controllers;

use App\Models\Evento;
use Illuminate\Http\Request;

class EventoController extends Controller
{
    /**
     * Display a listing of the resource.
     */

     public function __construct() {
        $this->middleware('auth:api');
            }

    public function index(Request $request)
    {
        $eventos = Evento::all();
        return response()->json([
            'success' => true,
            'data' => $eventos,
            'message' => 'Lista de eventos'
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
        Evento::create($input);

        $eventos = Evento::all();
        return response()->json([
            'success' => true,
            'data' => $eventos,
            'message' => 'Lista de eventos'
        ], 200);
    }


    /**
     * Display the specified resource.
     */
    public function show(Evento $evento)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Evento $evento)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Evento $evento)
    {
        $input = $request->all();
        $evento->nom_evento = $input['nom_evento'];
        $evento->fecha = $input['fecha'];
        $evento->horai = $input['horai'];
        $evento->min_toler = $input['min_toler'];
        $evento->latitud = $input['latitud'];
        $evento->longitud = $input['longitud'];
        $evento->estado = $input['estado'];
        $evento->evaluar = $input['evaluar'];
        $evento->perfil_evento = $input['perfil_evento'];
        $evento->offline = $input['offline'];
        $evento->periodo_id = $input['periodo_id'];
        $evento->save();

        $eventos = Evento::all();
        return response()->json([
            'success' => true,
            'data' => $eventos,
            'message' => 'Lista de eventos'
        ], 200);
    }


    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Evento $evento)
    {
        $evento->delete();

        $eventos = Evento::all();
        return response()->json([
            'success' => true,
            'data' => $eventos,
            'message' => 'Lista de eventos'
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
