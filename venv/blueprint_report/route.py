from flask import *
from db_work import select, call_proc
from access import login_required, group_required
from sql_provider import SQLProvider
import os
from db_context_manager import DBConnection

blueprint_report = Blueprint('bp_report', __name__, template_folder='templates')
provider = SQLProvider(os.path.join(os.path.dirname(__file__), 'sql'))



report_list = [
    {'rep_name':'report1 ', 'rep_id':'1'},
    {'rep_name':'report2 ', 'rep_id':'2'}
]


report_url = {
    '1': {'create_rep':'bp_report.create_rep1', 'view_rep':'bp_report.view_rep1'},
    '2': {'create_rep':'bp_report.create_rep2', 'view_rep':'bp_report.view_rep'}
}


@blueprint_report.route('/', methods=['GET', 'POST'])
def start_report():
    if request.method == 'GET':
        return render_template('menu_report.html', report_list=report_list)
    else:
        rep_id = request.form.get('rep_id')
        print('rep_id = ', rep_id)
        if request.form.get('create_rep'):
            url_rep = report_url[rep_id]['create_rep']
        else:
            url_rep = report_url[rep_id]['view_rep']
        print('url_rep = ', url_rep)
        return redirect(url_for(url_rep))
    # из формы получает номер отчета и какую кнопку

@blueprint_report.route('/create_rep1', methods=['GET', 'POST'])
@group_required
def create_rep1():
    if request.method == 'GET':
        print("GET_create")
        return render_template('report_create.html')
    else:
        print(current_app.config['dbconfig'])
        print("POST_create")
        rep_year = request.form.get('input_year')
        print("Loading...")
        if rep_year:
            res = call_proc(current_app.config['dbconfig'], 'report_1', rep_year)
            print('res=', res)
            return render_template('report_created.html')
        else:
            return "Repeat input"


@blueprint_report.route('/view_rep1', methods=['GET', 'POST'])
@group_required
def view_rep1():
    if request.method == 'GET':
        return render_template('view_rep.html')
    else:
        rep_year = request.form.get('input_year')
        print(rep_year)
        if rep_year:
            _sql = provider.get('rep1.sql', in_year=rep_year)
            product_result, schema = select(current_app.config['dbconfig'], _sql)
            return render_template('result_rep1.html', schema = schema, result = product_result)
        else:
            return "Repeat input"
