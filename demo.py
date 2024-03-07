import dash_bootstrap_components as dbc
from dash import Input, Output, State, html, Dash , callback, dcc
import dash
from pages import pune, sur
# Use flatly theme
external_css = [dbc.themes.BOOTSTRAP]


app = Dash(__name__, pages_folder='pages', use_pages=True, external_stylesheets=external_css,
           meta_tags=[{'name': 'viewport',
                       'content': 'width=device-width, initial-scale=1.0'}],
           suppress_callback_exceptions=True)

page_order = ['/pune', '/sur', '/csmt', '/ngp', '/bsl',]
navbar = dbc.NavbarSimple(
    children=[
        # dbc.NavItem(dbc.NavLink("Page 1", href="#")),
        dbc.DropdownMenu(
            children=[
                # dbc.DropdownMenuItem("More pages", header=True),
                dbc.DropdownMenuItem("Pune", id='pune_div'),
                dbc.DropdownMenuItem("Solapur", id='sur_div'),
            ],
            nav=True,
            in_navbar=True,
            label="Select Division",
            id='division_dropdown',

        ),
        dbc.DropdownMenu(
            children=[
                # dbc.DropdownMenuItem("More pages", header=True),
                dbc.DropdownMenuItem("Pune", href="#" ),
                dbc.DropdownMenuItem("Daund", href="#"),
            ],
            nav=True,
            in_navbar=True,
            label="Select Station",
            disabled=True,
            id='station_dropdown'
        ),
        dbc.NavLink(html.Div("Contact Us",), href="#", disabled=True)
    ],
    brand="Central Railway",
    brand_href="#",
    color="primary",
    dark=True,
)


app.layout = dbc.Container([
    dbc.Row(navbar),
    html.Div([
    dcc.Location(id='url', refresh=False),
    html.Div(id='page-content')
])
    # html.Div(children=[
    #     dash.page_container
    # ], style={'marginTop': '100px'})
])


@app.callback(
    Output(component_id='division_dropdown' , component_property='label'),
    Output(component_id='page-content', component_property='children'),
    
    [
    Input(component_id="pune_div", component_property="n_clicks"),
    Input(component_id="sur_div", component_property="n_clicks"),
    ]
)
def update_dropdown(pune_clicks, sur_clicks):
    if pune_clicks or sur_clicks:
        ctx = dash.callback_context
        if ctx.triggered_id:
            triggered_id = ctx.triggered_id.split('.')[0]
            if triggered_id == 'pune_div':
                return "Pune"  , pune.layout
            elif triggered_id == 'sur_div':
                return "Solapur" , sur.layout
    return "Select Division" , None



if __name__ == '__main__':
    app.run_server(debug=True)