# from dash import html , callback , Input, Output, dcc , State
# from dash.exceptions import PreventUpdate
# import dash_bootstrap_components as dbc
# from src.components.database_connection import handle_database
# from src.constants.constants import *
# import plotly.graph_objects as go
# from plotly.subplots import make_subplots
# import textwrap, os
# from pages.overview import overview_graphs_buttons
# from pandasai import Agent

# from dotenv import load_dotenv
# import os

# load_dotenv()

# # Access the API key
# api_key = os.getenv("PANDASAI_API_KEY")

# def generate_output(input_data):
#     os.environ["PANDASAI_API_KEY"] = api_key
#     print(input_data)

#     overview_object = overview_graphs_buttons(selected_division='pune')
#     print(overview_object.full_dataframe.columns)
#     # Process input data using Pandas AI (replace this with your actual processing logic)
    
#     agent = Agent(dfs=overview_object.full_dataframe)
#     response = agent.chat(input_data)
    
#     print(response)
#     return response
# input_data = "write down the columns in the dataframe"
# generate_output(input_data)

# def update_ask_gpt_page(selected_division):
#     if selected_division is not None:
        
#         layout = dbc.Container([
#             dbc.Row([
#                 dbc.Col([
#                     html.H3("Input Box"),
#                     dcc.Textarea(id='input-box', placeholder='Enter your data here...', style={'width': '100%', 'height': 200}),
#                     html.Button('Submit', id='submit-button', className='btn btn-primary mt-2')
#                 ])
#             ], className="flex"),
#             dbc.Row([
#                 dbc.Col([
#                     html.H3("Output"),
#                     html.Div(id='output')
#                 ])
#             ], className="flex")
#         ], fluid=True)
        
#         return layout

#     else:
#         layout = html.Div([
#                     dbc.Container([
#                         dbc.Row([
#                             dbc.Col([
#                                 html.H2("Please Select Division")
#                             ], className="d-flex justify-content-center align-items-center" , style={'marginTop':20}),
#                         ],)
#                     ]),
#                 ])
#         return layout
    
    
    
# # Initialize the load_ask_gpt class outside the callback

# @callback(
#     Output('output', 'children'),
#     [Input('submit-button', 'n_clicks')],
#     [State('input-box', 'value')],
# )
# def update_output(n_clicks, input_value):
#     if n_clicks is None:
#         raise PreventUpdate
#     else:
#         if input_value:
#             # Call the generate_output method of the load_ask_gpt class
#             output_data = generate_output(str(input_value))
#             return html.Div([
#                 html.Pre(output_data)
#             ])
#         else:
#             return html.Div("Please enter some data in the input box.")