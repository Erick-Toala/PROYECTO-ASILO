/*============================================================*/
/* Tabla: ANCIANO                                             */
/*============================================================*/
CREATE TABLE ANCIANO(
	ID_ANCIANO serial CONSTRAINT PK_ID_ANCIANO PRIMARY KEY,
	NOMBRE_ANCIANO varchar(30) NOT NULL,
	APELLIDO_ANCIANO varchar(30) NOT NULL,
	TIPO_SANGRE varchar(30),
	GENERO varchar(30)
);

/*============================================================*/
/* Tabla: PLANTILLA_REGISTRO                                  */
/*============================================================*/
CREATE TABLE PLANTILLA_REGISTRO(
	ID_PLANTILLA_REGISTRO serial CONSTRAINT PK_ID_PLANTILLA_REGISTRO PRIMARY KEY,
	ID_ANCIANO integer NOT NULL,
	FECHA_INGRESO date DEFAULT CURRENT_DATE,
	ESTADO_SALUD varchar(30),
	NUMERO_FAMILIAR varchar(10),
	DIRECCION_FAMILIAR varchar(30),
	INFO_BOVEDA varchar(50)
);

/*============================================================*/
/* Tabla: FACTURA                                             */
/*============================================================*/
CREATE TABLE FACTURA(
	ID_FACTURA serial CONSTRAINT PK_ID_FACTURA PRIMARY KEY,
	ID_PLANTILLA_REGISTRO integer NOT NULL,
	FECHA_EMISION date DEFAULT CURRENT_DATE,
	FORMA_PAGO varchar(30),
	ESTADO varchar(15),
	PRECIO_ESTANCIA real NOT NULL,
	TOTAL real
);

/*============================================================*/
/* Tabla: SERVICIOS_FACTURA                                   */
/*============================================================*/
CREATE TABLE SERVICIOS_FACTURA(
	ID_SERVICIOS_FACTURA serial CONSTRAINT PK_ID_SERVICIOS_FACTURA PRIMARY KEY,
	ID_FACTURA integer NOT NULL,
	ID_SERVICIO integer NOT NULL,
	ID_PERSONAL integer NOT NULL,
	FECHA_SERVICIO date DEFAULT CURRENT_DATE,
	TOTAL real NOT NULL
);

/*============================================================*/
/* Tabla: SERVICIOS                                           */
/*============================================================*/
CREATE TABLE SERVICIOS(
	ID_SERVICIO serial CONSTRAINT PK_ID_SERVICIO PRIMARY KEY,
	DESCRIPCION varchar(30) NOT NULL,
	PRECIO real NOT NULL
);

/*============================================================*/
/* Tabla: PERSONAL                                            */
/*============================================================*/
CREATE TABLE PERSONAL(
	ID_PERSONAL serial CONSTRAINT PK_ID_PERSONAL PRIMARY KEY,
	ID_TIPO_PERSONAL integer NOT NULL,
	NOMBRE_PERSONAL varchar(30) NOT NULL,
	APELLIDO_PERSONAL varchar(30) NOT NULL,
	TELEFONO varchar(10)
);

/*============================================================*/
/* Tabla: TIPO_PERSONAL                                       */
/*============================================================*/
CREATE TABLE TIPO_PERSONAL(
	ID_TIPO_PERSONAL serial CONSTRAINT PK_ID_TIPO_PERSONAL PRIMARY KEY,
	DESCRIPCION varchar(30) NOT NULL
);

/*============================================================*/
/* Tabla: TERAPIAS                                            */
/*============================================================*/
CREATE TABLE TERAPIAS(
	ID_TERAPIA serial CONSTRAINT PK_ID_TERAPIA PRIMARY KEY,
	ID_PLANTILLA_REGISTRO integer NOT NULL,
	ID_PERSONAL integer NOT NULL,
	FECHA_TERAPIA date DEFAULT CURRENT_DATE
);
/*============================================================*/
/* Tabla: REVISIONES_MEDICA                                   */
/*============================================================*/
CREATE TABLE REVISIONES_MEDICAS(
	ID_REVISION_MEDICA serial CONSTRAINT PK_ID_REVISION_MEDICA PRIMARY KEY,
	ID_PLANTILLA_REGISTRO integer NOT NULL,
	ID_PERSONAL integer NOT NULL,
	FECHA_REVISION date DEFAULT CURRENT_DATE
);
/*============================================================*/
/* Tabla: CERTIFICADOS                                        */
/*============================================================*/
CREATE TABLE CERTIFICADOS(
	ID_CERTIFICADO serial CONSTRAINT PK_ID_CERTIFICADO PRIMARY KEY,
	DESCRIPCION varchar(30) NOT NULL,
	VALOR real NOT NULL
);

/*============================================================*/
/* Tabla: CERTIFICADOS_ANCIANOS                               */
/*============================================================*/
CREATE TABLE CERTIFICADOS_ANCIANOS(
	ID_CERTIFICADOS_ANCIANOS serial CONSTRAINT PK_ID_CERTIFICADOS_ANCIANOS PRIMARY KEY,
	ID_PLANTILLA_REGISTRO integer NOT NULL
);

/*============================================================*/
/* Tabla: EMISION_CERTIFICADOS                                */
/*============================================================*/
CREATE TABLE EMISION_CERTIFICADOS(
	ID_EMISION_CERTIFICADOS serial CONSTRAINT PK_ID_EMISION_CERTIFICADOS PRIMARY KEY,
	ID_CERTIFICADOS_ANCIANOS integer NOT NULL,
	ID_CERTIFICADO integer NOT NULL,
	FECHA_EMISION date DEFAULT CURRENT_DATE
);

/*============================================================*/
/* Tabla: EVENTOS                                             */
/*============================================================*/
CREATE TABLE EVENTOS(
	ID_EVENTO serial CONSTRAINT PK_ID_EVENTO PRIMARY KEY,
	ID_TIPO_EVENTO integer NOT NULL,
	FECHA_EVENTO date DEFAULT CURRENT_DATE
);

/*============================================================*/
/* Tabla: TIPO_EVENTO                                         */
/*============================================================*/
CREATE TABLE TIPO_EVENTO(
	ID_TIPO_EVENTO serial CONSTRAINT PK_ID_TIPO_EVENTO PRIMARY KEY,
	DESCRIPCION varchar(30) NOT NULL
);

/*============================================================*/
/* Tabla: ASISTENCIA_EVENTOS                                  */
/*============================================================*/
CREATE TABLE ASISTENCIA_EVENTOS(
	ID_ASISTENCIA_EVENTO serial CONSTRAINT PK_ID_ASISTENCIA_EVENTO PRIMARY KEY,
	ID_EVENTO integer NOT NULL,
	ID_PLANTILLA_REGISTRO integer NOT NULL
);

--relación PLANTILLA_REGISTRO ANCIANO
ALTER TABLE PLANTILLA_REGISTRO 
ADD CONSTRAINT FK_ID_ANCIANO
FOREIGN KEY (ID_ANCIANO)  
REFERENCES ANCIANO(ID_ANCIANO)
ON DELETE RESTRICT ON UPDATE CASCADE;
--relación FACTURA PLANTILLA_REGISTRO
ALTER TABLE FACTURA 
ADD CONSTRAINT FK_ID_PLANTILLA_REGISTRO
FOREIGN KEY (ID_PLANTILLA_REGISTRO)  
REFERENCES PLANTILLA_REGISTRO(ID_PLANTILLA_REGISTRO)
ON DELETE RESTRICT ON UPDATE CASCADE;
--relación SERVICIOS_FACTURA FACTURA
ALTER TABLE SERVICIOS_FACTURA 
ADD CONSTRAINT FK_ID_FACTURA
FOREIGN KEY (ID_FACTURA)  
REFERENCES FACTURA(ID_FACTURA)
ON DELETE RESTRICT ON UPDATE CASCADE;
--relación SERVICIOS_FACTURA SERVICIOS
ALTER TABLE SERVICIOS_FACTURA 
ADD CONSTRAINT FK_ID_SERVICIO
FOREIGN KEY (ID_SERVICIO)  
REFERENCES SERVICIOS(ID_SERVICIO)
ON DELETE RESTRICT ON UPDATE CASCADE;
--relación SERVICIOS_FACTURA PERSONAL
ALTER TABLE SERVICIOS_FACTURA 
ADD CONSTRAINT FK_ID_PERSONAL
FOREIGN KEY (ID_PERSONAL)  
REFERENCES PERSONAL(ID_PERSONAL)
ON DELETE RESTRICT ON UPDATE CASCADE;
--relación PERSONAL TIPO_PERSONAL
ALTER TABLE PERSONAL 
ADD CONSTRAINT FK_ID_TIPO_PERSONAL
FOREIGN KEY (ID_TIPO_PERSONAL)  
REFERENCES TIPO_PERSONAL(ID_TIPO_PERSONAL)
ON DELETE RESTRICT ON UPDATE CASCADE;
--relación TERAPIAS PLANTILLA_REGISTRO
ALTER TABLE TERAPIAS 
ADD CONSTRAINT FK_ID_PLANTILLA_REGISTRO
FOREIGN KEY (ID_PLANTILLA_REGISTRO)  
REFERENCES PLANTILLA_REGISTRO(ID_PLANTILLA_REGISTRO)
ON DELETE RESTRICT ON UPDATE CASCADE;
--relación TERAPIAS PERSONAL
ALTER TABLE TERAPIAS 
ADD CONSTRAINT FK_ID_PERSONAL
FOREIGN KEY (ID_PERSONAL)  
REFERENCES PERSONAL(ID_PERSONAL)
ON DELETE RESTRICT ON UPDATE CASCADE;
--relación REVISIONES_MEDICAS PLANTILLA_REGISTRO
ALTER TABLE REVISIONES_MEDICAS 
ADD CONSTRAINT FK_ID_PLANTILLA_REGISTRO
FOREIGN KEY (ID_PLANTILLA_REGISTRO)  
REFERENCES PLANTILLA_REGISTRO(ID_PLANTILLA_REGISTRO)
ON DELETE RESTRICT ON UPDATE CASCADE;
--relación REVISIONES_MEDICAS PERSONAL
ALTER TABLE REVISIONES_MEDICAS 
ADD CONSTRAINT FK_ID_PERSONAL
FOREIGN KEY (ID_PERSONAL)  
REFERENCES PERSONAL(ID_PERSONAL)
ON DELETE RESTRICT ON UPDATE CASCADE;
--relación CERTIFICADOS_ANCIANOS PLANTILLA_REGISTRO
ALTER TABLE CERTIFICADOS_ANCIANOS 
ADD CONSTRAINT FK_ID_PLANTILLA_REGISTRO
FOREIGN KEY (ID_PLANTILLA_REGISTRO)  
REFERENCES PLANTILLA_REGISTRO(ID_PLANTILLA_REGISTRO)
ON DELETE RESTRICT ON UPDATE CASCADE;
--relación EMISION_CERTIFICADOS CERTIFICADOS_ANCIANOS
ALTER TABLE EMISION_CERTIFICADOS 
ADD CONSTRAINT FK_ID_CERTIFICADOS_ANCIANOS
FOREIGN KEY (ID_CERTIFICADOS_ANCIANOS)  
REFERENCES CERTIFICADOS_ANCIANOS(ID_CERTIFICADOS_ANCIANOS)
ON DELETE RESTRICT ON UPDATE CASCADE;
--relación EMISION_CERTIFICADOS CERTIFICADOS
ALTER TABLE EMISION_CERTIFICADOS 
ADD CONSTRAINT FK_ID_CERTIFICADO
FOREIGN KEY (ID_CERTIFICADO)  
REFERENCES CERTIFICADOS(ID_CERTIFICADO)
ON DELETE RESTRICT ON UPDATE CASCADE;
--relación EVENTOS TIPO_EVENTO
ALTER TABLE EVENTOS 
ADD CONSTRAINT FK_ID_TIPO_EVENTO
FOREIGN KEY (ID_TIPO_EVENTO)  
REFERENCES TIPO_EVENTO(ID_TIPO_EVENTO)
ON DELETE RESTRICT ON UPDATE CASCADE;
--relación ASISTENCIA_EVENTOS EVENTOS
ALTER TABLE ASISTENCIA_EVENTOS 
ADD CONSTRAINT FK_ID_EVENTO
FOREIGN KEY (ID_EVENTO)  
REFERENCES EVENTOS(ID_EVENTO)
ON DELETE RESTRICT ON UPDATE CASCADE;
--relación ASISTENCIA_EVENTOS EVENTOS
ALTER TABLE ASISTENCIA_EVENTOS 
ADD CONSTRAINT FK_ID_PLANTILLA_REGISTRO
FOREIGN KEY (ID_PLANTILLA_REGISTRO)  
REFERENCES PLANTILLA_REGISTRO(ID_PLANTILLA_REGISTRO)
ON DELETE RESTRICT ON UPDATE CASCADE;

--Insercion de registros a las tablas
INSERT INTO ANCIANO (NOMBRE_ANCIANO, APELLIDO_ANCIANO, TIPO_SANGRE, GENERO) VALUES ('Erick Alexander','Toala Intriago','Tipo B','Masculino');
INSERT INTO ANCIANO (NOMBRE_ANCIANO, APELLIDO_ANCIANO, TIPO_SANGRE, GENERO) VALUES ('Luis Antonio','Tuarez Castro','Tipo AB','Masculino');
INSERT INTO ANCIANO (NOMBRE_ANCIANO, APELLIDO_ANCIANO, TIPO_SANGRE, GENERO) VALUES ('Joan Job','Gallardo Alcivar','Tipo A','Masculino');
INSERT INTO ANCIANO (NOMBRE_ANCIANO, APELLIDO_ANCIANO, TIPO_SANGRE, GENERO) VALUES ('Susana Amelia','Horia Perez','Tipo A','Femenino');
INSERT INTO ANCIANO (NOMBRE_ANCIANO, APELLIDO_ANCIANO, TIPO_SANGRE, GENERO) VALUES ('Ashly Mayerly','Moran Cabeza','Tipo B','Femenino');
INSERT INTO PLANTILLA_REGISTRO (ID_ANCIANO, FECHA_INGRESO, ESTADO_SALUD, NUMERO_FAMILIAR, DIRECCION_FAMILIAR, INFO_BOVEDA) VALUES (1,'2022-03-14','Bien','0965486281','Rto.Arenales-Quinindé','Ninguna');
INSERT INTO PLANTILLA_REGISTRO (ID_ANCIANO, ESTADO_SALUD, NUMERO_FAMILIAR, DIRECCION_FAMILIAR, INFO_BOVEDA) VALUES (2,'Es muy viejo','0985372618','Las cumbres','No tiene');
INSERT INTO PLANTILLA_REGISTRO (ID_ANCIANO, ESTADO_SALUD, NUMERO_FAMILIAR, DIRECCION_FAMILIAR, INFO_BOVEDA) VALUES (3,'Está por morirse','0969361537','Barrio Cuba','Tampoco');
INSERT INTO PLANTILLA_REGISTRO (ID_ANCIANO, FECHA_INGRESO, ESTADO_SALUD, NUMERO_FAMILIAR, DIRECCION_FAMILIAR, INFO_BOVEDA) VALUES (4,'2015-07-20','Bien','0993671894','Av. Circunvalacion','Ninguna');
INSERT INTO PLANTILLA_REGISTRO (ID_ANCIANO, FECHA_INGRESO, ESTADO_SALUD, NUMERO_FAMILIAR, DIRECCION_FAMILIAR, INFO_BOVEDA) VALUES (5,'2018-01-01','Bien','0991768361','Rto.Arenales-Quinindé','Ninguna');

INSERT INTO SERVICIOS (DESCRIPCION, PRECIO) VALUES('Paseo','2.50');
INSERT INTO SERVICIOS (DESCRIPCION, PRECIO) VALUES('Masaje','5.00');
INSERT INTO SERVICIOS (DESCRIPCION, PRECIO) VALUES('Atención con Nutricionista','5.00');

INSERT INTO TIPO_PERSONAL(DESCRIPCION) VALUES('Administrativo');
INSERT INTO TIPO_PERSONAL(DESCRIPCION) VALUES('Terapista');
INSERT INTO TIPO_PERSONAL(DESCRIPCION) VALUES('Doctor');
INSERT INTO TIPO_PERSONAL(DESCRIPCION) VALUES('Enfermero');
INSERT INTO TIPO_PERSONAL(DESCRIPCION) VALUES('Nutricionista');
INSERT INTO TIPO_PERSONAL(DESCRIPCION) VALUES('Personal General');
INSERT INTO TIPO_PERSONAL(DESCRIPCION) VALUES('Masajista');

INSERT INTO PERSONAL (ID_TIPO_PERSONAL, NOMBRE_PERSONAL, APELLIDO_PERSONAL, TELEFONO) VALUES(1,'Juan Carlos','Perez Cedeño','0995672517');
INSERT INTO PERSONAL (ID_TIPO_PERSONAL, NOMBRE_PERSONAL, APELLIDO_PERSONAL, TELEFONO) VALUES(1,'Paulo Javier','Perez Cedeño','0995882113');
INSERT INTO PERSONAL (ID_TIPO_PERSONAL, NOMBRE_PERSONAL, APELLIDO_PERSONAL, TELEFONO) VALUES(2,'Jose Marcos','Hurtado Macias','0995672511');
INSERT INTO PERSONAL (ID_TIPO_PERSONAL, NOMBRE_PERSONAL, APELLIDO_PERSONAL, TELEFONO) VALUES(2,'Maria Belen','Cuero Sanchez','0995672512');
INSERT INTO PERSONAL (ID_TIPO_PERSONAL, NOMBRE_PERSONAL, APELLIDO_PERSONAL, TELEFONO) VALUES(3,'Roberto Humberto','Vera Rodriguez','0995672513');
INSERT INTO PERSONAL (ID_TIPO_PERSONAL, NOMBRE_PERSONAL, APELLIDO_PERSONAL, TELEFONO) VALUES(3,'Bruno Petroleo','Pascuaza Loor','0995672514');
INSERT INTO PERSONAL (ID_TIPO_PERSONAL, NOMBRE_PERSONAL, APELLIDO_PERSONAL, TELEFONO) VALUES(4,'Diego Felix','Suarez Cedeño','0995672515');
INSERT INTO PERSONAL (ID_TIPO_PERSONAL, NOMBRE_PERSONAL, APELLIDO_PERSONAL, TELEFONO) VALUES(4,'Gilmar Eduardo','Napa Caicedo','0995672516');
INSERT INTO PERSONAL (ID_TIPO_PERSONAL, NOMBRE_PERSONAL, APELLIDO_PERSONAL, TELEFONO) VALUES(5,'Alexander Bryan','Dominguez Paz','0995672518');
INSERT INTO PERSONAL (ID_TIPO_PERSONAL, NOMBRE_PERSONAL, APELLIDO_PERSONAL, TELEFONO) VALUES(5,'Robert Jose','Arboleda Pascuaza','0995672519');
INSERT INTO PERSONAL (ID_TIPO_PERSONAL, NOMBRE_PERSONAL, APELLIDO_PERSONAL, TELEFONO) VALUES(6,'Byron Xavier','Castillo Cedeño','0995672510');
INSERT INTO PERSONAL (ID_TIPO_PERSONAL, NOMBRE_PERSONAL, APELLIDO_PERSONAL, TELEFONO) VALUES(6,'Jhoanner Stalin','Chávez Quintero','0995672524');
INSERT INTO PERSONAL (ID_TIPO_PERSONAL, NOMBRE_PERSONAL, APELLIDO_PERSONAL, TELEFONO) VALUES(7,'Eduar Ayrton','Preciado García','0995672300');
INSERT INTO PERSONAL (ID_TIPO_PERSONAL, NOMBRE_PERSONAL, APELLIDO_PERSONAL, TELEFONO) VALUES(7,'Kevin José','Rodríguez Cortéz','0995672533');

BEGIN;
INSERT INTO FACTURA (ID_PLANTILLA_REGISTRO, FECHA_EMISION, FORMA_PAGO, ESTADO, PRECIO_ESTANCIA, TOTAL) VALUES (1,'2022-03-14','Efectivo','Pagada','100.00','112.50');
INSERT INTO SERVICIOS_FACTURA (ID_FACTURA, ID_SERVICIO, ID_PERSONAL, FECHA_SERVICIO, TOTAL) VALUES(1,1,11,'2022-03-19','2.50');
INSERT INTO SERVICIOS_FACTURA (ID_FACTURA, ID_SERVICIO, ID_PERSONAL, FECHA_SERVICIO, TOTAL) VALUES(1,2,13,'2022-03-26','5.00');
INSERT INTO SERVICIOS_FACTURA (ID_FACTURA, ID_SERVICIO, ID_PERSONAL, FECHA_SERVICIO, TOTAL) VALUES(1,3,9,'2022-03-28','5.00');
COMMIT;

BEGIN;
INSERT INTO FACTURA (ID_PLANTILLA_REGISTRO, FECHA_EMISION, FORMA_PAGO, ESTADO, PRECIO_ESTANCIA, TOTAL) VALUES (2,'2022-11-12','Efectivo','Pendiente','100.00','105.00');
INSERT INTO SERVICIOS_FACTURA (ID_FACTURA, ID_SERVICIO, ID_PERSONAL, FECHA_SERVICIO, TOTAL) VALUES(2,2,13,'2022-11-12','5.00');
COMMIT;

BEGIN;
INSERT INTO FACTURA (ID_PLANTILLA_REGISTRO, FECHA_EMISION, FORMA_PAGO, ESTADO, PRECIO_ESTANCIA, TOTAL) VALUES (3,'2022-11-12','Efectivo','Pendiente','100.00','102.50');
INSERT INTO SERVICIOS_FACTURA (ID_FACTURA, ID_SERVICIO, ID_PERSONAL, FECHA_SERVICIO, TOTAL) VALUES(3,1,11,'2022-11-12','2.50');
COMMIT;

BEGIN;
INSERT INTO FACTURA (ID_PLANTILLA_REGISTRO, FECHA_EMISION, FORMA_PAGO, ESTADO, PRECIO_ESTANCIA, TOTAL) VALUES (4,'2018-01-01','Efectivo','Pagada','100.00','112.50');
INSERT INTO SERVICIOS_FACTURA (ID_FACTURA, ID_SERVICIO, ID_PERSONAL, FECHA_SERVICIO, TOTAL) VALUES(4,1,11,'2018-01-05','2.50');
INSERT INTO SERVICIOS_FACTURA (ID_FACTURA, ID_SERVICIO, ID_PERSONAL, FECHA_SERVICIO, TOTAL) VALUES(4,2,13,'2018-01-10','5.00');
INSERT INTO SERVICIOS_FACTURA (ID_FACTURA, ID_SERVICIO, ID_PERSONAL, FECHA_SERVICIO, TOTAL) VALUES(4,3,9,'2018-01-15','5.00');
COMMIT;

BEGIN;
INSERT INTO FACTURA (ID_PLANTILLA_REGISTRO, FECHA_EMISION, FORMA_PAGO, ESTADO, PRECIO_ESTANCIA, TOTAL) VALUES (5,'2015-07-20','Efectivo','Pagada','100.00','112.50');
INSERT INTO SERVICIOS_FACTURA (ID_FACTURA, ID_SERVICIO, ID_PERSONAL, FECHA_SERVICIO, TOTAL) VALUES(5,1,11,'2015-07-21','2.50');
INSERT INTO SERVICIOS_FACTURA (ID_FACTURA, ID_SERVICIO, ID_PERSONAL, FECHA_SERVICIO, TOTAL) VALUES(5,2,13,'2015-07-25','5.00');
INSERT INTO SERVICIOS_FACTURA (ID_FACTURA, ID_SERVICIO, ID_PERSONAL, FECHA_SERVICIO, TOTAL) VALUES(5,3,9,'2015-07-28','5.00');
COMMIT;

INSERT INTO TIPO_EVENTO (DESCRIPCION) VALUES('Taller de cocina');
INSERT INTO TIPO_EVENTO (DESCRIPCION) VALUES('Show de música');
INSERT INTO TIPO_EVENTO (DESCRIPCION) VALUES('Películas y documentales');
INSERT INTO TIPO_EVENTO (DESCRIPCION) VALUES('Cine debate');
INSERT INTO TIPO_EVENTO (DESCRIPCION) VALUES('Juego de cartas');
INSERT INTO TIPO_EVENTO (DESCRIPCION) VALUES('Bingo');
INSERT INTO TIPO_EVENTO (DESCRIPCION) VALUES('Caminatas');

INSERT INTO EVENTOS (ID_TIPO_EVENTO, FECHA_EVENTO) VALUES(5,'2016-01-11');
INSERT INTO EVENTOS (ID_TIPO_EVENTO, FECHA_EVENTO) VALUES(4,'2018-01-01');
INSERT INTO EVENTOS (ID_TIPO_EVENTO, FECHA_EVENTO) VALUES(3,'2022-03-17');
INSERT INTO EVENTOS (ID_TIPO_EVENTO, FECHA_EVENTO) VALUES(6,'2022-04-17');
INSERT INTO EVENTOS (ID_TIPO_EVENTO, FECHA_EVENTO) VALUES(2,'2022-05-17');
INSERT INTO EVENTOS (ID_TIPO_EVENTO, FECHA_EVENTO) VALUES(7,'2022-06-17');
INSERT INTO EVENTOS (ID_TIPO_EVENTO, FECHA_EVENTO) VALUES(1,'2022-11-12');

INSERT INTO ASISTENCIA_EVENTOS (ID_EVENTO, ID_PLANTILLA_REGISTRO) VALUES(1, 4);
INSERT INTO ASISTENCIA_EVENTOS (ID_EVENTO, ID_PLANTILLA_REGISTRO) VALUES(2, 4);
INSERT INTO ASISTENCIA_EVENTOS (ID_EVENTO, ID_PLANTILLA_REGISTRO) VALUES(2, 5);
INSERT INTO ASISTENCIA_EVENTOS (ID_EVENTO, ID_PLANTILLA_REGISTRO) VALUES(3, 1);
INSERT INTO ASISTENCIA_EVENTOS (ID_EVENTO, ID_PLANTILLA_REGISTRO) VALUES(4, 1);
INSERT INTO ASISTENCIA_EVENTOS (ID_EVENTO, ID_PLANTILLA_REGISTRO) VALUES(5, 1);
INSERT INTO ASISTENCIA_EVENTOS (ID_EVENTO, ID_PLANTILLA_REGISTRO) VALUES(6, 1);
INSERT INTO ASISTENCIA_EVENTOS (ID_EVENTO, ID_PLANTILLA_REGISTRO) VALUES(7, 1);
INSERT INTO ASISTENCIA_EVENTOS (ID_EVENTO, ID_PLANTILLA_REGISTRO) VALUES(7, 4);
INSERT INTO ASISTENCIA_EVENTOS (ID_EVENTO, ID_PLANTILLA_REGISTRO) VALUES(7, 5);


INSERT INTO TERAPIAS (ID_PLANTILLA_REGISTRO, ID_PERSONAL, FECHA_TERAPIA) VALUES(1,3,'2022-03-21');
INSERT INTO TERAPIAS (ID_PLANTILLA_REGISTRO, ID_PERSONAL, FECHA_TERAPIA) VALUES(1,4,'2022-04-21');
INSERT INTO TERAPIAS (ID_PLANTILLA_REGISTRO, ID_PERSONAL, FECHA_TERAPIA) VALUES(1,4,'2022-05-21');
INSERT INTO TERAPIAS (ID_PLANTILLA_REGISTRO, ID_PERSONAL, FECHA_TERAPIA) VALUES(2,4,'2022-11-13');
INSERT INTO TERAPIAS (ID_PLANTILLA_REGISTRO, ID_PERSONAL, FECHA_TERAPIA) VALUES(3,3,'2022-11-14');
INSERT INTO TERAPIAS (ID_PLANTILLA_REGISTRO, ID_PERSONAL, FECHA_TERAPIA) VALUES(4,3,'2015-07-25');
INSERT INTO TERAPIAS (ID_PLANTILLA_REGISTRO, ID_PERSONAL, FECHA_TERAPIA) VALUES(5,3,'2018-02-15');

INSERT INTO REVISIONES_MEDICAS (ID_PLANTILLA_REGISTRO, ID_PERSONAL, FECHA_REVISION) VALUES(1,3,'2022-03-15');
INSERT INTO REVISIONES_MEDICAS (ID_PLANTILLA_REGISTRO, ID_PERSONAL, FECHA_REVISION) VALUES(1,4,'2022-04-15');
INSERT INTO REVISIONES_MEDICAS (ID_PLANTILLA_REGISTRO, ID_PERSONAL, FECHA_REVISION) VALUES(1,4,'2022-05-15');
INSERT INTO REVISIONES_MEDICAS (ID_PLANTILLA_REGISTRO, ID_PERSONAL, FECHA_REVISION) VALUES(2,4,'2022-11-12');
INSERT INTO REVISIONES_MEDICAS (ID_PLANTILLA_REGISTRO, ID_PERSONAL, FECHA_REVISION) VALUES(3,3,'2022-11-12');
INSERT INTO REVISIONES_MEDICAS (ID_PLANTILLA_REGISTRO, ID_PERSONAL, FECHA_REVISION) VALUES(4,3,'2015-07-21');
INSERT INTO REVISIONES_MEDICAS (ID_PLANTILLA_REGISTRO, ID_PERSONAL, FECHA_REVISION) VALUES(5,3,'2018-01-02');

/*===============================================================================================================*/
/*                                                 CONSULTAS                                                     */
/*===============================================================================================================*/
--Consulta 1: Mostrar los costos cobrado por servicios del asilo en el año
select
	servicios.descripcion as Servicios,
	SUM(servicios_factura.total) as Costos
from servicios_factura
	inner join servicios on servicios_factura.id_servicio = servicios.id_servicio
	where servicios_factura.fecha_servicio between '2022-01-01' and '2022-12-31'
	GROUP BY servicios.descripcion ORDER BY Costos desc

--Consulta 2: Mostrar la cantidad de tratamiento hechos por el personal de tratamiento en todo el año.
select
	COUNT(terapias) as Terapias
	from terapias
	where terapias.fecha_terapia between '2022-01-01' and '2022-12-31'

--Consulta 3: Mostrar las revisiones médicas por doctor en el año.
select
	(personal.nombre_personal||' '||personal.apellido_personal) as Doctores,
	COUNT(revisiones_medicas) as Revisiones
from revisiones_medicas
	inner join personal on revisiones_medicas.id_personal = personal.id_personal
	where revisiones_medicas.fecha_revision between '2022-01-01' and '2022-12-31'
	GROUP BY personal.id_personal 

--Consulta 4: Mostrar el evento que generó más participación de los ancianos en todo el año
select
	tipo_evento.descripcion as Eventos,
	count(asistencia_eventos.id_evento) as Participaciones
from eventos
	inner join asistencia_eventos on asistencia_eventos.id_evento = eventos.id_evento
	inner join tipo_evento on eventos.id_tipo_evento = tipo_evento.id_tipo_evento
	where eventos.fecha_evento between '2022-01-01' and '2022-12-31'
	group by tipo_evento.descripcion order by Participaciones desc limit 1
	
/*===============================================================================================================*/
/*                                                 TRIGGER                                                       */
/*===============================================================================================================*/
CREATE OR REPLACE FUNCTION TR_ACTUALIZAR_TOTAL_FACTURA() RETURNS TRIGGER AS
$$
DECLARE 
BEGIN
	UPDATE factura set total = total+new.total
	where id_factura= new.id_factura;
	return new;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER TR_ACTUALIZAR_TOTAL_FACTURA AFTER INSERT ON servicios_factura
FOR EACH ROW EXECUTE PROCEDURE TR_ACTUALIZAR_TOTAL_FACTURA();

--Verificación
--Podemos observar que la factura con ID = 1 tiene un monto total de 112.5
Select id_factura, id_plantilla_registro, total from FACTURA;

/*Insertar servicios para que el monto total de la factura con ID = 1 se actualice
	El monto total al insertarse los nuevos servicios se debe de ser de 122.5*/
BEGIN;
INSERT INTO SERVICIOS_FACTURA (ID_FACTURA, ID_SERVICIO, ID_PERSONAL, FECHA_SERVICIO, TOTAL) VALUES(1,2,14,'2022-05-23','5.00');
INSERT INTO SERVICIOS_FACTURA (ID_FACTURA, ID_SERVICIO, ID_PERSONAL, FECHA_SERVICIO, TOTAL) VALUES(1,3,9,'2022-05-25','5.00');
COMMIT;

/*===============================================================================================================*/
/*                                                 CURSOR                                                        */
/*===============================================================================================================*/
--Histórico que muestre la cantidad de atención de servicios por género en cada año.
do $$
declare
	registro Record;
	Cursor_CantidadServiciosPorGenero Cursor for 
	select 
		anciano.genero as Genero,
		COUNT(servicios_factura) as Cantidad
	from servicios_factura
		inner join factura on servicios_factura.id_factura = factura.id_factura
		inner join plantilla_registro on factura.id_plantilla_registro = plantilla_registro.id_plantilla_registro
		inner join anciano on plantilla_registro.id_anciano = anciano.id_anciano
	group by anciano.genero;
begin
Open Cursor_CantidadServiciosPorGenero;
Fetch Cursor_CantidadServiciosPorGenero into registro;
while (found) loop
Raise Notice 'Género: %, Cantidad de servicios: %', registro.genero, registro.Cantidad;
Fetch Cursor_CantidadServiciosPorGenero into registro;
end loop;
end$$
Language 'plpgsql';

/*===============================================================================================================*/
/*                                           STORE PROCEDURE                                                     */
/*===============================================================================================================*/
--Un procedimiento que devuelva cuantas atenciones generó por año un especialista, el cual se pasará como parámetro
create function atencionesEspecialista(nombre varchar) returns integer as
$$
declare
cantidadAtenciones integer;
begin
cantidadAtenciones:=
(select count(terapias) as Cantidad
from terapias inner join personal on terapias.id_personal = personal.id_personal
where personal.nombre_personal = nombre);
return cantidadAtenciones;
end;
$$
language plpgsql;

select atencionesEspecialista('Jose Marcos') as Cantidad_Atenciones

/*===============================================================================================================*/
/*                                                REPORTE                                                        */
/*===============================================================================================================*/
--Histórico de ingresos por año en el asilo en un diagrama de barras
select 
	cast(extract(year from plantilla_registro.fecha_ingreso) as INTEGER) as Anio,
	cast(count(plantilla_registro.id_plantilla_registro)as INTEGER ) as Ingresos
from plantilla_registro
group by Anio