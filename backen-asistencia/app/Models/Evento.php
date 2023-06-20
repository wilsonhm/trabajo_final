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
    protected $foreignKey = ['id_periodo'];
    protected $fillable = [
        'id', 'id_periodo', 'nombre_evento', 'fecha',
        'horai', "min_toler",
        'latitud', 'longitud', 'estado', 'evaluar', 'perfil_evento', 'offline'
    ];

    public function periodo()
    {
        return $this->belongsTo(Periodo::class);
    }

    public function asistencias()
    {
        return $this->hasMany(Asistencia::class);
    }


}
