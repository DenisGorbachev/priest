class share.JavaScriptToCoffeeScriptConverter
  getSample: ->
    sample = """
      function previewfile(file) {
        if (tests.filereader === true && acceptedTypes[file.type] === true) {
          var reader = new FileReader();
          reader.onload = function (event) {
            var image = new Image();
            image.src = event.target.result;
            image.width = 250; // a fake resize
            holder.appendChild(image);
          };

          reader.readAsDataURL(file);
        }  else {
          holder.innerHTML += '<p>Uploaded ' + file.name + ' ' + (file.size ? (file.size/1024|0) + 'K' : '');
          console.log(file);
        }
      }

      function readfiles(files) {
          debugger;
          var formData = tests.formdata ? new FormData() : null;
          for (var i = 0; i < files.length; i++) {
            if (tests.formdata) formData.append('file', files[i]);
            previewfile(files[i]);
          }

          // now post a new XHR request
          if (tests.formdata) {
            var xhr = new XMLHttpRequest();
            xhr.open('POST', '/devnull.php');
            xhr.onload = function() {
              progress.value = progress.innerHTML = 100;
            };

            if (tests.progress) {
              xhr.upload.onprogress = function (event) {
                if (event.lengthComputable) {
                  var complete = (event.loaded / event.total * 100 | 0);
                  progress.value = progress.innerHTML = complete;
                }
              }
            }

            xhr.send(formData);
          }
      }

      "filereader formdata progress".split(' ').forEach(function (api) {
        if (tests[api] === false) {
          support[api].className = 'fail';
        } else {
          support[api].className = 'hidden';
        }
      });
    """
    sample.trim()
  convert: (value, formOptions = []) ->
    js2coffee.build(value,
      show_src_lineno: false
    )
  name: ->
    return "JavaScriptToCoffeeScriptConverter"
#    options =
#      cssSyntax: false
#      unPrefix: true
#    for option in formOptions
#      if option.name is "cssSyntax"
#        options.cssSyntax = true
#      if option.name is "doPrefix"
#        options.unPrefix = false
#