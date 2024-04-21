import pandas as pd
import dash
from dash import html, dash_table, dcc, Dash, Input , Output, callback
import plotly.graph_objects as go
import dash_bootstrap_components as dbc
import datetime, textwrap
from plotly.subplots import make_subplots
import plotly.graph_objects as go
from src.components.database_connection import handle_database
from src.constants.constants import *
from src.logger import logging 
from src.exception import CustomException
import sys

class load_goods_page:
    def __init__(self , selected_division):
        self.selected_division = selected_division
        class_object = handle_database()
        class_object.load_dataframe(self.selected_division,DB_DIVISION_GOODS_MONTHEWISE_YEARWISE_OW)
        self.cy_division_goods_outward_df =class_object.cy_dataframe
        self.ly_division_goods_outward_df = class_object.ly_dataframe
        self.cy_division_target_df = class_object.cy_division_target_df
        self.full_ow_dataframe = class_object.full_dataframe.sort_values(by='earning_month',ascending=False)
        
        class_object.load_dataframe(self.selected_division,DB_DIVISION_GOODS_DEPOWISE_YEARWISE_OW)
        # self.division_depowise_outward_df = class_object.full_dataframe
        self.cy_depowise_df_yearly_ow = class_object.cy_dataframe_yearly_data
        self.ly_depowise_df_yearly_ow = class_object.ly_dataframe_yearly_data
        self.full_depowise_yearly_df = class_object.full_dataframe
        
        class_object.load_dataframe(self.selected_division, DB_DIVISION_GOODS_COMMODITY_YEARWISE_OW)
        self.cy_commoditywise_yearly_ouward_df = class_object.cy_dataframe_yearly_data
        self.ly_commoditywise_yearly_outward_df = class_object.ly_dataframe_yearly_data
        self.full_commodiywise_yearly_df = class_object.full_dataframe
        
    def comparison_line_plot(self , feature):
        
        current_year_df = self.cy_division_goods_outward_df.sort_values(by='earning_month')
        previous_year_df = self.ly_division_goods_outward_df.sort_values(by='earning_month')
        target_df = self.cy_division_target_df.sort_values(by='earning_month')
        
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
                    name=f'CY {feature[0].upper()}{feature[1:]}',
                    hovertemplate = f'Month: %{{x}}<br>Current Year {feature[0].upper()}{feature[1:]}: %{{y:.2f}} {unit}'
            )
        )
        fig.add_trace(
            go.Scatter(x=months,
                    y=previous_year_df[feature],
                    mode='lines+markers',
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


        monthly_avg_current = round(current_year_df[feature].mean(),2)
        daily_avg_current = round(monthly_avg_current / 30,2)

        # Update figure layout
        fig.update_layout(
            xaxis_tickangle=-45,
            title="<br>".join(textwrap.wrap(f'{feature[0].upper()}{feature[1:]} Comparison',width=10)),
            title_x=0.01,
            yaxis_title=f'{feature[0].upper()}{feature[1:]} {unit}',
            margin=dict(t=50, b=10,r=10), 
            legend=dict(
                yanchor="top",
                y=1.15,
                xanchor="right",
                x=1,
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

        return fig , daily_avg_current , monthly_avg_current

    def yearly_data_comparison_line_plot(self,feature):
        
        
        current_year_df= self.cy_depowise_df_yearly_ow.sort_values(by=feature)
        previous_year_df = self.ly_depowise_df_yearly_ow.sort_values(by=feature)
        
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
            title="<br>".join(textwrap.wrap(f'Depowise {feature[0].upper()}{feature[1:]} Comparison',width=10)),
            xaxis_tickangle=-45,
            title_x=0.01,# Center title
            yaxis_title=f'{feature[0].upper()}{feature[1:]} {unit}',
            margin=dict(t=20, b=5,r=5, l=5),  # Adjust top margin
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
            ),
            yaxis=dict(
            title_font=dict(size=15),  # Adjust font size of y-axis title
        ),
        )
        
        fig.update_xaxes(showline=True, linewidth=2, linecolor='black',)

        return fig
    
    def plot_pie_chart(self,):
        try:
            logging.info(f"Entered plot_pie_chart")
            threshold = 0.001
            df_filtered = self.cy_commoditywise_yearly_ouward_df[self.cy_commoditywise_yearly_ouward_df['freight'] > (self.cy_commoditywise_yearly_ouward_df['freight'].sum()*threshold)]
            df_filtered_ly = self.ly_commoditywise_yearly_outward_df[self.ly_commoditywise_yearly_outward_df['freight'] > (self.ly_commoditywise_yearly_outward_df['freight'].sum()*threshold)]
            
            others_cy = self.cy_commoditywise_yearly_ouward_df[self.cy_commoditywise_yearly_ouward_df['freight'] <= (self.cy_commoditywise_yearly_ouward_df['freight'].sum()*threshold)]
            others_ly = self.ly_commoditywise_yearly_outward_df[self.ly_commoditywise_yearly_outward_df['freight'] <= (self.ly_commoditywise_yearly_outward_df['freight'].sum()*threshold)]
            
            fig = make_subplots(rows=2, cols=1, specs=[[{'type':'domain'}], [{'type':'domain'}]])

            others_sum_cy = others_cy['freight'].sum() 
            others_sum_ly = others_ly['freight'].sum()
            if others_sum_cy > 0:
                others_row_cy = pd.DataFrame({'commodity': ['Others'], 'freight': [others_sum_cy]})
                df_filtered = pd.concat([df_filtered, others_row_cy], ignore_index=True)
            if others_sum_ly > 0:
                others_row_ly = pd.DataFrame({'commodity': ['Others'], 'freight': [others_sum_ly]})
                df_filtered_ly = pd.concat([df_filtered_ly, others_row_ly], ignore_index=True)
            
            
            
            # Extract values and names from the filtered DataFrame
            values = df_filtered['freight']
            names = df_filtered['commodity']
            values_ly = df_filtered_ly['freight']
            names_ly = df_filtered_ly['commodity']
            # Add pie charts to the subplots
            fig.add_trace(go.Pie(values=values, labels=names,
                                title=f"<br>".join(textwrap.wrap('CY : Freight',width=7, )),
                                textinfo='label+percent',
                                showlegend=False,insidetextorientation='radial'),
                                row=1, col=1)
            fig.add_trace(go.Pie(values=values_ly, labels=names_ly,
                                title=f"<br>".join(textwrap.wrap('CY : Freight',width=7, )),
                                textinfo='label+percent',
                                showlegend=False,insidetextorientation='radial'),
                                row=2, col=1)
            fig.update_traces(hole=.8, hoverinfo="label+percent+name+value",  textfont_size=14,
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
                    # title_font=dict(size=10),
                ),
                )
            logging.info(f"Completed plot_pie_chart")
            return fig
        except Exception as e:
            raise CustomException(e, sys) from e
        


    def plot_trend_line(self,feature):
        try:
            
            logging.info(f"Entered plot_trend_line")
            full_df = self.full_ow_dataframe
            # Create a figure with subplots
            fig = go.Figure()
            
            if feature == 'freight':
                unit = 'Crores'
            # elif feature == 'sugar':
            #     # full_df = self.sort_values(by='earning_month')['freight']
            #     unit = 'Tonnes'
            # else:
            #     unit = ' '
            # Add trend lines for each category
            fig.add_trace(
                go.Scatter(x=full_df['earning_month'],
                        y=full_df[feature],
                        mode='lines+markers',
                        name=f'{feature[0].upper()}{feature[1:]}',
                        hovertemplate = f'%{{x}} {feature[0].upper()}{feature[1:]}: %{{y:.2f}} {unit}'
                )
            )

            # Update figure layout
            fig.update_layout(
                xaxis_tickangle=-45,
                title=f'Outward {feature[0].upper()}{feature[1:]} Trend Over Time',
                title_x=0.01,
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
            logging.info(f"Completed plot_trend_line")
            return fig
        except Exception as e:
            raise CustomException(e, sys) from e
            





def update_goods_page(selected_division):
    try:
        logging.info(f" {'='* 20} Update update_goods_page started. {'='*20} ")
        if selected_division is not None:
            class_object = load_goods_page(selected_division=selected_division)
            
            layout =dbc.Container([
                dbc.Row([
                    dbc.Col([
                        dbc.Row([
                            dbc.Col([
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
                                className="",  
                                ),
                            ],xs=12, sm=12, md=4, lg=4, xl=4),
                            dbc.Col([
                                html.Div(
                                        id="cy_daily_avg_freight")
                                ],
                                width=4, xs=12, sm=12, md=4, lg=4, xl=4,
                                className="border-secondary border rounded text-center fs-6",
                                ),
                            dbc.Col([
                                html.Div(
                                        id="cy_monthly_avg_freight")
                                ],
                                width=4, xs=12, sm=12, md=4, lg=4, xl=4,
                                className="border-secondary border rounded text-center fs-6",
                            ),
                        ]),
        
                        dcc.Graph (
                            
                            id='rake_wgn_wt_compare_graph',
                            config={
                            'displayModeBar': False
                            },
                        )
                    ], width=5, xs=12, sm=12, md=12, lg=12, xl=5,className="border-secondary border rounded"),
                    dbc.Col([
                        dcc.Graph(
                            figure=class_object.plot_pie_chart(),
                            id="pie_chart_freight_comparison",
                            config={
                            'displayModeBar': False
                            },
                        )
                    ], width=2, xs=12, sm=12, md=12, lg=12, xl=2,className="border-secondary border rounded"),
                    dbc.Col([
                        dcc.Dropdown(
                            id='dropdown_depowise_goods_rake_wagon_weight',  # This ID is for the dropdown itself, not individual items
                            options=[
                                {'label': 'Freight', 'value': f"freight_{selected_division}"},
                                {'label': 'Rakes', 'value': f"rakes_{selected_division}"},
                                {'label': 'Wagons', 'value': f"wagons_{selected_division}"},
                                {'label': 'Weight', 'value': f"weight_{selected_division}"}
                            ],
                            placeholder="Select Type",
                            clearable=False,
                            value= f"freight_{selected_division}",
                            className="",  
                        ),

                        dcc.Graph (
                            id='depowise_yearly_comparison_graph',
                            config={
                            'displayModeBar': False
                            },
                            # style={'position': 'relative', 'width': '100%', 'height': '100%'}
                        )
                    ], width=5, xs=12, sm=12, md=12, lg=12, xl=5,className="border-secondary border rounded"),
                    
                ], className="flex"),
                # dbc.Row([
                #     dbc.Col([
                #         dcc.Graph(
                #             figure = class_object.plot_trend_line('freight'),
                #             id = "Revenue Trend Over Time",
                #             config={
                #             'displayModeBar': False
                #             },
                #         ),
                #     ],
                #     width=6,xs=12, sm=12, md=12, lg=6, xl=6,
                #     className="border-secondary border rounded"),
                #     dbc.Col([

                #         dcc.Graph(
                        
                #         )
                #     ],
                #     width=3,xs=12, sm=12, md=3, lg=3, xl=3,
                #     className="border-secondary border rounded"),
                #     dbc.Col([
                #         dcc.Graph(
                            
                #         )
                #     ],
                #     width=3,xs=12, sm=12, md=3, lg=3, xl=3,
                #     className="border-secondary border rounded"),
                # ], className='flex'),
                # dbc.Row([
                #     dbc.Col([
                #         dbc.Row([
                #             html.Div([
                #                 "Goods Outward Data"
                #             ], className='text-center fs-5'),
                            
                            
                            
                #         ], align='center'),
                #         dash_table.DataTable(data=class_object.full_ow_dataframe.to_dict('records'),)
                #                             #   columns=[i for i in class_object.full_dataframe.columns])
                #         ], width= 6, xs=12 , sm=12, md=12 , lg=6, xl=6,className="border-secondary border rounded",
                #             id='dash_table_for_goods_ow_data'),
                #     dbc.Col([
                #         dbc.Row([
                #             html.Div([
                #                 "Goods Depowise Outward Data"
                #             ], className='text-center fs-5')
                            
                #         ], align='center'),
                #         dash_table.DataTable(data=class_object.full_depowise_yearly_df.to_dict('records'),)
                #                             #   columns=[i for i in class_object.full_dataframe.columns])
                #         ], width= 6, xs=12 , sm=12, md=12 , lg=6, xl=6,className="border-secondary border rounded",
                #             id='dash_table_for_goods_depowise_data'),
                # ], className='flex'),
            ], fluid=True)
            
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
    except Exception as e:
        raise CustomException(e, sys) from e



@callback(
    Output('rake_wgn_wt_compare_graph', 'figure'),
    Output('dropdown_goods_rake_wagon_weight', 'label'),
    Output('cy_daily_avg_freight', 'children'),
    Output('cy_monthly_avg_freight', 'children'),
    [Input('dropdown_goods_rake_wagon_weight', 'value'),
     ],
    prevent_initial_call=False,
)
def update_graph(dropdown_value):
    try:
        if dropdown_value is not None:
            parts = dropdown_value.split('_')
            selected_division = parts[-1]
            selected_feature = '_'.join(parts[:-1])
            class_object = load_goods_page(selected_division)
            if 'rakes' == selected_feature:
                feature = 'rakes'
                label = "Rakes"
            elif 'wagons' == selected_feature:
                feature = 'wagon'
                label = 'Wagons'
            elif 'freight' == selected_feature:
                feature = 'freight'
                label = 'Freight'
            elif 'weight' == selected_feature:
                feature = 'weight'
                label = 'Weight'
            else:
                feature = 'freight'
                label = 'Freight'
        figure,daily_avg_current, monthly_avg_current = class_object.comparison_line_plot(
            feature=feature,
        )
        daily_avg_current = f"CY Daily Avg : {daily_avg_current}"
        monthly_avg_current = f"CY Month Avg : {monthly_avg_current}"
        return figure, label, daily_avg_current,monthly_avg_current
    except Exception as e:
        pass
    


@callback(
    Output('depowise_yearly_comparison_graph', 'figure'),
    Output('dropdown_depowise_goods_rake_wagon_weight', 'label'),
    [Input('dropdown_depowise_goods_rake_wagon_weight', 'value'),
  ],
    prevent_initial_call=False,
)
def update_graph(dropdown_value):
    try:
        if dropdown_value is not None:
            parts = dropdown_value.split('_')
            selected_division=parts[-1]
            selected_feature= '_'.join(parts[:-1])
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
            figure = class_object.yearly_data_comparison_line_plot(
                feature=feature)
            return figure, label
    except Exception as e:
        pass



    

        
    

