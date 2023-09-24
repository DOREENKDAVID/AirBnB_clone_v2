#!/usr/bin/python3
"""A script that starts a Flask web application"""
from flask import Flask, render_template
from markupsafe import escape

app = Flask(__name__)


@app.route("/", strict_slashes=False)
def display_hello():
    return "Hello HBNB!"


@app.route("/hbnb", strict_slashes=False)
def display_hbnb():
    return "HBNB"


@app.route("/c/<text>", strict_slashes=False)
def display_c(text):
    text = text.replace("_", " ")
    return "C %s" % (text)


@app.route('/python/', strict_slashes=False)
@app.route("/python/<text>", strict_slashes=False)
def display_python(text='is cool'):
    if text != 'is cool':
        text = text.replace("_", " ")
    return "Python %s" % (text)


@app.route("/number/<int:n>", strict_slashes=False)
def display_if_number(n):
    """ return numbers """
    if type(n) == int:
        return "%d is a number" % (n)


@app.route('/number_template/<int:n>', strict_slashes=False)
def template_int(n):
    """ return html template with number """
    if type(n) == int:
        return render_template('5-number.html', num=n)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
