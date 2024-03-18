import pandas as pd
import dash
from dash import html, dash_table, dcc
import plotly.graph_objects as go
import dash_bootstrap_components as dbc


layout = html.Div([
                    dbc.Container([
                        dbc.Row([
                            dbc.Col([
                                html.H1("Solapur Division"),
                            ], className="d-flex justify-content-center align-items-center" , style={'marginTop':50}),
                        ],),
                        dbc.Row([
                            dbc.Col([
                                html.I("Page will be updated soon........", className="fs-3")
                            ], className="d-flex justify-content-center align-items-center" , style={'marginTop':50}),
                        ],)
                    ]),
                ])
