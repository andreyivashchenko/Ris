import os
from flask import Blueprint, render_template, request, current_app, session, redirect, url_for
from db_context_manager import DBConnection
from db_work import select_dict, insert
from sql_provider import SQLProvider
from cache.wrapper import fetch_from_cache

blueprint_order = Blueprint('bp_order', __name__, template_folder='templates', static_folder='static')
provider = SQLProvider(os.path.join(os.path.dirname(__file__), 'sql'))


@blueprint_order.route('/', methods=['GET', 'POST'])
def order_index():
    db_config = current_app.config['dbconfig']
    cache_config = current_app.config['cache_config']
    cached_select = fetch_from_cache('all_items_cached', cache_config)(select_dict) #явное задание декоратора
    if request.method == 'GET':
        sql = provider.get('all_items.sql')
        items = cached_select(db_config, sql)
        print('items = ', items)
        basket_items = session.get('basket', {})
        return render_template('basket_order_list.html', items=items, basket=basket_items)
    else:
        id_ser = request.form['id_ser']
        sql = provider.get('all_items.sql')
        items = select_dict(db_config, sql)
        add_to_basket(id_ser, items)

        return redirect(url_for('bp_order.order_index'))


def add_to_basket(id_ser: str, items: dict):
    item_description = [item for item in items if str(item['id_ser']) == str(id_ser)]
    print('item_description before=', item_description)
    item_description = item_description[0]
    curr_basket = session.get('basket', {})

    if id_ser in curr_basket:
        print(id_ser)
        return 'данная услуга уже добавлена'
    else:
        curr_basket[id_ser] = {
            'name_ser': item_description['name_ser'],
            'price_ser': item_description['price_ser'],
        }
        session['basket'] = curr_basket
        session.permanent = True
    return True


@blueprint_order.route('/clear-basket')
def clear_basket():
    if 'basket' in session:
        session.pop('basket')
    return redirect(url_for('bp_order.order_index'))


@blueprint_order.route('/save_order', methods=['GET', 'POST'])
def save_order():
    user_id = session.get('user_id')
    current_basket = session.get('basket', {})
    order_id = save_order_with_list(current_app.config['dbconfig'], user_id, current_basket)
    if order_id:
        session.pop('basket')
        return render_template('order_created.html', order_id=order_id)
    else:
        return 'smth went wrong'


def save_order_with_list(dbconfig: dict, user_id: int, current_basket: dict):
    with DBConnection(dbconfig) as cursor:
        if cursor is None:
            raise ValueError('Курсор не создан')
        _sql1 = provider.get('insert_order.sql', user_id=user_id, order_date='2022-12-08')
        result1 = cursor.execute(_sql1)
        print('res1', result1)
        if result1 == 1:
            _sql2 = provider.get('select_order_id.sql', user_id=user_id)
            cursor.execute(_sql2)
            order_id = cursor.fetchall()[0][0]
            print('order_id=', order_id)
            if order_id:
                for key in current_basket:
                    print(key, current_basket[key]['amount'])
                    prod_amount = current_basket[key]['amount']
                    _sql3 = provider.get('insert_order_list.sql', order_id=order_id, prod_id=key, prod_amount=prod_amount)
                    cursor.execute(_sql3)
                return order_id
