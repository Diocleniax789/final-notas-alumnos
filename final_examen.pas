PROGRAM final_examen_notas;
USES crt, Dos;

CONST
     ULTIMA_POSICION_X = 6;

TYPE
    DatoAlumno = RECORD
     legajo: integer;
     codigo_asignatura: string[6];
     nota: real;
     activo: boolean;
    END;

    cadena = array[1..6]of string;

VAR
   archivo_basico,archivo_profesional,archivo_juntos: FILE OF DatoAlumno;
   registro_basico,registro_profesional,registro_juntos: DatoAlumno;
   cad: cadena;

PROCEDURE crea_archivo_basico;
 BEGIN
 rewrite(archivo_basico);
 close(archivo_basico);
 END;

PROCEDURE crea_archivo_profesional;
 BEGIN
 rewrite(archivo_profesional);
 close(archivo_profesional);
 END;

PROCEDURE ordena_archivo_basico;
VAR
 i,j: integer;
 reg_aux: DatoAlumno;
 BEGIN
 FOR i:= 0 TO filesize(archivo_basico) - 2 DO
  BEGIN
  FOR j:= i + 1 TO filesize(archivo_basico) - 1 DO
   BEGIN
   seek(archivo_basico,i);
   read(archivo_basico,registro_basico);
   seek(archivo_basico,j);
   read(archivo_basico,reg_aux);
   IF registro_basico.legajo > reg_aux.legajo THEN
    BEGIN
    seek(archivo_basico,i);
    write(archivo_basico,reg_aux);
    seek(archivo_basico,j);
    write(archivo_basico,registro_basico);
    END;
   END;
  END;
 END;

PROCEDURE ordena_archivo_archivo_profesional;
VAR
 i,j: integer;
 reg_aux: DatoAlumno;
 BEGIN
 FOR i:= 0 TO filesize(archivo_profesional) - 2 DO
  BEGIN
  FOR j:= i + 1 TO filesize(archivo_profesional) - 1 DO
   BEGIN
   seek(archivo_profesional,i);
   read(archivo_profesional,registro_profesional);
   seek(archivo_profesional,j);
   read(archivo_profesional,reg_aux);
   IF registro_profesional.legajo > reg_aux.legajo THEN
    BEGIN
    seek(archivo_profesional,i);
    write(archivo_profesional,reg_aux);
    seek(archivo_profesional,j);
    write(archivo_profesional,registro_profesional);
    END;
   END;
  END;
 END;

PROCEDURE ordena_archivo_archivo_juntos;
VAR
 i,j: integer;
 reg_aux: DatoAlumno;
 BEGIN
 FOR i:= 0 TO filesize(archivo_juntos) - 2 DO
  BEGIN
  FOR j:= i + 1 TO filesize(archivo_juntos) - 1 DO
   BEGIN
   seek(archivo_juntos,i);
   read(archivo_juntos,registro_juntos);
   seek(archivo_juntos,j);
   read(archivo_juntos,reg_aux);
   IF registro_juntos.legajo > reg_aux.legajo THEN
    BEGIN
    seek(archivo_juntos,i);
    write(archivo_juntos,reg_aux);
    seek(archivo_juntos,j);
    write(archivo_juntos,registro_juntos);
    END;
   END;
  END;
 END;

FUNCTION verificar_estado_archivo_basico(): boolean;
 BEGIN
 reset(archivo_basico);
 IF filesize(archivo_basico) = 0 THEN
  verificar_estado_archivo_basico:= true
 ELSE
  verificar_estado_archivo_basico:= false;
 close(archivo_basico);
 END;

FUNCTION verificar_estado_archivo_profesional(): boolean;
 BEGIN
 reset(archivo_profesional);
 IF filesize(archivo_profesional) = 0 THEN
  verificar_estado_archivo_profesional:= true
 ELSE
  verificar_estado_archivo_profesional:= false;
 close(archivo_profesional);
 END;


FUNCTION valida_codigo_asignatura(): string;
VAR
 i,f: integer;
 caracter,aux,aux_2,concatenar,codigo: string;
 BEGIN
 writeln('>>> Ingrese codigo de asignatura <unicamente 6 caracteres>');
 caracter:= readkey;
 i:= 0;
 WHILE caracter <> #13 DO
  BEGIN
  IF caracter <> #8 THEN
   BEGIN
   gotoxy(whereX,whereY);
   IF whereX <= ULTIMA_POSICION_X THEN
    BEGIN
    write(caracter);
    i:= i + 1;
    cad[i]:= caracter;
    END;
   END
  ELSE
   BEGIN
   gotoxy(whereX -  1,whereY);
   write(' ',#8);
   cad[i]:= ' ';
   IF (i >= 1) AND (1 <= ULTIMA_POSICION_X) THEN
    i:= i - 1
   ELSE
    i:= 0;
   END;
  caracter:= readkey;
  END;
  aux:= ' ';
  FOR f:= 1 TO 6 DO
   BEGIN
   IF aux = ' ' THEN
    aux:= cad[f]
   ELSE
    BEGIN
    aux_2:= cad[f];
    concatenar:= concat(aux,aux_2);
    aux:= concatenar;
    END;
   END;
 codigo:= aux;
 valida_codigo_asignatura:= codigo;
 END;

PROCEDURE cargar_alumnos_basicos;
VAR
 op,long_cod_asig: integer;
 codigo_asig,op_1: string;
 BEGIN
 REPEAT
 textcolor(lightgreen);
 writeln('CARGUE AQUI AL ALUMNO CON SUS RESPECTIVOS DATOS');
 writeln('-----------------------------------------------');
 clrscr;
 textcolor(white);
 reset(archivo_basico);
 writeln();
 write('>>> Ingrese nro de legajo: ');
 readln(registro_basico.legajo);
 writeln();
 REPEAT
 textcolor(white);
 codigo_asig:= valida_codigo_asignatura;
 long_cod_asig:= Length(codigo_asig);
 writeln();
 IF long_cod_asig < 6 THEN
  BEGIN
  textcolor(lightred);
  writeln();
  writeln('////////////////////////////////////////////////////////////');
  writeln('X EL CODIGO DEBER SER DE 6 CARACTERES. VUELVA A INTENTARLO X');
  writeln('////////////////////////////////////////////////////////////');
  writeln();
  END
 UNTIL (long_cod_asig = 6);
 registro_basico.codigo_asignatura:= codigo_asig;
 writeln();
 write('>>> Ingrese la nota: ');
 readln(registro_basico.nota);
 writeln();
 writeln('Estado del alumno');
 writeln('-----------------');
 writeln();
 writeln('1. Activo');
 writeln('2. No Activo');
 writeln();
 write('>>> Seleccione estado del alumno: ');
 readln(op);
 CASE op OF
  1:BEGIN
    registro_basico.activo:= true;
    END;
  2:BEGIN
    registro_basico.activo:= false;
    END;
 END;
 seek(archivo_basico,filesize(archivo_basico));
 write(archivo_basico,registro_basico);
 ordena_archivo_basico;
 close(archivo_basico);
 textcolor(lightcyan);
 writeln();
 writeln('====================================');
 writeln('*** REGISTRO GUARDADO CON EXITO! ***');
 writeln('====================================');
 writeln();
 REPEAT
 textcolor(yellow);
 writeln('---------------------------------------------');
 write('Desea volver a cargar otro alumno[s/n]: ');
 readln(op_1);
 IF (op_1 <> 's') AND (op_1 <> 'n') THEN
  BEGIN
  textcolor(lightred);
  writeln();
  writeln('///////////////////////////////////////');
  writeln('X VALOR INCORRECTO. VUELVA A INTENTAR X');
  writeln('///////////////////////////////////////');
  writeln();
  END;
 UNTIL (op_1 = 's') OR (op_1 = 'n');
 UNTIL (op_1 = 'n');
 END;

PROCEDURE cargar_alumnos_profesionales;
VAR
 op,long_cod_asig: integer;
 codigo_asig,op_1: string;
 BEGIN
 REPEAT
 textcolor(lightgreen);
 writeln('CARGUE AQUI AL ALUMNO CON SUS RESPECTIVOS DATOS');
 writeln('-----------------------------------------------');
 clrscr;
 textcolor(white);
 reset(archivo_profesional);
 writeln();
 write('>>> Ingrese nro de legajo: ');
 readln(registro_profesional.legajo);
 writeln();
 REPEAT
 textcolor(white);
 codigo_asig:= valida_codigo_asignatura;
 long_cod_asig:= Length(codigo_asig);
 writeln();
 IF long_cod_asig < 6 THEN
  BEGIN
  textcolor(lightred);
  writeln();
  writeln('////////////////////////////////////////////////////////////');
  writeln('X EL CODIGO DEBER SER DE 6 CARACTERES. VUELVA A INTENTARLO X');
  writeln('////////////////////////////////////////////////////////////');
  writeln();
  END
 UNTIL (long_cod_asig = 6);
 registro_profesional.codigo_asignatura:= codigo_asig;
 writeln();
 write('>>> Ingrese la nota: ');
 readln(registro_profesional.nota);
 writeln();
 writeln('Estado del alumno');
 writeln('-----------------');
 writeln();
 writeln('1. Activo');
 writeln('2. No Activo');
 writeln();
 write('>>> Seleccione estado del alumno: ');
 readln(op);
 CASE op OF
  1:BEGIN
    registro_profesional.activo:= true;
    END;
  2:BEGIN
    registro_profesional.activo:= false;
    END;
 END;
 seek(archivo_profesional,filesize(archivo_profesional));
 write(archivo_profesional,registro_profesional);
 ordena_archivo_archivo_profesional;
 close(archivo_profesional);
 textcolor(lightcyan);
 writeln();
 writeln('====================================');
 writeln('*** REGISTRO GUARDADO CON EXITO! ***');
 writeln('====================================');
 writeln();
 REPEAT
 textcolor(yellow);
 writeln('---------------------------------------------');
 write('Desea volver a cargar otro alumno[s/n]: ');
 readln(op_1);
 IF (op_1 <> 's') AND (op_1 <> 'n') THEN
  BEGIN
  textcolor(lightred);
  writeln();
  writeln('///////////////////////////////////////');
  writeln('X VALOR INCORRECTO. VUELVA A INTENTAR X');
  writeln('///////////////////////////////////////');
  writeln();
  END;
 UNTIL (op_1 = 's') OR (op_1 = 'n');
 UNTIL (op_1 = 'n');
 END;

PROCEDURE intercalacion;        /// MERGE
VAR
 f,i,j,n,m: integer;
 BEGIN
 rewrite(archivo_juntos);
 reset(archivo_basico);
 reset(archivo_profesional);
 i:= 1;
 j:= 1;
 n:= filesize(archivo_basico);
 m:= filesize(archivo_profesional);
 read(archivo_basico,registro_basico);
 read(archivo_profesional,registro_profesional);

 WHILE (i <= n) AND (j <= m) DO
  BEGIN
  IF registro_basico.legajo > registro_profesional.legajo THEN
   BEGIN
   write(archivo_juntos,registro_basico);
   IF NOT eof(archivo_basico) THEN
    read(archivo_basico,registro_basico);
   i:= i + 1;
   END
  ELSE
   BEGIN
   write(archivo_juntos,registro_profesional);
   IF NOT eof(archivo_profesional) THEN
    read(archivo_profesional,registro_profesional);
   j:= j + 1;
   END;
  END;

  IF i > n THEN
   BEGIN
   FOR f:= j TO m DO
    BEGIN
    write(archivo_juntos,registro_profesional);
    IF NOT eof(archivo_profesional) THEN
     read(archivo_profesional,registro_profesional);
    END;
    END
  ELSE
   FOR f:= i TO n DO
    BEGIN
    write(archivo_juntos,registro_basico);
    IF NOT eof(archivo_basico) THEN
     read(archivo_basico,registro_basico);
    END;


 ordena_archivo_archivo_juntos;
 close(archivo_basico);
 close(archivo_profesional);
 close(archivo_juntos);
 END;

PROCEDURE muestra_listado;
 BEGIN
 reset(archivo_juntos);
 writeln('LISTADO DE ALUMNOS TANTO BASICOS COMO PROFESIONALES');
 writeln('---------------------------------------------------');
 WHILE NOT eof(archivo_juntos) DO
  BEGIN
  read(archivo_juntos,registro_juntos);
  write(registro_juntos.legajo:1,' | ',registro_juntos.codigo_asignatura:1,' | ',registro_juntos.nota:1,' | ',registro_juntos.activo);
  writeln();
  END;
 close(archivo_juntos);
 writeln();
 writeln('Presione enter para salir...');
 readln();
 END;

PROCEDURE generar_listado_alumnos_basico_profesional;
 BEGIN
  IF (verificar_estado_archivo_basico() = true) OR (verificar_estado_archivo_profesional = true) THEN
  BEGIN
  clrscr;
  textcolor(lightred);
  writeln();
  writeln('//////////////////////////////////////////////////////////////////');
  writeln('X COMO UNO DE LOS ARCHIVOS AUN ESTA VACIO, NO SE PUEDE CONTINUAR X');
  writeln('//////////////////////////////////////////////////////////////////');
  delay(2000);
  END
 ELSE
  BEGIN
  intercalacion;
  muestra_listado;
  END;
 END;

PROCEDURE generar_listado_promedios_por_alumno;
VAR                                                                   /////// CORTE DE CONTROL
  contador_materias, prom, notas_real_to_integer: integer;
  acumulador_notas: real;
  anterior: integer;
BEGIN
  IF (verificar_estado_archivo_basico() = true) OR (verificar_estado_archivo_profesional() = true) THEN
  BEGIN
    clrscr;
    textcolor(lightred);
    writeln();
    writeln('//////////////////////////////////////////////////////////////////');
    writeln('X COMO UNO DE LOS ARCHIVOS AUN ESTA VACIO, NO SE PUEDE CONTINUAR X');
    writeln('//////////////////////////////////////////////////////////////////');
    delay(2000);
  END
  ELSE
  BEGIN
    clrscr;
    reset(archivo_juntos);
    WHILE NOT eof(archivo_juntos) DO
    BEGIN
      contador_materias := 0;
      acumulador_notas := 0;
      read(archivo_juntos, registro_juntos);
      anterior := registro_juntos.legajo;
      WHILE (anterior = registro_juntos.legajo) AND (NOT eof(archivo_juntos)) DO
      BEGIN
        contador_materias := contador_materias + 1;
        acumulador_notas := acumulador_notas + registro_juntos.nota;
        read(archivo_juntos, registro_juntos);
      END;
      IF anterior <> registro_juntos.legajo THEN
       BEGIN
       notas_real_to_integer := Trunc(acumulador_notas);
       prom := notas_real_to_integer div contador_materias;
       writeln('Legajo: ',anterior,'Promedio: ',prom);
       seek(archivo_juntos,filepos(archivo_juntos)-1);
       END;
    END;

    IF eof(archivo_juntos) THEN
     IF anterior <> registro_juntos.legajo THEN
        BEGIN
        notas_real_to_integer := Trunc(acumulador_notas);
        prom := notas_real_to_integer div contador_materias;
        writeln('Legajo: ',anterior,'Promedio: ',prom);
        END
     ELSE
        BEGIN
        notas_real_to_integer := Trunc(acumulador_notas);
        prom := notas_real_to_integer div contador_materias;
        writeln('Legajo: ',anterior,'Promedio: ',prom);
        END;



    close(archivo_juntos);
    writeln();
    writeln('Presione enter para salir...');
    readln();
  END;
END;

FUNCTION busca_legajo(legajo: integer): boolean;
VAR
 f: boolean;
 medio,inf,sup: integer;
 BEGIN
 f:= false;
 sup:= filesize(archivo_basico) - 1;
 inf:= 0;
 REPEAT
 medio:= (sup + inf) div 2;
 seek(archivo_basico,medio);
 read(archivo_basico,registro_basico);
 IF legajo = registro_basico.legajo THEN
  f:= true
 ELSE
  IF registro_basico.legajo > legajo THEN
   sup:= medio - 1
  ELSE
   inf:= medio + 1;
 UNTIL eof(archivo_basico) OR (f = true);
 IF f = true THEN
  busca_legajo:= true
 ELSE
  busca_legajo:= false;
 END;

PROCEDURE dar_de_baja_en_basico;
VAR
 opcion: string;
 legajo: integer;
 BEGIN
 reset(archivo_basico);
 writeln();
 write('>>> Ingrese numero de legajo: ');
 readln(legajo);
 IF busca_legajo(legajo) = true THEN
  BEGIN
  textcolor(lightred);
  WHILE NOT eof(archivo_basico) DO
   BEGIN
   read(archivo_basico,registro_basico);
   IF legajo = registro_basico.legajo THEN
    BEGIN
    write(registro_juntos.legajo:1,' | ',registro_juntos.codigo_asignatura:1,' | ',registro_juntos.nota:1,' | ',registro_juntos.activo);
    writeln();
    END;
   END;
  writeln();
  REPEAT
  textcolor(white);
  write('Desea dar de baja todos los registros pertenecientes a este alumno[s/n]?: ');
  readln(opcion);
  IF (opcion <> 's') AND (opcion <> 'n') THEN
   BEGIN
   textcolor(lightred);
   writeln();
   writeln('////////////////////////////////////////');
   writeln('X VALOR INCORRECTO. INGRESE NUEVAMENTE X');
   writeln('////////////////////////////////////////');
   writeln();
   END;
  UNTIL (opcion = 's') OR (opcion = 'n');
  IF opcion = 'n' THEN
   BEGIN
   WHILE NOT eof(archivo_basico) DO
    BEGIN
    read(archivo_basico,registro_basico);
    IF legajo = registro_basico.legajo THEN
      IF registro_basico.activo = true THEN
       BEGIN
       registro_basico.activo:= false;
       seek(archivo_basico,filepos(archivo_basico) - 1);
       write(archivo_basico,registro_basico);
       END;
    END;
   END
  ELSE
   BEGIN
   textcolor(yellow);
   writeln();
   writeln('===================');
   writeln('# NO HAY PROBLEMA #');
   writeln('===================');
   writeln();
   END;
  END
 ELSE
  BEGIN
  textcolor(lightred);
  writeln();
  writeln('////////////////////////');
  writeln('X NO EXISTE ESE LEGAJO X');
  writeln('////////////////////////');
  writeln();
  END;
 close(archivo_basico);
 END;

PROCEDURE baja_logica_alumno;
VAR
 opcion_2: string;
 opcion: integer;
 BEGIN
 REPEAT
 clrscr;
 textcolor(white);
 writeln('DAR BAJA UN ALUMNO');
 writeln('------------------');
 writeln();
 writeln('Archivos');
 writeln('1. Basico');
 writeln('2. Profesional');
 writeln();
 writeln('-----------------------');
 write('Seleccione el archivo: ');
 readln(opcion);
 CASE opcion OF
  1:BEGIN
    dar_de_baja_en_basico;
    END;
  {2:BEGIN
    dar_de_baja_en_profesional;
    END;   }
  END;
 REPEAT
 textcolor(white);
 write('Desea dar de baja a otro alumno[s/n]?: ');
 readln(opcion_2);
 IF (opcion_2 <> 's') AND (opcion_2 <> 'n') THEN
  BEGIN
  textcolor(lightred);
  writeln();
  writeln('////////////////////////////////////////');
  writeln('X VALOR INCORRECTO. INGRESE NUEVAMENTE X');
  writeln('////////////////////////////////////////');
  writeln();
  END;
 UNTIL (opcion_2 = 's') OR (opcion_2 <> 'n');
 UNTIL (opcion_2 = 'n');
 END;


PROCEDURE menu_principal;
VAR
 op: integer;
 BEGIN
 REPEAT
 textcolor(white);
 clrscr;
 writeln('1. Cargar alumnos basicos.');
 writeln('2. Cargar alumnos profesionales.');
 writeln('3. Generar listado de alumnos de ambos cursos.');
 writeln('4. Generar listado de promedios por alumno.');
 writeln('5. Dar de baja algun alumno.');
 writeln('6. Salir.');
 writeln();
 writeln('---------------------');
 write('Seleccione opcion: ');
 readln(op);
 CASE op OF
  1:BEGIN
    cargar_alumnos_basicos;
    END;
  2:BEGIN
    cargar_alumnos_profesionales;
    END;
  3:BEGIN
    clrscr;
    generar_listado_alumnos_basico_profesional;
    END;
  4:BEGIN
    generar_listado_promedios_por_alumno;
    END;
  5:BEGIN
    baja_logica_alumno;
    END;

 END;
 UNTIL (op = 6);
 END;

BEGIN
assign(archivo_basico,'C:\Users\JULIO\Desktop\final-notas-alumnos\basico.dat');
assign(archivo_profesional,'C:\Users\JULIO\Desktop\final-notas-alumnos\profesional.dat');
assign(archivo_juntos,'C:\Users\JULIO\Desktop\final-notas-alumnos\juntos.dat');
crea_archivo_basico;
crea_archivo_profesional;
menu_principal;
END.
