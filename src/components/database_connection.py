import os
import pandas as pd
from dotenv import load_dotenv
from sqlalchemy import create_engine, text
import datetime
from src.constants.constants import *
# Load environment variables from .env file
load_dotenv()

class handle_database:
    def __init__(self):
        DB_HOST = os.getenv("DB_HOST")
        DB_PORT = os.getenv("DB_PORT")
        DB_NAME = os.getenv("DB_NAME")
        DB_USER = os.getenv("DB_USER")
        DB_PASSWORD = os.getenv("DB_PASSWORD")

        # Define the database connection URI
        DB_URI = f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"

        # Create a SQLAlchemy engine
        engine = create_engine(DB_URI)

        self.conn = engine.connect()

        # Define function to load division earnings data
    def load_dataframe(self, selected_division, selected_database):
        if selected_division:
            selected_division = selected_division.lower()
            select_query = text(f"SELECT * FROM {selected_database} WHERE division_code = '{selected_division}'")
            earnings_df = pd.read_sql_query(select_query, self.conn)
            self.full_dataframe = earnings_df
            
            
            target_select_query = text(f"SELECT * FROM {DB_DIVISION_TARGET_OVERVIEW} WHERE division_code = '{selected_division}'")
            target_df = pd.read_sql_query(target_select_query, self.conn)
            
            self.full_target_dataframe = target_df
            current_date = datetime.datetime.now()
            current_year = current_date.year
            current_month = current_date.month

            if current_month < 4:  # Financial year starts from April
                start_year = current_year - 1
                end_year = current_year
            else:
                start_year = current_year
                end_year = current_year + 1
            
            current_year = pd.Timestamp(
                year=start_year+1, month=3, day=31)
            previous_year = pd.Timestamp(
                year=start_year, month=3, day=31)
            
            previous_financial_year_start = pd.Timestamp(
                year=start_year-1, month=4, day=1)
            previous_financial_year_end = pd.Timestamp(
                    year=end_year-1, month=3, day=31)
            
            financial_year_start = pd.Timestamp(year=start_year, month=4, day=1)
            financial_year_end = pd.Timestamp(year=end_year, month=3, day=1)
            
            
            self.cy_division_target_df = target_df[(target_df['earning_month'] >= financial_year_start.date()) &
                                                (target_df['earning_month'] <= financial_year_end.date())]
            # march_year_end = pd.Timestamp(year=end_year, month=3, day=1)
            if 'earning_month' in earnings_df.columns:
                self.cy_dataframe = earnings_df[(earnings_df['earning_month'] >= financial_year_start.date()) &
                                                (earnings_df['earning_month'] <= financial_year_end.date())]
                

                self.ly_dataframe = earnings_df[(earnings_df['earning_month'] >= previous_financial_year_start.date()) &
                                                (earnings_df['earning_month'] <= previous_financial_year_end.date())]
    
                
                current_year_end = pd.Timestamp(year=end_year, month=current_month-2, day=1)
                prev_year_end = financial_year_end = pd.Timestamp(year=end_year-1, month=current_month-2, day=1)
                
                
                self.cy_division_target_df_upto_current_month = target_df[(target_df['earning_month'] >= financial_year_start.date()) &
                                                (target_df['earning_month'] <= current_year_end.date())]
                
                self.ly_dataframe_upto_current_month = self.ly_dataframe[(self.ly_dataframe['earning_month'] >= previous_financial_year_start.date()) &
                                            (self.ly_dataframe['earning_month'] <= prev_year_end.date())]
                
                self.cy_dataframe_upto_current_month = self.cy_dataframe[(self.cy_dataframe['earning_month'] >= financial_year_start.date()) &
                                            (self.cy_dataframe['earning_month'] <= current_year_end.date())]
                
                self.full_dataframe_upto_current_month = self.full_dataframe[(self.full_dataframe['earning_month'] <= current_year_end.date())]
                
            elif 'earning_year' in earnings_df.columns:
                self.cy_dataframe_yearly_data = earnings_df[(earnings_df['earning_year'] == current_year.date())]
                            
                self.ly_dataframe_yearly_data = earnings_df[(earnings_df['earning_year'] == previous_year.date())]


                