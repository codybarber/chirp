from flask import Flask, render_template, request, redirect, session
import bcrypt
import time
import pg

from dotenv import load_dotenv, find_dotenv
import os

load_dotenv(find_dotenv())
db = pg.DB(
    dbname=os.environ.get('DBNAME'),
    host=os.environ.get('DBHOST'),
    port=5432,
    user=os.environ.get('DBUSER'),
    passwd=os.environ.get('DBPASSWORD')
)



app = Flask('ChirpApp')
app.debug = True

@app.route('/')
def home():
    if 'username' in session:
        return redirect('/timeline')
    else:
        return render_template(
            'login.html',
            title='Sign In'
        )

@app.route('/timeline')
def fetch_timeline():
    userid = session['id']
    query = db.query('''
        select
	        chirper.username,
        	chirper.profile_image,
        	chirps.chirp,
        	chirps.date
        from
	        chirps
        left outer join
	        chirper on chirps.chirper_id = chirper.id
        where
	        chirps.chirper_id = $1 or chirps.chirper_id in
	            (select
		            chirper_followed
	            from
		            follow
	            where
		            follow.chirper_id = $1)
        order by
	        chirps.date desc
    ''', userid)



    return render_template(
    'timeline.html',
    title='Latest Tweets',
    chirps=query.namedresult())

@app.route('/send_chirp', methods=['POST'])
def send_chirp():
    userid = session['id']
    username = session['username']
    chirp_to_send = request.form['send']

    db.insert('chirps', chirp=chirp_to_send, chirper_id=userid, date=time.strftime('%c'))
    return redirect('/timeline')

@app.route('/profile')
def profile():
    userid = session['id']
    query = db.query('''
        select
            chirper.username,
            chirper.profile_image,
            chirps.chirp,
            chirps.date
        from
            chirper
        left outer join
            chirps on chirper.id = chirps.chirper_id
        where
	       chirper.id = $1
        order by
	       chirps.date desc
    ''', userid)

    return render_template(
        'profile.html',
        title='',
        user_chirps=query.namedresult())

@app.route('/login')
def login():

    return render_template(
        'login.html',
        title='Please Sign In'
    )

@app.route('/send_login', methods=['POST'])
def signin():
    signin_name = request.form['username']
    signin_password = request.form['password'].encode('utf-8')
    hashed = bcrypt.hashpw(signin_password, bcrypt.gensalt())
    print 'password: %r' % hashed
    query_string = "select chirper.username as name, chirper.password as password, chirper.id as id from chirper where chirper.username = $1"
    query = db.query(query_string, signin_name)
    if query.namedresult():
        name = query.namedresult()[0].name
        password = query.namedresult()[0].password
        user_id = query.namedresult()[0].id
    else:
        return redirect('/login')
    print 'name: ' + name


    if query:
        if signin_name == name and bcrypt.hashpw(signin_password, password) == password:
            session['username'] = signin_name
            session['id'] = user_id
            return redirect('/timeline')
        elif signin_name == name and bcrypt.hashpw(signin_password, password) != password:
            return redirect('/login')
        elif signin_name != name and bcryptpw(signin_password, password) != password:
            return redirect('/signup')
        else:
            pass
    else:
        return redirect('/login')



@app.route('/signup')
def register():

    return render_template(
        'signup.html',
        title='Registration'
    )

@app.route('/send_signup', methods=['POST'])
def signup():
    username = request.form['username']
    email = request.form['email']
    unhashed_password = request.form['password'].encode('utf-8')
    password = bcrypt.hashpw(unhashed_password, bcrypt.gensalt())

    db.insert('chirper', username=username, password=password, email=email, date=time.strftime('%c'))
    return redirect('/login')


@app.route('/logout', methods=['GET'])
def logout():
    session.clear()
    return redirect('/')

app.secret_key = 'CSF686CCF85C6FRTCHQDBJDXHBHC1G478C86GCFTDCR'

if __name__ == '__main__':
    app.run(debug=True)
