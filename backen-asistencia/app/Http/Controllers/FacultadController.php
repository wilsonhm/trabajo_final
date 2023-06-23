<?php

namespace App\Http\Controllers;

use App\Models\Facultad;
use Illuminate\Http\Request;

class FacultadController extends Controller
{
    /* Display a listing of the resource.
    */
   public function index(Request $request)
   {
       return response()->json(['success' => true,
       'data' => Facultad::all(),
       'message' => 'lista de facultad'], 200);
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
       Facultad::create($input);

       $facultades = Facultad::all();
       return response()->json([
           'success' => true,
           'data' => $facultades,
           'message' => 'Lista de facultades'
       ], 200);
   }

   /**
    * Display the specified resource.
    */
   public function show(Facultad $facultad)
   {
       //
   }

   /**
    * Show the form for editing the specified resource.
    */
   public function edit(Facultad $facultad)
   {
       //
   }

   /**
    * Update the specified resource in storage.
    */
   public function update(Request $request, Facultad $facultad)
   {
       $input = $request->all();
       $facultad->nombrefac = $input['nombrefac'];
       $facultad->estado = $input['estado'];
       $facultad->inicales = $input['inicales'];
       $facultad->save();

       $facultades = Facultad::all();
       return response()->json([
           'success' => true,
           'data' => $facultades,
           'message' => 'Lista de facultades'
       ], 200);
   }


   /**
    * Remove the specified resource from storage.
    */
   public function destroy(Facultad $facultad)
   {
       $facultad->delete();

       $facultades = Facultad::all();
       return response()->json([
           'success' => true,
           'data' => $facultades,
           'message' => 'Lista de facultades'
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
