<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Matricula extends Model
{
    use HasFactory;
    protected $table = 'matriculas';
    public $timestamps = false;
    protected $primaryKey = 'id';
    protected $fillable = ['id','estado', 'periodo_id', 'persona_id'];

    // Relación de pertenencia a un periodo
    public function periodo()
    {
        return $this->belongsTo(Periodo::class);
    }

    // Relación de pertenencia a una persona
    public function persona()
    {
        return $this->belongsTo(Persona::class);
    }
}
