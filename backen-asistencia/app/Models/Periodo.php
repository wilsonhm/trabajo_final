<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Periodo extends Model
{
    use HasFactory;
    protected $table = 'periodos';
    public $timestamps = false;
    protected $primaryKey = 'id';
    protected $fillable = ['id','nombre', 'estado'];

    // Relación de uno a muchos con la tabla de matriculas
    public function matriculas()
    {
        return $this->hasMany(Matricula::class);
    }

    // Relación de uno a muchos con la tabla de actividades
    public function actividades()
    {
        return $this->hasMany(Actividad::class);
    }

    // Relación de uno a muchos con la tabla de eventos
    public function eventos()
    {
        return $this->hasMany(Evento::class);
    }
}
