from dash import html, callback, Input, Output, dcc
import dash_bootstrap_components as dbc
from src.components.database_connection import handle_database
from src.constants.constants import *
import plotly.graph_objects as go
from plotly.subplots import make_subplots
import textwrap

class load_other_coaching_page:
    def __init__(self, selected_division):
        self.selected_division = selected_division
        handle_database_object = handle_database()
        handle_database_object.load_dataframe(
            self.selected_division, DB_DIVISION_TC_MONTHWISE_CASES_EARNINGS)
        self.full_tc_monthwise_df = handle_database_object.full_dataframe_upto_current_month
        self.cy_tc_monthwise_upto_current_month_df = handle_database_object.cy_dataframe_upto_current_month
        self.ly_tc_monthwise_upto_current_month_df = handle_database_object.ly_dataframe_upto_current_month
        self.ly_tc_monthwise_df = handle_database_object.ly_dataframe
        self.cy_tc_target_df = handle_database_object.cy_division_target_df

        handle_database_object.load_dataframe(
            self.selected_division, DB_DIVISION_TC_STATEMENT_OF_EARNINGS)
        self.full_tc_statement_of_earnings = handle_database_object.full_dataframe_upto_current_month
        self.cy_tc_statement_of_earning = handle_database_object.cy_dataframe_upto_current_month
        self.ly_tc_statement_of_earning = handle_database_object.ly_dataframe_upto_current_month

    def comparison_line_plot_tc_cases_rv(self, feature):
        current_year_df = self.cy_tc_monthwise_upto_current_month_df.sort_values(
            by='earning_month')
        previous_year_df = self.ly_tc_monthwise_df.sort_values(
            by='earning_month')
        target_df = self.cy_tc_target_df.sort_values(by='earning_month')

        months = ['Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep',
                  'Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar']

        # Create a figure with subplots
        fig = go.Figure()

        if feature == 'cases':
            label = 'Total Cases'
            unit = ' '
            legend = 'Cases'
            target_feature = 'tc_cases'
            self.monthly_avg_current_cases = round(
                current_year_df[feature].mean(), 2)
            self.daily_avg_current_cases = round(
                self.monthly_avg_current_cases / 30, 2)
            self.daily_avg_current_cases = f"CY Daily Avg : {self.daily_avg_current_cases}"
            self.monthly_avg_current_cases = f"CY Month Avg : {self.monthly_avg_current_cases}"
        elif feature == 'amount':
            label = 'Total Amount'
            legend = 'TTL AMT'
            unit = 'Crores'
            target_feature = 'tc_amt'
            self.monthly_avg_current_amt = round(
                current_year_df[feature].mean(), 2)
            self.daily_avg_current_amt = round(
                self.monthly_avg_current_amt / 30, 2)
            self.monthly_avg_current_amt = f"CY Month Avg : {self.monthly_avg_current_amt}"
            self.daily_avg_current_amt = f"CY Daily Avg : {self.daily_avg_current_amt}"

        # Add trend lines for each category
        fig.add_trace(
            go.Scatter(x=months,
                       y=current_year_df[feature],
                       mode='lines+markers',
                       name=f'CY {legend}',
                       hovertemplate=f'Month: %{{x}}<br>Current Year {label[0].upper()}{label[1:]}: %{{y:.2f}} {unit}'
                       )
        )
        fig.add_trace(
            go.Scatter(x=months,
                       y=previous_year_df[feature],
                       mode='lines+markers',
                       name=f'LY {legend}',
                       hovertemplate=f'Month: %{{x}}<br>Last Year {label[0].upper()}{label[1:]}: %{{y:.2f}} {unit}'
                       )
        ),

        if target_df is not None:
            target_df = target_df.sort_values(by='earning_month')
            fig.add_trace(
                go.Scatter(x=months,
                           y=target_df[target_feature],
                           mode='lines+markers',
                           showlegend=True,
                           name=f'TGT {legend}',
                           hovertemplate=f'Month: %{{x}}<br>Last Year {label[0].upper()}{label[1:]}: %{{y:.2f}} {unit}'),
            )

        # Update figure layout
        fig.update_layout(
            xaxis_tickangle=-45,
            title="<br>".join(textwrap.wrap(
                f'{label[0].upper()}{label[1:]} Comparison {unit}', width=22)),
            title_x=0.01,  # Center title
            yaxis_title=f'{label[0].upper()}{label[1:]} {unit}',
            margin=dict(t=50, b=10, r=10),  # Adjust top margin
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
                # Background color of the legend
                bgcolor='rgba(255, 255, 255, 0.5)',
                bordercolor='rgba(0, 0, 0, 0.5)',  # Border color of the legend
                borderwidth=1,  # Border width of the legend
                orientation='h',
            ),
            yaxis=dict(
                title_font=dict(size=15),  # Adjust font size of y-axis title
            ),
        )

        fig.update_xaxes(showline=True, linewidth=2, linecolor='black',)
        
        monthly_avg_current = round(current_year_df[feature].mean(),2)
        daily_avg_current = round(monthly_avg_current / 30,2)
        

        return fig, daily_avg_current , monthly_avg_current

    def draw_revenue_trend_lines(self):
        earnings_df = self.full_tc_monthwise_df
        earnings_df = earnings_df.sort_values(by='earning_month')

        # Create a figure with subplots
        fig = go.Figure()

        # Add trend lines for each category
        fig.add_trace(
            go.Scatter(x=earnings_df['earning_month'], y=earnings_df['amount'],
                       mode='lines+markers', showlegend=True, name='Total Revenue',)
        )
        # fig.add_trace(
        #     go.Scatter(x=earnings_df['earning_month'], y=self.full_tc_statement_of_earnings['pwt_amt'], mode='lines+markers', showlegend=True, name='Passenger'),
        # )

        # fig.add_trace(
        #     go.Scatter(x=earnings_df['earning_month'], y=earnings_df['freight'], mode='lines+markers', showlegend=True, name='Freight'),

        # )
        # fig.add_trace(
        #     go.Scatter(x=earnings_df['earning_month'], y=earnings_df['other_coaching'], mode='lines+markers', showlegend=True, name='Other Coaching'),

        # )
        # fig.add_trace(
        #     go.Scatter(x=earnings_df['earning_month'], y=earnings_df['sundry'], mode='lines+markers', showlegend=True, name='Sundry'),

        # )

        # Update figure layout
        fig.update_layout(
            xaxis_tickangle=-45,
            title="<br>".join(textwrap.wrap('TC Revenue Trend', width=10)),
            title_x=0.01,
            yaxis_title='Revenue in Cr',
            margin=dict(t=10, b=10, r=10),  # Adjust top margin
            legend=dict(
                yanchor="top",
                y=1.15,
                xanchor="right",
                x=1,  # Change the y-coordinate of the legend
                traceorder='normal',  # Order of the legend items
                font=dict(
                    family='sans-serif',
                    size=15,
                    color='black'
                ),
                # Background color of the legend
                bgcolor='rgba(255, 255, 255, 0.5)',
                bordercolor='rgba(0, 0, 0, 0.5)',  # Border color of the legend
                borderwidth=1,  # Border width of the legend
                orientation='h',
                # yanchor="bottom",
            ),
        )
        fig.update_xaxes(showline=True, linewidth=2, linecolor='black',)

        return fig

    def plot_pie_chart(self,):

        cy_data = {
            'PWT': self.cy_tc_statement_of_earning['pwt_amt'].sum(),
            'UBL': self.cy_tc_statement_of_earning['ubl_amt'].sum(),
            'IRREGULAR':  self.cy_tc_statement_of_earning['irregular_amt'].sum(),
        }

        ly_data = {
            'PWT': self.ly_tc_statement_of_earning['pwt_amt'].sum(),
            'UBL': self.ly_tc_statement_of_earning['ubl_amt'].sum(),
            'IRREGULAR':  self.ly_tc_statement_of_earning['irregular_amt'].sum(),
        }
        fig = make_subplots(rows=2, cols=1, specs=[
                            [{'type': 'domain'}], [{'type': 'domain'}]])

        values = list(cy_data.values())
        names = list(cy_data.keys())
        values_ly = list(ly_data.values())
        names_ly = list(ly_data.keys())

        # Add pie charts to the subplots
        fig.add_trace(go.Pie(values=values, labels=names,
                             title=f"<br>".join(textwrap.wrap(
                                 'CY : TC Revenue', width=7, )),
                             textinfo='label+percent',
                             showlegend=False, insidetextorientation='radial'),
                      row=1, col=1)
        fig.add_trace(go.Pie(values=values_ly, labels=names_ly,
                             title=f"<br>".join(textwrap.wrap(
                                 'LY : TC Revenue', width=7, )),
                             textinfo='label+percent',
                             showlegend=False, insidetextorientation='radial'),
                      row=2, col=1)
        fig.update_traces(hole=.8, hoverinfo="label+percent+name+value",  textfont_size=15,
                          titlefont_size=18,)
        fig.update_layout(
            margin=dict(t=0, b=0, r=0),
            legend=dict(
                x=0.01,  # Change the x-coordinate of the legend
                y=1.15,  # Change the y-coordinate of the legend
                traceorder='normal',  # Order of the legend items
                font=dict(
                    family='sans-serif',
                    size=15,
                    color='black'
                ),
                # Background color of the legend
                bgcolor='rgba(255, 255, 255, 0.5)',
                bordercolor='rgba(0, 0, 0, 0.5)',  # Border color of the legend
                borderwidth=1,  # Border width of the legend
                orientation='v',
                # title_font=dict(size=16),
            ),
        )
        return fig


def update_other_coaching_page(selected_division):
    if selected_division is not None:
        class_object = load_other_coaching_page(
            selected_division=selected_division)
        figure_compare_tc_cases = class_object.comparison_line_plot_tc_cases_rv(
            'cases')
        figure_compare_tc_amt = class_object.comparison_line_plot_tc_cases_rv(
            'amount')

        layout = dbc.Container([
            dbc.Row([
                dbc.Col([
                    dbc.Row([
                        dbc.Col([
                            dcc.Dropdown(
                                id='dropdown_tc_rev_cases',
                                options=[
                                    {'label': 'Total TC Revenue',
                                     'value': f"total_tc_revenue_{selected_division}"},
                                    {'label': 'Total TC Cases',
                                     'value': f"total_tc_cases_{selected_division}"},
                                ],
                                value=f"total_tc_revenue_{selected_division}",
                                # placeholder="Select Type",# default value
                                clearable=False,
                                optionHeight=80
                            ),
                            ], width=4, xs=12, sm=12, md=4, lg=4, xl=4),
                        dbc.Col([
                            html.Div(class_object.daily_avg_current_cases,
                                     id="cy_daily_avg_revenue_tc")
                            ],
                            width=4, xs=12, sm=12, md=4, lg=4, xl=4,
                            className="border-secondary border rounded text-center fs-6",
                            ),
                        dbc.Col([
                            html.Div(class_object.monthly_avg_current_cases,
                                     id="cy_monthly_avg_revenue_tc")
                            ],
                            width=4, xs=12, sm=12, md=4, lg=4, xl=4,
                            className="border-secondary border rounded text-center fs-6",
                             ),

                    ], className=""),

                    dcc.Graph(
                        # figure=figure_compare_tc_cases,
                        id='compare_tc_revenue_cases',
                        config={
                            'displayModeBar': False
                        },
    
                    )
                ],  xs=12, sm=12, md=12, lg=12, xl=5,
                    className="border-secondary border rounded"),
                dbc.Col([
                    dcc.Graph(
                        figure=class_object.plot_pie_chart(),
                        config={
                            'displayModeBar': False,
                        },
                        id='tc_revenue_pie_chart'
                        )
                    ], xs=12, sm=12, md=12, lg=12, xl=2,
                    className="border-secondary border rounded"),

                dbc.Col([
                    dcc.Graph(
                        figure=class_object.draw_revenue_trend_lines(),
                        id = 'tc_revenue_cases_trendline',
                        config={
                            'displayModeBar': False,
                        },
                    )
                    ],  xs=12, sm=12, md=12, lg=12, xl=5,
                    className="border-secondary border rounded"),
            ], className="flex"),
            dbc.Row([
         

            ], className="flex")

        ], fluid=True,
            className="m-1")
        return layout
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
        return layout


@callback(
    Output('compare_tc_revenue_cases', 'figure'),
    Output('dropdown_tc_rev_cases', 'label'),
    Output('cy_daily_avg_revenue_tc', 'children'),
    Output('cy_monthly_avg_revenue_tc', 'children'),
    [Input('dropdown_tc_rev_cases', 'value'),
     ],
    prevent_initial_call=False,
)
def update_tc_graph(dropdown_value):
    try:
        if dropdown_value is not None:
            parts = dropdown_value.split('_')
            selected_division = parts[-1]
            selected_feature = '_'.join(parts[:-1])
            class_object = load_other_coaching_page(selected_division)

            if 'total_tc_revenue' == selected_feature:
                feature = 'amount'
                label = "Total TC Revenue"
            elif 'total_tc_cases' == selected_feature:
                feature = 'cases'
                label = 'Total TC Cases'
            figure, daily_avg_current, monthly_avg_current = class_object.comparison_line_plot_tc_cases_rv(
                feature)
            daily_avg_current = f"CY Daily Avg : {daily_avg_current}"
            monthly_avg_current = f"CY Month Avg : {monthly_avg_current}"
            return figure, label, daily_avg_current, monthly_avg_current
    except Exception as e:
        raise e
