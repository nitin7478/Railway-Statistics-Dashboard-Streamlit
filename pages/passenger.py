import dash_bootstrap_components as dbc
from pages.overview import overview_graphs_buttons
from dash import dcc, html, Input , Output , callback
import dash


from src.components.plot_functions import comparison_line_plot,\
                            yearly_data_comparison_line_plot,\
                                plot_pie_chart

class plot_passenger_graphs:
    def __init__(self, selected_division):
        self.selected_division = selected_division


def update_passenger_page(selected_division):
    class_object = plot_passenger_graphs(selected_division=selected_division)
    layout = dbc.Container([
        dbc.Row([
            dbc.Col([
                dbc.DropdownMenu(
                    label="Select Type",
                    children=[
                        dbc.DropdownMenuItem(
                            "Total Revenue", id="dropdown_total_rv"),
                        dbc.DropdownMenuItem(
                            "Sub-Urban Revenu", id="dropdown_subub_rv",),
                        dbc.DropdownMenuItem(
                            "Non-Sub Urban Revenue", id="dropdown_nonsubub_rv"),
                    ],
                    id='dropdown_total_revenue', color="secondary",
                ),
                dcc.Graph(
                    id='compare_pass_rv',
                    # style={'position': 'relative', 'width': '100%', 'height': '100%'}
                )
            ], width=5, xs=12, sm=12, md=5, lg=5, xl=5, className="border-secondary border rounded"),
            # dbc.Col([
            #     dcc.Graph(
            #         # figure=class_object.pot_pie_chart_this_page(),
            #         id="pie_chart_revenue"
            #     )
            # ], width=2, xs=12, sm=12, md=2, lg=2, xl=2, className="border-secondary border rounded"),
            # dbc.Col([
            #     dbc.DropdownMenu(
            #         label="Select Type",
            #         children=[
            #             dbc.DropdownMenuItem(
            #                 "Total Pass", id="dropdown_total_pass", header=selected_division),
            #             dbc.DropdownMenuItem(
            #                 "Sub-Urban Pass", id="dropdown_subub_pass",),
            #             dbc.DropdownMenuItem(
            #                 "Non-Sub Urban Pass", id="dropdown_nonsubub_pass"),
            #         ],
            #         id='dropdown_total_pass', color="secondary",
            #         # style={'position': 'absolute', 'top': '10px', 'right': '20px', 'zIndex': '9999'},
            #         # className="ms-auto bg-light border"
            #     ),

            #     dcc.Graph(
            #         id='compare_pass_pass',
            #         # style={'position': 'relative', 'width': '100%', 'height': '100%'}
            #     )
            # ], width=5, xs=12, sm=12, md=5, lg=5, xl=5, className="border-secondary border rounded"),

        ], className="flex"),
    ], fluid=True)
    return layout



# @callback(
#     Output('compare_pass_rv', 'figure'),
#     Output('dropdown_total_revenue', 'label'),
#     [Input('dropdown_total_rv', 'n_clicks'),
#      Input('dropdown_subub_rv', 'n_clicks'),
#      Input('dropdown_nonsubub_rv', 'n_clicks'),
#      ]
# )
# def update_graph(n_clicks_ttl, n_clicks_subub, n_clicks_nonsub):
#     changed_id = [p['prop_id'] for p in dash.callback_context.triggered][0]
#     if 'dropdown_total_rv' in changed_id:
#         feature = 'total_pass'
#         label = "Total"
#     elif 'dropdown_subub_rv' in changed_id:
#         feature = 'uts_sub_urban_pass'
#         label = 'Sub-Urban'
#     elif 'dropdown_nonsubub_pass' in changed_id:
#         feature = 'uts_non_sub_urban_pass'
#         label = 'Non-Sub-Urban'
#     else:
#         feature = 'total_pass'
#         label = "Total"
#     # Assuming you have defined the comparison_line_plot function
#     figure = comparison_line_plot(
#         feature=feature,
#         current_year_df=class_object.current_year_upto_this_month_year_data,
#         previous_year_df=class_object.previous_financia_year_data,
#         target_df=class_object.current_year_division_target
#     )
#     return figure, label