<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Evento extends Model
{
    use HasFactory;
    protected $table = 'eventos';
    public $timestamps = false;
    protected $primaryKey = 'id';
    protected $fillable = [
        'nom_evento', 'fecha', 'horai', 'min_toler', 'latitud', 'longitud',
        'estado', 'evaluar', 'perfil_evento', 'offline', 'periodo_id'
    ];

    // Relación de pertenencia a un periodo
    public function periodo()
    {
        return $this->belongsTo(Periodo::class);
    }
}
