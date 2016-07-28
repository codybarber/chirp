from flask import Flask, render_template, request, redirect, session
import pg
db = pg.DB(dbname='chirp_db')
app = Flask('ChirpApp')
app.debug = True

@app.route('/')
def home():

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
	        chirps.chirper_id = 1 or chirps.chirper_id in
	            (select
		            chirper_followed
	            from
		            follow
	            where
		            follow.chirper_id = 1)
        order by
	        chirps.date asc
    ''')

    return render_template(
    'timeline.html',
    title='Latest Tweets',
    chirps=query.namedresult())

@app.route('/profile')
def profile():
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
	       chirper.id = 1
        order by
	       chirps.date asc
    ''')

    return render_template(
    'profile.html',
    title='',
    user_chirps=query.namedresult())


if __name__ == '__main__':
    app.run(debug=True)
