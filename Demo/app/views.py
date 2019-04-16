from flask import request, jsonify
from flask import current_app as app
import json, os

PATH = os.path.dirname(os.path.abspath(__file__))



# Classify API
def classify ():
    input = request.form
    print (input)

    return 'success'


# Hate to No-Hate API
def convert ():
    try:
        hateSentence = request.json['sentence']
    except:
        return 'I pledge to speak decently'

    print (hateSentence)
    return 'I pledge to speak decently'

