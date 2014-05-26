class share.CoffeeScriptToJavaScriptConverter
  convert: (value, formOptions = []) ->
    CoffeeScript.compile(value, {bare: true});
