# Ejercicios ER → Relacional → SQL

Implementación en MySQL de 5 modelos entidad-relación.  
Cada base de datos incluye claves primarias, foráneas, relaciones N/M con atributos, herencia y entidades débiles.

---

## Tecnologías

- MySQL 8.4.9  
- Git + GitHub  

---

## Estructura del repositorio
.
├── README.md
└── sql/
└── esquemas_completos.sql # Script único con todas las bases y tablas

text

---

## Bases de datos implementadas

| Base              | Tablas | Características clave                          |
|-------------------|--------|------------------------------------------------|
| discografica      | 4      | Relación N/M `artista_evento`                  |
| tienda_informatica| 5      | N/M con fecha (`compra`), N/M (`suministra`)   |
| discos_musicales  | 5      | N/M `disco_cancion` con atributo `posicion`    |
| transporte_camiones| 5     | N/M `conduce` con fecha en PK                  |
| clinica_veterinaria| 8     | Herencia, entidad débil con ON DELETE CASCADE  |

---

## Modelo relacional resumido

### discografica
- `manager(id_manager PK, nombre)`
- `artista(nif PK, nombre_completo, id_manager FK)`
- `evento_promocion(id_evento PK, fecha_celebracion, num_asistentes)`
- `artista_evento(nif_artista PK FK, id_evento PK FK)`  → N/M

### tienda_informatica
- `cliente(codigo_cliente PK, nombre, apellidos, direccion, telefono)`
- `producto(codigo_producto PK, descripcion, precio, num_existencias)`
- `proveedor(codigo_proveedor PK, nombre, apellidos, direccion, provincia, telefono)`
- `compra(codigo_cliente PK FK, codigo_producto PK FK, fecha PK)` → N/M con fecha
- `suministra(codigo_proveedor PK FK, codigo_producto PK FK)` → N/M

### discos_musicales
- `genero(id_genero PK, nombre_genero)`
- `cantante(id_cantante PK, nombre, pais)`
- `disco(id_disco PK, titulo, precio, id_genero FK, id_cantante FK)`
- `cancion(id_cancion PK, titulo)`
- `disco_cancion(id_disco PK FK, id_cancion PK FK, posicion)` → N/M con atributo

### transporte_camiones
- `provincia(codigo_provincia PK, nombre)`
- `camionero(cedula PK, nombre, telefono, direccion, salario, poblacion)`
- `camion(matricula PK, modelo, tipo, potencia)`
- `paquete(codigo_paquete PK, descripcion, destinatario, direccion_destinatario, cedula_camionero FK, codigo_provincia FK)`
- `conduce(matricula PK FK, cedula_camionero PK FK, fecha PK)` → N/M con fecha

### clinica_veterinaria
- `propietario(cedula PK, apellidos, nombres, direccion, telefonos)`
- `familiar_contacto(cedula_familiar PK, nombre, telefono, cedula_propietario FK UNIQUE, ON DELETE CASCADE)` → débil
- `mascota(id_mascota PK, nombre, fecha_nacimiento, tipo, cedula_propietario FK)`
- `personal(codigo_personal PK, cedula UNIQUE, nombre, tipo_personal)`
- `veterinario(codigo_personal PK FK, fecha_alta, especialidad)` → herencia
- `auxiliar(codigo_personal PK FK, base_cotizacion)` → herencia
- `consulta(id_mascota PK FK, codigo_vet PK FK, fecha PK, diagnostico)` → N/M con atributos

---

## Instalación y uso

```bash
# Clonar
git clone https://github.com/alejrs7/-Ejercicios-ER-Relacional-SQL.git

# Entrar a MySQL
mysql -u root -p

# Ejecutar script
source sql/esquemas_completos.sql;
