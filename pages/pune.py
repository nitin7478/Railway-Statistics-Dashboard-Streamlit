
from dash import html, dcc, callback, Input , Output
import dash_bootstrap_components as dbc
import os, base64

def update_pune_division_page():
    layout = html.Div([
        dbc.Container([
            dbc.Row([
                dbc.Col([
                    html.H4("Pune Division Commercial Profile",className="text-center"),
                    html.Iframe(
                    id="embedded-pdf",
                    src="assets/divisions/pune.pdf",
                    style={"width": "100%", "height": "100vh", "overflow": "auto" , 'border':'none'}  # Adjust width and height as needed
                    )
                ],xs=12, sm=12, md=12, lg=12, xl=12 ),
                
            ], className="flex", style={'marginTop':5})
        ], fluid=True),
    ])
    

    return layout




