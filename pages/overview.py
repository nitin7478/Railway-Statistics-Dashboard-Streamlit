import pandas as pd
import dash
from dash import html, dash_table, dcc
import plotly.graph_objects as go
import dash_bootstrap_components as dbc
# dash.register_page(__name__, path='/pune', name="Pune")
from src.components.database_connection import load_division_earnings_data , load_division_target_data
import plotly.graph_objects as go
import datetime, io
import pandas as pd
from dash import dcc, html, Input, Output, callback
from plotly.subplots import make_subplots
from dash.exceptions import PreventUpdate

def update_overview_page(selected_division):
    class_object = overview_graphs_buttons(selected_division=selected_division)

    layout = dbc.Container([
        dbc.Row([
                dbc.Col([
                    dbc.Card([
                        dbc.CardBody(
                            [
                                html.H6(f"{selected_division} Division Revenue",
                                        className="bi bi-currency-rupees me-2"),
                                        # html.I("In crores"),
                                html.H5(
                                    [
                                        f"{round(class_object.division_current_gross_total_revenue,2)} Cr",
                                    ],
                                    className="",
                                ),
                               html.Div([
                                    html.I(f"{round(((class_object.division_current_gross_total_revenue - class_object.division_previous_gross_total_revenue) / class_object.division_previous_gross_total_revenue) * 100, 2)}%",
                                        className=f"bi bi-caret-up-fill me-2 {'text-success' if class_object.division_current_gross_total_revenue > class_object.division_previous_gross_total_revenue else 'text-danger'}"),
                                    f"vs previous: {round(class_object.division_previous_gross_total_revenue, 2)}"
                                ]),

                                html.Div([
                                    html.I(f"{round(((class_object.division_current_gross_total_revenue - class_object.division_current_year_target_revenue) / class_object.division_current_year_target_revenue) * 100, 2)}%",
                                        className=f"bi bi-caret-up-fill me-2 {'text-success' if class_object.division_current_gross_total_revenue > (class_object.division_current_year_target_revenue) else 'text-danger'}"),
                                    f"vs target:", html.Br(), f"{round(class_object.division_current_year_target_revenue, 2)}"
                                ]),
                                  
    
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
                                html.H5(
                                    [
                                        f"{round(class_object.division_current_passenger_earning_revenue,2)} Cr",
                                    ],
                                    className="",
                                ),
                               html.Div([
                                    html.I(f"{round(((class_object.division_current_passenger_earning_revenue - class_object.division_previous_passenger_earning_revenue) / class_object.division_previous_passenger_earning_revenue) * 100, 2)}%",
                                        className=f"bi bi-caret-up-fill me-2 {'text-success' if class_object.division_current_passenger_earning_revenue > class_object.division_previous_passenger_earning_revenue else 'text-danger'}"),
                                    f"vs previous: {round(class_object.division_previous_passenger_earning_revenue, 2)}"
                                ]),

                                html.Div([
                                    html.I(f"{round(((class_object.division_current_passenger_earning_revenue - class_object.division_current_year_target_passenger_earning_revenue) / class_object.division_current_year_target_passenger_earning_revenue ) * 100, 2)}%",
                                        className=f"bi bi-caret-up-fill me-2 {'text-success' if class_object.division_current_passenger_earning_revenue > class_object.division_current_year_target_passenger_earning_revenue  else 'text-danger'}"),
                                    f"vs target:", html.Br(), f"{round(class_object.division_current_year_target_passenger_earning_revenue, 2)}"
                                ]),
                                  
    
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
                                # html.I("In crores"),
                                html.H5(
                                    [
                                        f"{round(class_object.division_current_year_goods_revenue,2) } Cr",
                                    ],
                                    className="",
                                ),
                               html.Div([
                                    html.I(f"{round(((class_object.division_current_year_goods_revenue - class_object.division_previous_year_goods_revenue) / class_object.division_previous_year_goods_revenue) * 100, 2)}%",
                                        className=f"bi bi-caret-up-fill me-2 {'text-success' if class_object.division_current_year_goods_revenue > class_object.division_previous_gross_total_revenue else 'text-danger'}"),
                                    f"vs previous:", html.Br() ,f"{round(class_object.division_previous_year_goods_revenue, 2)}"
                                ]),

                                html.Div([
                                    html.I(f"{round(((class_object.division_current_year_goods_revenue - class_object.division_current_year_target_goods_revenue) / class_object.division_current_year_target_goods_revenue) * 100, 2)}%",
                                        className=f"bi bi-caret-up-fill me-2 {'text-success' if class_object.division_current_gross_total_revenue > (class_object.division_current_year_target_goods_revenue + 100) else 'text-danger'}"),
                                    f"vs target:" , html.Br(), f"{round(class_object.division_current_year_target_goods_revenue, 2)}"
                                ]),
                            ], className="border-start border-success border-5"
                        ),
                    ], className="text-center m-4",),
                ], width=2 , xs=12 , sm=12, md=6, lg=4 , xl=2),
                dbc.Col([
                    dbc.Card([
                        dbc.CardBody(
                            [
                                html.H6(f"Other Cog Revenue",
                                        className="bi bi-currency-rupees me-2"),
                                # html.I("In crores"),
                                html.H5(
                                    [
                                        f"{round(class_object.division_current_year_other_coaching_revenue,2) } Cr",
                                    ],
                                    className="",
                                ),
                               html.Div([
                                    html.I(f"{round(((class_object.division_current_year_other_coaching_revenue - class_object.division_previous_year_other_coaching_revenue) / class_object.division_previous_year_other_coaching_revenue) * 100, 2)}%",
                                        className=f"bi bi-caret-up-fill me-2 {'text-success' if class_object.division_current_year_other_coaching_revenue > class_object.division_previous_year_other_coaching_revenue else 'text-danger'}"),
                                    f"vs previous:" , html.Br(), f" {round(class_object.division_previous_year_other_coaching_revenue, 2)}"
                                ]),

                                html.Div([
                                    html.I(f"{round(((class_object.division_current_year_other_coaching_revenue - class_object.division_current_year_target_other_coaching_revenue) / class_object.division_current_year_target_other_coaching_revenue ) * 100, 2)}%",
                                        className=f"bi bi-caret-up-fill me-2 {'text-success' if class_object.division_current_year_other_coaching_revenue > class_object.division_current_year_target_other_coaching_revenue  else 'text-danger'}"),
                                    f"vs target:", html.Br(), f"{round(class_object.division_current_year_target_other_coaching_revenue, 2)}"
                                ]),
                                  
    
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
                                # html.I("In crores"),
                                html.H5(
                                    [
                                        f"{round(class_object.division_current_year_sundry_revenue,2) } Cr",
                                    ],
                                    className="",
                                ),
                               html.Div([
                                    html.I(f"{round(((class_object.division_current_year_sundry_revenue - class_object.division_previous_year_sundry_revenue) / class_object.division_previous_year_sundry_revenue) * 100, 2)}%",
                                        className=f"bi bi-caret-up-fill me-2 {'text-success' if class_object.division_current_year_sundry_revenue > class_object.division_previous_year_sundry_revenue else 'text-danger'}"),
                                    f"vs Previous : {round(class_object.division_previous_year_sundry_revenue, 2)}"
                                ]),

                                html.Div([
                                    html.I(f"{round(((class_object.division_current_year_sundry_revenue - class_object.division_current_year_target_sundry_revenue) / class_object.division_current_year_target_sundry_revenue ) * 100, 2)}%",
                                        className=f"bi bi-caret-up-fill me-2 {'text-success' if class_object.division_current_year_sundry_revenue > class_object.division_current_year_target_sundry_revenue  else 'text-danger'}"),
                                    f"vs Target:", html.Br(), f" {round(class_object.division_current_year_target_sundry_revenue, 2)}"
                                ]),
                                  
    
                            ], className="border-start border-success border-5"
                        ),
                    ], className="text-center m-4",),
                ], width=2 , xs=12 , sm=12, md=6, lg=4 , xl=2),
                dbc.Col([
                    dbc.Card([
                        dbc.CardBody(
                            [
                                html.H6(f"Origininating Pass",
                                        className="bi bi-currency-rupees me-2 wrap-text"),
                                # html.I("In Millions"),
                                html.H5(
                                    [
                                        f"{round(class_object.division_current_year_originating_pass,2) } Millions",
                                    ],
                                    className="",
                                ),
                               html.Div([
                                    html.I(f"{round(((class_object.division_current_year_originating_pass - class_object.division_previous_year_originating_pass) / class_object.division_previous_year_originating_pass) * 100, 2)}%",
                                        className=f"bi bi-caret-up-fill me-2 {'text-success' if class_object.division_current_year_originating_pass > class_object.division_previous_year_originating_pass else 'text-danger'}"),
                                    f"vs previous:", html.Br(), f" {round(class_object.division_previous_year_originating_pass, 2)}"
                                ]),

                                html.Div([
                                    html.I(f"{round(((class_object.division_current_year_originating_pass - class_object.division_current_year_target_originating_pass ) / class_object.division_current_year_target_originating_pass ) * 100, 2)}%",
                                        className=f"bi bi-caret-up-fill me-2 {'text-success' if class_object.division_current_year_originating_pass > class_object.division_current_year_target_originating_pass  else 'text-danger'}"),
                                    f"vs target:", html.Br(), f" {round(class_object.division_current_year_target_originating_pass, 2)}"
                                ]),
                                  
    
                            ], className="border-start border-success border-5"
                        ),
                    ], className="text-center m-4",),
                ], width=2 , xs=12 , sm=12, md=6, lg=4 , xl=2),

                ], className='flex'),
        dbc.Row([
            dbc.Col(
                [ 
                    dcc.Graph(
                        figure=class_object.plot_bar_chart()
                    ),
                    html.Button("Download Data", id="btn-download", value=selected_division ),
                    dcc.Download(id="download-data")
                ], width= 6, xs=12 , sm=12, md=6 , lg=6, xl=6,className="border-secondary border rounded"
            ),
            dbc.Col(
                [
                    dcc.Graph(
                        figure=class_object.draw_revenue_trend_lines()
                    )
                ],width= 6, xs=12 , sm=12, md=6 , lg=6, xl=6,className="border-secondary border rounded"
            ),
        ], className='flex'),
        dbc.Row([
            dbc.Col([
                
                ], width= 6, xs=12 , sm=12, md=6 , lg=6, xl=6,className="border-secondary border rounded"),
            ], className='flex'),
    ], fluid=True, className="flex")
    return layout

@callback(
    Output('download-data', 'data'),
    [Input('btn-download', 'n_clicks'),
     Input('btn-download', 'value')],
    prevent_initial_call =True
)
def export_to_excel(n_clicks, selected_division):
    if n_clicks is None:
        raise PreventUpdate
    else:
        class_object = overview_graphs_buttons(selected_division=selected_division)
        earnings_df = class_object.earnings_df
        target_df = class_object.target_df
        
        writer = pd.ExcelWriter('division_overview.xlsx', engine="xlsxwriter")
        workbook = writer.book
        earnings_df.to_excel(writer , sheet_name='Division Earnings')
        target_df.to_excel(writer, sheet_name='Division Targets')
        writer.close()
        return dcc.send_file('division_overview.xlsx')
    
  



class overview_graphs_buttons:
    def __init__(self , selected_division):
        self.selected_division = selected_division
        self.earnings_df = load_division_earnings_data(self.selected_division)
        self.target_df = load_division_target_data(self.selected_division)
        self.current_financia_year_data, self.previous_financia_year_data ,\
        self.current_year_division_target, self.target_upto_current_month,\
        self.previous_upto_this_month_year_data, self.current_year_upto_this_month_year_data= self.get_current_previous_year_dataframe()
        

        self.division_current_gross_total_revenue  = self.current_year_upto_this_month_year_data['gross_total'].sum()
        self.division_previous_gross_total_revenue = self.previous_upto_this_month_year_data['gross_total'].sum()
        self.division_current_year_target_revenue = self.target_upto_current_month['gross_total'].sum()
        
        self.division_current_passenger_earning_revenue  = self.current_year_upto_this_month_year_data['total_pass'].sum()
        self.division_previous_passenger_earning_revenue = self.previous_upto_this_month_year_data['total_pass'].sum()
        self.division_current_year_target_passenger_earning_revenue = self.target_upto_current_month['total_pass'].sum()
        
        self.division_current_year_goods_revenue  = self.current_year_upto_this_month_year_data['freight'].sum()
        self.division_previous_year_goods_revenue = self.previous_upto_this_month_year_data['freight'].sum()
        self.division_current_year_target_goods_revenue = self.target_upto_current_month['freight'].sum()
        
        self.division_current_year_other_coaching_revenue  = self.current_year_upto_this_month_year_data['other_coaching'].sum()
        self.division_previous_year_other_coaching_revenue = self.previous_upto_this_month_year_data['other_coaching'].sum()
        self.division_current_year_target_other_coaching_revenue = self.target_upto_current_month['other_coaching'].sum()
        
        self.division_current_year_sundry_revenue  = self.current_year_upto_this_month_year_data['sundry'].sum()
        self.division_previous_year_sundry_revenue = self.previous_upto_this_month_year_data['sundry'].sum()
        self.division_current_year_target_sundry_revenue = self.target_upto_current_month['sundry'].sum()
        
        self.division_current_year_originating_pass  = 46.63
        self.division_previous_year_originating_pass = 38.58
        self.division_current_year_target_originating_pass = self.target_upto_current_month['total_passengers'].sum()
        
    def get_current_previous_year_dataframe(self):
        earnings_df = self.earnings_df
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
        # march_year_end = pd.Timestamp(year=end_year, month=3, day=1)
       
        financial_year_data = earnings_df[(earnings_df['earning_month'] >= financial_year_start.date()) &
                                        (earnings_df['earning_month'] <= financial_year_end.date())]
        
        previous_financial_year_start = pd.Timestamp(
            year=start_year-1, month=4, day=1)
        previous_financial_year_end = pd.Timestamp(
            year=end_year-1, month=3, day=31)
        previous_year_data = earnings_df[(earnings_df['earning_month'] >= previous_financial_year_start.date()) &
                                        (earnings_df['earning_month'] <= previous_financial_year_end.date())]
        
        
        target_division_data = self.target_df[(self.target_df['earning_month'] >= financial_year_start.date()) &
                                        (self.target_df['earning_month'] <= financial_year_end.date())]
        
        current_year_end = pd.Timestamp(year=end_year, month=current_month-2, day=1)
        prev_year_end = financial_year_end = pd.Timestamp(year=end_year-1, month=current_month-2, day=1)
        
        
        target_upto_this_month = self.target_df[(self.target_df['earning_month'] >= financial_year_start.date()) &
                                        (self.target_df['earning_month'] <= current_year_end.date())]
        
        previous_upto_this_month_year_data = previous_year_data[(previous_year_data['earning_month'] >= previous_financial_year_start.date()) &
                                    (previous_year_data['earning_month'] <= prev_year_end.date())]
        
        current_year_upto_this_month_year_data = financial_year_data[(financial_year_data['earning_month'] >= financial_year_start.date()) &
                                    (financial_year_data['earning_month'] <= current_year_end.date())]
        
        
        return financial_year_data , previous_year_data , target_division_data, target_upto_this_month , previous_upto_this_month_year_data,current_year_upto_this_month_year_data
    
    def plot_bar_chart(self):
        
        # Extract revenue data for current and previous financial years
        combined_data = pd.concat([self.current_financia_year_data.assign(year='Current Financial Year'),
                                self.previous_financia_year_data.assign(year='Previous Financial Year')],
                                )
        current_year_revenue = combined_data.loc[combined_data['year']
                                                == 'Current Financial Year', 'gross_total']
        previous_year_revenue = combined_data.loc[combined_data['year']
                                                == 'Previous Financial Year', 'gross_total']
        current_year_target = self.current_year_division_target['gross_total']
        
        
        # List of months
        months = ['Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep',
                'Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar']
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
        
        # Create side-by-side bar charts
        fig = go.Figure()
        fig.add_trace(go.Bar(
            x=months,
            y=previous_year_revenue,
            name=f'{financial_year_start.year - 1} - {financial_year_start.year} - LY',
            marker_color='#089955',
            hovertemplate='Month: %{x}<br>Previous Year Revenue: %{y:.2f} Cr',
            
        ))
        fig.add_trace(go.Bar(
            x=months,
            y=current_year_target,
            name=f'{financial_year_start.year} - {financial_year_start.year +1} - TGT',
            marker_color='#c9782c',
            hovertemplate='Month: %{x}<br>Target Revenue: %{y:.2f} Cr'
        ))
        fig.add_trace(go.Bar(
            x=months,
            y=current_year_revenue,
            name=f'{financial_year_start.year} - {financial_year_start.year + 1} - CY',
            marker_color='#036bfc',
            hovertemplate='Month: %{x}<br>Current Revenue: %{y:.2f} Cr'
        ))
        
        

        # Modify the tickangle of the xaxis for better readability
        fig.update_layout(barmode='group', xaxis_tickangle=-45)

        fig.update_layout(
            xaxis=dict(showgrid=True, gridcolor='lightgrey'),
            yaxis=dict(showgrid=True, gridcolor='lightgrey'),
            title='Revenue Comparison',
            # xaxis_title='Month',
            yaxis_title='Total Revenue in Cr.',
            title_x = 0.1,
            margin=dict(t=10, b=10, r=10),
            legend=dict(
                x=0.35,  # Change the x-coordinate of the legend
                y=1.15,  # Change the y-coordinate of the legend
                traceorder='normal',
                # Order of the legend items
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
    

    def draw_revenue_trend_lines(self):
        earnings_df = self.earnings_df
        earnings_df = earnings_df.sort_values(by='earning_month')

        # Create a figure with subplots
        fig = go.Figure()

        # Add trend lines for each category
        fig.add_trace(
            go.Scatter(x=earnings_df['earning_month'], y=earnings_df['gross_total'], mode='lines+markers', showlegend=True, name='Gross Total',)
        )
        fig.add_trace(
            go.Scatter(x=earnings_df['earning_month'], y=earnings_df['total_pass'], mode='lines+markers', showlegend=True, name='Passenger'),
        )
        
        fig.add_trace(
            go.Scatter(x=earnings_df['earning_month'], y=earnings_df['freight'], mode='lines+markers', showlegend=True, name='Freight'),
           
        )
        fig.add_trace(
            go.Scatter(x=earnings_df['earning_month'], y=earnings_df['other_coaching'], mode='lines+markers', showlegend=True, name='Other Coaching'),
           
        )
        fig.add_trace(
            go.Scatter(x=earnings_df['earning_month'], y=earnings_df['sundry'], mode='lines+markers', showlegend=True, name='Sundry'),
           
        )

        # Update figure layout
        fig.update_layout(
            xaxis_tickangle=-45,
            title='Revenue Trend Lines ',
            title_x=0.1,# Center title
            # xaxis_title='Month',
            yaxis_title='Revenue in Cr',
            # xaxis=dict(title=dict(standoff=15)),  # Change location of x-axis title
            # # height=400,
            # # width=300,
            margin=dict(t=10, b=10,r=10),  # Adjust top margin
            legend=dict(
                x=0.3,  # Change the x-coordinate of the legend
                y=1.15, # Change the y-coordinate of the legend
                traceorder='normal',  # Order of the legend items
                font=dict(
                    family='sans-serif',
                    size=12,
                    color='black'
                ),
                bgcolor='rgba(255, 255, 255, 0.5)',  # Background color of the legend
                bordercolor='rgba(0, 0, 0, 0.5)',  # Border color of the legend
                borderwidth=1,  # Border width of the legend
                orientation='h',
                # yanchor="bottom",
                ),
            )
        fig.update_xaxes(showline=True, linewidth=2, linecolor='black',)


        return fig





