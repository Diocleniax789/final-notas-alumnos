PROGRAM final_examen_notas;
USES crt;

TYPE
    basico = RECORD
     alumno: integer;
     codigo_asignatura: string[6];
     nota: real;
    END;

    profesional = RECORD
     alumno: integer;
     codigo_asignatura: string [6];
     nota: real;
    END;

    juntos = RECORD
     alumno: integer;
     codigo_asignatura: string [6];
     nota: real;
    END;

VAR
   archivo_basico: FILE OF basico;
   archivo_profesional: FILE OF profesional;
   archivo_juntos: FILE OF juntos;
   registro_basico: basico;
   registro_profesional: profesional;

PROCEDURE crea_archivo_basico;
 BEGIN
 rewrite(archivo_basico);
 close(archivo_basico);
 END;

PROCEDURE crea_archivo_profesional;
 BEGIN
 rewrite(archivo_basico);
 close(archivo_basico);
 END;

PROCEDURE crea_archivo_juntos;
 BEGIN
 rewrite(archivo_juntos);
 close(archivo_juntos);
 END;

PROCEDURE menu_principal;
VAR
 op: integer;
 BEGIN
 REPEAT
 textcolor(white);
 clrscr;
 writeln('1. Generar listado de alumnos de ambos cursos.');
 writeln('2. Generar listado de promedios por alumno.');
 writeln('3. Salir.');
 writeln();
 writeln('---------------------');
 write('Seleccione opcion: ');
 readln(op);
 CASE op OF
  1:BEGIN
    END;
  2:BEGIN
    END;
 END;
 UNTIL (op = 3);
 END;

BEGIN
assign(archivo_basico,'C:\Users\JULIO\Desktop\final-notas-alumnos\basico.dat');
assign(archivo_profesional,'C:\Users\JULIO\Desktop\final-notas-alumnos\profesional.dat');
assign(archivo_juntos,'C:\Users\JULIO\Desktop\final-notas-alumnos\juntos.dat');
crea_archivo_basico;
crea_archivo_profesional;
crea_archivo_juntos;
menu_principal;
END.
