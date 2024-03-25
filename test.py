# import os
# import pandas as pd
# from pandasai import SmartDataframe

# # Sample DataFrame
# sales_by_country = pd.DataFrame({
#     "country": ["United States", "United Kingdom", "France", "Germany", "Italy", "Spain", "Canada", "Australia", "Japan", "China"],
#     "sales": [5000, 3200, 2900, 4100, 2300, 2100, 2500, 2600, 4500, 7000]
# })

# # Get your FREE API key signing up at https://pandabi.ai.
# # You can also configure it in your .env file.
# os.environ["PANDASAI_API_KEY"]

# agent = SmartDataframe(sales_by_country)
# print(agent.chat('Which are the top 5 countries by sales?'))