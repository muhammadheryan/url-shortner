import random, string, validators
from flask import Flask, request, Response, redirect, url_for
from flask_mysqldb import MySQL

app = Flask(__name__)
app.config["DEBUG"] = True
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'url_shortener'
mysql = MySQL(app)

@app.route('/', methods=['GET'])
def home():
    return {"app":"url-shorten","status":"service-up"}    


@app.route('/short_url', methods=['POST'])
def short_url():
    #Check Input
    request_data = request.get_json()
    url_origin = ""
    if "url" in request_data:
        url_origin = request_data['url']
    else:
        return Response("{'result':'error','message':'param url required','url_shorten':''}", status=400, mimetype='application/json')

    #Check valid url
    if not validators.url(url_origin):
        return Response("{'result':'error','message':'invalid url','url_shorten':''}", status=400, mimetype='application/json')

    #Check Existing URL
    cur = mysql.connection.cursor()
    query = "SELECT * from url WHERE url_origin='"+url_origin+"'"
    cur.execute(query)
    data = cur.fetchone()
    cur.close()
    if data is not None:
        resp = "{'result':'success','message':'url shorten exist','url_shorten':'"+data[2]+"'}"
        return Response(resp, status=200, mimetype='application/json')

    #Make URL
    url_shorten = generate_shorten_url()

    #Insert to DB
    cur = mysql.connection.cursor()
    cur.execute("INSERT INTO url (url_origin,url_shorten) VALUES (%s,%s)",(url_origin,url_shorten))
    mysql.connection.commit()

    #Return URL
    return {'result':"success","message":"success creating new shorten url",'url_shorten':url_shorten}


@app.route('/redirect', methods=['GET'])
def redirect_to_origin_url():
    #GET Reuqeust URl
    url_shorten = request.url

    #Get Data From DB
    cur = mysql.connection.cursor()
    query = "SELECT * from url WHERE url_shorten='"+url_shorten+"'"
    cur.execute(query)
    data = cur.fetchone()
    cur.close()

    #Respon based on result from DB
    if data is None:
        return Response("{'result':'error','message':'url shorten doesn`t exist','url_shorten':'"+url_shorten+"'}", status=400, mimetype='application/json')
    else:
        return redirect(data[1])


def generate_shorten_url():
    base_url = request.url_root+"redirect?url="
    random_string = ''.join(random.choice(string.ascii_uppercase + string.ascii_lowercase + string.digits) for _ in range(8))
    return base_url+random_string


app.run()