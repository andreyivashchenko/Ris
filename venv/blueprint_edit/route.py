import os.path

from flask import Blueprint, request, render_template, current_app
from db_work import select, select_dict
from sql_provider import SQLProvider
from db_context_manager import DBConnection
from db_work import update

blueprint_edit = Blueprint('bp_edit', __name__, template_folder='templates')
provider = SQLProvider(os.path.join(os.path.dirname(__file__), 'sql'))

@blueprint_edit.route('/', methods=['GET'])
def show_all_products():
    _sql = provider.get('all_services.sql')
    service_list = select_dict(current_app.config['dbconfig'], _sql)
    return render_template('all_services.html', service_list=service_list)

@blueprint_edit.route('/', methods=['POST'])
def edit_product():
    action = request.form.get('action')
    id_ser = request.form.get('id_ser')
    dbconfig = current_app.config['dbconfig']
    print('id_ser ', id_ser)
    if action == 'edit_ser':
        _sql = provider.get('get_service_by_id.sql', id_ser=id_ser)
        service = select_dict(dbconfig, _sql)[0]
        return render_template('service_update.html', service=service)
    if action == 'del_ser':
        message = del_ser(dbconfig, id_ser)
        return render_template('update_ok.html', message=message)
    if action == 'update_ser':
        message = update_ser(dbconfig, id_ser)
        return render_template('update_ok.html', message=message)

def del_ser(dbconfig: dict, id_ser: str):
    sql = provider.get('delete_service.sql', id_ser=id_ser)
    update(dbconfig, sql)
    message = 'Услуга удалена из базы данных'
    return message

def update_ser(dbconfig: dict, id_ser: str):
    name_ser = request.form.get('name_ser')
    price_ser = request.form.get('price_ser')
    sql = provider.get('update_service.sql', name_ser=name_ser, price_ser=price_ser, id_ser=id_ser)
    update(dbconfig, sql)
    message = 'Услуга изменена в базе данных'
    return message


@blueprint_edit.route('/insert_prod', methods=['GET'])
def insert_ser():
    service = {}
    return render_template('service_update.html', service=service)

@blueprint_edit.route('/insert_prod', methods=['POST'])
def inserted_ser():
    id_ser = request.form.get('id_ser')
    name_ser = request.form.get('name_ser')
    price_ser = request.form.get('price_ser')
    sql = provider.get('insert_service.sql', id_ser=id_ser, name_ser=name_ser, price_ser=price_ser)
    update(current_app.config['dbconfig'], sql)
    message = 'Услуга добавлена в базу данных'
    return render_template('update_ok.html', message=message)


