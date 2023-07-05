<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Facultad extends Model
{
    use HasFactory;
    protected $table = 'facultads';
    public $timestamps = false;
    protected $primaryKey = 'id';
    protected $fillable = ['id','nombrefac', 'estado', 'inicales'];

    // Relación de uno a muchos con la tabla de escuelas
    public function escuelas()
    {
        return $this->hasMany(Escuela::class);
    }
}
