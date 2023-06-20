<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('eventos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("id_periodo");
            $table->string('nombre_evento', 60);
            $table->date('fecha');
            $table->time('horai');
            $table->time('min_toler');
            $table->string('latitud', 60);
            $table->string('longitud', 60);
            $table->string('estado', 8);
            $table->string('evaluar', 2);
            $table->string('perfil_evento', 20);
            $table->string('offline', 5);
            //$table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('eventos');
    }
};
