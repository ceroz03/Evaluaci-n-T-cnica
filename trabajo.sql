CREATE DATABASE CarrerasCarro
use CarrerasCarro
CREATE TABLE Competidores(
			#Competidor numeric(3) not null primary key ,
			nombre VARCHAR(100),
			Vehiculo VARCHAR(100),
			escuderia VARCHAR(100)
			)

---------------------------------------------------------------------------------------------------------------------------------------------------
CREATE DATABASE Escuela
use Escuela
CREATE TABLE Alumnos(
			 matricula VARCHAR(10) not null primary key,
			 nombre VARCHAR(100),
			 apellidos VARCHAR(100),
			 fecha_nacimiento date
			 )
CREATE TABLE Materias(
			clave_materia VARCHAR(10) not null primary key,
			nombre VARCHAR(100) not null,
			area VARCHAR(100) not null
			)
CREATE TABLE Calificaciones(
			matricula VARCHAR(10) not null,
			clave_materia VARCHAR(10) not null,
			calificacion VARCHAR(10)
			)
--a)	Obtener los alumnos ordenados por fecha de nacimiento de los m�s j�venes a los m�s viejos.
SELECT *
FROM Alumnos
ORDER BY fecha_nacimiento
--b)	Obtener las materias que pertenezcan al �rea �Espa�ol�.
SELECT *
FROM Materias
WHERE nombre='Espa�ol'
--c)	Obtener la boleta del alumno con matr�cula �A09998�. La boleta deber� tener el nombre completo (nombre y apellidos) del alumno, 
--la clave y nombre de la materia, as� como la calificaci�n obtenida. 
--No importa que el nombre del alumno se repita en cada registro. El ordenamiento deber� ser por nombre de materia.
SELECT A.nombre ,A.apellidos,c.clave_materia,M.nombre,C.calificacion
FROM Alumnos as A INNER JOIN Calificaciones as C ON 
A.matricula=C.matricula
INNER JOIN Materias as M ON
C.clave_materia=M.clave_materia
WHERE A.matricula='A09998'
ORDER BY M.nombre
--d)	Obtener el listado de alumnos inscritos. Por inscritos se entiende que cuentan con al menos una materia inscrita.
SELECT A.matricula,A.nombre,A.apellidos,M.clave_materia 'Clave de la materia',M.nombre 'Nombre Materia'
FROM Alumnos as A INNER JOIN Calificaciones as C ON 
A.matricula=C.matricula
INNER JOIN Materias as M ON
C.clave_materia=M.clave_materia
WHERE C.clave_materia=M.clave_materia
--a)	Crear el registro del alumno Pedro P�rez, con fecha de nacimiento el 10 de octubre de 2001. Su matr�cula ser� �A09999�
INSERT INTO Alumnos
VALUES('A09999','Pedro','P�rez','2001-10-10')
--b)	Crear el registro de la materia �Introducci�n a la Programaci�n�, del �rea �Computaci�n�. Su clave ser�: �TI0001�.
INSERT INTO Materias
VALUES ('TI0001','Introducci�n a la Programaci�n','Computaci�n')
--c)	Inscribir a Pedro en Introducci�n a la Programaci�n con calificaci�n de 88.
INSERT INTO Calificaciones
VALUES((SELECT matricula FROM Alumnos WHERE nombre='Pedro'),(Select clave_materia FROM materias WHERE nombre='Introducci�n a la Programaci�n'),'88')
--d)	Actualizar la calificaci�n de Pedro a 92.
UPDATE Calificaciones
SET calificacion='92'
WHERE matricula=(SELECT matricula FROM Alumnos WHERE nombre='Pedro')
--e)	Eliminar el registro de Pedro de la clase de Programaci�n Avanzada.
DELETE FROM Calificaciones WHERE clave_materia=(SELECT clave_materia 
												FROM Materias 
												WHERE nombre='Programaci�n Avanzada')
								AND
									matricula=(SELECT matricula
										       FROM Alumnos
											   WHERE nombre='Pedro')
------------------------------------------------------------------------------------------------STORED PROCEDURE
CREATE DATABASE Personal
USE Personal

CREATE TABLE Persona(
			clave_persona numeric(5) not null primary key ,
			Nombre VARCHAR(100) not null,
			Apellidos VARCHAR(100) not null,
			fecha_nacimiento date not null,
			clave_puesto numeric(3)
			)
CREATE TABLE Puesto(
			clave_puesto numeric(3)not null primary key,
			Titulo varchar(50) not null,
			Sueldo numeric(8,2)
			)
--Dise�e un procedimiento que reciba como entrada la clave de persona y la clave del puesto y actualice el puesto actual de la persona por el nuevo. 
CREATE PROCEDURE sp_Personal_Acutualizar(
@clave_persona numeric(5),
@clave_puesto numeric(3)
)
As
BEGIN
	UPDATE persona
	SET clave_puesto=@clave_puesto
	WHERE clave_persona=@clave_persona
END
GO
EXEC sp_Personal_Acutualizar 2,1

--Dise�e una funci�n que reciba como entrada la clave de la persona y regrese como salida el sueldo actual de la persona.
CREATE PROCEDURE sp_Sueldo_Actual(
@clave_persona numeric(5)
)
AS
BEGIN
	SELECT sueldo
	FROM Puesto INNER JOIN Persona ON
	Puesto.clave_puesto=Persona.clave_puesto
	WHERE Persona.clave_persona=@clave_persona

END
GO
EXEC sp_Sueldo_Actual 2
--Dise�e una funci�n que genere una nueva persona. Deber� de recibir como entrada el nombre, apellido y fecha de nacimiento de la persona. 
--Como salida deber� regresar la clave de la persona generada. Las claves nuevas se deber�n obtener buscando la m�xima clave de persona existente y sumando uno.
CREATE PROCEDURE sp_nueva_persona(
@Nombre VARCHAR(100),
@Apellido VARCHAR(100),
@fecha_nacimiento date
)
AS
BEGIN
	INSERT INTO persona(clave_persona,Nombre,Apellidos,fecha_nacimiento)
	VALUES((SELECT MAX(clave_persona)+1 FROM persona),@Nombre,@Apellido,@fecha_nacimiento)
	SELECT MAX(clave_persona) 'Nueva Clave'
	FROM Persona
END
GO
INSERT INTO Persona
VALUES(1,'Jose','Olivares','1997-10-31',15)
EXEC sp_nueva_persona 'Juan','Perez','1995-09-03'
INSERT INTO Puesto
VALUES (1,'Desarrollador jr','9500')