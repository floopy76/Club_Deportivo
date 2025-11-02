CREATE DATABASE Club_Deporte;

CREATE TABLE socio (
socio_id INT PRIMARY KEY IDENTITY,
nombre VARCHAR (30),
apellido VARCHAR (30),
telefono BIGINT,
email VARCHAR (50),
documento BIGINT,
estado TINYINT CHECK (estado IN ('Activo', 'Inactivo','Suspendido')),
fecha_alta DATE );

CREATE TABLE Disciplina (
disciplina_id INT PRIMARY KEY IDENTITY,
nombre VARCHAR(40) );

CREATE TABLE Instalacion (
instalacion_id INT PRIMARY KEY IDENTITY,
codigo VARCHAR(20) UNIQUE,
ubicacion VARCHAR(90),
estado TINYINT CHECK (estado IN ('Disponible, Fuera_de_Servicio','Inactiva')),
disciplina_id INT REFERENCES Disciplina(disciplina_id),
tipo VARCHAR(60));

CREATE TABLE Tarifa (
tarifa_id INT PRIMARY KEY IDENTITY,
fecha_inicio DATE,
fecha_fin DATE,
precio_hora DECIMAL(10,2),
instalacion_id INT REFERENCES Instalacion(instalacion_id),
descripcion VARCHAR(90));

CREATE TABLE Servicio (
servicio_id INT PRIMARY KEY IDENTITY,
nombre VARCHAR(65),
costo DECIMAL (10,2),
precio DECIMAL (10,2),
cupo_diario INT,
disciplina_id INT NOT  NULL REFERENCES Disciplina(disciplina_id));

CREATE TABLE Reserva (
reserva_id INT PRIMARY KEY IDENTITY,
fecha_creacion DATETIME,
socio_id INT REFERENCES Socio(socio_id),
estado TINYINT CHECK (estado IN ('Pendiente','Confirmada','Anulada')),
total DECIMAL (10,2));

CREATE TABLE Detalle_Reserva (
Detalle_id INT PRIMARY KEY IDENTITY,
reserva_id INT REFERENCES Reserva (reserva_id),
instalacion_id INT REFERENCES Instalacion(instalacion_id),
fecha_uso DATETIME,
horas DECIMAL (5,5),
precio_horas_aplicado DECIMAL(10,2),
subtotal AS (horas*precio_horas_aplicado) PERSISTED,
tarifa_id_aplicada INT NULL REFERENCES Tarifa(tarifa_id));

CREATE TABLE Pago (
pago_id INT PRIMARY KEY IDENTITY,
reserva_id INT REFERENCES Reserva(reserva_id),
fecha_pago DATETIME,
medio_pago TINYINT CHECK (medio_pago IN ('Targeta','Transferencia','Efectivo')),
importe DECIMAL (10,2) CHECK (importe>0));

CREATE TABLE Alerta (
alerta_id INT PRIMARY KEY IDENTITY,
fecha_alerta DATE,
tipo TINYINT CHECK (tipo IN ('Error','Mantenimiento','Repeticion', 'Otro')),
entidad_referencia VARCHAR(62) NULL,
referencia VARCHAR(280));

CREATE TABLE Reserva_Servivio (
reserva_id INT REFERENCES Reserva(reserva_id),
servicio_id INT REFERENCES Servicio(servicio_id),
PRIMARY KEY (reserva_id, servicio_id));






