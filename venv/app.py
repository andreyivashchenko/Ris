from flask import Blueprint, Flask, request, render_template, json, redirect, session, url_for
from blueprint_query.route import blueprint_query
from blueprint_report.route import blueprint_report
from blueprint_auth.route import blueprint_auth
from basket.route import blueprint_order


app = Flask(__name__)
app.secret_key = 'SuperKey'

app.register_blueprint(blueprint_auth, url_prefix='/auth')
app.register_blueprint(blueprint_query, url_prefix='/queries')
app.register_blueprint(blueprint_report, url_prefix='/reports')
app.register_blueprint(blueprint_order, url_prefix='/orders')

app.config['dbconfig'] = json.load(open('data_files/dbconfig.json'))

with open('data_files/access.json', 'r') as f:
    access_config = json.load(f)
    app.config['access_config'] = access_config

app.config['cache_config'] = json.load(open('data_files/cache.json'))


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


def add_blueprint_access_handler(app:Flask, blueprint_names: list[str], handler: callable) -> Flask:
    for view_func_name, view_func in app.view_functions.items(): #цикл по всем достпуным обработчикам
        print('view_func_name=', view_func_name) #Имя функиции
        print('view_func', view_func_name) #Сама функция
        view_func_parts = view_func_name.split('.')
        if len(view_func_parts) > 1:
            view_blueprint = view_func_parts[0] #Имя блюпринта
            if view_blueprint in blueprint_names:
                view_func = handler(view_func) #функция оборачивается в декоратор
                app.view_functions[view_func_name] = view_func
    return app




if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5001)