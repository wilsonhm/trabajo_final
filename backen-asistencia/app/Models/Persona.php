<?php


namespace App\Models;


use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class Persona extends Model
{
    use HasFactory;
    protected $table = 'personas';
    public $timestamps = false;
    protected $primaryKey = 'id';
    protected $fillable = [
        'id','dni', 'codigo', 'nombre', 'apellido_paterno', 'apellido_materno',
        'telefono', 'genero', 'correo', 'estado', 'escuela_id'
    ];

    // Relación de pertenencia a una escuela
    public function escuela()
    {
        return $this->belongsTo(Escuela::class);
    }
}
