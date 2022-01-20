

Profile:        PacienteCl
Parent:         Patient
Id:             CorePacienteCl
Title:          "Perfil Paciente Para Core Nacional"
Description:    "Este Perfil ha sido desarrollado para cubrir las necesidades del Caso de Uso de Receta Electrónica. Sin embargo, se ha modelado con el fin de cubrir las necesidades nacionales de un Recurso Paciente para un Historial Clínico Nacional"




* extension contains PaisOrigenNacionalidadCl named nacionalidad 0..1   


* extension ^short = "Extensión de Nacionalidad para pacientes extranjeros"
* extension ^definition = "Para hacer uso de esta extensión se debe agregar el path: extension.url = ´nacionalidad´"

//* extension[nacionalidad].valueCodeableConcept from  CodPaises  
//* extension.valueCodeableConcept.coding.system ^short = "El sistema de códigos queda definido en la norma ISO3166-1-N"
//* extension.valueCodeableConcept.coding.system ^definition = "El sistema de códigos queda definido en la norma ISO3166-1-N, en donde el código sería el numero correspondiente designado para el país"
//* extension MS


* identifier  and identifier.use   and identifier.type and identifier.extension  MS

* identifier ^short = "Listados de Id de Paciente. De poseer una CI con RUN vigente, este DEBE ser ingresado"
* identifier ^definition = "Este es el listado de Identificaciones de un paciente. Se procura como R2 el RUN, pero en caso de no existir ese identificador se debe ocupar otro nacional u otro otorgado por país extranjero"
* identifier ^comment = "En caso de que el paciente posea una CI con número RUN válido, este debe ser ingresado como identificador, independiente de que tenga otros identificadores, los cuales también pueden ser ingresados. La identificación implica el ingreso del tipo de documento, el país de origen de ese documento y ev valor del identificador"

* identifier 1..* 
* identifier.use ^short = "usual | official | temp | secondary | old (If known)"
* identifier.use ^definition = "Se definirá este uso siempre como ´official´ debido a que cualquier ID presentado para motivos de este perfil deb ser de este tipo"
* identifier.use = #official 
* identifier.use ^comment = "Se definirá como official pues en una primera etapa solo se considerarán los identidicadores en esa categoría. Para una segunda etapa se abrirá este elemento para cualquier clase de identificador" 


* identifier.type ^short = "Tipo de documento de Id (Extensible)"
* identifier.type ^definition = "Se define como tipo de documento de Id, aquel definido en el Sistema de Codificación V2-0203 de Hl7. Este sistema es extensible. Para pacientes sin documeto local deben especificar el de origen. Pacientes sin Id, deben usar el código MR = Local Medical Record, es decir numero del registro clínico abierto en el establecimiento"
* identifier.type ^comment = "De haber RUN, este se debe usar. De haber Run temporal, se debe usar ese identificador. Pacientes sin identificador Chileno deben usar su CI o Pasaporte de origen. Pacientes sin identificación se debe registrar con el numero de registro clínico generado en el recinto de salud"
//* identifier.type.coding.system from  http://terminology.hl7.org/ValueSet/v2-0203 (extensible)
* identifier.type.coding.system ^short = "Sistema de identificación de tipos de documentos"
* identifier.type.coding.system ^definition = "Sistema mediante el cual se obtienen los códigos para un determinado tipo de documento"
* identifier.type.coding.system ^comment = "En la URL del sistema se describe el set de códigos. Por ejemplo si se desea usar Cédula de identidad el código es NNxxx en donde xxx corresponde al identificador del país según la norma iso3166-1-N. Dado lo anterior si fuera Chile, el tipo de documento sería NNCL. En el Caso de Usar un Pasaporte este no requiere identificar país de origen dado que este es un elemento adicional, por lo que independiente del país el código será PPT según el VS indicado"

* identifier.type.coding.code ^short = "Código de Tipo de Documento"
* identifier.type.coding.code ^definition = "Código de Tipo de Documento"
* identifier.type.coding.code from VSTiposDocumentos

* identifier.type.extension ^short = "País de Origen del Documento de Id" 


* identifier.type.extension ^definition = "Se usa esta extensión para agregarle al tipo de documento el país de origen de este" 
* identifier.type.extension contains PaisOrigenNacionalidadCl named paises 1..1  
//* identifier.type.extension[paises] from CodPaises (required)



* name ^slicing.discriminator.type = #value
* name ^slicing.discriminator.path = "use"
* name ^slicing.rules = #open
* name ^slicing.description = "Este slice se genera para diferenciar el nombre registrado Versus el nombre social"
* name contains NombreOficial 1..1 MS and NombreSocial 0..1 MS

* name ^short = "Nombres y Apellidos del Paciente considerando, según el caso: 1er Nombre, Nombres, 1er Apellido y 2o Apellido"
* name ^definition = "Nombre del Paciente considerando, según el caso: 1er Nombre, Nombres, 1er Apellido y 2o Apellido"

* name[NombreOficial] ^short = "Determinación del nombre registrado oficialmente del Paciente"
* name[NombreOficial] ^definition = "Determinación del nombre registrado oficialmente del Paciente"
* name[NombreOficial].use = #official
* name[NombreOficial].use ^short = "uso del nombre del paciente"
* name[NombreOficial].use ^definition = "este slice corresponde al nombre registrado al momento de nacer, por lo que se fuerza el valor ´official´"
* name[NombreOficial].use ^comment = "Para ser considerado como el slice determinado para el uso de nombre completo, el use DEBE ser de valor de código ´official´"
* name[NombreOficial].family ^short = "1er Apellido"
* name[NombreOficial].family ^definition = "Se define el primer apellido registrado al momento de nacer o aquel que se ha inscrito legalmente en el Registro Civil"
* name[NombreOficial].family 1..1
* name[NombreOficial].family.extension contains http://hl7.org/fhir/StructureDefinition/humanname-mothers-family named mothers-family 0..1
* name[NombreOficial].family.extension ^short = "Extensión para 2o apellido"
* name[NombreOficial].family.extension ^definition = "Extensión para la declaracion de un segundo apellido"
* name[NombreOficial].given 1..
* name[NombreOficial].given ^short = "Primer nombre y nombres del Paciente"
* name[NombreOficial].given ^definition = "Todos los nombres de los pacientes no necesariamente solo el Primer Nombre"

* name[NombreSocial] ^short = "Nombre con el cual se identifica al paciente sin ser este oficial. Se especifica slo en el uso del nombre"
* name[NombreSocial] ^definition = "Nombre con el cual se identifica al paciente sin ser este oficial. Se especifica slo en el uso del nombre"
* name[NombreSocial] ^short = "nombre recurrente que usa el paciente"
* name[NombreSocial].use = #usual
* name[NombreSocial].use ^short = "uso que se le da al nombre"
* name[NombreSocial].use ^definition = "Este uso especifico se enfoca a la definición de un nombre social. Es por esta razón que el uso se fuerza a usual"
* name[NombreSocial].use ^comment = "Para ser considerado como el slice determinado para el uso de nombre social, el use DEBE ser de valor de código ´usual´"
* name[NombreSocial].text 0..0  
* name[NombreSocial].family 0..0
* name[NombreSocial].given 1..*
* name[NombreSocial].given ^short = "Nombre Social"
* name[NombreSocial].given ^definition = "Nombre Social"
* name[NombreSocial].prefix 0..0
* name[NombreSocial].suffix 0..0
* name[NombreSocial].period 0..0
 
 
* telecom and gender and birthDate  MS
* telecom ^short = "Detalles de contacto del Paciente"
* telecom ^definition = "Detalles del contacto de un paciente comunmente el o los mas usados (Ej: Teléfono fijo, móvil, email, etc.)"
* telecom.use ^short = "home | work | temp | old | mobile" 
* telecom.use ^definition = "Propósito para el contacto que se ha definido" 
* telecom.use from  http://hl7.org/fhir/ValueSet/contact-point-use (required)
* telecom.system ^short = "phone | fax | email | pager | url | sms | other"
* telecom.system ^definition = "Forma de telecomunicación para el punto de contacto: qué sistema de comunicación se requiere para hacer uso del contacto."
* telecom.system from  http://hl7.org/fhir/ValueSet/contact-point-system (required)
* telecom.value ^short = "Dato del contato del paciente descrito"
* telecom.value ^definition = "Valor del contacto como por ejemplo el numero de telefono fijo o de móvil o el email del Paciente"

* gender 1..1
* gender ^short = "Sexo de nacimiento Registrado, male | female | other | unknown (requerido)"
* gender ^definition = "Sexo de nacimiento Registrado"

* birthDate 1..1
* birthDate ^short = "Fecha de nacimiento del Paciente. El formato debe ser YYYY-MM-DD"
* birthDate ^definition = "Fecha de nacimiento del Paciente. El formato debe ser YYYY-MM-DD (Ej: 1996-08-21)"

* address and address.use and address.line and address.city and address.district and address.state and address.country MS
* address ^short = "Dirección del paciente"
* address ^definition = "Se definirá la dirección en una línea y se podría codificar en city la comuna, en district la provincia y en state la región"
* address.use 1..1
* address.use ^short = "Definición del tipo de domicilio home | work | temp | old (requerido)"
* address.use ^definition = "Se especifica el tipo de dirección notificada. Esto debe ser segun los códigos definidos por HL7 FHIR"
* address.line ^short = "Calle o avenida, numero y casa o depto"
* address.line ^definition = "Aquí se escribe toda la dirección completa"
* address.city ^short = "Campo para Comuna de residencia"
* address.city ^definition = "Campo para Comuna de residencia. Se usa el valueSet de códigos de comunas definidos a nivel naciona."
* address.city from VSCodigosComunaCL (required)
* address.district ^short = "Campo para Provincia de Residencia"
* address.district ^definition = "Campo para Provincia de Residencia. Se usa el valueSet de códigos de provicias definidos a nivel naciona."
* address.district from VSCodigosProvinciasCL (required)
* address.state ^short = "Campo para la Región"
* address.state ^definition = "Campo Región. Se usa el valueSet de códigos de regiones definidos a nivel naciona."
* address.state from VSCodigosRegionesCL (required)
* address.country ^short = "Campo para País de Residencia"
* address.country ^definition = "Campo para País de Residencia"
* address.country from CodPaises (required)



Extension:   PaisOrigenNacionalidadCl
Id:          CodigoPaises
Title:       "Codigo de Identificación de países"
Description: "Esta extensión incluye códigos de paises de origen"
* value[x] only CodeableConcept
* value[x] ^short = "Código de País"
* valueCodeableConcept.coding.system from CodPaises (extensible)


 
  
	Instance : PacienteCL
	Title : "Ejemplo de Recurso Paciente Nacional"
	Description: "Paciente ficticio nacional CI Chilena, sin sistema de validación ´http://regcivil.cl/Validacion/RUN´ ficticio , cuyo nombre se decribe mediante el oficial y uno social. La dirección tampoco es Real"
	InstanceOf : CorePacienteCl
	Usage : #example

	 
	//Identificación por Cédula Chilena
* identifier.use = #official    //obligado
* identifier.type.extension[paises].valueCodeableConcept.coding.system =  "urn:iso:std:iso:3166"
* identifier.type.extension[paises].valueCodeableConcept.coding.code = #152
* identifier.type.extension[paises].valueCodeableConcept.coding.display = "Chile"
* identifier.type.coding.system = "https://hl7chile.cl/fhir/ig/CoreCL/CodeSystem/CSCodigoDNI"
* identifier.type.coding.code = #NNCHL
* identifier.type.coding.display = "Chile"

* identifier.system = "http://regcivil.cl/Validacion/RUN"
* identifier.value = "15.236.327-k"

//registro de paciente activo
* active = true

//Nombre Oficial
* name[NombreOficial].use = #official
* name[NombreOficial].family = "Rosales"
* name[NombreOficial].family.extension[mothers-family].valueString	 = "Bosh" //uso de la extensión
* name[NombreOficial].given = "Marietta"
* name.given[1] = "María"
* name.given[2] = "Ximena"

//nombre social
* name[NombreSocial].use = #usual
* name[NombreSocial].given = "Xime"

//dos contactos, un celular y un email
* telecom.system = #phone
* telecom.use = #mobile
* telecom.value = "943561833"

* telecom[1].system = #email
* telecom[1].use = #work
* telecom[1].value = "mariRosal@mimail.com"

//sexo registrado al nacer y fecha de nacimiento
* gender = #female
* birthDate = "1983-03-24"

// Una sola dirección
* address.use = #home
* address.line = "Av Los Chirimoyos, 32, casa 4"
* address.city = "05101"  //codigo de comuna por binding (valpo)
* address.district = "051"  //codigo de provincia por binding (valpo)
* address.state = "05" //codigo por binding region (valparaiso)

* address.country = #152


Instance : PacienteCL2
Title : "Ejemplo de Recurso Paciente Extranjero"
Description: "Paciente ficticio extrangero, con identificación Pasaporte de origen Salvadoreño sin sistema real de validación del número de Pasaporte."
InstanceOf : CorePacienteCl
Usage : #example

// Nacionalidad por medio de la extensión
* extension[nacionalidad].valueCodeableConcept.coding.system = "urn:iso:std:iso:3166"
* extension[nacionalidad].valueCodeableConcept.coding.code = #222
* extension[nacionalidad].valueCodeableConcept.coding.display = "El Salvador"

 
//Identificación por Pasaporte Salvadoreño
* identifier.use = #official    //obligado
* identifier.type.extension[paises].valueCodeableConcept.coding.system = "urn:iso:std:iso:3166"
* identifier.type.extension[paises].valueCodeableConcept.coding.code = #222
* identifier.type.extension[paises].valueCodeableConcept.coding.display = "El Salvador"
* identifier.type.coding.system = "http://terminology.hl7.org/CodeSystem/v2-0203"
* identifier.type.coding.code = #PPN
* identifier.type.coding.display = "Passport number"
* identifier.system = "http://Pasaportes.cl/Validacion/Pass"
* identifier.value = "P3334521.2"


//registro de paciente activo
* active = true

//Nombre Oficial
* name[NombreOficial].use = #official
* name[NombreOficial].family = "Cabrales"
* name[NombreOficial].family.extension[mothers-family].valueString = "Rivas"
* name[NombreOficial].given = "Wilmer"
* name[NombreOficial].given[1] = "Andres"
* name[NombreOficial].given[2] = "de Dios"


//un contactos, un email

* telecom.system = #email
* telecom.use = #home
* telecom.value = "wilCAB12l@wilmermail.com"

//sexo registrado al nacer y fecha de nacimiento
* gender = #male
* birthDate = "1968-11-03"



// Una sola dirección
* address.use = #temp
* address.line = "Calle 4 Norte, 52, pieza 802"
* address.city = "15101"  //codigo de comuna por binding (Arica)
* address.district = "151"  //codigo de comuna por binding (Arica)
* address.state = "15" //codigo por binding region (Arica)
* address.country = #152

 
Instance: PacienteCl-3
InstanceOf: CorePacienteCl
Description: "Paciente ficticio nacional CI Chilena con sistema de validación no real, cuyo nombre es solo el oficial. La dirección tampoco es Real"
Title : "Paciente Nacional, con datos actualizados, declarando nacionalidad"
Usage: #example

* meta.versionId = "2"
* meta.lastUpdated = "2021-07-13T00:22:41.166Z"

* extension[nacionalidad].valueCodeableConcept.coding.system = "urn:iso:std:iso:3166"
* extension[nacionalidad].valueCodeableConcept.coding.code = #152
* extension[nacionalidad].valueCodeableConcept.coding.display = "Chile"

* identifier.use = #official
* identifier.type.extension[paises].valueCodeableConcept.coding.system = "urn:iso:std:iso:3166"
* identifier.type.extension[paises].valueCodeableConcept.coding.code = #152
* identifier.type.extension[paises].valueCodeableConcept.coding.display = "Chile"
* identifier.type.coding.system = "https://hl7chile.cl/fhir/ig/CoreCL/CodeSystem/CSCodigoDNI"
* identifier.type.coding.code = #NNCHL
* identifier.type.coding.display = "Chile"
* identifier.system = "http://regcivil.cl/Validacion/RUN"
* identifier.value = "15602754-5"

* active = true
* name[NombreOficial].use = #official
* name[NombreOficial].family = "PIZARRO"

* name[NombreOficial].family.extension[mothers-family].valueString = "DELGADO" //uso de la extensión

* name[NombreOficial].given[0] = "PABLO"
* name[NombreOficial].given[+] = "RODRIGO"

* telecom.system = #email
* telecom.value = "ppizarro.delgado@minsal.cl"
* telecom.use = #work

* gender = #male
* birthDate = "1983-08-04"

* address.use = #home
* address.city = "13120"
* address.district = "131"
* address.state = "13"
* address.country = #152
* deceasedBoolean = false 








/* Instance : OperationDefinition
Title : "$match"
InstanceOf :  OperationDefinition
Usage: #definition

* url = "http://hl7.org/fhir/OperationDefinition/Patient-match"
* version = "4.0.1"

* name = "$match"
* title = "Operacion $match para encuentro del paciente en MPI"
* status = #active
* kind = #operation
* description = "Un índice maestro de pacientes (MPI ) es un servicio utilizado para gestionar la identificación de pacientes en un contexto en el que existen múltiples bases de datos de pacientes. 

Las aplicaciones sanitarias y el middleware utilizan el MPI para cotejar los pacientes entre las bases de datos y para almacenar los datos de los nuevos pacientes a medida que se encuentran. 

Los MPI son aplicaciones muy especializadas, que a menudo se adaptan ampliamente a la combinación particular de pacientes de la institución. Las IPM también pueden funcionar a nivel regional y nacional.Para pedir a un MPI que haga coincidir un paciente, los clientes utilizan la operación $match, que acepta un recurso de paciente que puede estar sólo parcialmente completo. 

Los datos proporcionados se interpretan como una entrada MPI y son procesados por un algoritmo de algún tipo que utiliza los datos para determinar las coincidencias más apropiadas en el conjunto de pacientes. Tenga en cuenta que los diferentes algoritmos de emparejamiento MPI tienen diferentes entradas requeridas. La operación genérica $match no especifica ningún algoritmo en particular, ni un conjunto mínimo de información que debe proporcionarse cuando se pide que se realice una operación de coincidencia MPI, pero muchas implementaciones tendrán un conjunto de información mínima, que puede declararse en su definición de la operación $match especificando un perfil en el parámetro del recurso, indicando qué propiedades se requieren en la búsqueda. El recurso del paciente enviado a la operación no tiene que estar completo, ni tiene que pasar la validación (es decir, los campos obligatorios no tienen que ser rellenados), pero sí tiene que ser una instancia válida, ya que se utiliza como los datos de referencia para comparar."

* code = #match

* comment = "La respuesta de una consulta ¨MPI¨ es un conjunto que contiene registros de pacientes, ordenados de más a menos probable. Si no hay coincidencias de pacientes, el MPI DEBERÁ devolver un conjunto de búsqueda vacío sin error, pero puede incluir un resultado de la operación con más consejos sobre la selección de pacientes. Todos los registros de pacientes TIENEN una puntuación de búsqueda de 0 a 1, donde 1 es la coincidencia más segura, junto con una extensión ¨match-grade¨ que indica la posición del MPI en la calidad de la coincidencia."
* system = false
* type = true
* instance = false

* resource = #Patient

* parameter.name = #resource
* parameter.use = #in
* parameter.min = 1
* parameter.max = "1"
* parameter.documentation = "Utilícelo para proporcionar un conjunto completo de datos de pacientes para que el IPM los compare (por ejemplo, envíe un registro de pacientes a Patient/$match)."
* parameter.type = #Resource

* parameter[1].name = #onlyCertainMatches
* parameter[1].use = #in
* parameter[1].min = 0
* parameter[1].max = "1"
* parameter[1].documentation = "Si hay múltiples coincidencias potenciales, entonces la coincidencia no debería devolver los resultados con esta bandera establecida en true.  Cuando es falso, el servidor puede devolver múltiples resultados con cada resultado calificado en consecuencia."
* parameter[1].type = #boolean

* parameter[2].name = #count
* parameter[2].use = #in
* parameter[2].min = 0
* parameter[2].max = "1"
* parameter[2].documentation = "El número máximo de registros a devolver. Si no se proporciona ningún valor, el servidor decide cuántas coincidencias devolver. Tenga en cuenta que los clientes deben tener cuidado al usar esto, ya que puede impedir que se devuelvan coincidencias probables -y válidas-."
* parameter[2].type = #integer

* parameter[3].name = #return
* parameter[3].use = #out
* parameter[3].min = 1
* parameter[3].max = "1"
* parameter[3].documentation = "Un paquete contiene un conjunto de registros de pacientes que representan posibles coincidencias, 
    opcionalmente puede contener también un OperationOutcome con más información sobre los resultados de la búsqueda 
	(como advertencias o mensajes informativos, por ejemplo, un recuento de los registros que estaban cerca pero fueron eliminados) 
	Si la operación no tiene éxito, se puede devolver un OperationOutcome junto con un código de estado BadRequest 
	(por ejemplo, un problema de seguridad, o propiedades insuficientes en el fragmento del paciente - comprobar con el perfil)"
* parameter[3].type = #Bundle




Instance : Operation
Title : "$everything"
InstanceOf :  OperationDefinition
Usage: #definition

* url = "http://hl7.org/fhir/OperationDefinition/Patient-everything"
* version = "4.0.1"

* name = "$everything"
* title = "Operacion $everything: Encuentro de Información de Pacientes"
* status = #draft

* kind = #operation

* description = "Las principales diferencias entre esta operación y la simple búsqueda en el compartimento del paciente son

•	A menos que el cliente solicite lo contrario, el servidor devuelve todo el conjunto de resultados en un solo paquete (en lugar de utilizar la paginación)

•	Al servidor es responsable de determinar qué recursos debe devolver como recursos incluidos (en lugar de que el cliente especifique cuáles).
Esto libera al cliente de la necesidad de determinar lo que podría o debería pedir, especialmente en lo que respecta a los recursos incluidos. Los servidores deben considerar la devolución de Provenance y AuditTrail apropiados en los recursos devueltos, aunque éstos no formen parte directamente del compartimento del paciente.

Se supone que el servidor ha identificado y asegurado el contexto adecuadamente, y puede asociar el contexto de autorización con un único paciente, o determinar si el contexto tiene los derechos del paciente nominado, si lo hay, o puede determinar una lista apropiada de pacientes para los que proporcionar datos a partir del contexto de la solicitud. Si no hay un paciente nominado (GET /Patient/$everything) y el contexto no está asociado a un único registro de paciente, la lista real de pacientes es la de todos los pacientes a los que el usuario asociado a la solicitud tiene acceso. Puede tratarse de todos los pacientes de la familia a los que el paciente tiene acceso, o puede tratarse de todos los pacientes a los que un proveedor de atención tiene acceso, o de todos los pacientes del sistema de registros completo. En estos casos, el servidor puede optar por devolver un error en lugar de todos los registros. La especificación de la relación entre el contexto, un usuario y los registros de los pacientes está fuera del alcance de esta especificación (aunque véase la guía de implementación de Smart App Launch.

Cuando esta operación se utiliza para acceder a varios registros de pacientes a la vez, el paquete de retorno podría ser bastante grande; los servidores pueden optar por exigir que dichas solicitudes se realicen de forma asíncrona y se asocien a formatos de datos masivos. Por otra parte, los clientes pueden optar por hojear el conjunto de resultados (o los servidores pueden exigirlo). La paginación de los resultados se realiza de la misma manera que la búsqueda, utilizando el parámetro _count y los enlaces Bundle. Los implementadores deben tener en cuenta que la paginación será más lenta que la simple devolución de todos los resultados a la vez (más tráfico de red, múltiples retrasos de latencia), pero puede ser necesaria para no agotar la memoria disponible leyendo o escribiendo toda la respuesta en un solo paquete. A diferencia de la búsqueda, no hay un orden inherente al usuario para la operación $everything. Los servidores pueden considerar la posibilidad de ordenar los recursos devueltos en orden descendente de la última actualización del registro, pero no están obligados a hacerlo.

El parámetro *since se proporciona para soportar consultas periódicas para obtener información adicional que ha cambiado sobre el paciente desde la última consulta. Esto significa que el parámetro _since se basa en la hora del registro. El valor del parámetro *since debe ajustarse a la hora del servidor. Si se utiliza la respuesta directa, se trata de la marca de tiempo en la cabecera de la respuesta. Si se utiliza la interfaz asíncrona, se trata de la marca de tiempo de la transacción en la respuesta json. Los servidores deben asegurarse de que las marcas de tiempo se gestionen de forma que el cliente no pierda ningún cambio. Los clientes deben ser capaces de obtener la misma respuesta más de una vez en el caso de que la transacción caiga en un límite de tiempo. Los clientes deben asegurarse de que los demás parámetros de consulta sean constantes para garantizar un conjunto coherente de registros al realizar consultas periódicas."		 
   
* code = #everything

* comment = "principales diferencias entre esta operación y la simple búsqueda en el compartimento del paciente son

•	A menos que el cliente solicite lo contrario, el servidor devuelve todo el conjunto de resultados en un solo paquete (en lugar de utilizar la paginación)

•	El servidor es responsable de determinar qué recursos debe devolver como recursos incluidos (en lugar de que el cliente especifique cuáles).
Esto libera al cliente de la necesidad de determinar lo que podría o debería pedir, especialmente en lo que respecta a los recursos incluidos. Los servidores deben considerar la devolución de Provenance y AuditTrail apropiados en los recursos devueltos, aunque éstos no formen parte directamente del compartimento del paciente.

Se supone que el servidor ha identificado y asegurado el contexto adecuadamente, y puede asociar el contexto de autorización con un único paciente, o determinar si el contexto tiene los derechos del paciente nominado, si lo hay, o puede determinar una lista apropiada de pacientes para los que proporcionar datos a partir del contexto de la solicitud. Si no hay un paciente nominado (GET /Patient/$everything) y el contexto no está asociado a un único registro de paciente, la lista real de pacientes es la de todos los pacientes a los que el usuario asociado a la solicitud tiene acceso. Puede tratarse de todos los pacientes de la familia a los que el paciente tiene acceso, o puede tratarse de todos los pacientes a los que un proveedor de atención tiene acceso, o de todos los pacientes del sistema de registros completo. En estos casos, el servidor puede optar por devolver un error en lugar de todos los registros. La especificación de la relación entre el contexto, un usuario y los registros de los pacientes está fuera del alcance de esta especificación (aunque véase la guía de implementación de Smart App Launch.

Cuando esta operación se utiliza para acceder a varios registros de pacientes a la vez, el paquete de retorno podría ser bastante grande; los servidores pueden optar por exigir que dichas solicitudes se realicen de forma asíncrona y se asocien a formatos de datos masivos. Por otra parte, los clientes pueden optar por hojear el conjunto de resultados (o los servidores pueden exigirlo). La paginación de los resultados se realiza de la misma manera que la búsqueda, utilizando el parámetro _count y los enlaces Bundle. Los implementadores deben tener en cuenta que la paginación será más lenta que la simple devolución de todos los resultados a la vez (más tráfico de red, múltiples retrasos de latencia), pero puede ser necesaria para no agotar la memoria disponible leyendo o escribiendo toda la respuesta en un solo paquete. A diferencia de la búsqueda, no hay un orden inherente al usuario para la operación $everything. Los servidores pueden considerar la posibilidad de ordenar los recursos devueltos en orden descendente de la última actualización del registro, pero no están obligados a hacerlo.

El parámetro *since se proporciona para soportar consultas periódicas para obtener información adicional que ha cambiado sobre el paciente desde la última consulta. Esto significa que el parámetro _since se basa en la hora del registro. El valor del parámetro *since debe ajustarse a la hora del servidor. Si se utiliza la respuesta directa, se trata de la marca de tiempo en la cabecera de la respuesta. Si se utiliza la interfaz asíncrona, se trata de la marca de tiempo de la transacción en la respuesta json. Los servidores deben asegurarse de que las marcas de tiempo se gestionen de forma que el cliente no pierda ningún cambio. Los clientes deben ser capaces de obtener la misma respuesta más de una vez en el caso de que la transacción caiga en un límite de tiempo. Los clientes deben asegurarse de que los demás parámetros de consulta sean constantes para garantizar un conjunto coherente de registros al realizar consultas periódicas."

* system = false

* type = true
* instance = true

* resource = #Patient

* parameter.name = #start
* parameter.use = #in
* parameter.min = 0
* parameter.max = "1"
* parameter.documentation = "El intervalo de fechas se refiere a las fechas de la atención, no a las fechas de la moneda del registro; por ejemplo, todos los registros relativos a la atención prestada en un determinado intervalo de fechas. Si no se proporciona una fecha de inicio, todos los registros anteriores a la fecha de finalización están en el ámbito de aplicación."
* parameter.type = #date


* parameter[1].name = #end
* parameter[1].use = #in
* parameter[1].min = 0
* parameter[1].max = "1"
* parameter[1].documentation = "El intervalo de fechas se refiere a las fechas de la atención, no a las fechas de la moneda del registro; por ejemplo, todos los registros relativos a la atención prestada en un determinado intervalo de fechas. Si no se proporciona una fecha de finalización, todos los registros posteriores a la fecha de inicio están en el ámbito de aplicación."
* parameter[1].type = #date

* parameter[2].name = #_since
* parameter[2].use = #in
* parameter[2].min = 0
* parameter[2].max = "1"
* parameter[2].documentation = "Los recursos actualizados después de este periodo se incluirán en la respuesta. La intención de este parámetro es permitir que un cliente solicite sólo los registros que han cambiado desde la última solicitud, basándose en la hora de la cabecera de retorno, o (para uso asíncrono), la hora de la transacción"
* parameter[2].type = #instant

* parameter[3].name = #_type
* parameter[3].use = #in
* parameter[3].min = 0
* parameter[3].max = "1"
* parameter[3].documentation = "Uno o más parámetros, cada uno de los cuales contiene uno o más tipos de recursos FHIR delimitados por comas para incluirlos en los recursos devueltos. En ausencia de tipos especificados, el servidor devuelve todos los tipos de recursos"
* parameter[3].type = #code

* parameter[4].name = #count
* parameter[4].use = #in
* parameter[4].min = 0
* parameter[4].max = "1"
* parameter[4].documentation = "Véase la discusión más abajo sobre la utilidad de paginar los resultados de la operación $everything"
* parameter[4].type = #integer

* parameter[5].name = #return
* parameter[5].use = #out
* parameter[5].min = 1
* parameter[5].max = "1"
* parameter[5].documentation = "El tipo de Bundle es searchset"
* parameter[5].type = #Bundle
*/

