from flask import request
import os
import flask
#import rs

app = flask.Flask(__name__)


@app.route('/')
def index():

    if request.args:

        context = request.args["context"]
        question = request.args["question"]

        #answer = rs.predict(context, question)
        answer = 'Done'
        print(answer)

        return flask.render_template('index.html', question=question, answer=answer)
    else:
        return flask.render_template('index.html')


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=int(os.environ.get('PORT', 8080)))

