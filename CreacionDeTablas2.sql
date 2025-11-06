use tp_integrador;

-- Creacion de tablas

CREATE TABLE `asistente` (
  `ID_Asistente` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `Pais` VARCHAR(45) NULL,
  `Provincia` VARCHAR(45) NULL,
  `Ciudad` VARCHAR(45) NULL,
  `InteresPrincipal` VARCHAR(45) NULL,
  PRIMARY KEY (`ID_Asistente`),
  UNIQUE INDEX `ID_Asistente_UNIQUE` (`ID_Asistente` ASC) VISIBLE);
  
  CREATE TABLE `evento` (
  `idEvento` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idEvento`),
  UNIQUE INDEX `idEvento_UNIQUE` (`idEvento` ASC) VISIBLE);
  
  CREATE TABLE `empresa` (
  `CUIT` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`CUIT`),
  UNIQUE INDEX `CUIT_UNIQUE` (`CUIT` ASC) VISIBLE);

   CREATE TABLE `establecimiento` (
  `idEstablecimiento` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idEstablecimiento`),
  UNIQUE INDEX `idEstablecimiento_UNIQUE` (`idEstablecimiento` ASC) VISIBLE);
  
   CREATE TABLE `docente` (
  `legajo` INT NOT NULL AUTO_INCREMENT,
  `NombreCompleto` VARCHAR(45) NOT NULL,
  `titulo`VARCHAR(45) NOT NULL,
  PRIMARY KEY (`legajo`),
  UNIQUE INDEX `legajo_UNIQUE` (`legajo` ASC) VISIBLE);
  
  CREATE TABLE `proyecto` (
  `COD` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `objetivo` VARCHAR(145) NOT NULL,
  `lista_tags` VARCHAR(45) NULL,
  PRIMARY KEY (`COD`),
  UNIQUE INDEX `COD_UNIQUE` (`COD` ASC) VISIBLE);
  
  CREATE TABLE `actividad` (
  `nombre` VARCHAR(45) NOT NULL,
  `fecha_hora` DATETIME NOT NULL,
  `lugar` VARCHAR(85) NULL,
  `ID_EVENTO` INT NULL,
  PRIMARY KEY (`nombre`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
    FOREIGN KEY (`ID_EVENTO`)
    REFERENCES `evento` (`idEvento`));
    
    ALTER TABLE actividad
modify nombre VARCHAR(85) PRIMARY KEY NOT NULL;

CREATE TABLE `asistenteparticipaenactividad` (
  `ID_ASIST` INT NOT NULL,
  `NOMBRE_ACT` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_ASIST`, `NOMBRE_ACT`),
  CONSTRAINT `idAsist`
    FOREIGN KEY (`ID_ASIST`)
    REFERENCES `asistente` (`ID_Asistente`),
  CONSTRAINT `nombreAct`
    FOREIGN KEY (`NOMBRE_ACT`)
    REFERENCES `actividad` (`nombre`));
  
  CREATE TABLE `nota_Periodistica` (
  `ID` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `plataforma` VARCHAR(45) NOT NULL,
  `enlace` VARCHAR(45) NULL,
  `ID_EVENTO` INT NOT NULL,
  FOREIGN KEY (`ID_EVENTO`)
  REFERENCES `evento` (`idEvento`)
  );

CREATE TABLE `asistenteopinaennota` (
  `ID_ASIST` INT NOT NULL,
  `ID_NOTA` INT NOT NULL,
  PRIMARY KEY (`ID_ASIST`, `ID_NOTA`),
    FOREIGN KEY (`ID_ASIST`)
    REFERENCES `asistente` (`ID_Asistente`),
    FOREIGN KEY (`ID_NOTA`)
    REFERENCES `nota_Periodistica` (`ID`));
  
   CREATE TABLE `premio` (
  `cod` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL,
  `COD_PROYECTO` INT NOT NULL,
  FOREIGN KEY (`COD_PROYECTO`)
  REFERENCES `proyecto` (`COD`)
  );
  
  CREATE TABLE `asistenteobtienePremio` (
  `ID_ASIST` INT NOT NULL,
  `cod_Premio` INT NOT NULL,
  PRIMARY KEY (`ID_ASIST`, `cod_Premio`),
    FOREIGN KEY (`ID_ASIST`)
    REFERENCES `asistente` (`ID_Asistente`),
    FOREIGN KEY (`cod_Premio`)
    REFERENCES `premio` (`cod`));
    
      CREATE TABLE `estudiante` (
  `ID` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `carrera` VARCHAR(45) NOT NULL,
  `COD_PROYECTO` INT NOT NULL,
  `ID_ESTABLECIMIENTO` INT NOT NULL,
  FOREIGN KEY (`COD_PROYECTO`)
  REFERENCES `proyecto` (`COD`),
  FOREIGN KEY (`ID_ESTABLECIMIENTO`)
  REFERENCES `establecimiento` (`idEstablecimiento`)
  );
  
  CREATE TABLE `notaPeriodistaEntrevistaEstudiante` (
  `ID_NOTA` INT NOT NULL,
  `ID_ESTUDIANTE` INT NOT NULL,
  PRIMARY KEY (`ID_NOTA`, `ID_ESTUDIANTE`),
    FOREIGN KEY (`ID_NOTA`)
    REFERENCES `nota_Periodistica` (`ID`),
    FOREIGN KEY (`ID_ESTUDIANTE`)
    REFERENCES `estudiante` (`ID`));
  
    CREATE TABLE `stand` (
  `ID` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  `ID_EVENTO` INT NOT NULL,
  FOREIGN KEY (`ID_EVENTO`)
  REFERENCES `evento` (`IDevento`)
  );

ALTER TABLE stand 
ADD COD_PROYECTO INT NOT NULL;

ALTER TABLE stand 
ADD CONSTRAINT fk_stand_proyecto
FOREIGN KEY (COD_PROYECTO)
REFERENCES proyecto (cod);
  
     
  CREATE TABLE `esbrindada` (
  `nombre_actividad` VARCHAR(85) NOT NULL,
  `cuit_empresa` INT NOT NULL,
  PRIMARY KEY (`nombre_actividad`, `cuit_empresa`),
    FOREIGN KEY (`nombre_actividad`)
    REFERENCES `actividad` (`nombre`),
    FOREIGN KEY (`cuit_empresa`)
    REFERENCES `empresa` (`cuit`));
    
       CREATE TABLE `modalidad` (
  `ID` INT PRIMARY KEY NOT NULL AUTO_INCREMENT
  );
    
    
   CREATE TABLE `actividadPuedeSer` (
   `ID_MOD` INT NOT NULL,
  `NOMBRE_ACT` VARCHAR(85) NOT NULL,
  PRIMARY KEY (`ID_MOD`, `NOMBRE_ACT`),
    FOREIGN KEY (`ID_MOD`)
    REFERENCES `modalidad` (`ID`),
    FOREIGN KEY (`NOMBRE_ACT`)
    REFERENCES `actividad` (`nombre`)); 
  
  
   CREATE TABLE `virtual` (
  `ID_MOD` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `enlace` VARCHAR(65) NOT NULL,
  FOREIGN KEY (`ID_MOD`)
  REFERENCES `modalidad` (`ID`)
  );
  
    CREATE TABLE `presencial` (
  `ID_MOD` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  FOREIGN KEY (`ID_MOD`)
  REFERENCES `modalidad` (`ID`)
  );
  
  
  -- INSERCCION DE DATOS 
  
INSERT INTO asistente 
(ID_Asistente, email, nombre, apellido, Pais, Provincia, Ciudad, InteresPrincipal) VALUES
(1, 'pepe123@hotmail.com', 'Pepe', 'Fernandez', 'Argentina', 'Buenos Aires', 'Ramos Mejia', 'Ganar algun sorteo'),
(2, 'Sofia13@gmail.com', 'Sofia', 'Hernandez', 'Argentina', 'Buenos Aires', 'San Justo', 'Divertirse'),
(3, 'Mauro256@hotmail.com', 'Mauro', 'Bravo', 'Argentina', 'Buenos Aires', 'Haedo', 'Mirar los stands'),
(4, 'Juan123@yahoo.com.ar', 'Juan', 'Palma', 'Argentina', 'Corrientes', 'Colon', 'Hacer amigos'),
(5, 'VioletaTini@hotmail.com', 'Violeta', 'Tini', 'Argentina', 'Buenos Aires', 'Moron', 'Comprar cosas'),
(6, 'Analia123@gmail.com.ar', 'Analia', 'Martinez', 'Argentina', 'Cordoba', 'Villa Carlos Paz', 'Mirar los stands'),
(7, 'Lewis123@outlook.com', 'Lewis', 'Martinez', 'Venezuela', NULL, 'Caracas', 'Divertirse'),
(8, 'MatiasCABJ@outlook.com', 'Matias', 'Malta', 'Argentina', 'Cordoba', 'Capital', NULL),
(9, 'Veronica@gmail.com', 'Veronica', 'Gallardo', 'Uruguay', NULL, 'Montevideo', 'Hacer actividades');

insert into docente 
(legajo, nombreCompleto, titulo) VALUES
(1001, 'María López', 'Licenciada en Informática'),
(1002, 'Juan Pérez', 'Ingeniero en Sistemas'),
(1003, 'Carolina Gómez', 'Profesora en Tecnología'),
(1004, 'Ricardo Fernández', 'Magíster en Educación'),
(1005, 'Lucía Martínez', 'Licenciada en Diseño Gráfico'),
(1006, 'Santiago Torres', 'Doctor en Ciencias de la Computación');

insert into empresa (CUIT, nombre) VALUES
('30-71234567-9', 'TechVision S.A.'),
('30-68945213-7', 'Innovar Group SRL'),
('30-74589632-1', 'DataSoft Solutions'),
('30-65893412-4', 'Creativa Digital'),
('30-70123498-6', 'BioHealth Argentina'),
('30-77889900-3', 'ExpoMinds LATAM');

insert into establecimiento (idEstablecimiento, nombre) VALUES
(1, 'Escuela Técnica N°1 La Matanza'),
(2, 'Instituto Superior de Formación Docente N°46'),
(3, 'Universidad Nacional de La Matanza'),
(4, 'Colegio San José'),
(5, 'Escuela Industrial N°3 Morón'),
(6, 'UTN');

UPDATE establecimiento 
SET nombre = 'UBA' where (idEstablecimiento = 4) ;

INSERT INTO proyecto 
(COD, descripcion, nombre, objetivo, lista_tags) VALUES
(101, 'Sistema de gafas inteligentes que muestran información nutricional en tiempo real.', 'NutriGlass', 'Promover una alimentación consciente mediante realidad aumentada.', 'IA, Realidad Aumentada, Salud'),
(102, 'Aplicación móvil para conectar estudiantes y empresas tecnológicas.', 'ConectaTech', 'Fomentar la inserción laboral de jóvenes en el sector IT.', 'Aplicaciones, Empleo, Educación'),
(103, 'Plataforma web de reciclaje colaborativo con recompensas digitales.', 'EcoPoints', 'Motivar el reciclaje mediante gamificación y recompensas sostenibles.', 'Sustentabilidad, Web, Comunidad'),
(104, 'Sitio web interactivo que promueve la identidad visual de proyectos estudiantiles.', 'ExpoWeb', 'Difundir los proyectos de la muestra mediante diseño UX/UI y recursos multimedia.', 'Diseño Web, UX/UI, Frontend'),
(105, 'Robot educativo diseñado para enseñar programación básica.', 'EduBot', 'Introducir a los niños en el pensamiento computacional de forma interactiva.', 'Robótica, Educación, Tecnología'),
(106, 'Aplicación de seguridad para monitorear accesos en instituciones educativas.', 'SafeSchool', 'Brindar mayor seguridad y control en el ingreso de alumnos y visitantes.', 'Seguridad, Control de Acceso');

INSERT INTO estudiante 
(ID, nombre, carrera, COD_PROYECTO, ID_ESTABLECIMIENTO)  VALUES
-- Establecimiento 1
(1, 'Lucía Fernández', 'Programación Web', 101, 1),
(2, 'Matías Romero', 'Programación movil', 101, 1),
-- Establecimiento 2
(3, 'Carolina Pérez', 'Diseño Gráfico', 102, 2),
(4, 'Julián Gómez', 'Sistemas Informáticos', 102, 2),
-- Establecimiento 3
(5, 'Sofía Torres', 'Ingeniería en Informática', 103, 3),
(6, 'Martín López', 'Desarrollo de Software', 103, 3),
-- Establecimiento 4
(7, 'Valentina Díaz', 'Programación movil', 104, 4),
(8, 'Tomás Herrera', 'Programación Web', 104, 4),
-- Establecimiento 5
(9, 'Camila Suárez', 'Programación movil', 105, 5),
(10, 'Leandro Bravo', 'Ingeniería en Informática', 105, 5),
-- Establecimiento 6
(11, 'Brenda Morales', 'Desarrollo de Software', 106, 6),
(12, 'Nicolás Castro', 'Seguridad Informática', 106, 6);

INSERT INTO evento
(idEvento, nombre) VALUES
(1, 'Expo Proyecto Web'),
(2, 'Expo Proyecto Web dia 2'),
(3, 'Expo Proyecto Web dia 3');

UPDATE  evento
set nombre = 'Expo Proyecto Web dia 1' where (idEvento = 1);

INSERT INTO premio
(cod, tipo, COD_PROYECTO) VALUES
-- Premios a los proyectos ganadores
(1, '1° Puesto - PC Gamer de última generación (valor $1.200.000)', 101),
(2, '2° Puesto - Notebook Lenovo IdeaPad 15” (valor $800.000)', 103),
(3, '3° Puesto - Tablet Samsung Galaxy Tab S6 Lite (valor $500.000)', 105),
-- Premios sorteados en actividades
(4, 'Sorteo - Mochila con merchandising de la Expo', NULL),
(5, 'Sorteo - Auriculares inalámbricos JBL', NULL),
(6, 'Sorteo - Mouse gamer Logitech G203', NULL),
(7, 'Sorteo - Set de remeras oficiales de la Expo', NULL),
(8, 'Sorteo - Kit escolar tecnológico (pendrive, cuaderno y lapicera digital)', NULL),
(9, 'Sorteo - Powerbank solar portátil', NULL);

ALTER TABLE stand
modify descripcion VARCHAR(145) NOT NULL;

INSERT INTO stand 
(ID, descripcion, ID_EVENTO, COD_PROYECTO) VALUES
(1, 'Stand de gafas inteligentes con demostración de NutriGlass', 1, 101),
(2, 'Espacio interactivo de ConectaTech con charlas y networking', 1, 102),
(3, 'Stand ecológico de EcoPoints con panel informativo y juegos', 2, 103),
(4, 'Exhibición de ExpoWeb con pantallas táctiles y diseño UX/UI', 2, 104),
(5, 'Área de demostración de EduBot con robots programables', 3, 105),
(6, 'Zona de seguridad digital de SafeSchool con simulador de accesos', 3, 106);


INSERT INTO actividad 
(nombre, fecha_hora, lugar, ID_EVENTO) VALUES
-- Día 1 – Expo Proyecto 2026
('Apertura oficial y bienvenida', '2026-10-10 10:00:00', 'Auditorio Principal', 1),
('Charla: Innovación y tecnología educativa', '2026-10-10 12:00:00', 'Sala A', 1),
('Taller de Realidad Aumentada', '2026-10-10 15:00:00', 'Laboratorio 1', 1),
('Presentación de proyectos destacados', '2026-10-10 17:00:00', 'Stand Central', 1),

-- Día 2 – Expo Proyecto Web
('Charla: Diseño UX/UI en entornos educativos', '2026-10-11 10:00:00', 'Sala B', 2),
('Taller: Creación de sitios web responsivos', '2026-10-11 12:00:00', 'Laboratorio Web', 2),
('Exposición: ConectaTech y empleabilidad digital', '2026-10-11 15:00:00', 'Zona Stands', 2),
('Demostración: NutriGlass en acción', '2026-10-11 17:00:00', 'Stand 1', 2),

-- Día 3 – Expo Proyecto Web
('Charla: Ciberseguridad y protección de datos', '2026-10-12 10:00:00', 'Sala A', 3),
('Taller: Programación con IA generativa', '2026-10-12 12:00:00', 'Laboratorio 2', 3),
('Competencia de proyectos estudiantiles', '2026-10-12 15:00:00', 'Auditorio Principal', 3),
('Cierre y entrega de premios', '2026-10-12 17:00:00', 'Escenario Principal', 3);

