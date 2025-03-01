Feature: US02 - Inicio de sesión en la plataforma
  Como usuario registrado, quiero poder iniciar sesión en la plataforma, 
  para acceder a mi cuenta y sus funcionalidades.

  # Escenario 1: Opción de Inicio de Sesión
  Scenario: Visualización de la opción de Inicio de Sesión
    Given el [Usuario] tiene una cuenta registrada en la plataforma
    When el [Usuario] selecciona la opción [Iniciar Sesión]
    Then el sistema muestra la sección [Iniciar Sesión]
    And se muestran los campos [Usuario] y [Contraseña]
    And se muestran las opciones de ingreso con otra cuenta (Facebook, Google, Apple)

    Examples:
              |Iniciar Sesión|               |Registrarse|  
              
                            |Iniciar Sesión|  
          |Iniciar Sesión|                  |Cuenta Externa|
      | Usuario      | XXXXXX |                | Apple    |      
      | Contraseña   | XXXXXX |       | Facebook |      | Google  |
          | Iniciar Sesión |

  # Escenario 2: Inicio de sesión con credenciales válidas
  Scenario: Inicio de sesión exitoso con credenciales válidas
    Given el [Usuario] está en la sección [Iniciar Sesión] con los campos [Usuario] y [Contraseña]
    And el sistema muestra opciones de ingreso con otra cuenta (Facebook, Google, Apple)
    When el [Usuario] completa los campos con credenciales válidas 
    And selecciona la opción [Iniciar Sesión]
    Then el sistema valida las credenciales
    And redirige al [Usuario] al menú principal

    Examples:
              |Iniciar Sesión|                    |Cuenta Externa|
      | Usuario      | UsuarioPrueba |                |  Apple  |      
      | Contraseña   | 123456        |       | Facebook |      | Google  |
             | Iniciar Sesión |

    |Mensaje|
    |Validación Exitosa|

    |Menú principal|

  # Escenario 3: Inicio de sesión fallido por credenciales incorrectas
  Scenario: Error de inicio de sesión por credenciales incorrectas
    Given el [Usuario] está en la sección [Iniciar Sesión] e ingresa 
          alguna credencial incorrecta (“Usuario” o “Contraseña”)
    When el [Usuario] selecciona la opción [Iniciar Sesión]
    Then el sistema muestra un mensaje de error con el texto "Credenciales incorrectas, 
                                                             por favor intente nuevamente"
    And muestra los campos completados erróneamente junto con mensajes de ayuda para corregirlos

    Examples:
              |Iniciar Sesión|                   
      | Usuario      | UsuarioPrueba   |   |X|
      | Contraseña   | 142156          |   |X|
             | Iniciar Sesión |

    |Mensaje|
    |"Credenciales incorrectas, por favor intente nuevamente"|


  # Escenario 4: Inicio de sesión con otra cuenta
  Scenario: Inicio de sesión mediante una cuenta externa
    Given el [Usuario] está en la sección [Iniciar Sesión] con los campos [Usuario] y [Contraseña]
    And el sistema muestra opciones de ingreso con otra cuenta (Facebook, Google, Apple)
    When el [Usuario] selecciona otra cuenta e ingresa sus datos de la cuenta externa
    Then el sistema valida la cuenta externa
    And redirige al [Usuario] al menú principal

    Examples:
              |Iniciar Sesión|                    |Cuenta Externa|
      | Usuario      | XXXXXXXXXXXXX |                |  Apple  |      
      | Contraseña   | XXXXXX        |       | Facebook |      | Google  |

              |Cuenta Externa|
      |Google|                 
        | Correo Electronico | UsuarioPrueba@gmail.com |       
        | Contraseña         | ContraseñaSecreta       |      



---------
Feature: US01 - Registro de nuevas cuentas de usuario
  Como usuario nuevo no registrado en la plataforma, quiero poder crear una cuenta nueva, 
  para poder acceder a las funcionalidades exclusivas.

  # Escenario 1: Opción de Registro
  Scenario: Visualización de la opción de Registro en la plataforma
    Given el [Usuario] no registrado se encuentra en la página principal
    When el [Usuario] no registrado selecciona la opción [Inicar Sesión]
    Then el sistema abre la sección [Crear Cuenta]
    And se muestran los campos a completar como [Nombre], [Correo electrónico”], 
        [Número de Celular], [Contraseña]

    Examples:
    |Página Principal|
      | Usuario       | Acción                      | Resultado Esperado                       |
      |---------------|-----------------------------|------------------------------------------|
      | No registrado | Seleccionar "Iniciar Sesión"| Se abre la sección "Crear Cuenta"        |
      | No registrado | Ver campos disponibles      | Se muestran los campos: [Nombre], [Correo electrónico], 
                                                                          [Número de Celular], [Contraseña]|

  # Escenario 2: Registro de una cuenta nueva con información válida
  Scenario: Registro exitoso con información válida
    Given el [Usuario] no registrado está en la sección [Crear Cuenta] con los campos [Nombre], 
          [Correo electrónico”], [Número de Celular], [Contraseña]
    And el sistema muestra opciones de registro con otra cuenta (Facebook, Google, Apple)
    When el [Usuario] no registrado completa los campos [Nombre], [Correo electrónico”], 
         [Número de Celular], [Contraseña] con información válida
    And acepta los términos de servicio y la política de privacidad
    Then el sistema genera un código de verificación enviado por SMS o email

     Examples:
     |Crear Cuenta|
                |Crear Cuenta|                             |Cuenta Externa|
       | Nombre             | XXXXXXXXXXXXX |                 | Apple |
       | Correo Electronico | XXXXXXXXXXXXX |       | Facebook |      | Google  |
       | Número de Celular  | XXXXXXXXXXXXX |
       | Contraseña         | XXXXXXXXXXXXX |

       | OK |  "Acepta los términos de servicio y la política de privacidad" |
           
                | Código de Verificación Enviado por Email |

  # Escenario 3: Verificación de cuenta a través de código y creación de cuenta
  Scenario: Verificación de cuenta con código válido
    Given el sistema ha enviado un código de verificación por correo o SMS
    When el [Usuario] no registrado ingresa el código de verificación válido
    And hace clic en [Verificar]
    Then el sistema confirma la creación de la cuenta mostrando el mensaje "Cuenta creada con éxito"
    And redirige al [Usuario] a la página de [Inicio Sesión]

    Examples:
      | Código de Verificación |
      | 123456                 |
            | Verificar |

       | "Cuenta creada con éxito" |
              |Inicio Sesión|


  # Escenario 4: Registro de una cuenta nueva con información no válida
  Scenario: Error en el registro por información no válida
    Given el [Usuario] no registrado está en la sección [Crear Cuenta] con los campos [Nombre], 
          [Correo electrónico”], [Número de Celular], [Contraseña]
    And el sistema muestra opciones de registro con otra cuenta (Facebook, Google, Apple)
    When el [Usuario] no registrado completa alguno de los campos con información no válida
    And acepta o no los términos de servicio y la política de privacidad
    Then el sistema muestra el mensaje "Error"
    And muestra los campos completados erróneamente junto con mensajes de ayuda para corregirlos

    Examples:
     |Crear Cuenta|
                |Crear Cuenta|                                                                 
       | Nombre             | 1213123123133 | |X| |No se permiten numeros|                         
       | Correo Electronico | prueba1201233 | |X| |No se encontro correo electronico|   
       | Número de Celular  | 4343434       | |X| |Coloque su numero telefonico con 9 digitos|
       | Contraseña         | XXXXXXXXXXXXX |
     
     |Cuenta Externa|
          |Apple|
    |Facebook|Google|
      
      |Mensaje: Error!|

  # Escenario 5: Opción de Registro con cuentas externas
  Scenario: Registro mediante cuenta externa
    Given el [Usuario] no registrado está en la sección [Crear Cuenta] con los campos [Nombre], 
          [Correo electrónico”], [Número de Celular], [Contraseña]
    And el sistema muestra opciones de registro con otra cuenta (Facebook, Google, Apple)
    When el [Usuario] no registrado selecciona cualquier otra cuenta externa
    Then el sistema abre una pantalla para el registro con la cuenta seleccionada

    Examples:
     |Crear Cuenta|
                |Crear Cuenta|                             |Cuenta Externa|
       | Nombre             | XXXXXXXXXXXXX |                 | Apple |
       | Correo Electronico | XXXXXXXXXXXXX |         | Facebook |   | Google  |
       | Número de Celular  | XXXXXXXXXXXXX | 
       | Contraseña         | XXXXXXXXXXXXX | 

      | Cuenta Externa |
         | Facebook          |  
         | Google            |  |OK|
         | Apple             |

      |Google|
             | Correo Electronico | XXXXXXXXXXXXX | 
             | Contraseña         | XXXXXXXXXXXXX |  


---------------
Feature: US05 - Adaptabilidad a dispositivos
  Como usuario, quiero que la plataforma sea adaptable a diferentes dispositivos, 
  para acceder a las funcionalidades de manera óptima en cualquier entorno.

  # Escenario 1: Ajuste automático del diseño según el dispositivo
  Scenario: Ajuste de diseño para diferentes dispositivos
    Given que el [Usuario] accede a la plataforma desde cualquier dispositivo
    When el sistema detecta el tamaño de la pantalla
    Then el diseño de la plataforma se ajusta automáticamente para adaptarse al dispositivo

       Examples:
      | Usuario         | TipoDispositivo | Resolución          | DiseñoAjustado                |
      | UsuarioMóvil    | Móvil           | 360x640             | Diseño móvil                  |
      | UsuarioTablet   | Tableta         | 768x1024            | Diseño adaptado para tableta  |
      | UsuarioDesktop  | Computadora     | 1920x1080           | Diseño de pantalla completa   |

-------------------------
Feature: US22 - Contactar con Soporte
  Como usuario, quiero poder contactar con el equipo de soporte para recibir asistencia 
  frente a cualquier inconveniente dentro de la plataforma.

  # Escenario 1: Sección Soporte
  Scenario: Acceso a la sección de soporte
    Given que el [Usuario] ha iniciado sesión en la plataforma
    When el [Usuario] selecciona [Soporte] en el menú principal
    Then el sistema muestra las opciones de [Comunicarse con IA ROTROT], [Centro de Ayuda]
    And el sistema muestra el formulario [Contacta con soporte]

    Examples:
    |Soporte|
       |Comunicarse con IA ROTROT|
       |Centro de Ayuda          |

          |Centro de Ayuda|
            |1. Identificacion del cliente|
              |Nombre Completo| |Direccion|
              |Tipo Documento | |Numero Documento|
              |Correo Electronico| |Telefono|
            |2. Detalle del Problema|
             |Asunto|
               |Detalles del Problema que presenta|

  # Escenario 2: Envío de solicitud de soporte
  Scenario: Envío exitoso de solicitud de soporte
    Given que el [Usuario] está en la sección [Soporte] con el formulario [Contacta con soporte]
    When el [Usuario] completa los campos con datos válidos
    And el [Usuario] selecciona [Enviar formulario]
    Then el sistema envía la solicitud al equipo de soporte
    And el sistema muestra un mensaje de confirmación indicando que la solicitud ha sido recibida
    Examples:
    |Centro de Ayuda|
                    |1. Identificacion del cliente|
              |Nombre Completo: Franco Leandro Ochoa Lopez| 
              |Direccion: Av.Las violetas 126|
              |Tipo Documento: DNI | 
              |Numero Documento: 72164314|
              |Correo Electronico: U202316350@upc.edu.pe| 
              |Telefono: 982666205|
                         |Enviar Formulario|
               |La solicitud ha sido recibida con exito.|

  # Escenario 3: Error en envío de solicitud de soporte
  Scenario: Error en el envío de solicitud de soporte por datos no válidos
    Given que el [Usuario] está en la sección [Soporte] con el formulario [Contacta con soporte]
    When el [Usuario] completa algunos campos con datos no válidos
    And el [Usuario] selecciona [Enviar formulario]
    Then el sistema muestra un mensaje de [Error en el llenado]
    And el sistema muestra la opción para [Volver a llenar]
    And el sistema indica los campos completados erróneamente con mensajes de cómo corregirlos
    Examples:
    |Centro de Ayuda|
                    |1. Identificacion del cliente|
              |Nombre Completo: Fr123co 35 Och2oa Lopez| |X| |No se permiten numeros|
              |Direccion: 12francoleandro| |X| |Direccion no encontrada|
              |Tipo Documento: DNI |  
              |Numero Documento: 724314| |X| |debe contener 8 digitos|
              |Correo Electronico: U202316350upc.edu.pe|  |X| 
              |Telefono: 9826205| |X| |debe contener 9 digitos| 
                         |Enviar Formulario|
               |Volver a llenar los campos con el formato indicado.|