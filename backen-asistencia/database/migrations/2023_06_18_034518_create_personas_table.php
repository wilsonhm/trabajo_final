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
        Schema::create('personas', function (Blueprint $table) {
            $table->id();
            $table->string('dni',9);
            $table->string('codigo',10);
            $table->string('nombre',20);
            $table->string('apellido_paterno',20);
            $table->string('apellido_materno',20);
            $table->string('telefono');
            $table->string('genero', 16);
            $table->string('correo', 24);
            $table->string('estado', 8);
            $table->unsignedBigInteger('escuela_id');
            $table->foreign('escuela_id')->references('id')->on('escuelas')->onDelete('cascade');
            //$table->timestamps();
        });
    }


    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('personas');
    }
};
