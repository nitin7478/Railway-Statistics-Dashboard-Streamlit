import pandas as pd
import dash
from dash import html, dash_table, dcc
import plotly.graph_objects as go
import dash_bootstrap_components as dbc
# dash.register_page(__name__, path='/pune', name="Pune")
from src.components.database_connection import load_division_earnings_data
import plotly.graph_objects as go
import datetime
import pandas as pd


def update_overview_page(selected_division):
    layout = dbc.Container([
        dbc.Row([
                dbc.Col([
                    dbc.Card([
                        dbc.CardBody(
                            [
                                html.H6(f"{selected_division}",
                                        className="bi bi-currency-rupees me-2"),
                                html.H5(
                                    [
                                        "134.5",
                                    ],
                                    className="",
                                ),
                                html.I(
                                    "5.8%", className="bi bi-caret-up-fill me-2 text-success"),
                                "vs previous"
                            ], className="border-start border-success border-5"
                        ),
                    ], className="text-center m-4",),
                ], width=2 , xs=12 , sm=12, md=6, lg=4 , xl=2),
                dbc.Col([
                    dbc.Card([
                             dbc.CardBody(
                                 [
                                     html.H6(f"Passenger Revenue",
                                             className="bi bi-currency-rupees me-2"),
                                     html.H3(
                                         [
                                             "134.5",
                                         ],
                                         className="",
                                     ),
                                     html.I(
                                         "5.8%", className="bi bi-caret-up-fill me-2 text-success"),
                                     "vs previous"
                                 ], className="border-start border-success border-5"
                             ),
                             ], className="text-center m-4",),
                ], width=2 , xs=12 , sm=12, md=6, lg=4 , xl=2),
                dbc.Col([
                    dbc.Card([
                        dbc.CardBody(
                            [
                                html.H6(f"Goods Revenue",
                                        className="bi bi-currency-rupees me-2"),
                                html.H3(
                                    [
                                        "134.5",
                                    ],
                                    className="",
                                ),
                                html.I(
                                    "5.8%", className="bi bi-caret-up-fill me-2 text-success"),
                                "vs previous"
                            ], className="border-start border-success border-5"
                        ),
                    ], className="text-center m-4",),
                ], width=2 , xs=12 , sm=12, md=6, lg=4 , xl=2),
                dbc.Col([
                    dbc.Card([
                        dbc.CardBody(
                            [
                                html.H6(f"Other Coaching Revenue",
                                        className="bi bi-currency-rupees me-2"),
                                html.H3(
                                    [
                                        "134.5",
                                    ],
                                    className="",
                                ),
                                html.I(
                                    "5.8%", className="bi bi-caret-up-fill me-2 text-success"),
                                "vs previous"
                            ], className="border-start border-success border-5"
                        ),
                    ], className="text-center m-4",),
                ], width=2 , xs=12 , sm=12, md=6, lg=4 , xl=2),
                dbc.Col([
                    dbc.Card([
                        dbc.CardBody(
                            [
                                html.H6(f"Sundry Revenue",
                                        className="bi bi-currency-rupees me-2"),
                                html.H3(
                                    [
                                        "134.5",
                                    ],
                                    className="",
                                ),
                                html.I(
                                    "5.8%", className="bi bi-caret-up-fill me-2 text-success"),
                                "vs previous"
                            ], className="border-start border-success border-5"
                        ),
                    ], className="text-center m-4",),
                ], width=2 , xs=12 , sm=12, md=6, lg=4 , xl=2),
                dbc.Col([
                    dbc.Card([
                        dbc.CardBody(
                            [
                                html.H6(f"Originating Passengers traffic",
                                        className="bi bi-currency-rupees me-2"),
                                html.H3(
                                    [
                                        "134.5",
                                    ],
                                    className="",
                                ),
                                html.I(
                                    "5.8%", className="bi bi-caret-up-fill me-2 text-success"),
                                "vs previous"
                            ], className="border-start border-success border-5"
                        ),
                    ], className="text-center m-4",),
                ],width=2 , xs=12 , sm=12, md=6, lg=4 , xl=2),

                ], className='flex'),
        dbc.Row([
            dbc.Col(
                [
                    dcc.Graph(
                        figure=plot_bar_chart(selected_division)
                    )
                ], width= 6, xs=12 , sm=12, md=6 , lg=6, xl=6,
            ),
             dbc.Col(
                [
                    dcc.Graph(
                        figure=draw_revenue_trend_lines(selected_division)
                    )
                ], width= 6, xs=12 , sm=12, md=6 , lg=6, xl=6,
            )

        ], className='flex')
    ], fluid=True, className="flex")

    return layout


def plot_bar_chart(selected_division):
    earnings_df = load_division_earnings_data(selected_division)
    current_date = datetime.datetime.now()
    current_year = current_date.year
    current_month = current_date.month

    if current_month < 4:  # Financial year starts from April
        start_year = current_year - 1
        end_year = current_year
    else:
        start_year = current_year
        end_year = current_year + 1

    financial_year_start = pd.Timestamp(year=start_year, month=4, day=1)
    financial_year_end = pd.Timestamp(year=end_year, month=3, day=1)
    financial_year_data = earnings_df[(earnings_df['earning_month'] >= financial_year_start) &
                                      (earnings_df['earning_month'] <= financial_year_end)]
    previous_financial_year_start = pd.Timestamp(
        year=start_year-1, month=4, day=1)
    previous_financial_year_end = pd.Timestamp(
        year=end_year-1, month=3, day=31)
    previous_year_data = earnings_df[(earnings_df['earning_month'] >= previous_financial_year_start) &
                                     (earnings_df['earning_month'] <= previous_financial_year_end)]

    # Extract revenue data for current and previous financial years
    combined_data = pd.concat([financial_year_data.assign(year='Current Financial Year'),
                               previous_year_data.assign(year='Previous Financial Year')])
    current_year_revenue = combined_data.loc[combined_data['year']
                                             == 'Current Financial Year', 'gross_total']
    previous_year_revenue = combined_data.loc[combined_data['year']
                                              == 'Previous Financial Year', 'gross_total']
    # List of months
    months = ['Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep',
              'Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar']

    # Create side-by-side bar charts
    fig = go.Figure()
    fig.add_trace(go.Bar(
        x=months,
        y=current_year_revenue,
        name=f'{financial_year_start.year} - {financial_year_start.year + 1}',
        marker_color='indianred'
    ))
    fig.add_trace(go.Bar(
        x=months,
        y=previous_year_revenue,
        name=f'{financial_year_start.year - 1} - {financial_year_start.year}',
        marker_color='lightsalmon',
    ))

    # Modify the tickangle of the xaxis for better readability
    fig.update_layout(barmode='group', xaxis_tickangle=-45)

    fig.update_layout(
        title='Revenue Comparison',
        xaxis_title='Month',
        yaxis_title='Total Revenue',
        legend=dict(
            x=0.5,  # Change the x-coordinate of the legend
            y=1.25,  # Change the y-coordinate of the legend
            traceorder='normal',  # Order of the legend items
            font=dict(
                family='sans-serif',
                size=12,
                color='black'
            ),
            bgcolor='rgba(255, 255, 255, 0.5)',  # Background color of the legend
            bordercolor='rgba(0, 0, 0, 0.5)',  # Border color of the legend
            borderwidth=1,  # Border width of the legend
            orientation='h',  # Horizontal orientation of the legend
        )
    )
    return fig

import plotly.graph_objects as go
import pandas as pd
from plotly.subplots import make_subplots

def draw_revenue_trend_lines(selected_division):
    earnings_df = load_division_earnings_data(selected_division)
    # Sort earning_month column by oldest to newest
    earnings_df = earnings_df.sort_values(by='earning_month')

    # Create a figure with subplots
    fig = make_subplots(rows=2, cols=2, subplot_titles=('Total Passenger Revenue', 'Freight', 'Other Coaching', 'Sundry'))

    # Add trend lines for each category
    fig.add_trace(
        go.Scatter(x=earnings_df['earning_month'], y=earnings_df['total_pass'], mode='lines+markers', showlegend=False),
        row=1, col=1
    )
    fig.add_trace(
        go.Scatter(x=earnings_df['earning_month'], y=earnings_df['freight'], mode='lines+markers', showlegend=False),
        row=1, col=2
    )
    fig.add_trace(
        go.Scatter(x=earnings_df['earning_month'], y=earnings_df['other_coaching'], mode='lines+markers', showlegend=False),
        row=2, col=1
    )
    fig.add_trace(
        go.Scatter(x=earnings_df['earning_month'], y=earnings_df['sundry'], mode='lines+markers', showlegend=False),
        row=2, col=2
    )

    # Update figure layout
    fig.update_layout(
        title='Trend Lines for Revenue Categories Over Time',
        title_x=0.5,  # Center title
        xaxis_title='Earning Month',
        yaxis_title='Revenue',
        xaxis=dict(title=dict(standoff=10)),  # Change location of x-axis title
        height=400,
        width=800,
        margin=dict(t=50, b=30, r=20)  # Adjust top margin
    )

    return fig





def plot_cards(selected_division):
    pass
