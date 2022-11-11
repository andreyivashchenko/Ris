from flask import Blueprint, Flask, request, render_template, json, redirect, session, url_for
from blueprint_query.route import blueprint_query
from blueprint_report.route import blueprint_report
from blueprint_auth.route import blueprint_auth


app = Flask(__name__)
app.secret_key = 'SuperKey'

app.register_blueprint(blueprint_auth, url_prefix='/auth')
app.register_blueprint(blueprint_query, url_prefix='/queries')
app.register_blueprint(blueprint_report, url_prefix='/reports')


app.config['dbconfig'] = json.load(open('data_files/dbconfig.json'))

with open('data_files/access.json', 'r') as f:
    access_config = json.load(f)
    app.config['access_config'] = access_config

@app.route('/')
def menu_choice():
    if 'user_id' in session:
        User = session.get('user_group', None)
        if User:
            return render_template('main_menu.html', User=User)
        else:
            User = 'client'
            return render_template('main_menu.html', User=User)
    else:
        return render_template('main_menu.html')




if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5001)