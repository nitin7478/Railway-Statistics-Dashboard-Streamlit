
from dash import html, dcc, callback, Input , Output
import dash_bootstrap_components as dbc
import os, base64

def update_stations_page():
    layout = html.Div([
        dbc.Container([
            dbc.Row([
                dbc.Col([
                    html.H4("Select Station", style={'marginTop': '5px'})
                ], xs=12, sm=12, md=2, lg=2, xl=2, className=""),
                dbc.Col([
                    dcc.Dropdown(
                        id='dropdown_select_station',
                        options=[
                            {'label': 'Pune', 'value': f"pune.pdf"},
                            {'label': 'Solapur', 'value': f"sur"},
                        ],
                        value=f"pune",
                        # placeholder="Select Type",# default value
                        clearable=False,
                    ),
                ], xs=12, sm=12, md=4, lg=4, xl=4),
            ], className="flex justify-content-center", style={'marginTop':5}),
            dbc.Row([
                dbc.Col([
                    html.Iframe(
                    id="embedded-pdf",
                    src="assets/stations/pune.pdf",
                    style={"width": "100%", "height": "100%", "overflow": "auto"}  # Adjust width and height as needed
                    )
                ],xs=12, sm=12, md=12, lg=12, xl=12 ),
                
            ], className="flex", style={"height": "80vh",'marginTop':5})
        ], fluid=True),
    ])
    

    return layout




