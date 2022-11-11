import os
from typing import Optional, Dict
from flask import Blueprint, request, render_template, current_app, session, redirect, url_for
from db_work import select_dict
from sql_provider import SQLProvider
from access import login_required, group_required

blueprint_auth = Blueprint('bp_auth', __name__, template_folder='templates')
provider = SQLProvider(os.path.join(os.path.dirname(__file__), 'sql'))


@blueprint_auth.route('/', methods=['GET', 'POST'])
def start_auth():
    if request.method == 'GET':
        return render_template('input_login.html', message='')
    else:
        login = request.form.get('login')
        password = request.form.get('password')

        if login:
            user_info = define_user(login, password)

            if user_info:
                user_dict = user_info[0]
                session['user_id'] = user_dict['user_id']
                session['user_group'] = user_dict['user_group']
                session.permanent = True

                return redirect(url_for('menu_choice'))
            else:
                return render_template('input_login.html', message='Пользователь не найден')

        return render_template('input_login.html', message='Повторите ввод')

@blueprint_auth.route('/internal')
@login_required
@group_required
def int_user():
    return render_template('internal_user_menu.html')

@blueprint_auth.route('/external')
def ext_user():
    return render_template('external_user_menu.html')

@blueprint_auth.route('/exit')
def exit():
    session.clear()
    return render_template('exit.html')


def define_user(login: str, password: str) -> Optional[Dict]:
    sql_internal = provider.get('internal_user.sql', login=login, password=password)
    sql_external = provider.get('external_user.sql', login=login, password=password)

    user_info = None

    for sql_search in [sql_internal, sql_external]:
        user_info = select_dict(current_app.config['dbconfig'], sql_search)

        if user_info:
            break

    return user_info