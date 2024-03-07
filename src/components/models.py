from sqlalchemy import create_engine,UniqueConstraint, Column, Integer, Float, String, Date, ForeignKey, Table
from sqlalchemy.orm import relationship, sessionmaker
from sqlalchemy.ext.declarative import declarative_base

# Create a PostgreSQL database named 'railway_dashboard'
# engine = create_engine("postgresql://postgres:1234@localhost:5432/railway_dashboard", echo=True)

# Create a base class for declarative models
Base = declarative_base()


# Define the Division model
class Division(Base):
    __tablename__ = 'division'
    division_code = Column(String(5), primary_key=True, unique=True)
    division_name = Column(String(30), nullable=False, unique=True)
    railway_code = Column(String(5), nullable=False, default='CR')
    location = Column(String, nullable=True)
    contact_info = Column(String, nullable=True)
    
    # Define the many-to-many relationship with Station
    stations = relationship("Station", back_populates="divisions")
    # Define the many-to-many relationship with DivisionEarnings
    division_earningss = relationship("DivisionEarnings", back_populates="divisions")

# Define the Station model
class Station(Base):
    __tablename__ = 'station'
    station_code = Column(String(5), primary_key=True, unique=True)
    station_name = Column(String(255), nullable=False,unique=True)
    location = Column(String, nullable=True)
    
    division_code = Column(String(5),ForeignKey('division.division_code'))
    # Define the many-to-many relationship with Division
    divisions = relationship("Division",back_populates="stations")

# Define the DivisionEarnings model
class DivisionEarnings(Base):
    __tablename__ = 'division_earnings'
    earning_id = Column(Integer, primary_key=True, unique=True)
    earning_month = Column(Date, nullable=False)
    uts_sub_urban_pass = Column(Float, nullable=False, default=0)
    uts_non_sub_pass = Column(Float, nullable=False, default=0)
    prs_pass = Column(Float, nullable=False, default=0)
    total_pass = Column(Float, nullable=False, default=0)
    freight = Column(Float, nullable=False, default=0)
    other_coaching = Column(Float, nullable=False, default=0)
    total = Column(Float, nullable=False, default=0)
    sundry = Column(Float, nullable=False, default=0)
    gross_total = Column(Float, nullable=False, default=0)
    
    division_code = Column(String(5),ForeignKey('division.division_code'))
    # Define the many-to-many relationship with Division
    divisions = relationship("Division", back_populates="division_earningss")

# Create the tables in the database if they don't exist
# Base.metadata.create_all(engine)
