CREATE DATABASE Club_Deporte;

CREATE TABLE Socio (
socio_id INT PRIMARY KEY IDENTITY,
nombre VARCHAR (30) NOT NULL,
apellido VARCHAR (30) NOT NULL,
telefono BIGINT,
email VARCHAR (100) UNIQUE,
documento BIGINT UNIQUE NOT NULL,
estado VARCHAR(20) CHECK (estado IN ('Activo', 'Inactivo','Suspendido')) NOT NULL,
fecha_alta DATE DEFAULT GETDATE());

CREATE TABLE Disciplina (
disciplina_id INT PRIMARY KEY IDENTITY,
nombre VARCHAR(40) NOT NULL );

CREATE TABLE Instalacion (
instalacion_id INT PRIMARY KEY IDENTITY,
codigo VARCHAR(20) UNIQUE NOT NULL,
ubicacion VARCHAR(90),
estado VARCHAR(30) CHECK (estado IN ('Disponible', 'Fuera de Servicio', 'Inactiva')) NOT NULL,
disciplina_id INT REFERENCES Disciplina(disciplina_id),
tipo VARCHAR(60));

CREATE TABLE Tarifa (

tarifa_id INT PRIMARY KEY IDENTITY,
fecha_inicio DATE NOT NULL,
fecha_fin DATE NOT NULL ,
precio_hora DECIMAL(10,2) NOT NULL CHECK  (precio_hora >0),
instalacion_id INT NOT NULL REFERENCES Instalacion(instalacion_id),
descripcion VARCHAR(90),
UNIQUE (instalacion_id, fecha_inicio, fecha_fin)
);

CREATE TABLE Servicio (
servicio_id INT PRIMARY KEY IDENTITY,
nombre VARCHAR(65) NOT NULL,
costo DECIMAL (10,2) NOT NULL,
precio DECIMAL (10,2) NOT NULL,
cupo_diario INT NOT NULL,
disciplina_id INT NOT  NULL REFERENCES Disciplina(disciplina_id));

CREATE TABLE Reserva (
reserva_id INT PRIMARY KEY IDENTITY,
fecha_creacion DATE DEFAULT GETDATE(),
socio_id INT REFERENCES Socio(socio_id),
estado VARCHAR(20) CHECK (estado IN ('Pendiente','Confirmada','Anulada')) NOT NULL,
total DECIMAL (10,2) NOT NULL );

CREATE TABLE Detalle_Reserva (
Detalle_id INT PRIMARY KEY IDENTITY,
reserva_id INT NOT NULL REFERENCES Reserva (reserva_id),
instalacion_id INT NULL REFERENCES Instalacion(instalacion_id),
serivicios_id INT NULL  REFERENCES Servicio (servicio_id),
fecha_uso DATE NOT NULL,
horas DECIMAL (5,2) NULL,
precio_horas_aplicado DECIMAL(10,2),
subtotal AS (
CASE 
WHEN instalacion_id IS NOT NULL THEN horas * precio_horas_aplicado --- logica para las canchas 
ELSE precio_horas_aplicado ---- logica para el servicio(precio_horas aplicado)
END
) PERSISTED,
tarifa_id_aplicada INT REFERENCES Tarifa(tarifa_id),
);
CREATE TABLE Pago (
pago_id INT PRIMARY KEY IDENTITY,
reserva_id INT NOT NULL REFERENCES Reserva(reserva_id),
fecha_pago DATE DEFAULT GETDATE(),
medio_pago VARCHAR(20) NOT NULL CHECK (medio_pago IN ('Targeta','Transferencia','Efectivo')),
importe DECIMAL (10,2) CHECK (importe>0 )NOT NULL); 

CREATE TABLE Alerta (
alerta_id INT PRIMARY KEY IDENTITY,
fecha_alerta DATETIME DEFAULT GETDATE(),
tipo VARCHAR(20) CHECK (tipo IN ('Error','Mantenimiento','Repeticion' )) NOT NULL,
entidad_referencia VARCHAR(62) NULL,
referencia_id INT NULL, ------- Identificador del registro que causo esa alerta
descripcion VARCHAR(500) NOT NULL ---descripcion del error
);






