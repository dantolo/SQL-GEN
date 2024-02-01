/* Creamos base de datos */
CREATE database ch35;

-- MySQL Workbench Forward Engineering


USE `ch35`;

-- -----------------------------------------------------
-- Table `ch35`.`perfil_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ch35`.`perfil_cliente` (
  `id_perfil_cliente` INT NOT NULL AUTO_INCREMENT,
  `fecha_registro` DATE NOT NULL,
  `preferencias` MEDIUMTEXT NOT NULL,
  PRIMARY KEY (`id_perfil_cliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ch35`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ch35`.`cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(80) NOT NULL,
  `apellido` VARCHAR(80) NOT NULL,
  `correo` VARCHAR(80) NOT NULL,
  `direccion` VARCHAR(80) NOT NULL,
  `perfil_cliente_id_perfil_cliente` INT NOT NULL,
  PRIMARY KEY (`id_cliente`),
  INDEX `fk_cliente_perfil_cliente1_idx` (`perfil_cliente_id_perfil_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_perfil_cliente1`
    FOREIGN KEY (`perfil_cliente_id_perfil_cliente`)
    REFERENCES `mydb`.`perfil_cliente` (`id_perfil_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ch35`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ch35`.`productos` (
  `id_productos` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `descripcion` TEXT(300) NOT NULL,
  `precio` DECIMAL(10) UNSIGNED NOT NULL,
  `stock` INT ZEROFILL UNSIGNED NOT NULL,
  PRIMARY KEY (`id_productos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ch35`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ch35`.`pedidos` (
  `id_pedidos` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `estado_pedido` VARCHAR(100) NOT NULL,
  `total` DECIMAL(10) UNSIGNED NOT NULL,
  `cliente_id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_pedidos`),
  INDEX `fk_pedidos_cliente_idx` (`cliente_id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_pedidos_cliente`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `mydb`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ch35`.`detalles_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ch35`.`detalles_pedido` (
  `id_detalles_pedido` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NOT NULL,
  `precio_unitario` DECIMAL(10) UNSIGNED NOT NULL,
  `descuento` DECIMAL(10) UNSIGNED NOT NULL,
  `pedidos_id_pedidos` INT NOT NULL,
  `productos_id_productos` INT NOT NULL,
  PRIMARY KEY (`id_detalles_pedido`),
  INDEX `fk_detalles_pedido_pedidos1_idx` (`pedidos_id_pedidos` ASC) VISIBLE,
  INDEX `fk_detalles_pedido_productos1_idx` (`productos_id_productos` ASC) VISIBLE,
  CONSTRAINT `fk_detalles_pedido_pedidos1`
    FOREIGN KEY (`pedidos_id_pedidos`)
    REFERENCES `mydb`.`pedidos` (`id_pedidos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalles_pedido_productos1`
    FOREIGN KEY (`productos_id_productos`)
    REFERENCES `mydb`.`productos` (`id_productos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ch35`.`productos_favoritos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ch35`.`productos_favoritos` (
  `id_productos_favoritos` INT NOT NULL,
  `productos_id_productos` INT NOT NULL,
  PRIMARY KEY (`id_productos_favoritos`, `productos_id_productos`),
  INDEX `fk_cliente_has_productos_productos1_idx` (`productos_id_productos` ASC) VISIBLE,
  INDEX `fk_cliente_has_productos_cliente1_idx` (`id_productos_favoritos` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_has_productos_cliente1`
    FOREIGN KEY (`id_productos_favoritos`)
    REFERENCES `ch35`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_has_productos_productos1`
    FOREIGN KEY (`productos_id_productos`)
    REFERENCES `ch35`.`productos` (`id_productos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Insertar datos en la tabla del cliente

INSERT into cliente ( id_cliente, nombre, apellido, correo, direccion)
values (1, "Daniel", "Maldonado", "dany.maldonado@gmail.com", "calle Walabe");



-- Insertar datos en la tabla perfil_cliente
INSERT into perfil_cliente (id_perfil_cliente, fecha_registro, preferencias)
values (1, "2024-01-28", "tazas tipo Starbucks");
