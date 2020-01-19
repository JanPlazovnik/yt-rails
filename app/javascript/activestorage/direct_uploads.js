window.addEventListener('turbolinks:load', () => {
    if (document.getElementById("video_form")) {
        
        let xhr;
        document.getElementById("video_clip").addEventListener("direct-upload:before-storage-request", (event) => xhr = event.detail.xhr);
        document.addEventListener("turbolinks:request-start", (event) => {
            if(xhr)
                xhr.abort();             
        })

        document.getElementById("video_clip").addEventListener("direct-upload:initialize", (event) => {
            const { target, detail } = event;
            const { id, file } = detail;
            console.log("Initialized", file);
            $("#video_upload_abort").removeClass("hidden");
            target.insertAdjacentHTML("beforebegin", `
                <div id="direct-upload-${id}" class="direct-upload direct-upload--pending">
                    <div id="direct-upload-progress-${id}" class="direct-upload__progress" style="width: 0%"></div>
                    <span class="direct-upload__filename">${file.name}</span>
                </div>
            `);
        })

        document.getElementById("video_clip").addEventListener("direct-upload:start", (event) => {
            const { id } = event.detail;
            const element = document.getElementById(`direct-upload-${id}`);
            element.classList.remove("direct-upload--pending");
            console.log("Started", id);

        });

        document.getElementById("video_clip").addEventListener("direct-upload:progress", (event) => {
            const { id, progress } = event.detail;
            console.log(`Progress: ${progress}`);
            const progressElement = document.getElementById(`direct-upload-progress-${id}`);
            progressElement.style.width = `${progress}%`;
        });

        document.getElementById("video_clip").addEventListener("direct-upload:error", (event) => {
            event.preventDefault();
            const { id, error } = event.detail;
            console.log("Error", id, error);
            const element = document.getElementById(`direct-upload-${id}`)
            element.classList.add("direct-upload--error")
            element.setAttribute("title", error)
            let abort_elem = document.getElementById("video_upload_abort");
            abort_elem.parentNode.removeChild(abort_elem);
        });

        document.getElementById("video_clip").addEventListener("direct-upload:end", (event) => {
            const { id } = event.detail;
            console.log("End", id);
            const element = document.getElementById(`direct-upload-${id}`)
            element.classList.add("direct-upload--complete")
            let abort_elem = document.getElementById("video_upload_abort");
            abort_elem.parentNode.removeChild(abort_elem);
        });
    }
});