class share.CSSConverter
  getSample: ->
    sample = """
    body {
      color: #ccc;
    }

    body a {
      text-decoration: none;
      -webkit-border-radius: 100%;
      -moz-border-radius: 100%;
      -webkit-box-shadow: 1px 1px black;
      -moz-box-shadow: 1px 1px black;
      color: #666;
    }

    body a:hover {
      text-decoration: underline;
      -webkit-border-radius: 100%;
      -moz-border-radius: 100%;
      -webkit-box-shadow: 1px 1px black;
      -moz-box-shadow: 1px 1px black;
      color: #333;
    }

    body a:active {
      color: #000;
    }
    """
    sample.trim()