# rn

Trabajo Práctico Integrador de la cursada 2020 de la materia Taller de Tecnologías de Producción de Software - Opción Ruby, de la Facultad de Informática
de la Universidad Nacional de La Plata.

Ruby Notes, o simplemente `rn`, es un gestor de notas concebido como un clon simplificado
de la excelente herramienta [TomBoy](https://wiki.gnome.org/Apps/Tomboy).


## Uso de `rn`

Para ejecutar el comando principal de la herramienta se utiliza el script `bin/rn`, el cual
puede correrse de las siguientes manera:

```bash
$ ruby bin/rn [args]
```

O bien:

```bash
$ bundle exec bin/rn [args]
```

O simplemente:

```bash
$ bin/rn [args]
```

Si se agrega el directorio `bin/` del proyecto a la variable de ambiente `PATH` de la shell,
el comando puede utilizarse sin prefijar `bin/`:

```bash
# Esto debe ejecutarse estando ubicad@ en el directorio raiz del proyecto, una única vez
# por sesión de la shell
$ export PATH="$(pwd)/bin:$PATH"
$ rn [args]
```

> Notá que para la ejecución de la herramienta, es necesario tener una versión reciente de
> Ruby (2.5 o posterior) y tener instaladas sus dependencias, las cuales se manejan con
> Bundler. Para más información sobre la instalación de las dependencias, consultar la sección ("Desarrollo").

### Estructura para escribir las notas


Las almohadillas "#" son uno de los métodos utilizados en Markdown para crear encabezados, añadiendo de a una por nivel, es decir
```
# Encabezado 1
## Encabezado 2
### Encabezado 3
#### Encabezado 4
##### Encabezado 5
###### Encabezado 6
```
Las citas se generar utilizando el carácter mayor que ">" al comienzo del bloque de texto. Si la cita en cuestión se compone de varios párrafos, deberás añadir el mismo símbolo > al comienzo de cada uno de ellos e incluso se pueden concatenar varios >> para crear citas anidadas.

>"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."

Para crear listas desordenadas se utiliza __*__ asteriscos, __-__ guiones, o __+__ símbolo de suma.

```
- Elemento de lista 1
* Elemento de lista 2
+ Elemento de lista 3
```

#### Elementos de enfasis:

`*cursiva*` o `_cursiva_` // *cursiva*

`**negrita**` o `__negrita__` // **negrita**


### Exportacion de notas

Para realizar la exportacion de notas se utiliza el siguiente comando:

`  rn notes export_html  `

El cual acepta distintos tipos de parametros, los cuales son:

-  `--title "pago de servicios"`
-  `--title "pago de servicios" --book "cuentas"`
- `--all`
- `--all --book "cuentas"`

La exportacion de una nota generará un archivo con extension `.html` en el mismo lugar donde la/las notas originales esten presentes


## Desarrollo

### Instalación de dependencias

Este proyecto utiliza Bundler para manejar sus dependencias. Si aún no sabés qué es eso
o cómo usarlo, no te preocupes: ¡lo vamos a ver en breve en la materia! Mientras tanto,
todo lo que necesitás saber es que Bundler se encarga de instalar las dependencias ("gemas")
que tu proyecto tenga declaradas en su archivo `Gemfile` al ejecutar el siguiente comando:

```bash
$ bundle install
```

> Nota: Bundler debería estar disponible en tu instalación de Ruby, pero si por algún
> motivo al intentar ejecutar el comando `bundle` obtenés un error indicando que no se
> encuentra el comando, podés instalarlo mediante el siguiente comando:
>
> ```bash
> $ gem install bundler
> ```

Una vez que la instalación de las dependencias sea exitosa (esto deberías hacerlo solamente
cuando estés comenzando con la utilización del proyecto), podés comenzar a probar la
herramienta y a desarrollar tu entrega.

### Estructura del proyecto

* `lib/`: directorio que contiene todas las clases del modelo y de soporte para la ejecución
  del programa `bin/rn`.
  * `lib/rn.rb` es la declaración del namespace `RN`, y las directivas de carga de clases
    o módulos que estén contenidos directamente por éste (`autoload`).
  * `lib/rn/` es el directorio que representa el namespace `RN`. Notá la convención de que
    el uso de un módulo como namespace se refleja en la estructura de archivos del proyecto
    como un directorio con el mismo nombre que el archivo `.rb` que define el módulo, pero
    sin la terminación `.rb`. Dentro de este directorio se ubicarán los elementos del
    proyecto que estén bajo el namespace `RN` - que, también por convención y para facilitar
    la organización, deberían ser todos. Es en este directorio donde deberías ubicar tus
    clases de modelo, módulos, clases de soporte, etc. Tené en cuenta que para que todo
    funcione correctamente, seguramente debas agregar nuevas directivas de carga en la
    definición del namespace `RN` (o dónde corresponda, según tus decisiones de diseño).
  * `lib/rn/commands.rb` y `lib/rn/commands/*.rb` son las definiciones de comandos de
    `dry-cli` que se utilizarán. En estos archivos es donde comenzarás a realizar la
    implementación de las operaciones en sí, que en esta plantilla están provistas como
    simples disparadores.
  * `lib/rn/version.rb` define la versión de la herramienta, utilizando [SemVer](https://semver.org/lang/es/).
* `bin/`: directorio donde reside cualquier archivo ejecutable, siendo el más notorio `rn`
  que se utiliza como punto de entrada para el uso de la herramienta.
