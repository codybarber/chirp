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
            chirps.chirp,
            chirps.date
        from
            chirper
        left outer join
            chirps on chirper.id = chirps.chirper_id
        order by
            chirps.date asc
    ''')

    return render_template(
    'timeline.html',
    title='Latest Tweets',
    chirps=query.namedresult())



if __name__ == '__main__':
    app.run(debug=True)
