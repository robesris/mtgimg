# mtgimg

Simple api for searching for Magic: The Gathering cards and returning the image url for the first match.
Written to be set up as a Slack webhook, but perfectly usable by any POST request.  Sending a GET request will instead return a bare-bones html file with an image tag for the card, so you can post a query right into a browser, e.g.:

    http://your_sinatra_app.com/?text=sengir%20vam

# Sample Usage
    POST: 	  {"text":"two refl" }   # Will match "Riku of Two Reflections"
    RESPONSE: {"text":"http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=236469&type=card"}
