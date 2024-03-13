import dash_bootstrap_components as dbc
from dash import Input, Output, State, html, Dash, dcc, dash_table
import dash
import json
from pages import pune , sur , cr, passenger
from pages.overview import update_overview_page 
from pages.goods import update_goods_page
from pages.passenger import update_passenger_page
from  src.constants.constants import *
external_css = [dbc.themes.BOOTSTRAP]

app = Dash(__name__, external_stylesheets=external_css,
           meta_tags=[{'name': 'viewport',
                       'content': 'width=device-width, initial-scale=1.0'}],
           suppress_callback_exceptions=True)

navbar = dbc.NavbarSimple(
    children=[
        dbc.DropdownMenu(
            label="Select Division",
            children=[
                dbc.DropdownMenuItem("Pune", id='pune_div'),
                dbc.DropdownMenuItem("Solapur", id='sur_div'),
            ],
            className="me-md-4",
            id='division_dropdown',
        ),
        dbc.Button("Overview", className="me-md-3", id='overview'),
        dbc.Button("Passenger", className="me-md-3", id='passenger'),
        dbc.Button("Goods", className="me-md-3", id='goods'),
        dbc.Button("Parcel", className="me-md-3", disabled=True, id='parcel'),
        dbc.Button("Other Coaching", className="me-md-3", disabled=True, id='other_coaching'),
        dbc.Button("Stations", className="me-md-3", disabled=True, id='stations'),
        dbc.Button("Achievements", className="me-md-3", disabled=True, id='achievements'),
        dbc.Button("Photo Gallery", className="me-md-3", disabled=True, id='photo_gallery'),
        dbc.Button("Planning", className="me-md-3", disabled=True, id='planning'),
        dbc.Button("Contact Us", disabled=True, id='contact'),
    ],
    brand="Central Railway",
    brand_href="#",
    color="dark",
    dark=True,
    fluid=True
)

app.layout = dbc.Container([
    dbc.Row(navbar),
    html.Div(id='page-content'),
    dcc.Store(id='selected_division_session', storage_type='session'),
], fluid=True)


@app.callback(
    Output(component_id='division_dropdown', component_property='label'),
    Output(component_id='selected_division_session', component_property='data'),
    Output(component_id='page-content', component_property='children'),
    [
        Input(component_id="pune_div", component_property="n_clicks"),
        Input(component_id="sur_div", component_property="n_clicks"),
        Input(component_id='overview', component_property='n_clicks'),
        Input(component_id='passenger', component_property='n_clicks'),
        Input(component_id='goods', component_property='n_clicks'),
        Input(component_id='parcel', component_property='n_clicks'),
        Input(component_id='achievements', component_property='n_clicks'),
        Input(component_id='photo_gallery', component_property='n_clicks'),
        Input(component_id='contact', component_property='n_clicks'),
    ],
    State('selected_division_session', 'data')
)
def update_dropdown(pune_clicks, sur_clicks, overview_clicks, coaching_clicks, goods_clicks, parcel_clicks, achievements_clicks, photo_gallery_clicks,
        contact_clicks, state):
    if pune_clicks or sur_clicks or overview_clicks or coaching_clicks or goods_clicks or parcel_clicks or achievements_clicks or photo_gallery_clicks or contact_clicks:
        ctx = dash.callback_context
        if ctx.triggered_id:
            triggered_id = ctx.triggered_id.split('.')[0]
            if triggered_id == 'pune_div':
                selected_division = 'Pune'
                return selected_division, selected_division, pune.layout
            elif triggered_id == 'sur_div':
                selected_division = 'Solapur'
                return selected_division, selected_division , sur.layout
            if state is not None:
                if triggered_id == 'overview':
                    html_page = update_overview_page(state)
                    return state, state , html_page
                elif triggered_id == 'passenger':
                    html_page = update_passenger_page(state)
                    return state, state , html_page
                elif triggered_id == 'goods':
                    html_page = update_goods_page(state)
                    return state, state , html_page
    elif state is not None:
        html_page = update_overview_page(state)
        return state, state , html_page

    return "Select Division", None , cr.layout


def update_page_for_division(selected_division):
    if selected_division == 'Pune':
        return pune.layout
    if selected_division == 'Solapur':
        return sur.layout





    

if __name__ == '__main__':
    app.run_server(debug=True)