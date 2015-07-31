# mtgimg

Simple api for searching for Magic: The Gathering cards and returning the image url for the first match.
Written to be set up as a Slack webhook, but perfectly usable by any POST request.

# Sample Usage
    POST: 	  {"text":"two refl" }   # Will match "Riku of Two Reflections"
    RESPONSE: {"text":"http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=236469&type=card"}
