---
layout: post
title: "Velocity Barcelona Dia 2"
modified:
categories: articles
excerpt:
tags: [conferences, velocityconf]
image:
  feature:
date: 2014-12-01T07:05:17-03:00
---

# Segundo Día

## [Upgrading the Web: Polyfills, Components and the Future of Web Development at Scale](http://velocityconf.com/velocityeu2014/public/schedule/detail/37693)

La charla giró en torno a un producto creado por la empresa del ponente: FT Labs y Fastly que hace la vida mas fácil para los diseñadores y programadores al mismo tiempo que a los encargados de asegurar el performance de la aplicación web.
Empezó hablando de [Origami](http://origami.ft.com/) un estándar de componentes para la creación del frontend de sitios web. Una de las ventajas de su implementación fue la reducción de esfuerzos duplicados a la hora de mantener distintas versiones de un mismo sitio.

Estos componentes utilizan tecnologías que no siempre están presentes en todos los navegadores, como por ejemplo funcionalidades de HTML 5, para suplir esto se utilizan los polyfills. Los polyfills son código que se descargan, implementan esas tecnologías y le permiten a las viejas versiones de los navegadores poder mostrar una página creada con los últimos estandares web.

Para facilitar servir los polyfills, crearon un [servicio](https://cdn.polyfill.io/) que a través  de la CDN de Fastly sirve estos polyfills on demand. De manera automática, en base al <code>User-Agent</code> prepara selectivamente y envia el paquete de polyfills que necesita ese navegador para completar las funcionalidades que le estarían faltando.

Más info [aquí](http://labs.ft.com/2014/09/polyfills-as-a-service/)

[Github Repository](https://github.com/financial-times/polyfill-service)

[Slides](http://cdn.oreillystatic.com/en/assets/1/event/121/Upgrading%20the%20Web_%20Polyfills,%20Components%20and%20the%20Future%20of%20Web%20Development%20at%20Scale%20Presentation.pdf)

## [Monitoring without Alerts - and Why it Makes Way More Sense than You Might Think](http://velocityconf.com/velocityeu2014/public/schedule/detail/39064)

Traza que no vas a mirar, no la loguees. Las trazas generan alertas. No por tener más alertas vamos a resolver mejor los problemas. Además, para ser realmente efectiva, la alerta necesita un contexto. Presentó el producto de su compañia que permite todo esto. El demo esta disponible en el sitio web http://ruxit.com

## [Velocity at GitHub](http://velocityconf.com/velocityeu2014/public/schedule/detail/39131)

Chicos, Github enterprise esta disponible en Amazon AWS.

Ah, y los logos son muy divertidos.

## [Lightning Demos](http://velocityconf.com/velocityeu2014/public/schedule/detail/37195)

Ilya Grigorik de Google mostró como analizar volumenes de datos utilizando BigQuery y Google Cloud Dataflow. Como base de datos utilizo el HTTP Archive, que contiene mas de 300K sitios web y archiva los archivos descargados de los mismos. 
En el sitio http://bigqueri.es se pueden armar sentencias de búsqueda en un lenguaje similar al SQL pero con expresiones regulares y encontrar por ejemplo, una clasificación en base a los tiempos de cache de la páginas que están utilizando los sitios móbiles. Hay ejemplos de búsquedas ya creadas en el sitio a manera de guía de la potencialidad de esta herramienta.

La parte divertida vino a continuación. A partir de un [proyecto](http://geeksta.net/geeklog/exploring-expressions-emotions-github-commit-messages/) que analizaba las emociones de los programadores de cada lenguaje a partir del análisis de los commits en Github, realizó un experimento similar en base a los códigos HTML, CSS y JavaScript. ¿Que relevancia tiene esto en una conferencia sobre rendimiento de sitios web? Que las mismas búsquedas se pueden aplicar a encontrar, por ejemplo, de que maneras estan cargando el codigo JavaScript los sitios. Esto ya es algo con un impacto directo en el rendimiento del sitio. Spoiler: los resultados no fueron muy buenos, casi nadie usa async o defer :(

[Sitio web de Ilya Grigorik](https://www.igvita.com/) (tiene cosas muy buenas, vale la pena echarle un vistazo)

El segundo demo fue de [OpenSpeedMonitor](https://github.com/IteraSpeed/OpenSpeedMonitor), una herramienta opensource que automatiza la medición del rendimiento de páginas web, basado en [webpagetest](http://www.webpagetest.org/). 

Ambas presentaciones estuvieron buenas, el [Video](http://www.youtube.com/watch?v=_CMcaYnBt-g) dura 18 mins pero pasan rápido.

## [Etsy’s Journey to Building a Continuous Integration Infrastructure for Mobile Apps](http://velocityconf.com/velocityeu2014/public/schedule/detail/37081)

Etsy libera código a producción más de 50 veces al dia en el sitio web, pero para las aplicaciones para móbiles el proceso no es tán sencillo. Apple se demora un promedio de 5 dias en evaluar una app con lo cual, en caso de un error, el rollback no es tán sencillo.

Armaron un pipeline interno para probar las apps, utilizan [shenzhen](https://github.com/nomad/shenzhen/) para firmar las apps, las buildean en un pool de 25 mac minis (deployadas mediante Chef).

Fue interesante conocer que no utilizan branches para el desarrollo. El código nuevo va en el mismo código base, diferenciandose mediante "feature flags". Admitió que se corre el riesgo al ir deprecando funcionalidades quede código viejo sin usar, pero prefiere ese riesgo a favor de la facilidades comparando a los problemas de compatibilidad que introduce el código basado en branches (para una empresa que comitea todos los dias, si haces hoy un branch para desarrollar una funcionalidad que te toma un mes, es muy probable que cuando vayas a mergear de vuelta tu código, ya el base se haya diferenciado demasiado del código sobre el que habias hecho el fork en primera instancia).

Como un detalle técnico, mencionó la herramienta [TryLib](https://github.com/etsy/TryLib) que permite testear en los jenkins el código antes de comitearlo al repo.

Tercerizan el testeo en equipos físicos a https://appthwack.com/.

Escribir los unit tests no le gusta a nadie. Para buscarle un ángulo divertido, implementaron los "testing dojos", donde 6 desarrolladores se rotan cada 3 minutos para escribir una funcionalidad, por un lado tener el tiempo limitado, por otro tener tiempo para ver los otros desarrolladores como van escribiendo el código ayuda además a fomentar el trabajo en equipo.

Para lo que es QA directamente, habló sobre dos técnicas, una es la creacion de equipos compuestos por 8 voluntarios, un facilitador de QA y un grupo de dispositivos que se juntan durante una hora con el objetivo de encontrar la mayora cantidad de bugs durante ese tiempo. La otra es una herramienta [BugHunt](https://github.com/etsy/BugHunt-iOS) que le permite a los desarolladores postear capturas de pantallas de los bugs que van encontrando, convirtiendolo en un juego al llevar un ranking.


## [It's 3AM, Do You Know Why You Got Paged?](http://velocityconf.com/velocityeu2014/public/schedule/detail/37141)

El contexto de las alarmas es importante. 
Mostró un gráfico con el número de alertas por año. Hubieron dos descensos significativos. El primero, cuando el equipo de operaciones se tomó una semana entera, sin hacer nada más, para revisar todas las alarmas que tenian en los nagios, y hacer limpieza.

La segunda, cuando implementaron [nagios-herald](https://github.com/etsy/nagios-herald).

## [Breaking News at 1000ms](http://velocityconf.com/velocityeu2014/public/schedule/detail/37127)

En estos tiempos donde la percepción en la velocidad de carga de un sitio web es tan importante, [The Guardian](http://www.theguardian.com) encontró una manera de estar en la delantera entre los sitios de noticios. Incluyen en el código fuente de la página todo lo que es necesario para que carguen los elementos principales de que se compone la página. Por ejemplo, en la página de un árticulo lo importante es mostrar el texto del árticulo, pero no sólo el contenido sino el diseño en su formato final támbien. Incluyen el código css y el javascript en el html inicial que se envia al navegador cuando se accede a la URL. De esta manera, cuando está manera, cuando la pagina carga ya muestra la noticia directamente. A continuación envían el resto del contenido: comentarios, anuncios, etc. Interesante la charla y en las slides mostraba como otros sitios de noticias mostraban una página en blanco en el navegador (mientras este aún estaba esperando por cargar archivos de css o js antes de decidir como iba a mostrar el contenido) ya el sitio de ellos mostraba el contenido, en su formato final.

[Slides](https://speakerdeck.com/patrickhamann/breaking-news-at-1000ms-velocity-eu-2014)


## [Using Promise Theory to Improve Digital Service Quality](http://velocityconf.com/velocityny2014/public/schedule/detail/35740)

Wikipedia dice que la [Promise Theory](http://en.wikipedia.org/wiki/Promise_theory): "es un modelo de cooperación voluntaria entre individuos, agentes o actores autónomos que comunican sus intenciones entre ellos en forma de promesas.

Una promesa es una declaración de intención con el propósito de incrementar la certidumbre del destinatario con respecto al reclamo de una conducta pasada, presente o futura. Para que una promesa incremente la certidumbre el destinatario necesita creer en el que promete, pero la confianza también puede provenir del conocimiento de promesas anteriores que fueron cumplidas, de esta manera se aprecia que la confianza mantiene una relación simbiótica con las promesas."

¿Como se relaciona esto con nuestro mundo? Para empezar asumiendo que las promesas, como tales, no necesariamente se cumplen. Los sistemas en el mundo real son colecciones de agentes autónomos colaborando a través de promesas. De este modo, el reconocimiento de la incertidumbre nos brinda un mayor grado de certidumbre. Además, al tratar a los agentes como autónomos, incrementamos la escalabilidad y la robustez de nuestros sistemas.

Luego pasó a hablar de los servicios. El servicio es acerca de las experiencias, no las cosas físicas. Las relaciones, no las transacciones. Los proveedores de servicios promete a sus usuarios a ayudarlos a concluir sus objetivos. Todos los elementos que integran una organización de servicios deben colaborar para cumplir con las promesas a sus usuarios.

Es importante hacernos preguntas como: ¿Qué promesas debemos hacer?, ¿Que promesas necesitamos que otros nos hagan a nosotros?, ¿Que debemos hacer para incrementar la confianza que nos tienen otros?, ¿Que promesas nos deben hacer nuestros usuarios?

La teoría de la promesa ayuda a cruzar fronteras, a establecer relaciones entre todos los integrantes de la organización. Ayuda entonces modelar la organización a partir del usuario en el flujo que siguen los mismos y definir los servicios con los que interactua.

Hay que ver las relaciones en términos de promesas:

* Beneficios
* Empatía
* Autonomía
* Resistencia al fallo

Todo esto en el contexto de todas las áreas de la organización.


[Blog](http://blog.ingineering.it/)

[Slides](http://www.slideshare.net/ingineeringit/promising-digital-service-quality)

## [How BBC Sport Scales Engineering](http://velocityconf.com/velocityeu2014/public/schedule/detail/37176)

Tenian el problema de un ciclo de release muy largo, esto incrementaba el nivel de riesgo y de frustración. Armaron un pipeline de continuous deployment similar al que usamos en OLX.
Para deployar el código evaluaron 4 variantes:

1. El código puesto en un equipo directamente.
2. El código puesto en un container puesto en un equipo.
3. El código puesto en un paquete instalado en un equipo.
4. El código puesto en un paquete instalado en un container puesto en un equipo.

Las dos primeras tenian un problema: ¿cómo expresas dependencias en tu software sin paquetes? (y no me digan con bash scripts)

Conclusión: Deja el manejo de dependencia de versiones a los sistemas diseñados a tal efecto: los gestores de paquetes.

Ya sea que usas contenedores o deployas directo a un equipo, empaqueta tu código.

Respecto a la opción de deployar contenedores (docker) es un tema dinámico:

* las herramientas de deployment y administración aun son inmaduras.
* es dificil el manejo de dependencias entre el codigo deployado en el container
* etc 

La solución elegida entonces fue: código -> paquete -> equipo.

Crean dos binarios:

1. Paquetes (e.g. rpm, deb, etc)
2. Imagenes de Equipos (e.g. AMI)

Principios Importantes

* Los binarios deben crearse de forma que sea repoducible.
* Solo se crean los binarios una vez.
* Deja el manejo de dependencias a las herramientas creadas para la tarea.

Hay distintos niveles de manejo de paquetes:

* Específicos del sistema, e.g. apt, yum
* Portables, e.g. pip, bundle, npm

Para manejar dependencias entre distintos tipos de manejadores de paquetes se recomienda empaquetar para el nivel mas bajo y luego, resolver las dependencias a nivel mas alto en el momento de buildear incluyendolas en el paquete final.

Usar CI es crítico, la elección de CI es irrelevante.

Buildean el código dentro de chroots creados on-demand con [mock](http://fedoraproject.org/wiki/Projects/Mock) lo que les asegura que todas las dependencias en tiempo de build esten especificadas correctamente y el build es reproducible.

¿Como crean los paquetes?
 
* Usan jenkins
* Crean los paquetes dentro de chroots usando mock.
* Los servicios son empaquetados como archivos rpm.

¿Qué hay en una imagen de equipo?

Crean dos imagenes (AMIs)

* Una con el sistema operativo y los paquetes de los servicios
* Una que toma como base la imagen anterior y le agrega los paquetes con las configuraciones. 

De esta manera pueden re-utilizar la misma imagen con el sistema operativo y los paquetes de los servicios a la hora de crear las imagenes que se deployan en los distintos ambientes.

Es una solución de compromiso entre las dos opciones: crear una imagen básica que se deploya para luego instalar todos los paquetes sobre la misma ó crear una imagen que tenga todos los paquetes que va a llevar y este lista para ser deployada y funcionar al momento.

Utilizan AWS Cloudformation y el concepto de Infrastructura como código, esto les permite:

* Manejar las dependencias de infrastructura
* Soportan rollbacks
* Reproducible
* Versionan la infrasctura con el código.

Esto permite:

* Deployar copias idénticas del servicio en distintos ambientes
* Pueden versionar los templates de infrastructura en código y ser capaces entonces de reproducir todo el stack en cualquier momento en el tiempo.

Entonces, la aplicación no es solo código, son código e infrastructura combinados.

¿Como provisionan la infrastructura?

* Separan en distintos templates la infrastuctura stateless de la stateful.
* Usa [librerias de abstracción de Cloudformation](https://github.com/cloudtools/troposphere) para generar programáticamente los templates.

Si no están utilizando Autoscaling Groups, lo están haciendo mal!

* ASGs se asegura de que tus instancias siempre esten corriendo.
* ASGs maneja multi AZ por usted.
* ASGs hacen de usted un mejor ingeniero.
* ASGs pueden deployar servicios.

Es importante olvidarse de las instancias como tal, son solo una unidad de capacidad computacional.

¿Cómo queda todo junto?

* Utilice subnets VPCs y ACLs para limitar el acceso por red a sus servicios.
* Siempre distribuya su infrastructura entre multiple AZs
* Utilice múltiples cuentas de AWS para distintos servicios y/o ambientes.
* Corra su servicio en ASGs.

