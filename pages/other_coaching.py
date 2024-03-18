from dash import html , callback , Input, Output, dcc
import dash_bootstrap_components as dbc
from src.components.database_connection import handle_database
from src.constants.constants import *
import plotly.graph_objects as go
from plotly.subplots import make_subplots
import textwrap
class load_other_coaching_page:
    def __init__(self , selected_division):
        self.selected_division= selected_division
        handle_database_object = handle_database()
        handle_database_object.load_dataframe(self.selected_division, DB_DIVISION_TC_MONTHWISE_CASES_EARNINGS)
        self.full_tc_monthwise_df = handle_database_object.full_dataframe
        self.cy_tc_monthwise_upto_current_month_df = handle_database_object.cy_dataframe_upto_current_month
        self.ly_tc_monthwise_upto_current_month_df = handle_database_object.ly_dataframe_upto_current_month
        self.ly_tc_monthwise_df = handle_database_object.ly_dataframe
        self.cy_tc_target_df = handle_database_object.cy_division_target_df
    
    
    def comparison_line_plot_tc_cases_rv(self, feature):
        current_year_df = self.cy_tc_monthwise_upto_current_month_df.sort_values(by='earning_month')
        previous_year_df = self.ly_tc_monthwise_df.sort_values(by='earning_month')
        target_df = self.cy_tc_target_df.sort_values(by='earning_month')
        
        months = ['Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep',
                    'Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar']
       
        # Create a figure with subplots
        fig = go.Figure()
        
        if feature == 'cases':
            label = 'Total Cases'
            unit = ''
            legend = 'Cases'
            target_feature = 'tc_cases'
            self.monthly_avg_current_cases = round(current_year_df[feature].mean(),2)
            self.daily_avg_current_cases = round(self.monthly_avg_current_cases / 30,2)
        elif feature == 'amount':
            label = 'Total Amount'
            legend = 'TTL AMT'
            unit = 'Crores'
            target_feature = 'tc_amt'
            self.monthly_avg_current_amt = round(current_year_df[feature].mean(),2)
            self.daily_avg_current_amt = round(self.monthly_avg_current_amt / 30,2)
        
            
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
        
        if target_df is not None :
            target_df  = target_df.sort_values(by='earning_month')
            fig.add_trace(
                go.Scatter(x=months,
                        y=target_df[target_feature],
                        mode='lines+markers',
                        showlegend=True,
                        name=f'TGT {legend}',
                        hovertemplate = f'Month: %{{x}}<br>Last Year {label[0].upper()}{label[1:]}: %{{y:.2f}} {unit}'),
            )
        

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
                size=12,
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

        return fig
    
        
        
def update_other_coaching_page(selected_division):
    if selected_division is not None:
        class_object = load_other_coaching_page(selected_division=selected_division)
        figure_compare_tc_cases =  class_object.comparison_line_plot_tc_cases_rv('cases')
        figure_compare_tc_amt  = class_object.comparison_line_plot_tc_cases_rv('amount')
        
        layout = dbc.Container([
            dbc.Row([
                dbc.Col([
                    dbc.Row([
                        dbc.Col([
                            "Hello"
                        ],width=4, xs=12, sm=12, md=4, lg=4, xl=4),
                        dbc.Col([
                            class_object.daily_avg_current_cases
                        ],
                        width=4, xs=12, sm=12, md=4, lg=4, xl=4,
                        className="border-secondary border rounded text-center fw-bold",
                        id="cy_daily_avg_revenue_tc"),
                        dbc.Col([
                            class_object.monthly_avg_current_cases
                        ],
                        width=4, xs=12, sm=12, md=4, lg=4, xl=4,
                        className="border-secondary border rounded fw-bold",
                        id="cy_monthly_avg_revenue_tc"),
                        
                    ],className="m-1"),
                    
                    dcc.Graph(
                        figure = figure_compare_tc_cases,
                        id='compare_tc_cases',
                        config={
                            'displayModeBar': False
                            },
                        # style={'position': 'relative', 'width': '100%', 'height': '100%'}
                    )
                    ],  xs=12, sm=12, md=6, lg=6, xl=6,
                    className="border-secondary border rounded"),
        
                    dbc.Col([
                        dbc.Row([
                        dbc.Col([
                                "Hello"
                        ], xs=12, sm=12, md=4, lg=4, xl=4),
                        dbc.Col([
                            class_object.daily_avg_current_amt
                        ],
                         xs=12, sm=12, md=4, lg=4, xl=4,
                        className="border-secondary border rounded fw-bold",
                        id="cy_daily_tc_revenue"),
                        dbc.Col([
                            class_object.monthly_avg_current_amt
                        ],
                        width=4, xs=12, sm=12, md=4, lg=4, xl=4,
                        className="border-secondary border rounded fw-bold",
                        id="cy_monthly_tc_revenue"),
                        
                        ], className='m-1'),
                        dcc.Graph (
                            figure = figure_compare_tc_amt,
                            id='compare_tc_revenue',
                            config={
                            'displayModeBar': False
                            },
                            # style={'position': 'relative', 'width': '100%', 'height': '100%'}
                        )
                    ], width=5, xs=12, sm=12, md=6, lg=6, xl=6,
                    className="border-secondary border rounded"),

            ], className="flex"),
            
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

    
        