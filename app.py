from flask import Flask, render_template, json, request
from flaskext.mysql import MySQL
from werkzeug import generate_password_hash, check_password_hash

# python app.py
# app.py:2: ExtDeprecationWarning: Importing flask.ext.mysql is deprecated, use flask_mysql instead.
#   from flask.ext.mysql import MySQL
# /usr/local/lib/python2.7/dist-packages/flask/exthook.py:106: ExtDeprecationWarning: Detected extension named flaskext.mysql, please rename it to flask_mysql. The old form is deprecated.
#   .format(x=modname), ExtDeprecationWarning

app = Flask(__name__)
mysql = MySQL()

app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'Test1234!'
app.config['MYSQL_DATABASE_DB'] = 'BucketList'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)
conn = mysql.connect()

@app.route("/")
def main():
    return render_template('login.html')

@app.route('/showSignUp')
def showSignUp():
    # json.dumps({'html':'<span>All fields good !!</span>'})
    return render_template('register.html')

@app.route('/signUp', methods=['POST'])
def signUp():
    # create user code will be here !!
    # read the posted values from the UI
    _name = request.form['firstName']
    _email = request.form['middleName']
    _password = request.form['lastName']
    # validate the received values
    if _name and _email and _password:
        json.dumps({'html':'<span>All fields good !!</span>'})
        # json.dumps({'result conn': conn})
    else:
        json.dumps({'html':'<span>Enter the required fields</span>'})

    _hashed_password = generate_password_hash(_password,method='pbkdf2:sha256', salt_length=8)

    # return json.dumps({'HashedPassword': _hashed_password})

    cursor = conn.cursor()
    cursor.callproc('sp_createUser',(_name,_email,_hashed_password))
    data = cursor.fetchall()
 
    if len(data) is 0:
        conn.commit()
        return json.dumps({'message':'User created successfully !'})
    else:
        return json.dumps({'error':str(data[0])})

if __name__ == "__main__":
    app.run()