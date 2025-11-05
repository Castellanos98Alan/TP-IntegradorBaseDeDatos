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
  