import pandas as pd
import dash
from dash import html, dash_table, dcc
import plotly.graph_objects as go

dash.register_page(__name__, path='/ngp', name="Nagpur")

layout = html.Div(children=[
    html.H1('Nagpur')
])