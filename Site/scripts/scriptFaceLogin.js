
var divLogin = document.getElementById('divLogin')
var divVideo = document.getElementById('divVideo')
var parametroArregloNuevo=""
var parametroArreglo=""
navigator.getMedia = (navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia)

const elVideo = document.getElementById('video')
const getTest = () => {

    const data = {};

    fetch("http://localhost:52773/api/vec/test", {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*"
      }//,
      //body: JSON.stringify(parametroArregloNuevo)
    }).then((response) => response.json())
    .then((result) => console.log(result))
    .catch((error) => console.error(error));

  };

 function BuscarFace(){
    try{
        
        var txtfirst = document.getElementById('first');
        var txtpassword = document.getElementById('password');
        txtfirst.value="";
        txtpassword.value="";
        
        const data = {};
    
        fetch("http://localhost:52773/api/vec/check", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*"
          },
          body: JSON.stringify(parametroArregloNuevo)
        }).then((response) => response.json())
        .then((data) =>{
            console.log(data)
            txtfirst.value=data.name;
            txtpassword.value=data.pass;

        })
        .catch((error) => console.error(error));
                    
    } catch (e) {
        console.log(e);
    }
            
}

const AgregarFace = ()=>{
    try{
        
    var txtfirst = document.getElementById('first')
    var txtpassword = document.getElementById('password')
    
    const data = {};

    fetch("http://localhost:52773/api/vec/savefull", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
      body: JSON.stringify({
        "name":txtfirst.value,
        "pass":txtpassword.value,
        "arreglo":parametroArregloNuevo})
    }).then((response) => response.json())
    .then((result) => alert(result.result))
    .catch((error) => console.error(error));

                
        } catch (e) {
            console.log(e);
        }

        
}
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
    //faceapi.nets.faceExpressionNet.loadFromUri('/models'),
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
        //faceapi.draw.drawFaceExpressions(canvas, resizedDetections)

        resizedDetections.forEach(async detection => {
            if(detection.detection.score>0.98)
            {
                parametroArregloNuevo=detection.landmarks.positions
                console.log(parametroArregloNuevo)
            const jawOutline = detection.landmarks.getJawOutline()
            const nose = detection.landmarks.getNose()
            const mouth = detection.landmarks.getMouth()
            const leftEye = detection.landmarks.getLeftEye()
            const rightEye = detection.landmarks.getRightEye()
            const leftEyeBrow = detection.landmarks.getLeftEyeBrow()
            const rightEyeBrow = detection.landmarks.getRightEyeBrow()
            const box = detection.detection.box
            new faceapi.draw.DrawBox(box, {
                //label: nombre
            }).draw(canvas)
            }
        })
    })
})

