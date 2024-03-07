import dash_bootstrap_components as dbc
from dash import Input, Output, State, html, Dash, dcc
import dash
from pages import overview, coaching , pune , sur, cr

import json
# Use flatly theme
external_css = [dbc.themes.BOOTSTRAP]

app = Dash(__name__, pages_folder='pages', use_pages=True, external_stylesheets=external_css,
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
        # dbc.DropdownMenuItem("Item 3"),
        ],className="me-md-4",id='division_dropdown',),
        
        dbc.Button("Overview",className="me-md-4", id='overview'),
        dbc.Button("Coaching", className="me-md-4", id='coaching'),
        dbc.Button("Goods", className="me-md-4", id='goods', disabled=True),
        dbc.Button("Parcel", className="me-md-4", disabled=True, id='parcel'),
        dbc.Button("Achievements", className="me-md-4", disabled=True, id='achievements'),
        dbc.Button("Photo Gallery", className="me-md-4", disabled=True, id='photo_gallery'),
        dbc.Button("Contact Us", disabled=True, id='contact'),
    ],
    brand="Central Railway",
    brand_href="#",
    color="dark",
    dark=True,
)


app.layout = dbc.Container([
    dbc.Row(navbar),
    html.Div(id='page-content'),
    dcc.Store(id='selected_division_session', storage_type='session'),
    
], fluid=False)



@app.callback(
    [
        Output(component_id='page-content', component_property='children'),
        Output(component_id='division_dropdown' , component_property='label'),
        Output(component_id='selected_division_session', component_property='data'),
    ],
    [
        Input(component_id='overview', component_property='n_clicks'),
        Input(component_id='coaching', component_property='n_clicks'),
        Input(component_id='goods', component_property='n_clicks'),
        Input(component_id='parcel', component_property='n_clicks'),
        Input(component_id='achievements', component_property='n_clicks'),
        Input(component_id='photo_gallery', component_property='n_clicks'),
        Input(component_id='contact', component_property='n_clicks'),
        Input(component_id="pune_div", component_property="n_clicks"),
        Input(component_id="sur_div", component_property="n_clicks"),
    ],
    State('selected_division_session', 'data'),
    prevent_initial_call=True
)
def update_page_and_dropdown(
        overview_clicks, coaching_clicks, goods_clicks, parcel_clicks, achievements_clicks, photo_gallery_clicks,
        contact_clicks, pune_clicks, sur_clicks, selected_division
    ):
    if pune_clicks or sur_clicks:
        ctx = dash.callback_context
        if ctx.triggered_id:
            triggered_id = ctx.triggered_id.split('.')[0]
            if triggered_id == 'pune_div':
                selected_division = 'Pune'
                return pune.layout ,selected_division, selected_division
            elif triggered_id == 'sur_div':
                selected_division = 'Solapur'
                return sur.layout, selected_division, selected_division
    elif selected_division is not None:
        return overview.layout, selected_division, selected_division
    # return cr.layout , "Select Division", None
    
    # Update page content based on button clicks
    # if button_id == 'overview':
    #     html_page = html.Div(children=[
    #         html.H1('Overview'),
    #         html.H1(selected_division)
    #     ])
    #     return html_page, selected_division, selected_division
    # elif button_id == 'coaching':
    #     html_page = html.Div(children=[
    #         html.H1('Coaching'),
    #         html.H1(selected_division),
    #     ])
    #     return html_page, selected_division, selected_division
    # # Update dropdown label and selected division based on dropdown clicks
    # elif pune_clicks or sur_clicks:
    #     triggered_id = ctx.triggered_id.split('.')[0]
    #     if triggered_id == 'pune_div':
    #         return pune.layout, "Pune", "Pune"
    #     elif triggered_id == 'sur_div':
    #         return sur.layout, "Solapur", "Solapur"
    # Default return if no condition is met
    # return overview.layout, "Select Division from return", None


if __name__ == '__main__':
    app.run_server(debug=True)




