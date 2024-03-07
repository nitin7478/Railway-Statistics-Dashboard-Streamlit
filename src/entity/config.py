from pydantic import BaseModel, Field
from datetime import date


class DivisionBase(BaseModel):
    division_code: str
    division_name: str
    railway_code: str = 'CR'
    location: str = None
    contact_info: str = None


class StationBase(BaseModel):
    station_code: str
    station_name: str
    location: str = None
    division_code: str



class DivisionEarningsBase(BaseModel):
    earning_month: date
    uts_sub_urban_pass: float = 0
    uts_non_sub_pass: float = 0
    prs_pass: float = 0
    total_pass: float = 0
    freight: float = 0
    other_coaching: float = 0
    total: float = 0
    sundry: float = 0
    gross_total: float = 0
    division_code: str

