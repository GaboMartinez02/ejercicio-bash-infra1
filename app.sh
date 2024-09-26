#!/bin/bash

registrar_admin(){
  read -p "Introduce tu nombre de usuario: " nombre_admin
  read -sp "Introduce tu contraseña: " contrasena_admin
  
  if grep -q "^Nombre: $nombre_admin$" "administradores.txt"; then
    echo "Nombre de usuario '$nombre_admin' esta tomado."
  else
    echo "Nombre: $nombre_admin" >> administradores.txt
    echo "Contraseña: $contrasena_admin" >> administradores.txt
    echo "El administrador fue agregado correctamente"
  fi  
}

registrar_usuario(){
  read -p "Introduce tu nombre: " nombre_usuario
  read -p "Introduce tu cedula: " cedula_usuario
  read -p "Introduce tu fecha de nacimiento(ej(29/08/1991)): " nacimiento_usuario
  read -sp "Introduce tu contraseña: " contrasena_usuario
  
  if grep -q "^Cedula: $cedula_usuario$" "usuarios.txt"; then
      echo "Cedula '$cedula_usuario' esta tomada."
    else
      echo "Nombre: $nombre_usuario" >> usuarios.txt
      echo "Cedula: $cedula_usuario" >> usuarios.txt
      echo "Nacimiento: $nacimiento_usuario" >> usuarios.txt
      echo "Contraseña: $contrasena_usuario" >> usuarios.txt
      echo "El usuario fue agregado correctamente"
    fi  
}

ingreso_usuario(){
  read -p "Introduce tu cedula de usuario: " cedula_usuario
  read -sp "Introduce tu contraseña: " contrasena_usuario
  
  if grep -q "^Cedula: $cedula_usuario$" "usuarios.txt"; then
      if grep -q "^Contraseña: $contrasena_usuario$" "usuarios.txt"; then
        echo "Te logeaste correctamente"
      else
          echo "Cedula o Contraseña incorrecta"
      fi
  else
    echo "Cedula o Contraseña incorrecta"
  fi
}

registro_mascota(){
  numero Identificador, tipo de mascota,
  nombre, sexo, edad, descripcion y fecha de ingreso al sistema
  
  read -p "Introduce el numero identificador de la mascota: " id_mascota
  read -p "Introduce el tipo de la mascota: " tipo_mascota
  read -p "Introduce el nombre de la mascota: " nombre_mascota
  read -p "Introduce el sexo de la mascota: " sexo_mascota
  read -p "Introduce la edad de la mascota: " edad_mascota
  read -p "Introduce una descripcion de la mascota: " descripcion_mascota
  read -p "Introduce la fecha de ingreso(dia/mes/año): " fecha_mascota
  
  if grep -q "^Id: $id_mascota$" "mascotas.txt"; then
    echo "El ID ya existe en otra mascota"
  else 
    echo "$id_mascota - $tipo_mascota - $nombre_mascota - $sexo_mascota - $edad_mascota - $descripcion_mascota - $fecha_mascota" >> mascotas.txt
  fi
}

listar_mascotas() {
    echo "Lista de mascotas (Nombre - Tipo - Edad - Descripción):"
    
    while IFS=" - " read -r id_mascota tipo_mascota nombre_mascota sexo_mascota edad_mascota restante
    do
        descripcion_mascota=$(echo "$restante" | rev | cut -d ' ' -f 3- | rev)
        echo "$nombre_mascota - $tipo_mascota - $edad_mascota - $descripcion_mascota"
    done < mascotas.txt
}

listar_mascotas_simple() {
    echo "Lista de mascotas (Id - Nombre):"
    
    while IFS=" - " read -r id_mascota tipo_mascota nombre_mascota sexo_mascota edad_mascota restante
    do
        echo "$id_mascota - $nombre_mascota"
    done < mascotas.txt
}

adoptar_mascota(){
  listar_mascotas_simple
  read -p "Introduce el numero identificador de la mascota a adoptar: " id_mascota
  
  if grep -q "^$id_mascota -" "mascotas.txt"; then
      mascota_info=$(grep "^$id_mascota -" mascotas.text)
      fecha_actual=$(date + "%d/$m/%Y")
      echo "$mascota_info - $fecha_actual" >> adopciones.txt

      sed "/^$id_mascota - /d" mascotas.txt > mascotas_temp.txt
      mv mascotas_temp.txt mascotas.txt
      echo "La mascota con ID $id_mascota ha sido adoptada y eliminada del sistema."
  else 
      echo "El ID no existe en una mascota."
  fi
}

adoptar_mascota