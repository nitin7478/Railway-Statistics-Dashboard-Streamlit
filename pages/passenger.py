import dash_bootstrap_components as dbc
from pages.overview import overview_graphs_buttons
from dash import dcc, html, Input , Output , callback, dash_table
from dash.exceptions import PreventUpdate
import dash
from src.components.database_connection import handle_database
from src.constants.constants import *
from pages.overview import overview_graphs_buttons
import plotly.graph_objects as go
from plotly.subplots import make_subplots
import textwrap

class plot_passenger_graphs:
    def __init__(self, selected_division):
        self.selected_division = selected_division
        class_object_overview_page_for_data = overview_graphs_buttons(selected_division)

        
        self.cy_dateframe = class_object_overview_page_for_data.cy_dateframe
        self.cy_target_df = class_object_overview_page_for_data.cy_target_df
        self.ly_year_df = class_object_overview_page_for_data.ly_year_df
        self.full_dataframe = class_object_overview_page_for_data.full_dataframe.sort_values(by='earning_month', ascending=False)
        
        self.cy_dataframe_upto_current_month = class_object_overview_page_for_data.cy_dataframe_upto_current_month
        self.cy_target_upto_current_month = class_object_overview_page_for_data.cy_target_upto_current_month
        self.ly_dataframe_upto_current_month = class_object_overview_page_for_data.ly_dataframe_upto_current_month
        
    def comparison_line_plot_pass(self, feature):
        current_year_df = self.cy_dataframe_upto_current_month.sort_values(by='earning_month')
        previous_year_df = self.ly_year_df.sort_values(by='earning_month')
        target_df = self.cy_target_df.sort_values(by='earning_month')
        
        months = ['Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep',
                    'Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar']
       
        # Create a figure with subplots
        fig = go.Figure()
        
        if feature == 'total_pass':
            label = 'Total Pass Revenue'
            unit = 'Crores'
            legend = 'Total'
        elif feature == 'uts_sub_urban_pass':
            label = 'Sub-Urban Pass Revenue'
            legend = 'Sub-Urb'
            unit = 'Crores'
        elif feature == 'non_sub_urban_revenue':
            label = 'Non-Sub Pass Revenue'
            unit = 'Crores'
            legend = 'Non-Sub'
            feature = 'non_sub_urban_revenue'
            current_year_df[feature] = current_year_df['uts_non_sub_pass'] + current_year_df['prs_pass']
            previous_year_df[feature] = previous_year_df['uts_non_sub_pass'] + previous_year_df['prs_pass']
            target_df[feature] = target_df['non_sub_pass']
        elif feature == 'total_passengers':
            legend = 'Total'
            label = 'Total Pass Traffic'
            unit = 'Lakhs'
        elif feature =='sub_passengers':
            legend = 'Sub-Urb'
            label = 'Sub-Urban Pass Traffic'
            unit = 'Lakhs'
        elif feature =='non_sub_passengers':
            legend = 'Non-Sub-Urb'
            label = 'Non-Sub-Urban Pass Traffic'
            unit = 'Lakhs'
        
            
        # Add trend lines for each category
        fig.add_trace(
            go.Scatter(x=months,
                    y=current_year_df[feature],
                    mode='lines+markers',
                    name=f'CY {legend}',
                    hovertemplate = f'Month: %{{x}}<br>Current Year {label[0].upper()}{label[1:]}: %{{y:.2f}} {unit}'
            )
        )
        fig.add_trace(
            go.Scatter(x=months,
                    y=previous_year_df[feature],
                    mode='lines+markers',
                    name=f'LY {legend}',
                    hovertemplate = f'Month: %{{x}}<br>Last Year {label[0].upper()}{label[1:]}: %{{y:.2f}} {unit}'
            )
        ),
        max_point_for_labale = max(max(current_year_df[feature]), max(previous_year_df[feature]))
        if target_df is not None :
            max_point_for_labale = max(max_point_for_labale , max(target_df[feature]))
            target_df  = target_df.sort_values(by='earning_month')
            fig.add_trace(
                go.Scatter(x=months,
                        y=target_df[feature],
                        mode='lines+markers',
                        showlegend=True,
                        name=f'TGT {legend}',
                        hovertemplate = f'Month: %{{x}}<br>Last Year {label[0].upper()}{label[1:]}: %{{y:.2f}} {unit}'),
            )
        monthly_avg_current = round(current_year_df[feature].mean(),2)
        daily_avg_current = round(monthly_avg_current / 30,2)

        # Update figure layout
        fig.update_layout(
            xaxis_tickangle=-45,
            title= "<br>".join(textwrap.wrap(f'{label[0].upper()}{label[1:]} Comparison ({unit})',width=22)),
            title_x=0.01,# Center title
            yaxis_title=f'{label[0].upper()}{label[1:]} {unit}',
            margin=dict(t=50, b=10,r=10),  # Adjust top margin
            legend=dict(
                yanchor="top",
                y=1.15,
                xanchor="right",
                x=1,
                font=dict(
                family='sans-serif',
                size=15,
                color='black',
                ),
                bgcolor='rgba(255, 255, 255, 0.5)',  # Background color of the legend
                bordercolor='rgba(0, 0, 0, 0.5)',  # Border color of the legend
                borderwidth=1,  # Border width of the legend
                orientation='h',
            ),
            yaxis=dict(
            title_font=dict(size=15),  # Adjust font size of y-axis title
        ),
        )

        fig.update_xaxes(showline=True, linewidth=2, linecolor='black',)

        return fig , daily_avg_current , monthly_avg_current
    
    def plot_pie_chart(self,):

        cy_data = {
            'UTS-Sub': self.cy_dataframe_upto_current_month['uts_sub_urban_pass'].sum(),
            'UTS-Non-Sub': self.cy_dataframe_upto_current_month['uts_non_sub_pass'].sum(),
            'PRS':  self.cy_dataframe_upto_current_month['prs_pass'].sum(),
        }
        
        
        ly_data = {
            'UTS-Sub': self.ly_dataframe_upto_current_month['uts_sub_urban_pass'].sum(),
            'UTS-Non-Sub': self.ly_dataframe_upto_current_month['uts_non_sub_pass'].sum(),
            'PRS':  self.ly_dataframe_upto_current_month['prs_pass'].sum(),
        }
        fig = make_subplots(rows=2, cols=1, specs=[[{'type':'domain'}], [{'type':'domain'}]])

        values = list(cy_data.values())
        names = list(cy_data.keys())
        values_ly = list(ly_data.values())
        names_ly = list(ly_data.keys())

        # Add pie charts to the subplots
        fig.add_trace(go.Pie(values=values, labels=names,
                            title=f"<br>".join(textwrap.wrap('CY : Pass Revenue',width=7, )),
                            textinfo='label+percent',
                            showlegend=False,insidetextorientation='radial'),
                            row=1, col=1)
        fig.add_trace(go.Pie(values=values_ly, labels=names_ly,
                            title=f"<br>".join(textwrap.wrap('LY : Pass Revenue',width=7, )),
                            textinfo='label+percent',
                            showlegend=False,insidetextorientation='radial'),
                            row=2, col=1)
        fig.update_traces(hole=.8, hoverinfo="label+percent+name+value",  textfont_size=15,
                          titlefont_size=18,)
        fig.update_layout(
            margin=dict(t=0, b=0,r=0),
            legend=dict(
                x=0.01,  # Change the x-coordinate of the legend
                y=1.15, # Change the y-coordinate of the legend
                traceorder='normal',  # Order of the legend items
                font=dict(
                    family='sans-serif',
                    size=15,
                    color='black'
                ),
                bgcolor='rgba(255, 255, 255, 0.5)',  # Background color of the legend
                bordercolor='rgba(0, 0, 0, 0.5)',  # Border color of the legend
                borderwidth=1,  # Border width of the legend
                orientation='v',
                # title_font=dict(size=16),
            ),
            )
        return fig
    


def update_passenger_page(selected_division):
    if selected_division is not None:
        class_object = plot_passenger_graphs(selected_division=selected_division)
        layout = dbc.Container([
            dbc.Row([
                dbc.Col([
                    dbc.Row([
                        dbc.Col([
                            dcc.Dropdown(
                            id='dropdown_total_revenue',
                            options=[
                                {'label': 'Total Revenue', 'value': f"total_pass_{selected_division}"},
                                {'label': 'Sub-Urban Revenue', 'value': f"uts_sub_urban_pass_{selected_division}"},
                                {'label': 'Non-Sub Urban Revenue', 'value': f"non_sub_urban_revenue_{selected_division}"}
                            ],
                            value=f"total_pass_{selected_division}", 
                            # placeholder="Select Type",# default value
                            clearable=False,
                            optionHeight=80
                        ),
                        ],width=4, xs=12, sm=12, md=4, lg=4, xl=4, 
                     
                        ),
                        dbc.Col([
                            html.Div(id="cy_daily_avg_revenue")
                        ],
                        width=4, xs=12, sm=12, md=4, lg=4, xl=4,
                        className="border-secondary border rounded text-center fs-6",
                        ),
                        dbc.Col([
                            html.Div(id="cy_monthly_avg_revenue")
                        ],
                        width=4, xs=12, sm=12, md=4, lg=4, xl=4,
                        className="border-secondary border rounded text-center fs-6",
                        id="cy_monthly_avg_revenue"),
                        
                    ],className="m-1"),
                    
                    dcc.Graph(
                        id='compare_pass_rv',
                        config={
                            'displayModeBar': False
                            },
                        # style={'position': 'relative', 'width': '100%', 'height': '100%'}
                    )
                    ], width=5, xs=12, sm=12, md=12, lg=12, xl=5,
                    className="border-secondary border rounded"),
                    dbc.Col([
                        dcc.Graph(
                            figure=class_object.plot_pie_chart(),
                            id="pie_pass_revenue_comparison",
                            config={
                            'displayModeBar': False
                            },
                        )
                    ], width=2, xs=12, sm=12, md=12, lg=12, xl=2,className="border-secondary border rounded"),
                    dbc.Col([
                        dbc.Row([
                        dbc.Col([
                        dcc.Dropdown(
                            id='dropdown_total_pass_traffic',
                            options=[
                                {'label': 'Total Passenger', 'value': f"total_passengers_{selected_division}"},
                                {'label': 'Sub-Urban Passenger', 'value': f"sub_passengers_{selected_division}"},
                                {'label': 'Non-Sub Urban Passenger', 'value': f"non_sub_passengers_{selected_division}"}
                            ],
                            value=f"total_passengers_{selected_division}", 
                            # placeholder="Select Type",# default value
                            optionHeight=80,
                            clearable=False,
                        ),
                        ],width=4, xs=12, sm=12, md=4, lg=4, xl=4),
                        dbc.Col([
                            html.Div(id="cy_daily_avg_pass")
                        ],
                        width=4, xs=12, sm=12, md=4, lg=4, xl=4,
                        className="border-secondary border rounded fs-6 text-center",
                        id="cy_daily_avg_pass"),
                        dbc.Col([
                            html.Div(id='cy_monthly_avg_pass')
                        ],
                        width=4, xs=12, sm=12, md=4, lg=4, xl=4,
                        className="border-secondary border rounded fs-6 text-center",
                        ),
                        
                        ], className='m-1'),
                        dcc.Graph (
                            id='passenger_traffic_trend_comparison',
                            config={
                            'displayModeBar': False
                            },
                            # style={'position': 'relative', 'width': '100%', 'height': '100%'}
                        )
                    ], width=5, xs=12, sm=12, md=12, lg=12, xl=5,
                    className="border-secondary border rounded"),

            ], className="flex"),
            
            # dbc.Row([
            #     dbc.Col([
            #         dash_table.DataTable(data=class_object.full_dataframe.to_dict('records'),)
            #                             #   columns=[i for i in class_object.full_dataframe.columns])
            #         ], width= 12, xs=12 , sm=12, md=12 , lg=12, xl=12,className="border-secondary border rounded",
            #             id='dash_table_for_passenger_data'),
            #     ], className='flex'),
        ], fluid=True,
        className="m-1")
        return layout
    else:
        layout = html.Div([
                    dbc.Container([
                        dbc.Row([
                            dbc.Col([
                                html.H2("Please Select Division")
                            ], className="d-flex justify-content-center align-items-center" , style={'marginTop':20}),
                        ],)
                    ]),
                ])
        return layout


@callback(
    Output('compare_pass_rv', 'figure'),
    Output('dropdown_total_revenue', 'label'),
    Output('cy_daily_avg_revenue', 'children'),
    Output('cy_monthly_avg_revenue', 'children'),
    [Input('dropdown_total_revenue', 'value'),
     ],
    prevent_initial_call=False,
)
def update_graph(dropdown_value):
    try:
        if dropdown_value is not None:
            parts = dropdown_value.split('_')
            selected_division = parts[-1]
            selected_feature = '_'.join(parts[:-1])
            class_object = plot_passenger_graphs(selected_division)
            if 'total_pass' == selected_feature:
                feature = 'total_pass'
                label = "Total Revenue"
            elif 'uts_sub_urban_pass' == selected_feature:
                feature = 'uts_sub_urban_pass'
                label = 'Sub-Urban Revenue'
            elif 'non_sub_urban_revenue' == selected_feature:
                feature = 'non_sub_urban_revenue'
                label = 'Non-Sub Urban Revenue'
            else:
                feature = 'total_pass'
                label = 'Total Revenue'
            figure, daily_avg_current , monthly_avg_current = class_object.comparison_line_plot_pass(feature)
            daily_avg_current = f"CY Daily Avg : {daily_avg_current}"
            monthly_avg_current = f"CY Month Avg : {monthly_avg_current}"
            
            return figure, label , daily_avg_current , monthly_avg_current
    except Exception as e:
        raise e
    
@callback(
    Output('passenger_traffic_trend_comparison', 'figure'),
    Output('dropdown_total_pass_traffic', 'label'),
     Output('cy_daily_avg_pass', 'children'),
    Output('cy_monthly_avg_pass', 'children'),
    [Input('dropdown_total_pass_traffic', 'value'),
    ],
    prevent_initial_call=False,
)
def update_traffic_graph(dropdown_value):
    try:
        if dropdown_value is not None:
            parts = dropdown_value.split('_')
            selected_division = parts[-1]
            selected_feature = '_'.join(parts[:-1])
            class_object = plot_passenger_graphs(selected_division)
            if 'total_passengers' == selected_feature:
                feature = 'total_passengers'
                label = "Total Passengers"
                
            elif 'sub_passengers' == selected_feature:
                feature = 'sub_passengers'
                label = 'Sub-Urban Passengers'
            elif 'non_sub_passengers' == selected_feature:
                feature = 'non_sub_passengers'
                label = 'Non-Sub Urban Passengers'
            else:
                feature = 'total_passengers'
                label = 'Total Passengers'
            figure, daily_avg_current , monthly_avg_current = class_object.comparison_line_plot_pass(feature)
            daily_avg_current = f"CY Daily Avg : {daily_avg_current}"
            monthly_avg_current = f"CY Month Avg : {monthly_avg_current}"
            return figure, label, daily_avg_current , monthly_avg_current
    except Exception as e:
        raise e