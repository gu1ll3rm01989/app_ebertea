-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 06-06-2020 a las 22:29:25
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ebertea_cobranzas`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acciones`
--

CREATE TABLE `acciones` (
  `id` int(255) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `fecha_vencimiento` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `razon_social` varchar(255) DEFAULT NULL,
  `cuit` bigint(100) NOT NULL,
  `domicilio` varchar(255) DEFAULT NULL,
  `telefono` bigint(100) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `cond_fiscal` varchar(255) DEFAULT NULL,
  `forma_pago` varchar(255) DEFAULT NULL,
  `reporte_frecuencia` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `deuda`
--

CREATE TABLE `deuda` (
  `SIGA_id` bigint(200) NOT NULL,
  `deuda_cliente` varchar(255) DEFAULT NULL,
  `tipo_gestion` varchar(255) DEFAULT NULL,
  `capital` bigint(200) DEFAULT NULL,
  `intereses_acumulados` bigint(200) DEFAULT NULL,
  `monto_fict` bigint(200) DEFAULT NULL,
  `inicio_mora` date DEFAULT NULL,
  `estado_tipo` varchar(255) DEFAULT NULL,
  `codigo_pagounico` varchar(255) DEFAULT NULL,
  `deudor_nombreyapellido` varchar(255) DEFAULT NULL,
  `deudor_dni` bigint(200) DEFAULT NULL,
  `domicilio` varchar(255) DEFAULT NULL,
  `localidad` varchar(255) DEFAULT NULL,
  `accion_programada` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `deudor`
--

CREATE TABLE `deudor` (
  `nombreyapellido` varchar(255) DEFAULT NULL,
  `dni` bigint(200) NOT NULL,
  `telefono_1` bigint(200) DEFAULT NULL,
  `telefono_2` bigint(200) DEFAULT NULL,
  `telefono_3` bigint(200) DEFAULT NULL,
  `telefono_4` bigint(200) DEFAULT NULL,
  `telefono_5` bigint(200) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `domicilio` varchar(255) DEFAULT NULL,
  `localidad` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados`
--

CREATE TABLE `estados` (
  `id` int(255) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `email` varchar(255) NOT NULL,
  `contraseña` varchar(255) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `acciones`
--
ALTER TABLE `acciones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `descripcion` (`descripcion`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`cuit`),
  ADD UNIQUE KEY `razon_social` (`razon_social`);

--
-- Indices de la tabla `deuda`
--
ALTER TABLE `deuda`
  ADD PRIMARY KEY (`SIGA_id`),
  ADD KEY `fk_nombredeudor` (`deudor_nombreyapellido`),
  ADD KEY `fk_dnideudor` (`deudor_dni`),
  ADD KEY `fk_estadotipo` (`estado_tipo`),
  ADD KEY `fk_deudacliente` (`deuda_cliente`),
  ADD KEY `fk_acciones` (`accion_programada`);

--
-- Indices de la tabla `deudor`
--
ALTER TABLE `deudor`
  ADD PRIMARY KEY (`dni`),
  ADD UNIQUE KEY `nombreyapellido` (`nombreyapellido`),
  ADD UNIQUE KEY `telefono_1` (`telefono_1`),
  ADD UNIQUE KEY `telefono_2` (`telefono_2`),
  ADD UNIQUE KEY `telefono_3` (`telefono_3`),
  ADD UNIQUE KEY `telefono_4` (`telefono_4`),
  ADD UNIQUE KEY `telefono_5` (`telefono_5`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `domicilio` (`domicilio`,`localidad`);

--
-- Indices de la tabla `estados`
--
ALTER TABLE `estados`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `descripcion` (`descripcion`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `acciones`
--
ALTER TABLE `acciones`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estados`
--
ALTER TABLE `estados`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `deuda`
--
ALTER TABLE `deuda`
  ADD CONSTRAINT `fk_acciones` FOREIGN KEY (`accion_programada`) REFERENCES `acciones` (`descripcion`),
  ADD CONSTRAINT `fk_deudacliente` FOREIGN KEY (`deuda_cliente`) REFERENCES `clientes` (`razon_social`),
  ADD CONSTRAINT `fk_dnideudor` FOREIGN KEY (`deudor_dni`) REFERENCES `deudor` (`dni`),
  ADD CONSTRAINT `fk_estadotipo` FOREIGN KEY (`estado_tipo`) REFERENCES `estados` (`descripcion`),
  ADD CONSTRAINT `fk_nombredeudor` FOREIGN KEY (`deudor_nombreyapellido`) REFERENCES `deudor` (`nombreyapellido`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
