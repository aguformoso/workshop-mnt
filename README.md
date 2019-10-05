# Acerca

Este repositorio incluye

**Dockerfile**: todas las dependencias para aquellos que deseen utilizar Docker durante el workshop.

**atlas-streaming**: el ejemplo que seguiremos para ver datos de RIPE Atlas en tiempo real a través de la [Streaming API](https://atlas.ripe.net/docs/result-streaming/)


<script src="http://atlas-stream.ripe.net/socket.io.js"></script>

<div id="out"></div>

<script>

    let msm_ids = [10001, 10101, 10201, 10301, 10401, 10501, 11001, 11101, 11201, 11301, 11401, 11501];
    let attrs = ["result", "prb_id", "msm_id", "timestamp", "rt"];

    let subscribeTo = (socket, prb, msm) => {
        let query = {
            stream_type: "result",

            msm: msm,

            // you can also subscribe with other filters
            // more at https://atlas.ripe.net/docs/result-streaming/

            // type: 'ping',
            // sourcePrefix: '200/8',
            // destinationPrefix: '200/8',

            acceptedFields: attrs,

            // buffering=true is the network-friendly way of subscribing to a stream
            // buffering=false might clog the receiving end (your browser) if
            // results are too many
            buffering: true
        };
        if (prb) query.prb = parseInt(prb);
        socket.emit("atlas_subscribe", query);
    };


    // Subscription to stream events
    let socket = io("https://atlas-stream.ripe.net:443", {path: "/stream/socket.io"});

    socket.on("atlas_error", (error) => {
        console.error(error)
    });
    socket.on('atlas_result', (msm) => {
        out.prepend(inspectObject(msm));
    });

    msm_ids.forEach(function(msm) {
        subscribeTo(socket, null, msm);
    });





    // UI-related bits (printing, handling responses in batch)
    let out = document.querySelector('#out');

    let inspectObject = (_objs) => {

        // support both buffering=true mode (.isArray)
        // and buffering=fale (simple object)
        if(!Array.isArray(_objs))
            _objs = [_objs];

        let objs = [];
        for(let _obj of _objs) {
            let obj = Object.keys(_obj).filter(key => attrs.includes(key)).reduce((o, k) => {o[k] = _obj[k]; return o}, {});
            objs.push(obj);
        }

        return JSON.stringify(objs);
    };

</script>

