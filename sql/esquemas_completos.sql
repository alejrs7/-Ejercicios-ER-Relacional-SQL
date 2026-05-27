-- ============================================================
-- 1. BASE: discografica
-- ============================================================
CREATE DATABASE discografica;
USE discografica;

CREATE TABLE MANAGER (
    id_manager   INT          PRIMARY KEY,
    nombre       VARCHAR(100) NOT NULL
);

CREATE TABLE ARTISTA (
    nif             VARCHAR(20)  PRIMARY KEY,
    nombre_completo VARCHAR(150) NOT NULL,
    id_manager      INT          NOT NULL,
    FOREIGN KEY (id_manager) REFERENCES MANAGER(id_manager)
);

CREATE TABLE EVENTO_PROMOCION (
    id_evento         INT  PRIMARY KEY,
    fecha_celebracion DATE NOT NULL,
    num_asistentes    INT
);

CREATE TABLE ARTISTA_EVENTO (
    nif_artista VARCHAR(20) NOT NULL,
    id_evento   INT         NOT NULL,
    PRIMARY KEY (nif_artista, id_evento),
    FOREIGN KEY (nif_artista) REFERENCES ARTISTA(nif),
    FOREIGN KEY (id_evento)   REFERENCES EVENTO_PROMOCION(id_evento)
);

-- ============================================================
-- 2. BASE: tienda_informatica
-- ============================================================
CREATE DATABASE tienda_informatica;
USE tienda_informatica;

CREATE TABLE PRODUCTO (
    codigo_producto INT           PRIMARY KEY,
    descripcion     VARCHAR(200),
    precio          DECIMAL(10,2) NOT NULL,
    num_existencias INT           DEFAULT 0
);

CREATE TABLE CLIENTE (
    codigo_cliente INT          PRIMARY KEY,
    nombre         VARCHAR(100) NOT NULL,
    apellidos      VARCHAR(150) NOT NULL,
    direccion      VARCHAR(200),
    telefono       VARCHAR(20)
);

CREATE TABLE PROVEEDOR (
    codigo_proveedor INT          PRIMARY KEY,
    nombre           VARCHAR(100) NOT NULL,
    apellidos        VARCHAR(150),
    direccion        VARCHAR(200),
    provincia        VARCHAR(100),
    telefono         VARCHAR(20)
);

CREATE TABLE COMPRA (
    codigo_cliente  INT  NOT NULL,
    codigo_producto INT  NOT NULL,
    fecha           DATE NOT NULL,
    PRIMARY KEY (codigo_cliente, codigo_producto, fecha),
    FOREIGN KEY (codigo_cliente)  REFERENCES CLIENTE(codigo_cliente),
    FOREIGN KEY (codigo_producto) REFERENCES PRODUCTO(codigo_producto)
);

CREATE TABLE SUMINISTRA (
    codigo_proveedor INT NOT NULL,
    codigo_producto  INT NOT NULL,
    PRIMARY KEY (codigo_proveedor, codigo_producto),
    FOREIGN KEY (codigo_proveedor) REFERENCES PROVEEDOR(codigo_proveedor),
    FOREIGN KEY (codigo_producto)  REFERENCES PRODUCTO(codigo_producto)
);

-- ============================================================
-- 3. BASE: discos_musicales
-- ============================================================
CREATE DATABASE discos_musicales;
USE discos_musicales;

CREATE TABLE GENERO (
    id_genero     INT          PRIMARY KEY,
    nombre_genero VARCHAR(100) NOT NULL
);

CREATE TABLE CANTANTE (
    id_cantante INT          PRIMARY KEY,
    nombre      VARCHAR(150) NOT NULL,
    pais        VARCHAR(100)
);

CREATE TABLE DISCO (
    id_disco    INT           PRIMARY KEY,
    titulo      VARCHAR(200)  NOT NULL,
    precio      DECIMAL(10,2),
    id_genero   INT           NOT NULL,
    id_cantante INT           NOT NULL,
    FOREIGN KEY (id_genero)   REFERENCES GENERO(id_genero),
    FOREIGN KEY (id_cantante) REFERENCES CANTANTE(id_cantante)
);

CREATE TABLE CANCION (
    id_cancion INT          PRIMARY KEY,
    titulo     VARCHAR(200) NOT NULL
);

CREATE TABLE DISCO_CANCION (
    id_disco   INT NOT NULL,
    id_cancion INT NOT NULL,
    posicion   INT NOT NULL,
    PRIMARY KEY (id_disco, id_cancion),
    FOREIGN KEY (id_disco)   REFERENCES DISCO(id_disco),
    FOREIGN KEY (id_cancion) REFERENCES CANCION(id_cancion)
);

-- ============================================================
-- 4. BASE: transporte_camiones
-- ============================================================
CREATE DATABASE transporte_camiones;
USE transporte_camiones;

CREATE TABLE PROVINCIA (
    codigo_provincia INT          PRIMARY KEY,
    nombre           VARCHAR(100) NOT NULL
);

CREATE TABLE CAMIONERO (
    cedula    VARCHAR(20)   PRIMARY KEY,
    nombre    VARCHAR(150)  NOT NULL,
    telefono  VARCHAR(20),
    direccion VARCHAR(200),
    salario   DECIMAL(10,2),
    poblacion VARCHAR(100)
);

CREATE TABLE CAMION (
    matricula VARCHAR(10)  PRIMARY KEY,
    modelo    VARCHAR(100),
    tipo      VARCHAR(50),
    potencia  INT
);

CREATE TABLE PAQUETE (
    codigo_paquete         INT         PRIMARY KEY,
    descripcion            VARCHAR(200),
    destinatario           VARCHAR(150),
    direccion_destinatario VARCHAR(200),
    cedula_camionero       VARCHAR(20) NOT NULL,
    codigo_provincia       INT         NOT NULL,
    FOREIGN KEY (cedula_camionero) REFERENCES CAMIONERO(cedula),
    FOREIGN KEY (codigo_provincia) REFERENCES PROVINCIA(codigo_provincia)
);

CREATE TABLE CONDUCE (
    matricula        VARCHAR(10) NOT NULL,
    cedula_camionero VARCHAR(20) NOT NULL,
    fecha            DATE        NOT NULL,
    PRIMARY KEY (matricula, cedula_camionero, fecha),
    FOREIGN KEY (matricula)        REFERENCES CAMION(matricula),
    FOREIGN KEY (cedula_camionero) REFERENCES CAMIONERO(cedula)
);

-- ============================================================
-- 5. BASE: clinica_veterinaria
-- ============================================================
CREATE DATABASE clinica_veterinaria;
USE clinica_veterinaria;

CREATE TABLE PROPIETARIO (
    cedula    VARCHAR(20)  PRIMARY KEY,
    apellidos VARCHAR(150) NOT NULL,
    nombres   VARCHAR(150) NOT NULL,
    direccion VARCHAR(200),
    telefonos VARCHAR(50)
);

CREATE TABLE FAMILIAR_CONTACTO (
    cedula_familiar    VARCHAR(20)  PRIMARY KEY,
    nombre             VARCHAR(150) NOT NULL,
    telefono           VARCHAR(20),
    cedula_propietario VARCHAR(20)  NOT NULL UNIQUE,
    FOREIGN KEY (cedula_propietario)
        REFERENCES PROPIETARIO(cedula)
        ON DELETE CASCADE
);

CREATE TABLE MASCOTA (
    id_mascota         INT          PRIMARY KEY,
    nombre             VARCHAR(100) NOT NULL,
    fecha_nacimiento   DATE,
    tipo               VARCHAR(50),
    cedula_propietario VARCHAR(20)  NOT NULL,
    FOREIGN KEY (cedula_propietario) REFERENCES PROPIETARIO(cedula)
);

CREATE TABLE PERSONAL (
    codigo_personal INT          PRIMARY KEY,
    cedula          VARCHAR(20)  UNIQUE NOT NULL,
    nombre          VARCHAR(150) NOT NULL,
    tipo_personal   VARCHAR(20)  NOT NULL
);

CREATE TABLE VETERINARIO (
    codigo_personal INT          PRIMARY KEY,
    fecha_alta      DATE,
    especialidad    VARCHAR(100),
    FOREIGN KEY (codigo_personal) REFERENCES PERSONAL(codigo_personal)
);

CREATE TABLE AUXILIAR (
    codigo_personal INT            PRIMARY KEY,
    base_cotizacion DECIMAL(10,2),
    FOREIGN KEY (codigo_personal) REFERENCES PERSONAL(codigo_personal)
);

CREATE TABLE CONSULTA (
    id_mascota  INT  NOT NULL,
    codigo_vet  INT  NOT NULL,
    fecha       DATE NOT NULL,
    diagnostico TEXT,
    PRIMARY KEY (id_mascota, codigo_vet, fecha),
    FOREIGN KEY (id_mascota) REFERENCES MASCOTA(id_mascota),
    FOREIGN KEY (codigo_vet) REFERENCES VETERINARIO(codigo_personal)
);
