# Pytest

* Pytest es un marco de pruebas para Python que permite escribir pruebas de manera sencilla y efectiva. Es ampliamente utilizado en la comunidad de Python debido a su flexibilidad y facilidad de uso. Aquí te presento algunas características clave de pytest, así como instrucciones para su instalación usando pip.

* **Características** 

    * **Simplicidad:** Permite escribir pruebas de manera sencilla utilizando funciones simples en lugar de clases complejas.
    * **Soporte para pruebas de unidad y funcionales:** Puedes usar pytest para realizar tanto pruebas unitarias como pruebas funcionales.
    * **Fixtures:** Proporciona un sistema de fixtures que permite configurar y limpiar el entorno de prueba de manera eficiente.
    * **Asserts mejorados:** Utiliza la declaración assert de Python, proporcionando mensajes de error más claros y detallados cuando una prueba falla.
    * **Plugins:** Tiene una arquitectura de plugins que permite extender su funcionalidad. Hay muchos plugins disponibles para diferentes necesidades.
    * **Compatibilidad:** Es compatible con otros marcos de pruebas, como unittest y nose, lo que facilita la migración.
    * **Ejecutar pruebas en paralelo:** Con el plugin pytest-xdist, puedes ejecutar pruebas en paralelo para mejorar el rendimiento.


* **Instalacion**

```bash
# Instalacion de pytest
pip install pytest
# Instalacion para cliete HTTP para realizar solicitudes a la API
pip install httpx
```

* **Comados**

    1. Ejecutar pruebas en el directorio actual:

        ```bash
        pytest
        ```
        *   Este comando buscará automáticamente archivos que comiencen con test_ o terminen con _test.py y ejecutará las funciones de prueba que comiencen con test_.
    
    2. Ejecutar pruebas en un archivo específico:

        ```bash
        pytest nombre_del_archivo.py
        ```
        *   Esto ejecutará solo las pruebas en el archivo especificado.

    3. Ejecutar pruebas en un directorio específico:

        ```bash
        pytest nombre_del_directorio/
        ```
        * Esto ejecutará todas las pruebas en el directorio especificado.

    4. Mostrar detalles de las pruebas:

        ```bash
        pytest -v
        ```
        * La opción -v (verbose) proporciona una salida más detallada sobre las pruebas que se están ejecutando.

    5. Ejecutar pruebas y detenerse en el primer error:

        ```bash
        pytest -x
        ```
        * Esto detendrá la ejecución de pruebas tan pronto como se encuentre un error.

    6. Ejecutar pruebas que fallaron en la última ejecución:

        ```bash
        pytest --lf
        ```
        * La opción --lf (last failed) ejecuta solo las pruebas que fallaron en la última ejecución.

    7. Ejecutar pruebas marcadas con un marcador específico:

        ```bash
        pytest -m "nombre_del_marcador"
        ```
        * Esto ejecutará solo las pruebas que tienen el marcador especificado.

    8. Mostrar la salida de impresión durante las pruebas:

        ```bash
        pytest -s
        ```
        * La opción -s permite que se muestre la salida de print() y otras salidas estándar durante la ejecución de las pruebas.

    9. Generar un informe de cobertura:

        ```bash
        pytest --cov=nombre_del_paquete
        ```
        * Esto generará un informe de cobertura para el paquete especificado. Necesitarás instalar el paquete pytest-cov para usar esta opción.

    10. Ejecutar pruebas en paralelo:

        ```bash
        pytest -n NUMERO_DE_HILOS
        ```
        * Esto ejecutará las pruebas en paralelo utilizando el número de hilos especificado. Necesitarás instalar el paquete pytest-xdist para usar esta opción.