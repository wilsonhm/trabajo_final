<?php

namespace Database\Seeders;

use App\Models\Role;
use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $admin = User::create([
            'name' => 'Administrador',
            'email' => 'user@admin.com',
            'password' => bcrypt('123456'),
        ]);

        $adviser = User::create([
            'name' => 'Estudiante',
            'email' => 'user@docent.com',
            'password' => bcrypt('123456'),
        ]);

        $user = User::create([
            'name' => 'User',
            'email' => 'user@student.com',
            'password' => bcrypt('123456'),
        ]);

        $roleAdmin = Role::all();
        $admin->roles()->attach($roleAdmin);

        $roleEstudiante = Role::where('roleName', 'estudiante')->first();
        $adviser->roles()->attach($roleEstudiante);

        $roleUser = Role::where('roleName', 'user')->first();
        $user->roles()->attach($roleUser);
    }
}
