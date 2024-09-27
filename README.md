# Introduccion
Desde su version 2024.1 se incluye en InterSystems IRIS Data Platform. Que es una nueva y poderosa función que le permite agregar fácilmente funciones de búsqueda semántica e inteligencia artificial generativa a sus aplicaciones. Vector Search le permite consultar sus datos en función de la semántica o el significado de los datos en lugar de los datos en sí. A continuacion vamos a mostrar un poco mas como funciona

# Arquitectura

<img src="Arquitectura FaceRecognition.jpg" width="1024" />

La solucion esta separada en 2:

1. Sitio con login Site/sidepanelLogin.html
2. Extencion Chrome ExtencionChrome/sidepanel.html

# IRIS
El servicio que se debe exponer en IRIS es IRIS/service.cls

se recomienda el uso de docker en la servion 2024.1 
https://containers.intersystems.com/contents?family=InterSystems%20IRIS%20Community%20Edition&product=iris-community&version=2024.1

# POSTMAN
Para probarlo servicios se puede importar a tu Postman POSTMAN/FaceRecognition.postman_collection.json

# Bibiografia
Extenciones en Chrome 

https://developer.chrome.com/docs/extensions/get-started?hl=es-419
https://developer.chrome.com/docs/extensions/reference/api/scripting?hl=es-419

IRIS

https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=RSQL_tovector
https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=RSQL_vectordotproduct
https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=RSQL_vectorcosine

Face-api.js

https://justadudewhohacks.github.io/face-api.js/docs/index.html
