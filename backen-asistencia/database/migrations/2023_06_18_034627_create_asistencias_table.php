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
        Schema::create('asistencias', function (Blueprint $table) {
            $table->id();
            $table->date("fecha");
            $table->time('hora');
            $table->string('latituda', 60);
            $table->string('longituda', 60);
            $table->string('tipo', 20);
            $table->string('tipo_reg', 12);
            $table->unsignedBigInteger('id_matricula');
            $table->unsignedBigInteger('id_evento');
            $table->unsignedBigInteger('id_persona');
            $table->integer('calificacion');
            $table->foreign('id_matricula')->references('id')->on('matriculas')->onDelete('cascade');
            $table->foreign('id_evento')->references('id')->on('eventos')->onDelete('cascade');
            $table->foreign('id_persona')->references('id')->on('personas')->onDelete('cascade');
            //$table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('asistencias');
    }
};
