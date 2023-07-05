<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Escuela extends Model
{
    use HasFactory;
    protected $table = 'escuelas';
    public $timestamps = false;
    protected $primaryKey = 'id';
    protected $fillable = ['id','nombreeap', 'estado', 'inicaleseap', 'facultad_id'];

    // Relación de pertenencia a una facultad
    public function facultad()
    {
        return $this->belongsTo(Facultad::class);
    }
}
