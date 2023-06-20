<?php

namespace App\Http\Controllers;

use App\Models\Evento;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;


class EventoController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function __construct() {
        $this->middleware('auth:api');
        }


    public function index()
    {
        Log::channel('stderr')->info("Si llega aqui");

        $eventos = Evento::all();
        $mappedcollection = $eventos->map(function ($evento, $key) {
        return [
        'id' => $evento->id,
        'id_periodo' => $evento->id_periodo,
        'nombre_evento'=>$evento->nombre_evento,
        'fecha'=>$evento->fecha,
        'horai'=>$evento->horai,
        'min_toler'=>$evento->min_toler,
        'latitud'=>$evento->latitud,
        'longitud'=>$evento->longitud,
        'estado'=>$evento->estado,
        'evaluar'=>$evento->evaluar,
        'perfil_evento'=>$evento->perfil_evento,
        'offline'=>$evento->offline,
        'asistencias'=>$evento->asistencias,
        ];
        });
        return response()->json(['success' => true,
        'data' => $mappedcollection,
        //'data' => Persona::all(),
        'message' => 'lista de eventos'], 200);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {
        Log::channel('stderr')->info($request);
        $input = $request->all();
        $evento=Evento::find($id);
        $evento->id_periodo = $input['id_periodo'];
        $evento->nombre_evento = $input['nombre_evento'];
        $evento->fecha = $input['fecha'];
        $evento->horai = $input['horai'];
        $evento->min_toler = $input['min_toler'];
        $evento->latitud = $input['latitud'];
        $evento->longitud = $input['longitud']; //estado
        $evento->estado = $input['estado'];
        $evento->evaluar = $input['evaluar'];
        $evento->perfil_evento = $input['perfil_evento'];
        $evento->offline = $input['offline'];
        $evento->save();
        return response()->json(['success' => true,
        'data' => Evento::all(),
        'message' => 'Lista de Eventos'], 200);
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
        Evento::create($input);

        return response()->json(['success' => true,
        'data' => Evento::all(),
        'message' => 'Lista de Evento'], 200);
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
     * Remove the specified resource from storage.
     */
    public function destroy(Request $request, $id)
    {
        Log::channel('stderr')->info($id);
        Evento::find($id)->delete();
        return response()->json(['success' => true,
        'data' => Evento::all(),
        'message' => 'Lista de Evento'], 200);
    }
}
