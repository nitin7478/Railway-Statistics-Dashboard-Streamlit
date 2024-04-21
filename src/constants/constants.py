import os
from datetime import datetime
ROOT_DIR = os.getcwd()

def get_current_time_stamp():
    return f"{datetime.now().strftime('%Y-%m-%d-%H-%M-%S')}"

DB_DIVISION = 'division'
DB_STATIONS = 'station'
DB_DIVISION_EARNINGS_OVERVIEW= 'division_earnings'
DB_DIVISION_TARGET_OVERVIEW = 'division_target'
DB_DIVISION_GOODS_MONTHEWISE_YEARWISE_OW = 'division_goods_monthwise_outward'
DB_DIVISION_GOODS_DEPOWISE_YEARWISE_OW = 'division_goods_depowise_yearly_earning'
DB_DIVISION_GOODS_COMMODITY_YEARWISE_OW = 'division_goods_commodity_outward'
DB_DIVISION_TC_MONTHWISE_CASES_EARNINGS = 'division_tc_monthwise_cases_earnings'
DB_DIVISION_TC_STATEMENT_OF_EARNINGS = 'division_tc_statement_of_earnings'


PANDAS_API_KEY='$2a$10$g.DW2.RNk8klOWAvnbX2AOzq17vhj6ZCKtxK4K741EewwS28BX57G'