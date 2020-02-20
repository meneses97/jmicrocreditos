/*
 Navicat Premium Data Transfer

 Source Server         : db
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : localhost:3306
 Source Schema         : jmicrocreditos

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : 65001

 Date: 20/02/2020 16:42:17
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bem
-- ----------------------------
DROP TABLE IF EXISTS `bem`;
CREATE TABLE `bem`  (
  `idbem` int(32) NOT NULL AUTO_INCREMENT,
  `descricao` char(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `idcredito` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idbem`) USING BTREE,
  INDEX `FK_bem_credito`(`idcredito`) USING BTREE,
  CONSTRAINT `FK_bem_credito` FOREIGN KEY (`idcredito`) REFERENCES `credito` (`idcredito`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bem
-- ----------------------------
INSERT INTO `bem` VALUES (1, 'Carro', NULL);

-- ----------------------------
-- Table structure for cliente
-- ----------------------------
DROP TABLE IF EXISTS `cliente`;
CREATE TABLE `cliente`  (
  `idcliente` int(32) NOT NULL,
  `estadocivil` int(32) NULL DEFAULT NULL,
  `nr_bi` char(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `iddistrito` int(32) NULL DEFAULT NULL,
  `linhaendereco1` char(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `linhaendereco2` char(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `contacto1` char(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `contacto2` char(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `sexo` char(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`idcliente`) USING BTREE,
  INDEX `cliente_iddistrito_fkey`(`iddistrito`) USING BTREE,
  CONSTRAINT `cliente_idcliente_fkey` FOREIGN KEY (`idcliente`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `cliente_iddistrito_fkey` FOREIGN KEY (`iddistrito`) REFERENCES `distrito` (`ididstrito`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for credito
-- ----------------------------
DROP TABLE IF EXISTS `credito`;
CREATE TABLE `credito`  (
  `idcredito` int(32) NOT NULL AUTO_INCREMENT,
  `valor` double NOT NULL,
  `data_emprestimo` date NOT NULL,
  `data_pagamento` date NOT NULL,
  `nr_max_pag` int(32) NOT NULL,
  `idcliente` int(32) NOT NULL,
  `idtipocredito` int(32) NULL DEFAULT NULL,
  `idestado` bigint(64) NULL DEFAULT NULL,
  PRIMARY KEY (`idcredito`) USING BTREE,
  INDEX `credito_idcliente_fkey`(`idcliente`) USING BTREE,
  INDEX `credito_idestado_fkey`(`idestado`) USING BTREE,
  INDEX `credito_idtipocredito_fkey`(`idtipocredito`) USING BTREE,
  CONSTRAINT `credito_idcliente_fkey` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idcliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `credito_idestado_fkey` FOREIGN KEY (`idestado`) REFERENCES `estado` (`idestado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `credito_idtipocredito_fkey` FOREIGN KEY (`idtipocredito`) REFERENCES `tipocredito` (`idcrecredito`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for creditoconsumo
-- ----------------------------
DROP TABLE IF EXISTS `creditoconsumo`;
CREATE TABLE `creditoconsumo`  (
  `idcredito` int(32) NOT NULL,
  `declaracoaservico` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `bi` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `extratobancario` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `cartaobancario` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`idcredito`) USING BTREE,
  CONSTRAINT `creditoconsumo_ibfk_1` FOREIGN KEY (`idcredito`) REFERENCES `credito` (`idcredito`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for creditojuro
-- ----------------------------
DROP TABLE IF EXISTS `creditojuro`;
CREATE TABLE `creditojuro`  (
  `idjuro` int(32) NOT NULL,
  `idcredito` int(32) NOT NULL,
  PRIMARY KEY (`idcredito`, `idjuro`) USING BTREE,
  INDEX `idjuro`(`idjuro`) USING BTREE,
  CONSTRAINT `credito_juro_idcredito_fkey` FOREIGN KEY (`idcredito`) REFERENCES `credito` (`idcredito`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `creditojuro_ibfk_1` FOREIGN KEY (`idjuro`) REFERENCES `juro` (`idjuros`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for creditonegocio
-- ----------------------------
DROP TABLE IF EXISTS `creditonegocio`;
CREATE TABLE `creditonegocio`  (
  `idcredito` int(255) NOT NULL,
  `declaracaobairro` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `bempenhor` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `testemunha 1` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `testemunha2` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`idcredito`) USING BTREE,
  CONSTRAINT `creditonegocio_ibfk_1` FOREIGN KEY (`idcredito`) REFERENCES `credito` (`idcredito`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for creditopenhor
-- ----------------------------
DROP TABLE IF EXISTS `creditopenhor`;
CREATE TABLE `creditopenhor`  (
  `idcredito` int(11) NOT NULL,
  `declaracaopenhor` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `titulopropriedade` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`idcredito`) USING BTREE,
  CONSTRAINT `FK_creditopenhor_credito` FOREIGN KEY (`idcredito`) REFERENCES `credito` (`idcredito`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for distrito
-- ----------------------------
DROP TABLE IF EXISTS `distrito`;
CREATE TABLE `distrito`  (
  `ididstrito` int(32) NOT NULL AUTO_INCREMENT,
  `descricao` char(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `idprovincia` int(32) NOT NULL,
  PRIMARY KEY (`ididstrito`) USING BTREE,
  INDEX `distrito_idprovincia_fkey`(`idprovincia`) USING BTREE,
  CONSTRAINT `distrito_idprovincia_fkey` FOREIGN KEY (`idprovincia`) REFERENCES `provincia` (`idprovincia`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for estado
-- ----------------------------
DROP TABLE IF EXISTS `estado`;
CREATE TABLE `estado`  (
  `idestado` bigint(64) NOT NULL AUTO_INCREMENT,
  `status` char(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`idestado`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for funcionario
-- ----------------------------
DROP TABLE IF EXISTS `funcionario`;
CREATE TABLE `funcionario`  (
  `idfuncionario` int(32) NOT NULL AUTO_INCREMENT,
  `funcao` char(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `instituicao` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `contacto1` char(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `contacto2` char(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `director` char(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `endereco` char(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`idfuncionario`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for historicopagamento
-- ----------------------------
DROP TABLE IF EXISTS `historicopagamento`;
CREATE TABLE `historicopagamento`  (
  `idcredito` int(32) NOT NULL,
  `idmodopagamento` int(32) NOT NULL,
  `data` date NOT NULL,
  `valor` double NOT NULL,
  `ordem` int(32) NOT NULL,
  PRIMARY KEY (`idmodopagamento`, `idcredito`) USING BTREE,
  INDEX `historico_pagamento_idcredito_fkey`(`idcredito`) USING BTREE,
  CONSTRAINT `historico_pagamento_idcredito_fkey` FOREIGN KEY (`idcredito`) REFERENCES `credito` (`idcredito`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `historico_pagamento_idmodopagamento_fkey` FOREIGN KEY (`idmodopagamento`) REFERENCES `modopagamento` (`idmodo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for juro
-- ----------------------------
DROP TABLE IF EXISTS `juro`;
CREATE TABLE `juro`  (
  `percentagem` double NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 0,
  `idjuros` int(255) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idjuros`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for modopagamento
-- ----------------------------
DROP TABLE IF EXISTS `modopagamento`;
CREATE TABLE `modopagamento`  (
  `idmodo` int(32) NOT NULL DEFAULT 0,
  `descricao` char(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`idmodo`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for provincia
-- ----------------------------
DROP TABLE IF EXISTS `provincia`;
CREATE TABLE `provincia`  (
  `idprovincia` int(32) NOT NULL AUTO_INCREMENT,
  `descricao` char(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`idprovincia`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `role_id` int(32) NOT NULL,
  `role` char(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tipocredito
-- ----------------------------
DROP TABLE IF EXISTS `tipocredito`;
CREATE TABLE `tipocredito`  (
  `idcrecredito` int(32) NOT NULL DEFAULT 0,
  `descricao` char(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `grupoalvo` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`idcrecredito`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `active` int(32) NULL DEFAULT NULL,
  `email` char(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `name` char(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `password` char(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `user_id` int(32) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `user_id` int(32) NOT NULL,
  `role_id` int(32) NOT NULL,
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE,
  UNIQUE INDEX `uk_it77eq964jhfqtu54081ebtio`(`role_id`) USING BTREE,
  CONSTRAINT `fka68196081fvovjhkek5m97n3y` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_role_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
