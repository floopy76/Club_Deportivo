CREATE DATABASE club_Deporte;
CREATE TABLE socios (
socios_id INT PRIMARY KEY IDENTITY,
nombre VARCHAR (30),
apellido VARCHAR (30),
telefono BIGINT,
email VARCHAR (50),
documento BIGINT,
estado TINYINT, CHECK (estado IN ('Activo', 'Inactivo','Suspendido')),
fecha_alta DATE );

CREATE TABLE Disciplina (
disciplina_id INT PRIMARY KEY IDENTITY,
nombre VARCHAR(40) );

CREATE TABLE INSTALACION (
instalacion_id INT PRIMARY KEY IDENTITY,
codigo VARCHAR(20) UNIQUE,
ubicacion VARCHAR(90),
estado TINYINT, CHECK (estado IN ('Disponible, Fuera_de_Servicio','Inactiva')),
disciplina_id INT REFERENCES Disciplina(disciplina_id),
tipo VARCHAR(60));
