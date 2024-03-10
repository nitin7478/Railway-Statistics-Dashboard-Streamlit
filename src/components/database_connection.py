import os
import pandas as pd
from dotenv import load_dotenv
from sqlalchemy import create_engine, text

# Load environment variables from .env file
load_dotenv()

# Access the database connection details
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")

# Define the database connection URI
DB_URI = f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"

# Create a SQLAlchemy engine
engine = create_engine(DB_URI)

conn = engine.connect()

# Define function to load division earnings data
def load_division_earnings_data(selected_division):
    if selected_division:
        selected_division = selected_division.lower()
        select_query = text(f"SELECT * FROM division_earnings WHERE division_code = '{selected_division}'")
        earnings_df = pd.read_sql_query(select_query, conn)
        # conn.close()
        return earnings_df


# Define function to load division earnings data
def load_division_target_data(selected_division):
    # Execute the query and read into a DataFrame
    selected_division = selected_division.lower()
    select_query = text(f"SELECT * FROM division_target WHERE division_code = '{selected_division}'")
    earnings_df = pd.read_sql_query(select_query, conn)
    return earnings_df


def load_division_goods_monthwise_outward_data(selected_division):
    # Execute the query and read into a DataFrame
    selected_division = selected_division.lower()
    select_query = text(f"SELECT * FROM division_goods_monthwise_outward WHERE division_code = '{selected_division}'")
    earnings_df = pd.read_sql_query(select_query, conn)
    return earnings_df


def load_division_good_yearly_depowisesoutward_data(selected_division):
    # Execute the query and read into a DataFrame
    selected_division = selected_division.lower()
    select_query = text(f"SELECT * FROM division_goods_depowise_yearly_earning WHERE division_code = '{selected_division}'")
    earnings_df = pd.read_sql_query(select_query, conn)
    return earnings_df

def load_division_commoditywise_yearly_data(selected_division):
    selected_division = selected_division.lower()
    select_query = text(f"SELECT * FROM division_goods_commodity_outward WHERE division_code = '{selected_division}'")
    earnings_df = pd.read_sql_query(select_query, conn)
    return earnings_df