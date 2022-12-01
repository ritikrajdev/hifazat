from tensorflow import keras
from pathlib import Path

import librosa
import numpy as np
from werkzeug.utils import secure_filename

from flask_cors.decorator import cross_origin
from pydub import AudioSegment

# from flask_ngrok import run_with_ngrok


def convert_m4a_to_wav(m4a_file: str):
    if m4a_file.endsWith('.m4a'):
        wav_file = m4a_file[:-4] + ".wav"
        track = AudioSegment.from_file(m4a_file,  format= 'm4a')
        file_handle = track.export(wav_filename, format='wav')
        return wav_file
    return m4a_file


def extract_features(file: Path):
    audio, sr = librosa.load(file, res_type='kaiser_fast')
    mfccs = librosa.feature.mfcc(y=audio, sr=sr, n_mfcc=40)
    features = np.mean(mfccs.T, axis=0)

    return features


def predict(file, model):
    file = Path(file)
    # read extract_features from feature extraction
    features = extract_features(file)
    features = features.reshape(1, -1)
    labels = ['atmospheric', 'non_scream', 'scream']
    predict_x = model.predict(features)
    classes_x = np.argmax(predict_x, axis=1)
    return labels[classes_x[0]]


model = keras.models.load_model('./scream_detection.hdf5')


from flask import Flask, jsonify, request, Response

app = Flask(__name__)

@app.route("/", methods=['POST'])
@cross_origin()
def get_prediction():
    file = request.files['file']
    filename = secure_filename(file.filename)
    file.save(filename)

    filename = convert_m4a_to_wav(filename)

    is_scream = predict(filename, model) == 'scream'

    Path(filename).unlink()

    return jsonify({"scream": is_scream})


# run_with_ngrok(app)
app.run(debug=True)
