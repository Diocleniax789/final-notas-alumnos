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
     codigo_asignatura = string [6];
     nota: real;
    END;

    juntos = RECORD
     alumno: integer;
     codigo_asignatura = string [6];
     nota: real;
    END;

    archivo_basico = FILE OF basico;

    archivo_profesional = FILE OF profesional;

    archivo_juntos = FILE OF juntos;
VAR
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

BEGIN
assign(archivo_basico,'C:\Users\JULIO\Desktop\final-notas-alumnos\basico.dat');
assign(archivo_profesional,'C:\Users\JULIO\Desktop\final-notas-alumnos\profesional.dat');
assing(archivo_juntos,'C:\Users\JULIO\Desktop\final-notas-alumnos\juntos.dat');
crea_archivo_basico;
crea_archivo_profesional;
crea_archivo_juntos;
menu_principal;
END.
