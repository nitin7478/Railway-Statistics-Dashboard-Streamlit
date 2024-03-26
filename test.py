import os
import pandas as pd
from pandasai import Agent

employees_data = {
    'EmployeeID': [1, 2, 3, 4, 5],
    'Name': ['John', 'Emma', 'Liam', 'Olivia', 'William'],
    'Department': ['HR', 'Sales', 'IT', 'Marketing', 'Finance']
}

salaries_data = {
    'EmployeeID': [1, 2, 3, 4, 5],
    'Salary': [5000, 6000, 4500, 7000, 5500]
}

employees_df = pd.DataFrame(employees_data)
salaries_df = pd.DataFrame(salaries_data)

# Get your FREE API key signing up at https://pandabi.ai.
# You can also configure it in your .env file.
os.environ["PANDASAI_API_KEY"] = "$2a$10$g.DW2.RNk8klOWAvnbX2AOzq17vhj6ZCKtxK4K741EewwS28BX57G"

agent = Agent([employees_df, salaries_df])
resp = agent.chat("Who gets paid the most?")
print(resp)