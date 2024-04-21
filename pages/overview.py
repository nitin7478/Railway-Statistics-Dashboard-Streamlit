import pandas as pd
import dash
from dash import html, dash_table, dcc
import plotly.graph_objects as go
import dash_bootstrap_components as dbc
import plotly.graph_objects as go
import datetime, io
import pandas as pd
from dash import dcc, html, Input, Output, callback, clientside_callback ,State
from plotly.subplots import make_subplots
from dash.exceptions import PreventUpdate
from src.components.database_connection import handle_database
from src.constants.constants import *
import textwrap
from pages.goods import load_goods_page
from pages.goods import update_goods_page
# from pages.passenger import update_passenger_page
# from pages.stations import update_stations_page
# from pages.other_coaching import update_other_coaching_page



def update_overview_page(selected_division):
    if selected_division is not None:
        
        selected_division =  f"{selected_division[:1].upper()}{selected_division[1:]}"
        class_object = overview_graphs_buttons(selected_division=selected_division)
        # card_style = {
        #     # 'minHeight':'242px',
        #     'backgroundColor': '#e1e7f0'
        # }
        
        def percentage_variation(current_value, previous_value):
            if previous_value != 0:
                return round(((current_value - previous_value) / previous_value) * 100, 2)
            else:
                return 0

        def generate_revenue_card(title, current_value, previous_value, target_value):
            percentage_vs_ly = percentage_variation(current_value, previous_value)
            percentage_vs_tgt = percentage_variation(current_value, target_value)
            if title == 'Originating Pass':
                label = 'Mil'
            else:
                label = 'Cr'
            return dbc.Col([
                dbc.Card([
                    dbc.CardHeader(title, className="fs-5", style={'backgroundColor': '#bff2eb', 'fontWeight':'500', 'minHeight':'80px'}),
                    dbc.CardBody([
                        html.H5(f"{round(current_value, 2)} {label}", className="card-title"),
                    ], className="border-start border-success border-3", style={'minHeight':'20px'}),
                    dbc.CardFooter([
                        html.Div([
                            html.I(f"vs LY :: {round(previous_value, 2)} :: "),
                            html.I(f"{percentage_vs_ly}% ", className=f"me-2 {'text-success' if current_value > previous_value else 'text-danger'}")
                        ]),
                        html.Div([
                            html.I("vs TGT :: "),
                            html.I(f"{round(target_value, 2)} :: "),
                            html.I(f"{percentage_vs_tgt}%", className=f" me-2 {'text-success' if current_value > target_value else 'text-danger'}")
                        ])
                    ],style={ 'minHeight':'100px'},),
                    # 'backgroundColor': '#f8f9fa'
                ], className="text-center m-1"),
            ], xs=12, sm=12, md=12, lg=6, xl=2)
        
        layout = html.Div([ 
                    dbc.Container([
            dbc.Row([
                    generate_revenue_card("Pune Division Revenue", class_object.division_current_gross_total_revenue, class_object.division_previous_gross_total_revenue, class_object.division_current_year_target_revenue),
                    generate_revenue_card("Passenger Revenue", class_object.division_current_passenger_earning_revenue, class_object.division_previous_passenger_earning_revenue, class_object.division_current_year_target_passenger_earning_revenue),
                    generate_revenue_card("Goods Revenue", class_object.division_current_year_goods_revenue, class_object.division_previous_year_goods_revenue, class_object.division_current_year_target_goods_revenue),
                    generate_revenue_card("Other Cog Revenue", class_object.division_current_year_other_coaching_revenue, class_object.division_previous_year_other_coaching_revenue, class_object.division_current_year_target_other_coaching_revenue),
                    generate_revenue_card("Sundry Revenue", class_object.division_current_year_sundry_revenue, class_object.division_previous_year_sundry_revenue, class_object.division_current_year_target_sundry_revenue),
                    generate_revenue_card("Originating Pass", class_object.division_current_year_originating_pass, class_object.division_previous_year_originating_pass, class_object.division_current_year_target_originating_pass),
               
                    ]),
            dbc.Row([
                dbc.Col(
                    [ 
                        dcc.Graph(
                            figure=class_object.plot_bar_chart(),
                            config={
                            'displayModeBar': False
                            },
                        ),
                        html.Button("Download Full Data", id="btn-download", value=selected_division ),
                        dcc.Download(id="download-data"),
                    ],  xs=12 , sm=12, md=12 , lg=12, xl=5,
                    className="border-secondary border rounded ",
                ),
                dbc.Col([
                        dcc.Graph(
                            figure=class_object.plot_pie_chart(),
                            id="pie_revenue_distribution",
                            config={
                            'displayModeBar': False                 
                            },
                        )
                    ], xs=12, sm=12, md=12, lg=12, xl=2,className="border-secondary border rounded"),
                dbc.Col(
                    [
                        dcc.Graph(
                            figure=class_object.draw_revenue_trend_lines(),
                            config={
                            'displayModeBar': False
                            },
                        )
                    ],xs=12 , sm=12, md=12 , lg=12, xl=5,className="border-secondary border rounded"
                ),
                ], className='flex'),
            ], fluid=True),
        ], id= 'tab_overview')
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
    Output('download-data', 'data'),
    [Input('btn-download', 'n_clicks'),
     Input('btn-download', 'value')],
    prevent_initial_call =True
)
def export_to_excel(n_clicks, selected_division):
    if n_clicks is None:
        raise PreventUpdate
    else:
        overview_class_object = overview_graphs_buttons(selected_division=selected_division)
        goods_class_object = load_goods_page(selected_division=selected_division)
        
        writer = pd.ExcelWriter('division_overview.xlsx', engine="xlsxwriter")
        workbook = writer.book
        overview_class_object.full_dataframe.to_excel(writer , sheet_name='Division Earnings')
        overview_class_object.cy_target_df.to_excel(writer, sheet_name='Division Targets')
        goods_class_object.full_ow_dataframe.to_excel(writer,sheet_name='Goods Outward' )
        goods_class_object.full_depowise_yearly_df.to_excel(writer, sheet_name="Goods Depowise OW")
        goods_class_object.full_commodiywise_yearly_df.to_excel(writer, sheet_name="Goods Commoditywise OW")
        writer.close()
        return dcc.send_file('division_overview.xlsx')

    return None
        
    
 



class overview_graphs_buttons:
    def __init__(self , selected_division):
        self.selected_division = selected_division
        
        load_database_object = handle_database()
        # load database
        load_database_object.load_dataframe(self.selected_division,DB_DIVISION_EARNINGS_OVERVIEW)
        self.cy_dateframe = load_database_object.cy_dataframe
        self.cy_target_df = load_database_object.cy_division_target_df
        self.ly_year_df = load_database_object.ly_dataframe
        self.full_dataframe = load_database_object.full_dataframe.sort_values(by='earning_month', ascending=False)
        
        
        self.cy_dataframe_upto_current_month = load_database_object.cy_dataframe_upto_current_month
        self.cy_target_upto_current_month = load_database_object.cy_division_target_df_upto_current_month
        self.ly_dataframe_upto_current_month = load_database_object.ly_dataframe_upto_current_month
        
        self.division_current_gross_total_revenue  = load_database_object.cy_dataframe_upto_current_month['gross_total'].sum()
        self.division_previous_gross_total_revenue = load_database_object.ly_dataframe_upto_current_month['gross_total'].sum()
        self.division_current_year_target_revenue = load_database_object.cy_division_target_df_upto_current_month['gross_total'].sum()
        
        self.division_current_passenger_earning_revenue  = load_database_object.cy_dataframe_upto_current_month['total_pass'].sum()
        self.division_previous_passenger_earning_revenue = load_database_object.ly_dataframe_upto_current_month['total_pass'].sum()
        self.division_current_year_target_passenger_earning_revenue = load_database_object.cy_division_target_df_upto_current_month['total_pass'].sum()
        
        self.division_current_year_goods_revenue  = load_database_object.cy_dataframe_upto_current_month['freight'].sum()
        self.division_previous_year_goods_revenue = load_database_object.ly_dataframe_upto_current_month['freight'].sum()
        self.division_current_year_target_goods_revenue = load_database_object.cy_division_target_df_upto_current_month['freight'].sum()
        
        self.division_current_year_other_coaching_revenue  = load_database_object.cy_dataframe_upto_current_month['other_coaching'].sum()
        self.division_previous_year_other_coaching_revenue = load_database_object.ly_dataframe_upto_current_month['other_coaching'].sum()
        self.division_current_year_target_other_coaching_revenue = load_database_object.cy_division_target_df_upto_current_month['other_coaching'].sum()
        
        self.division_current_year_sundry_revenue  = load_database_object.cy_dataframe_upto_current_month['sundry'].sum()
        self.division_previous_year_sundry_revenue = load_database_object.ly_dataframe_upto_current_month['sundry'].sum()
        self.division_current_year_target_sundry_revenue = load_database_object.cy_division_target_df_upto_current_month['sundry'].sum()
        
        self.division_current_year_originating_pass  = load_database_object.cy_dataframe_upto_current_month['total_passengers'].sum()
        self.division_previous_year_originating_pass = load_database_object.ly_dataframe_upto_current_month['total_passengers'].sum()
        self.division_current_year_target_originating_pass = load_database_object.cy_division_target_df_upto_current_month['total_passengers'].sum()
        
    
    def plot_bar_chart(self):
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
            y=self.ly_year_df['gross_total'],
            name=f'{financial_year_start.year - 1} - {financial_year_start.year} - LY',
            marker_color='#089955',
            hovertemplate='Month: %{x}<br>Previous Year Revenue: %{y:.2f} Cr',
            
        ))
        fig.add_trace(go.Bar(
            x=months,
            y=self.cy_target_df['gross_total'],
            name=f'{financial_year_start.year} - {financial_year_start.year +1} - TGT',
            marker_color='#c9782c',
            hovertemplate='Month: %{x}<br>Target Revenue: %{y:.2f} Cr'
        ))
        fig.add_trace(go.Bar(
            x=months,
            y=self.cy_dataframe_upto_current_month['gross_total'],
            name=f'{financial_year_start.year} - {financial_year_start.year + 1} - CY',
            marker_color='#036bfc',
            hovertemplate='Month: %{x}<br>Current Revenue: %{y:.2f} Cr'
        ))
        


        # Modify the tickangle of the xaxis for better readability
        fig.update_layout(barmode='group', xaxis_tickangle=-45)

        fig.update_layout(
            xaxis=dict(showgrid=True, gridcolor='lightgrey'),
            yaxis=dict(showgrid=True, gridcolor='lightgrey'),
            title="<br>".join(textwrap.wrap('Division Revenue Comparison',width=10)),
            # xaxis_title='Month',
            yaxis_title='Total Revenue in Cr.',
            title_x = 0.01,
            margin=dict(t=10, b=10, r=10),
            legend=dict(
                yanchor="top",
                y=1.15,
                xanchor="right",
                x=1,
                traceorder='normal',
                # Order of the legend items
                font=dict(
                    family='sans-serif',
                    size=15,
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
        earnings_df = self.full_dataframe
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
            title="<br>".join(textwrap.wrap('Division Revenue Trend',width=10)),
            title_x=0.01,
            yaxis_title='Revenue in Cr',
            margin=dict(t=10, b=10,r=10),  # Adjust top margin
            legend=dict(
                yanchor="top",
                y=1.15,
                xanchor="right",
                x=1, # Change the y-coordinate of the legend
                traceorder='normal',  # Order of the legend items
                font=dict(
                    family='sans-serif',
                    size=15,
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
    def plot_pie_chart(self,):
    
        cy_data = {
            'Passenger': self.cy_dataframe_upto_current_month['total_pass'].sum(),
            'Freight': self.cy_dataframe_upto_current_month['freight'].sum(),
            'Other Cog':  self.cy_dataframe_upto_current_month['other_coaching'].sum(),
            'Sundry':  self.cy_dataframe_upto_current_month['sundry'].sum()
        }
        ly_data = {
            'Passenger': self.ly_dataframe_upto_current_month['total_pass'].sum(),
            'Freight': self.ly_dataframe_upto_current_month['freight'].sum(),
            'Other Cog':  self.ly_dataframe_upto_current_month['other_coaching'].sum(),
            'Sundry':  self.ly_dataframe_upto_current_month['sundry'].sum()
        }
    
        fig = make_subplots(rows=2, cols=1, specs=[[{'type':'domain'}], [{'type':'domain'}]])

        values = list(cy_data.values())
        names = list(cy_data.keys())
        values_ly = list(ly_data.values())
        names_ly = list(ly_data.keys())

        # Add pie charts to the subplots
        fig.add_trace(go.Pie(values=values, labels=names,
                            title=f"<br>".join(textwrap.wrap('CY : Revenue',width=7, )),
                            textinfo='label+percent',
                            showlegend=False,rotation=50),
                            row=1, col=1)
        fig.add_trace(go.Pie(values=values_ly, labels=names_ly,
                            title=f"<br>".join(textwrap.wrap('LY : Revenue',width=7, )),
                            textinfo='label+percent',
                            showlegend=False,rotation=40),
                            row=2, col=1)
        fig.update_traces(hole=.8, hoverinfo="label+percent+name+value",  textfont_size=15,
                          titlefont_size=18,
                         )
        fig.update_layout(
            # title = "<br>".join(textwrap.wrap('Revenue Distribution',width=12)),
            # title_x = 0.2,
            margin=dict(t=0, b=0,r=0),
            legend=dict(
                x=0.01,  # Change the x-coordinate of the legend
                y=1.15, # Change the y-coordinate of the legend  # Order of the legend items
                font=dict(
                    family='sans-serif',
                    size=20,
                    color='black'
                ),
                bgcolor='rgba(255, 255, 255, 0.5)',  # Background color of the legend
                bordercolor='rgba(0, 0, 0, 0.5)',  # Border color of the legend
                borderwidth=1,  # Border width of the legend
                orientation='v',
                title_font=dict(size=20),
            ),
            )
        return fig





