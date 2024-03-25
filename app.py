import dash_bootstrap_components as dbc
from dash import Input, Output, State, html, Dash, dcc, dash_table
import dash
import json
import os
from pages import pune, sur, cr, passenger
from pages.overview import update_overview_page
from pages.goods import update_goods_page
from pages.passenger import update_passenger_page
from pages.stations import update_stations_page
from src.constants.constants import *
from pages.pune import update_pune_division_page
from pages.other_coaching import update_other_coaching_page
import dash_auth

# from dash_bootstrap_templates import load_figure_template
# load_figure_template('')


external_css = [dbc.themes.BOOTSTRAP]

app = Dash(__name__, external_stylesheets=external_css,
           meta_tags=[{'name': 'viewport',
                       'content': 'width=device-width, initial-scale=1.0'}],
           suppress_callback_exceptions=True)

VALID_USERNAME_PASSWORD_PAIRS = {
    'pune': 'pune'
}
auth = dash_auth.BasicAuth(
    app,
    VALID_USERNAME_PASSWORD_PAIRS
)

navbar = dbc.NavbarSimple(
    children=[
            dbc.DropdownMenu(
            label="Select Division",
            children=[
                dbc.DropdownMenuItem("Pune", id='pune_div'),
                # dbc.DropdownMenuItem("Solapur", id='sur_div'),
            ],
            className="me-md-4",
            id='division_dropdown',
        ),
        dbc.Button("Overview", className="me-md-3", id='overview'),
        dbc.Button("Passenger", className="me-md-3", id='passenger'),
        dbc.Button("Goods", className="me-md-3", id='goods'),
        dbc.Button("Other Coaching", className="me-md-3", disabled=False, id='other_coaching'),
        dbc.Button("Stations", className="me-md-3", disabled=False, id='stations'),
        dbc.Button("Contact Us",disabled=False, id='contact'),
        
    ],
    brand="Central Railway ",
    brand_href="#",
    color="dark",
    dark=True,
    fluid=True,
)





# Layout with spinner
app.layout = dbc.Container([
    navbar,
    dcc.Loading(
        id="loading",
        type="default",
        children=dbc.Container([
            html.Div(id='page-content'),
            dcc.Store(id='selected_division_session',
                      storage_type='session'),
        ], fluid=True)
    ),
], fluid=True)


@app.callback(
    Output(component_id='division_dropdown', component_property='label'),
    Output(component_id='selected_division_session', component_property='data'),
    Output(component_id='page-content', component_property='children'),
    [
        Input(component_id="pune_div", component_property="n_clicks"),
        # Input(component_id="sur_div", component_property="n_clicks"),
        Input(component_id='overview', component_property='n_clicks'),
        Input(component_id='passenger', component_property='n_clicks'),
        Input(component_id='goods', component_property='n_clicks'),
        Input(component_id='other_coaching', component_property='n_clicks'),
        Input(component_id='contact', component_property='n_clicks'),
        Input(component_id='stations', component_property='n_clicks'),
    ],
    State('selected_division_session', 'data'),
    prevent_initial_call=False,
)
def update_dropdown(pune_clicks, overview_clicks, coaching_clicks, goods_clicks, other_coaching_clicks,
                    contact_clicks, station_clicks, state):
    if pune_clicks or  overview_clicks or coaching_clicks or goods_clicks or other_coaching_clicks or contact_clicks or station_clicks:
        ctx = dash.callback_context
        if ctx.triggered_id:
            triggered_id = ctx.triggered_id.split('.')[0]
            if triggered_id == 'pune_div':
                selected_division = 'pune'
                return 'Pune', selected_division, update_pune_division_page()
            elif triggered_id == 'stations':
                label = "Select Division"
                state = None
                html_page = update_stations_page()
                return label, state, html_page
            if state is not None:
                if triggered_id == 'overview':
                    html_page = dbc.Container([
                        update_overview_page(state),
                        update_passenger_page(state),
                        update_goods_page(state),
                        update_other_coaching_page(state)
                    ], fluid=True)
                    label = f"{state[:1].upper()}{state[1:]}"
                    return label, state, html_page
                elif triggered_id == 'passenger':
                    label = f"{state[:1].upper()}{state[1:]}"
                    html_page = update_passenger_page(state)
                    return label, state, html_page
                elif triggered_id == 'goods':
                    label = f"{state[:1].upper()}{state[1:]}"
                    html_page = update_goods_page(state)
                    return label, state, html_page
                elif triggered_id == 'other_coaching':
                    label = f"{state[:1].upper()}{state[1:]}"
                    html_page = update_other_coaching_page(state)
                    return label, state, html_page
            else:
                layout = html.Div([
                    dbc.Container([
                        dbc.Row([
                            dbc.Col([
                                html.H2("Please Select Division")
                            ], className="d-flex justify-content-center align-items-center", style={'marginTop': 20}),
                        ],)
                    ]),
                ])
                return "Select Division", None, layout
    elif state is not None:
        html_page = dbc.Container([
            update_overview_page(state),
            update_passenger_page(state),
            update_goods_page(state),
            update_other_coaching_page(state)
        ], fluid=True)
        label = f"{state[:1].upper()}{state[1:]}"
        return label, state, html_page
    return "Select Division", None, cr.layout


# if __name__ == '__main__':
#     app.run_server(debug=True)
