import os.path

from flask import Blueprint, request, render_template, current_app
from db_work import select
from sql_provider import SQLProvider
from access import login_required, group_required


blueprint_query = Blueprint('bp_query', __name__, template_folder='templates')
provider = SQLProvider(os.path.join(os.path.dirname(__file__), 'sql'))




@blueprint_query.route('/')
@login_required
@group_required
def start_queries():
    return render_template('queries.html')


@blueprint_query.route('/query_1', methods=['GET', 'POST'])
@login_required
@group_required
def query_1():
    if request.method == 'GET':
        return render_template('query_1.html')
    else:
        input_data = request.form.get('data_name')
        if input_data:
            _sql = provider.get('query_1.sql', birth_cl=input_data)
            product_result, schema = select(current_app.config['dbconfig'], _sql)
            return render_template('db_result.html', schema=[ 'Id клиента', 'Имя клиента', 'Дата рождения', 'Текущий баланс' ], result=product_result)
        else:
            return ('Ничего не введено')


@blueprint_query.route('/query_2', methods=['GET', 'POST'])
@login_required
@group_required
def query_2():
    if request.method == 'GET':
        return render_template('query_2.html')
    else:
        cl_name = request.form.get('cl_name')
        cl_id = request.form.get('cl_id')
        if cl_name and cl_id:
            _sql = provider.get('query_2.sql', Name=cl_name, Id=cl_id)
            product_result, schema = select(current_app.config['dbconfig'], _sql)
            return render_template('db_result.html', schema=[ 'Id услуги', 'Название', 'Стоимость', 'Дата' ], result=product_result, Name=cl_name, Id=cl_id)
        else:
            return ('Ничего не введено')

@blueprint_query.route('/query_3', methods=['GET', 'POST'])
@login_required
@group_required
def query_3():
    if request.method == 'GET':
        return render_template('query_3.html')
    else:
        input_data = request.form.get('data_name')
        if input_data:
            _sql = provider.get('query_3.sql', name_ser=input_data)
            product_result, schema = select(current_app.config['dbconfig'], _sql)
            return render_template('db_result.html', schema=[ 'Название услуги', 'Количество подключений' ], result=product_result)
        else:
            return ('Ничего не введено')

@blueprint_query.route('/query_4', methods=['GET', 'POST'])
@login_required
@group_required
def query_4():
    if request.method == 'GET':
        return render_template('query_4.html')
    else:
        input_data = request.form.get('data_name')
        if input_data:
            _sql = provider.get('query_4.sql', birth_cl=input_data)
            product_result, schema = select(current_app.config['dbconfig'], _sql)
            return render_template('db_result.html', schema=schema, result=product_result)
        else:
            return ('Ничего не введено')

@blueprint_query.route('/query_5', methods=['GET', 'POST'])
@login_required
@group_required
def query_5():
    if request.method == 'GET':
        return render_template('query_5.html')
    else:
        input_data = request.form.get('data_name')
        if input_data:
            _sql = provider.get('query_5.sql', date=input_data)
            product_result, schema = select(current_app.config['dbconfig'], _sql)
            return render_template('db_result.html', schema= ['Id клиента', 'Количество изменений баланса'], result=product_result)
        else:
            return ('Ничего не введено')
