import pandas as pd
import dash
from dash import html, dash_table, dcc
import plotly.graph_objects as go
import dash_bootstrap_components as dbc


# dash.register_page(__name__, path='/pune', name="Pune")

layout = html.Div([
    dbc.Container([
    dbc.Row([
        dbc.Col([
            html.H1('Classification of stations')
        ], width=6
        ),
    ]),
]),
])

#