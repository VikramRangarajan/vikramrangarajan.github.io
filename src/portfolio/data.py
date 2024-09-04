from typing import Optional
from datetime import date

from pydantic import BaseModel


def str_date(date: date) -> str:
    return date.strftime("%m/%y")


class UserInfo(BaseModel):
    name: str
    email: str
    phone: str
    linkedin: str
    github: str
    location: str
    website: str


class Education(BaseModel):
    type: str
    name: str
    location: str
    degree: Optional[str]
    major: Optional[str]
    minor: Optional[str]
    GPA: float
    coursework: Optional[list[str]]
    start: date
    end: Optional[date]
    expected: Optional[date]
    current: bool


class Experience(BaseModel):
    title: Optional[str]
    title_link: Optional[str]
    employment_type: Optional[str]
    company_name: str
    location: Optional[str]
    location_type: Optional[str]
    start: date
    end: Optional[date]
    description: list[str]
    current: bool


class Publication(BaseModel):
    title: str
    authors: list[str]
    journal: Optional[str]
    link: Optional[str]
    date: Optional[date]
    status: str


class Award(BaseModel):
    name: str
    date: date | str
    link: Optional[str]
    current: bool


class Portfolio(BaseModel):
    info: UserInfo
    education: Optional[list[Education]]
    publications: Optional[list[Publication]]
    experience: Optional[list[Experience]]
    skills: Optional[dict[str, list[str]]]
    awards: Optional[list[Award]]


class Margins(BaseModel):
    top: float
    left: float
    right: float
    bottom: float


class DocxConfig(BaseModel):
    margins: Margins
    title_font_size: int
    heading_font_size: int
    text_font_size: int

