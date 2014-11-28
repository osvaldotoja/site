---
layout: post
title: "Velocity Barcelona Dia 1"
modified:
categories: articles
excerpt:
tags: [conferences, velocityconf]
image:
  feature:
date: 2014-11-28T07:59:02-03:00
---


# Primer dia

# Keynotes

## [Life after ‘Human Error’](http://velocityconf.com/velocityeu2014/public/schedule/detail/37751)

El presentador no era una persona del mundo de sistemas sino un sicólogo. Llamó la atención sobre como existen muchas palabras para definir el error pero solo una para el éxito. Mostró como los medios atribuyen los errores al factor humano como el único causante cuando en realidad es una mezcla de factores. 

También mencionó estudios que demuestran que la presión influye proporcionalmente en el incremento de la tasa de error.

Se puede leer mas sobre el tema en este [post](http://www.infoq.com/news/2014/11/human-error-velocity-conference)


## [LIGHTNING DEMO: Always Keep an Eye on Your Website Performance - PerfBar](http://velocityconf.com/velocityeu2014/public/schedule/detail/38145)

Es un script en js que te permite graficar la performance de la pagina. Se podría decir que es un New Relic para pobres ;)
Muy sencillo e interesante, a tener en cuenta para los entornos de desarrollo.

[Website](http://lafikl.github.io/perfBar/)

## [The Impatience Economy, Where Velocity Creates Value](http://velocityconf.com/velocityeu2014/public/schedule/detail/39554)

La charla comenzo con el tema del marketing, en particular las aplicaciones Real-Time Bidding (RTB), tipo google adwords, te presentan anuncios en basados en un grupo de criterios, calculando todo eso en tiempo real.

Se mostró como el producto de su empresa [Aerospike](http://www.aerospike.com/) permitió escalar a varios clientes su performance al tiempo que disminuían el número de servidores sin incrementar el los administradores del sistema. Es un producto de base de datos tipo mongodb.

Mencionaba como en los sitios se tiene una capa de datos sirviendo el frontend y se empieza a tener una capa de datos en el backend donde se guarda toda la data historica relacionada con el trafico del sitio y sus usuarios. Mientras que la capa que sirve el frontend se entiende la importancia de su optimizacion, no tanto la capa del frontend. El producto que vende apunta a ofrecer rendimiento en esa capa de backend.

La conclusión es que además de prestarle atención a la capa de datos que sirve el frontend, la capa de datos del backend empieza a tomar relevancia y su rendimiento pasa a ser un elemento a tomar en cuenta en la arquitectura de la aplicación.

## [Recruiting for Diversity in Tech](http://velocityconf.com/velocityeu2014/public/schedule/detail/36013)

Las comunidades se forman a imagen y semejanza de sus líderes. Si aplicamos el criterio de la meritocracia en solitario, y tenemos un grupo de líderes WASP (y masculinos), la comunidad, eventualmente terminará excluyendo a aquellos que no conforman ese grupo. Es importante tener un grupo de líderes diverso, diverso en cuanto a sexo, nacionalidad, estado social, etc. Ahi entonces si podemos decir que la meritocracia funciona.

Este principio se aplica a comunidades, empresas, etc.

Y no pasa solo por la meritocracia, en cualquier sistema de gestión van a aplicarse estos principios.

Como incorporar la diversidad? empezando por el principio, contrantando con un criterio diverso.

## [Better Performance Through Better Design](http://velocityconf.com/velocityeu2014/public/schedule/detail/37705)

Una de las formas que tenemos de mejorar el rendimiento es mejorando la presentación de los datos relacionados con el rendimiento.

Una cosa es decirle a un jefe de producto que el sitio demora 2.03 segundos en cargar y que necesitamos mejorar esa performance y otra, es mostrarle un gráfico donde se muestran los tiempos de carga de nuestro sitio comparandolo con los tiempos de los sitios de la competencia. En el primer ejemplo, nosotros le decimos que necesitamos mejorar, en el segundo, es muy probable que sea el jefe de producto el que nos lo diga (en el caso de que no estuvieramos en la punta).

Vale la pena mirar la pagina del [demo](http://speedcurve.com/demo/), es interesante la forma en que muestran el tiempo de carga, el timeline donde se muestra como un sitio ya cargó mientras los otros aún mantienen la pagina en blanco algun tiempo más.

# Sesiones

## [Continuous and Visible Security Testing with BDD-Security](http://velocityconf.com/velocityeu2014/public/schedule/detail/37137)

Interesante charla, mostrando un nuevo uso para las mismas técnicas y herramientas. En este caso, las tradicionales de BDD en el campo de la seguridad.

Hay que partir de la seguridad como un ciudadano de primera clase en la aplicación. Luego, tenemos el problema de como aplicarla de manera más transparante y sencilla posible. 

Las herramientas presentadas en esta sesión son un paso en este sentido.

Utilizando lenguaje natural, defines las reglas que quieres implementar y al ejecutar los tests, te aseguras de que las modificaciones en el código no introduzcan problemas de seguridad en la aplicación.

La ventaja de usar BDD es que las reglas quedan documentadas. 

Se mostró un framework que integra todo el proceso. 

[Slides](http://cdn.oreillystatic.com/en/assets/1/event/121/Continuous%20and%20Visible%20Security%20Testing%20with%20BDD-Security%20Presentation.pptx)


## [Monitoring: The Math Behind Bad Behavior](http://velocityconf.com/velocityeu2014/public/schedule/detail/36976)

Esta charla giró en torno al tema del manejo de datos, por ejemplo las trazas. Como las técnicas actuales manejan promedios de los datos cuando en realidad no es una buena idea, ya que por ejemplo, un pico puede quedar ignorado cuando se cacula el promedio entre un largo grupo de datos.

## [Design Reviews for Operations](http://velocityconf.com/velocityeu2014/public/schedule/detail/37146)

Un checklist de cosas que hay que tener en cuenta a la hora de desarrollar un producto que cubren el lado de operaciones y performance. No siempre tenidas en cuenta como parte del parte del proceso, por eso un checklist ahorra palabras y hace más fácil el proceso.

[Slides](http://cdn.oreillystatic.com/en/assets/1/event/121/Design%20Reviews%20for%20Operations%20Presentation.zip)

## [Cognitive Biases in Engineering Organizations](http://velocityconf.com/velocityeu2014/public/schedule/detail/36806)

El cerebro humano esta condicionado en formas en las que uno no se percibe concientemente. La charla giró en torno a tres de esas preconcepciones que directamente afectan nuestro trabajo.

__Fundamental Attribution Error__ Es cuando le atribuimos a otros motivaciones sin una base real que las justifique, solo porque miramos la situacion desde nuestro punto de vista sin deternernos a considerar que pueden haber otras razones fuera de nuestro conocimiento que provocan el comportamiento o accion de la otra persona.

__Confirmation Bias__ Es la tendencia que tenemos a prestarle mas atencion inconcientemente, a las cosas que justifican nuestros pensamientos o hipotesis. 

__Hyperbolic Discounting__ Es la tendencia a elegir cosas que nos ofrecen beneficios a corto plazo en vez de las que lo ofrecen a largo plazo, aún cuando el beneficio sea menor.

Si se sienten identificado con alguna de ellas, evítela :)

La charla esta publicada en el blog del autor [enlace](http://www.jonathanklein.net/2013/06/cognitive-biases-in-software-engineering.html)

## [The Machine is Dead, Long Live the Machine! - Service Resilience and Deployment Automation at The BBC](http://velocityconf.com/velocityeu2014/public/schedule/detail/36837)

Interesante charla sobre la forma en que la BBC organizo su pipeline de deployment, desde los desarrolladores hasta produccion.

Miren las slides, vale la pena.

tl;dr: los desarrolladores comitean, los jenkins testean, se crean paquetes que se instalan en imagenes AMI. Se crean dos imagenes, una con el código de la aplicación y otra con el codigo de la aplicación y la configuración para el entorno de pruebas. Una vez que el código se prueba y esta listo para producción, se promueve. Se crea una imagen a partir de la que tenia el código de la aplicación, esta vez sumandole la configuración para produccion.

La configuración se maneja toda por separado de la aplicación e incluye tanto configuración de la aplicación en sí como de los servicios del sistema (apache, etc).

[Slides](http://cdn.oreillystatic.com/en/assets/1/event/121/The%20Machine%20is%20Dead,%20Long%20Live%20the%20Machine_%20-%20Service%20Resilience%20and%20Deployment%20Automation%20at%20The%20BBC%20Presentation.pdf)

## [Your Place or Mine: A Discussion of Where to Host Your Site](http://velocityconf.com/velocityeu2014/public/schedule/detail/39647)

Fue un panel donde se discutieron las ventajas y desventajas de hospedar un sitio en servidores físicos ó en la nube. 

Conclusión: depende de cada caso.

