from flask import request, jsonify
from flask import current_app as app
import json, os
import random

PATH = os.path.dirname(os.path.abspath(__file__))



# Classify API
def classify ():
    try:
        hateSentence = request.json['sentence']
        print (hateSentence)
    except:
        pass

    if (random.random() > 0.7):
        return '1'
    else:
        return '0'


# Hate to No-Hate API
def convert ():
    try:
        hateSentence = request.json['sentence']
    except:
        return 'I pledge to speak decently'

    print (hateSentence)
    return 'I pledge to speak decently'

