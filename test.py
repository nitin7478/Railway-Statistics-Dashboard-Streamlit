from dash import Dash, html, dcc , Input , Output, callback
import dash_bootstrap_components as dbc
import dash

# Use flatly theme
external_css = [dbc.themes.CERULEAN]

app = Dash(__name__, pages_folder='pages', use_pages=True, external_stylesheets=external_css,
           meta_tags=[{'name': 'viewport', 'content': 'width=device-width, initial-scale=1.0'}])

page_order = ['/pune', '/sur', '/csmt', '/ngp', '/bsl', '/contact']
# Navbar component


navbar = dbc.Navbar(
    [
        html.A('Central Railway', href="/pune",
               className="container navbar-brand"),
        dbc.Nav(
            [
                dbc.NavItem(
                    dcc.Link(
                        page['name'],
                        href=page["relative_path"],
                        className="nav-link",
                        # Add margin to increase space between NavItems
                        style={"margin-right": "20px", 'width': '150px'},
                    )
                )
                for page_path in page_order
                for page in dash.page_registry.values()
                if page['relative_path'] == page_path and page['relative_path']
            ],
            fill=True,  # Add fill parameter to stretch items to the right
            navbar=True,
            className='navbar-nav  me-auto',
        ),
    ],
    className='navbar navbar-expand-lg fixed-top bg-primary',
    color="dark",
    dark=True,
)

# App layout
app.layout = dbc.Container([html.Div([
    navbar,  # Include the navbar
    html.Div(children=[
        dash.page_container
    ], style={'marginTop': '100px'})

])
])


if __name__ == '__main__':
    app.run_server(debug=True)
