alert('js loaded !!');

    function postMessage(...vars){
        console.log(...vars);
    }

    function loadContent(){
        let frame = document.getElementById('contentPlayer');
        frame.setAttribute('src', 'scorm/index_lms.html');
    }

    class LMSAdapter {

        cmiElement = {};

        constructor() {}

        LMSInitialize(...params){
            let prevContent = window.localStorage.getItem('lms_content');
            this.cmiElement = JSON.parse(prevContent);
            if (this.cmiElement == null){
                this.cmiElement = {};
            }
            console.log('Initialize called', this.cmiElement, ...params);
        }

        LMSGetValue(element){
            console.log('Current State(Get)',this.cmiElement);
            return this.cmiElement[element];
        }

        LMSSetValue(element, value){
            this.cmiElement[element] = value;
            console.log('Current State(Set)',this.cmiElement);
        }

        LMSGetLastError(...params){
            console.log('Get Last Error called', ...params);
        }
        
        LMSGetErrorString(...params){
            console.log('Get Error String called', ...params);
        }

        LMSGetDiagnostic(...params){
            console.log('Get Diagnostic called', ...params);
        }

        LMSCommit(...params){
            window.localStorage.setItem('lms_content', JSON.stringify(this.cmiElement));
            console.log('Commit called', ...params);
        }
    }

    window.onload = (event) => {
        window.API = new LMSAdapter();
        window.postMessage = postMessage;
        loadContent();
    }
