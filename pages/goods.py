import pandas as pd
import dash
from dash import html, dash_table, dcc, Dash, Input , Output, callback
import plotly.graph_objects as go
import dash_bootstrap_components as dbc
import datetime
from plotly.subplots import make_subplots
import plotly.graph_objects as go

from src.components.plot_functions import comparison_line_plot,\
                            yearly_data_comparison_line_plot,\
                                plot_pie_chart
from src.components.database_connection import load_division_goods_monthwise_outward_data,\
                                            load_division_target_data,\
                                        load_division_good_yearly_depowisesoutward_data,\
                                        load_division_commoditywise_yearly_data

class load_goods_page:
    def __init__(self , selected_division):
        self.selected_division = selected_division
        self.division_goods_outward_df =load_division_goods_monthwise_outward_data(selected_division=self.selected_division)
        self.division_target_df = load_division_target_data(selected_division=selected_division)
        self.division_depowise_outward_df = load_division_good_yearly_depowisesoutward_data(selected_division=selected_division)
        self.division_commodity_wise_outward_df = load_division_commoditywise_yearly_data(selected_division=selected_division)
        goods_outward = self.division_goods_outward_df
        
        
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
        financial_year_end = pd.Timestamp(year=end_year, month=3, day=31)
        # march_year_end = pd.Timestamp(year=end_year, month=3, day=1)
       
        self.current_year_monthwise_outward_data = goods_outward[(goods_outward['earning_month'] >= financial_year_start.date()) &
                                        (goods_outward['earning_month'] <= financial_year_end.date())]
        previous_financial_year_start = pd.Timestamp(
            year=start_year-1, month=4, day=1)
        previous_financial_year_end = pd.Timestamp(
            year=end_year-1, month=3, day=31)
        self.previous_year_monthwise_outward_data = goods_outward[(goods_outward['earning_month'] >= previous_financial_year_start.date()) &
                                        (goods_outward['earning_month'] <= previous_financial_year_end.date())]
        current_year = pd.Timestamp(
        year=start_year+1, month=3, day=31)
        previous_year = pd.Timestamp(
            year=start_year, month=3, day=31)
        
        self.current_year_depowise_df = self.division_depowise_outward_df[(self.division_depowise_outward_df['earning_year'] == current_year.date())]
                      
        self.previous_year_depowise_df = self.division_depowise_outward_df[(self.division_depowise_outward_df['earning_year'] == previous_year.date())]
        
        self.current_year_commoditywise_ouward_df = self.division_commodity_wise_outward_df[(self.division_commodity_wise_outward_df['earning_year'] == current_year.date())]
        
        self.previous_year_commoditywise_outward_df = self.division_commodity_wise_outward_df[(self.division_commodity_wise_outward_df['earning_year'] == previous_year.date())]
        
    
    
    
    def comparison_line_plot(self , feature , current_year_df , previous_year_df , target_df = None):
        
        current_year_df = current_year_df.sort_values(by='earning_month')
        previous_year_df = previous_year_df.sort_values(by='earning_month')
            
        months = ['Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep',
                    'Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar']
        
        # Create a figure with subplots
        fig = go.Figure()
        
        if feature == 'freight':
            unit = 'Crores'
        elif feature == 'weight':
            unit = 'Tonnes'
        else:
            unit = ' '
        # Add trend lines for each category
        fig.add_trace(
            go.Scatter(x=months,
                    y=current_year_df[feature],
                    mode='lines+markers',
                    showlegend=True,
                    name=f'CY {feature[0].upper()}{feature[1:]}',
                    hovertemplate = f'Month: %{{x}}<br>Current Year {feature[0].upper()}{feature[1:]}: %{{y:.2f}} {unit}'
            )
        )
        fig.add_trace(
            go.Scatter(x=months,
                    y=previous_year_df[feature],
                    mode='lines+markers',
                    showlegend=True,
                    name=f'LY {feature[0].upper()}{feature[1:]}',
                    hovertemplate = f'Month: %{{x}}<br>Last Year {feature[0].upper()}{feature[1:]}: %{{y:.2f}} {unit}'
            )
        )
    
        max_point_for_labale = max(max(current_year_df[feature]), max(previous_year_df[feature]))
        if target_df is not None and feature == 'freight':
            max_point_for_labale = max(max_point_for_labale , max(target_df[feature]))
            target_df  = target_df.sort_values(by='earning_month')
            fig.add_trace(
                go.Scatter(x=months,
                        y=target_df[feature],
                        mode='lines+markers',
                        showlegend=True,
                        name=f'TGT {feature[0].upper()}{feature[1:]}',
                        hovertemplate = f'Month: %{{x}}<br>Last Year {feature[0].upper()}{feature[1:]}: %{{y:.2f}} {unit}'),
            )


        monthly_avg_current = current_year_df[feature].mean()

        # Calculate daily average revenue assuming 30 days in a month
        daily_avg_current = monthly_avg_current / 30
        # fig.add_annotation(x=5,
        #                 y=20,
        #                 yanchor='middle',
        #                 text=f'CY Monthly Avg: {monthly_avg_current:.2f} {unit}',
        #                 showarrow=False,
        #                 bordercolor="#c7c7c7",
        #                 borderwidth=2,
        #                 borderpad=4,
        #                 bgcolor="lightgrey",
        #                 opacity=0.8,
        #                 font=dict(
        #                 family="Courier New, monospace",
        #                 size=20,
        #                 color="black",
        #                     ),
        #                 )
        # fig.add_annotation(x=5,
        #                     y=5,
        #                     text=f'CY Daily Avg: {daily_avg_current:.2f} {unit}',
        #                     showarrow=False,
        #                     # xanchor='left',
        #                     yanchor='middle',
        #                 bordercolor="#c7c7c7",
        #                 borderwidth=2,
        #                 borderpad=4,
        #                 bgcolor="lightgrey",
        #                 opacity=0.8,
        #                 font=dict(
        #                 family="Courier New, monospace",
        #                 size=20,
        #                 color="black",
        #                     ),
        # )


        # Update figure layout
        fig.update_layout(
            xaxis_tickangle=-45,
            title=f'{feature[0].upper()}{feature[1:]} Comparison',
            title_x=0.15,# Center title
            yaxis_title=f'{feature[0].upper()}{feature[1:]} {unit}',
            margin=dict(t=50, b=10,r=10),  # Adjust top margin
            legend=dict(
                x=0.45,  # Change the x-coordinate of the legend
                y=1.15, #
                font=dict(
                    family='sans-serif',
                    size=14,
                    color='black'
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

    def yearly_data_comparison_line_plot(self,feature, current_year_df, previous_year_df, target_df=None):
        current_year_df = current_year_df.sort_values(by=feature)
        previous_year_df = previous_year_df.sort_values(by=feature)
        
        fig = go.Figure()
        
        if feature == 'freight':
            unit = 'Crores'
        elif feature == 'weight':
            unit = 'Tonnes'
        else:
            unit = ' '
        # Add trend lines for each category
        fig.add_trace(
            go.Scatter(x=current_year_df['station_code'].str.upper(),
                    y=current_year_df[feature],
                    mode='lines+markers',
                    showlegend=True,
                    name=f'CY : {feature[0].upper()}{feature[1:]}',
                    hovertemplate = f'Station: %{{x}}<br>Current Year {feature[0].upper()}{feature[1:]}: %{{y:.2f}} {unit}'
            )
        )
        fig.add_trace(
            go.Scatter(x=current_year_df['station_code'].str.upper(),
                    y=previous_year_df[feature],
                    mode='lines+markers',
                    showlegend=True,
                    name=f'LY : {feature[0].upper()}{feature[1:]}',
                    hovertemplate = f'Station: %{{x}}<br>Last Year {feature[0].upper()}{feature[1:]}: %{{y:.2f}} {unit}'
            )
        )
        
        # Update figure layout
        fig.update_layout(
            xaxis_tickangle=-45,
            title=f'Depowise {feature[0].upper()}{feature[1:]} Comparison',
            title_x=0.1,# Center title
            yaxis_title=f'{feature[0].upper()}{feature[1:]} {unit}',
            margin=dict(t=20, b=5,r=5, l=5),  # Adjust top margin
            legend=dict(
                x=0.45,  # Change the x-coordinate of the legend
                y=1.15, # Change the y-coordinate of the legend
                traceorder='normal',  # Order of the legend items
                font=dict(
                    family='sans-serif',
                    size=14,
                    color='black'
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
    
    def plot_pie_chart(self,current_year_commoditywise_ouward_df,previous_year_commoditywise_outward_df):
        df_filtered = current_year_commoditywise_ouward_df[current_year_commoditywise_ouward_df['freight'] > (current_year_commoditywise_ouward_df['freight']*0.001)]
        df_filtered_ly = previous_year_commoditywise_outward_df[previous_year_commoditywise_outward_df['freight'] > (previous_year_commoditywise_outward_df['freight'].sum()*0.001)]

        fig = make_subplots(rows=2, cols=1, specs=[[{'type':'domain'}], [{'type':'domain'}]])

        # Extract values and names from the filtered DataFrame
        values = df_filtered['freight']
        names = df_filtered['commodity']
        values_ly = df_filtered_ly['freight']
        names_ly = df_filtered_ly['commodity']
        # Add pie charts to the subplots
        fig.add_trace(go.Pie(values=values, labels=names,
                            title=f'CY : Frieght',
                            textinfo='label+percent',
                            showlegend=False,insidetextorientation='radial'),
                            row=1, col=1)
        fig.add_trace(go.Pie(values=values_ly, labels=names_ly,
                            title=f'LY : Freight ',
                            textinfo='label+percent',
                            showlegend=False,insidetextorientation='radial'),
                            row=2, col=1)
        fig.update_traces(hole=.8, hoverinfo="label+percent+name+value")
        fig.update_layout(
            margin=dict(t=0, b=0,r=0),
            legend=dict(
                x=0.01,  # Change the x-coordinate of the legend
                y=1.15, # Change the y-coordinate of the legend
                traceorder='normal',  # Order of the legend items
                font=dict(
                    family='sans-serif',
                    size=10,
                    color='black'
                ),
                bgcolor='rgba(255, 255, 255, 0.5)',  # Background color of the legend
                bordercolor='rgba(0, 0, 0, 0.5)',  # Border color of the legend
                borderwidth=1,  # Border width of the legend
                orientation='v',
                title_font=dict(size=15),
            ),
            )
        return fig








def update_goods_page(selected_division):
        class_object = load_goods_page(selected_division=selected_division)
        layout = html.Div([ 
        dbc.Container([
            dbc.Row([
                dbc.Col([
                    # dbc.DropdownMenu(
                    #             label="Select Type",
                    #             children=[
                    #                 dbc.DropdownMenuItem("Freight", id="dropdown_freight"),
                    #                 dbc.DropdownMenuItem("Rakes", id="dropdown_rakes",),
                    #                 dbc.DropdownMenuItem("Wagons", id="dropdown_wagons"),
                    #                 dbc.DropdownMenuItem("Weight", id="dropdown_weight"),
                    #             ],
                    #         id='dropdown_goods_rake_wagon_weight',color="secondary",
                    #         # style={'position': 'absolute', 'top': '10px', 'left': '20px', 'zIndex': '9999'},
                    #         # className="ms-auto bg-light border"
                    #     ),
                    dcc.Dropdown(
                        id='dropdown_goods_rake_wagon_weight',  # This ID is for the dropdown itself, not individual items
                        options=[
                            {'label': 'Freight', 'value': f"freight_{selected_division}"},
                            {'label': 'Rakes', 'value': f"rakes_{selected_division}"},
                            {'label': 'Wagons', 'value': f"wagons_{selected_division}"},
                            {'label': 'Weight', 'value': f"weight_{selected_division}"}
                        ],
                        placeholder="Select Type",
                        clearable=False,
                        value= f"freight_{selected_division}",
                        # You might want to add custom classes or styles to mimic the "secondary" color theme from dbc
                        className="",  # Example class, you'd define this in your CSS
                        # style={'width': '100%', 'color': '#000'}  # Example inline style
                    ),
                    
                    dcc.Graph (
                        id='rake_wgn_wt_compare_graph',
                        # style={'position': 'relative', 'width': '100%', 'height': '100%'}
                    )
                ], width=5, xs=12, sm=12, md=5, lg=5, xl=5,className="border-secondary border rounded"),
                dbc.Col([
                    dcc.Graph(
                        # figure=class_object.pot_pie_chart_this_page(),
                        id="pie_chart_freight_comparison"
                    )
                ], width=2, xs=12, sm=12, md=2, lg=2, xl=2,className="border-secondary border rounded"),
                dbc.Col([
                    dbc.DropdownMenu(
                                label="Select Type",
                                children=[
                                    dbc.DropdownMenuItem("Freight", id="dropdown_freight_depowise",),
                                    dbc.DropdownMenuItem("Rakes", id="dropdown_rakes_depowise",),
                                    dbc.DropdownMenuItem("Wagons", id="dropdown_wagons_depowise"),
                                    dbc.DropdownMenuItem("Weight", id="dropdown_weight_depowise"),
                                ],
                            id='dropdown_goods_depowise_rake_wagon_weight',color="secondary",
            
                            # style={'position': 'absolute', 'top': '10px', 'right': '20px', 'zIndex': '9999'},
                            # className="ms-auto bg-light border"
                        ),

                    dcc.Graph (
                        id='depowise_yearly_comparison_graph',
                        # style={'position': 'relative', 'width': '100%', 'height': '100%'}
                    )
                ], width=5, xs=12, sm=12, md=5, lg=5, xl=5,className="border-secondary border rounded"),
                
            ], className="flex"),
        ], fluid=True)
        ])
        return layout



@callback(
    Output('rake_wgn_wt_compare_graph', 'figure'),
    Output('dropdown_goods_rake_wagon_weight', 'label'),
    [Input('dropdown_goods_rake_wagon_weight', 'value'),
     ],
    prevent_initial_call=False,
)
def update_graph(dropdown_value):
    try:
        if dropdown_value is not None:
            selected_feature, selected_division = dropdown_value.split('_')
            class_object = load_goods_page(selected_division)
            if 'rakes' in selected_feature:
                feature = 'rakes'
                label = "Rakes"
            elif 'wagons' in selected_feature:
                feature = 'wagon'
                label = 'Wagons'
            elif 'freight' in selected_feature:
                feature = 'freight'
                label = 'Freight'
            elif 'weight' in selected_feature:
                feature = 'weight'
                label = 'Weight'
            else:
                feature = 'freight'
                label = 'Freight'
        figure = class_object.comparison_line_plot(
            feature=feature,
            current_year_df=class_object.current_year_monthwise_outward_data,
            previous_year_df=class_object.previous_year_monthwise_outward_data,
            target_df=class_object.division_target_df
        )
        return figure, label
    except Exception as e:
        pass
    
# @callback(
#     Output('depowise_yearly_comparison_graph', 'figure'),
#     Output('dropdown_goods_depowise_rake_wagon_weight', 'label'),
#     [Input('dropdown_rakes_depowise', 'n_clicks'),
#      Input('dropdown_wagons_depowise', 'n_clicks'),
#      Input('dropdown_weight_depowise', 'n_clicks'),
#      Input('dropdown_freight_depowise', 'n_clicks'),
#       Input('dropdown_freight_depowise', 'header')]
# )
# def update_depowise_graph(n_clicks_rakes, n_clicks_wagons, n_clicks_weight,n_clicks_freight,selected_division):
#     class_object = load_goods_page(selected_division)
#     changed_id = [p['prop_id'] for p in dash.callback_context.triggered][0]
#     if 'dropdown_rakes_depowise' in changed_id:
#         feature = 'rakes'
#         label = "Rakes"
#     elif 'dropdown_wagons_depowise' in changed_id:
#         feature = 'wagon'
#         label = 'Wagons'
#     elif 'dropdown_freight_depowise' in changed_id:
#         feature = 'freight'
#         label = 'Freight'
#     elif 'dropdown_weight_depowise' in changed_id:
#         feature = 'weight'
#         label = 'Weight'
#     else:
#         feature = 'freight'
#         label = 'Freight'
#     # Assuming you have defined the comparison_line_plot function
#     figure = yearly_data_comparison_line_plot(
#         feature=feature,
#         current_year_df=class_object.current_year_depowise_df,
#         previous_year_df=class_object.previous_year_depowise_df,
#     )
#     return figure, label



    

        
    

