const elVideo = document.getElementById('video')

var tabId=0
var datosEnviados=0

function enviarDatosIris(usuario, clave) {

    const FORM_ID = 'Login';

    const FORM = document.forms[0];
    if (FORM) {
    FORM.elements['IRISUsername'].focus();
    FORM.elements['IRISUsername'].value = usuario;
    FORM.elements['IRISPassword'].focus();
    FORM.elements['IRISPassword'].value = clave;
   //FORM.elements['IRISLogin'].click();
    }

  }

function getTabID() {
    return new Promise((resolve, reject) => {
        try {
            chrome.tabs.query({
                active: true,
            }, function (tabs) {
                resolve(tabs[0].id);
            })
        } catch (e) {
            reject(e);
        }
    })
}


chrome.tabs.query({active: true, lastFocusedWindow: true}, tabs => {
    let url = tabs[0].url;
    tabId=tabs[0].id
    console.log(url)
});

navigator.getMedia = (navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia)

const cargarCamera = () => {
    navigator.getMedia(
        {
            video: true,
            audio: false
        },
        stream => elVideo.srcObject = stream,
        console.error
    )
}

// Cargar Modelos
Promise.all([
    faceapi.nets.ssdMobilenetv1.loadFromUri('/models'),
    faceapi.nets.ageGenderNet.loadFromUri('/models'),
    faceapi.nets.faceLandmark68Net.loadFromUri('/models'),
    faceapi.nets.faceLandmark68TinyNet.loadFromUri('/models'),
    faceapi.nets.faceRecognitionNet.loadFromUri('/models'),
    faceapi.nets.ssdMobilenetv1.loadFromUri('/models'),
    faceapi.nets.tinyFaceDetector.loadFromUri('/models'),
]).then(cargarCamera)

elVideo.addEventListener('play', async () => {
    // creamos el canvas con los elementos de la face api
    const canvas = faceapi.createCanvasFromMedia(elVideo)
    // lo añadimos al body
    document.body.append(canvas)

    // tamaño del canvas
    const displaySize = { width: elVideo.width, height: elVideo.height }
    faceapi.matchDimensions(canvas, displaySize)

    setInterval(async () => {
        // hacer las detecciones de cara
        const detections = await faceapi.detectAllFaces(elVideo)
            .withFaceLandmarks()
            .withAgeAndGender()
            .withFaceDescriptors()

        // ponerlas en su sitio
        const resizedDetections = faceapi.resizeResults(detections, displaySize)
        const faceMatcher = new faceapi.FaceMatcher(detections)
        
        // limpiar el canvas
        canvas.getContext('2d').clearRect(0, 0, canvas.width, canvas.height)

        // dibujar las líneas
        faceapi.draw.drawDetections(canvas, resizedDetections)
        faceapi.draw.drawFaceLandmarks(canvas, resizedDetections)

        resizedDetections.forEach(async detection => {
            if(detection.detection.score>0.98 )
            {
            try{
                    const data = {};
    
                    fetch("http://localhost:52773/api/vec/check", {
                      method: "POST",
                      headers: {
                        "Content-Type": "application/json",
                        "Access-Control-Allow-Origin": "*"
                      },
                      body: JSON.stringify(detection.landmarks.positions)
                    }).then((response) => response.json())
                    .then((data) =>{
                        console.log(data)
                        
                        const box = detection.detection.box
                        new faceapi.draw.DrawBox(box, {
                            label: data.name
                        }).draw(canvas)

                        //Enviar datos a login de IRIS
                        function getTitle() { return document.title; }
                        chrome.scripting
                        .executeScript({
                        target : {tabId: tabId},
                        func : enviarDatosIris,
                        args : [ data.name,data.pass ],
                        })
                            .then(() => console.log("injected a function"));


                    })
                    .catch((error) => console.error(error));

                    
            
                } catch (e) {
                    console.log(e);
                }
            }
        })
    })
})

