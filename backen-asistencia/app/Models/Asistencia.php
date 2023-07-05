<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Asistencia extends Model
{
    use HasFactory;
    protected $table = 'asistencias';
    public $timestamps = false;
    protected $primaryKey = 'id';
    protected $fillable = [
        'id','fecha', 'hora', 'latituda', 'longituda', 'tipo', 'tipo_reg',
        'id_matricula', 'id_evento', 'id_persona', 'calificacion',
    ];

    // Relación de pertenencia a una matrícula
    public function matricula()
    {
        return $this->belongsTo(Matricula::class, 'id_matricula');
    }

    // Relación de pertenencia a un evento
    public function evento()
    {
        return $this->belongsTo(Evento::class, 'id_evento');
    }
    public function persona()
    {
        return $this->belongsTo(Persona::class, 'id_persona');
    }
}
