from boto3.session import Session
import boto3
from flask import Flask

ACCESS_KEY = 'AKIA25ZPUMYN2A4GFK3H'
SECRET_KEY = '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'

app = Flask(__name__)

def get_s3():
    session = Session(aws_access_key_id=ACCESS_KEY,aws_secret_access_key=SECRET_KEY)

    return session.resource('s3')

@app.route("/")
def index():
    return "<h1>Hello!</h1>"

@app.route('/upload_file')
def upload_file():
    s3_client = get_s3()

    s3_client.Bucket("home-test-h").upload_file("a.jpeg", "a.jpeg") 
    return "Upload your file success" , 200

@app.route('/download_file')
def download_file():
    s3_client = get_s3()
    s3_client.Bucket("home-test-h").download_file("b.jpeg", "b.jpeg")
    return  "Download your file success" , 200


app.run(host='0.0.0.0', debug=True, port=5000)