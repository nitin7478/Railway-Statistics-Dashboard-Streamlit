
import plotly.graph_objects as go

def comparison_line_plot(feature , current_year_df , previous_year_df , target_df = None):
    
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

def yearly_data_comparison_line_plot(feature, current_year_df, previous_year_df, target_df=None):
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




from plotly.subplots import make_subplots
import plotly.graph_objects as go

def plot_pie_chart(current_year_commoditywise_ouward_df,previous_year_commoditywise_outward_df):
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
