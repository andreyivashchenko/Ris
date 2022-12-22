from flask import *
from db_work import select, call_proc
from access import login_required, group_required
from sql_provider import SQLProvider
import os

blueprint_report = Blueprint('bp_report', __name__, template_folder='templates')
provider = SQLProvider(os.path.join(os.path.dirname(__file__), 'sql'))

# reports = json.load(open('../data_files/reports.json'))

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
    # из формы получает номер отчета и какую кнопку нажали

@blueprint_report.route('/create_rep1', methods=['GET', 'POST'])
@group_required
def create_rep1():
    if request.method == 'GET':
        print("GET_create")
        return render_template('report_create.html')
    else:
        interval = request.form.get('input_year')
        year, month = interval.split('-')
        if year and month:
            _sql = provider.get('rep1.sql', year=year, month=month)
            report_result, schema = select(current_app.config['dbconfig'], _sql)
            if report_result:
                return "Данный очтет уже создан"
            else:
                res = call_proc(current_app.config['dbconfig'], 'report_1', year, month)
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
        interval = request.form.get('input_year')
        year, month = interval.split('-')
        print("год ", year, "месяц ", month)
        if year and month:
            _sql = provider.get('rep1.sql', year=year, month=month)
            report_result, schema = select(current_app.config['dbconfig'], _sql)
            if report_result:
                return render_template('result_rep1.html', schema = schema, result = report_result)
            else:
                return "Отчет за этот месяц не создан"
        else:
            return "Repeat input"
