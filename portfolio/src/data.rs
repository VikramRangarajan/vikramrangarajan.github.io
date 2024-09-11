use serde::{Deserialize, Serialize};

pub fn load_portfolio() -> Portfolio {
    let path = std::path::Path::new("portfolio.json");
    let file = std::fs::File::open(path).unwrap();
    let x: Portfolio = serde_json::from_reader(file).unwrap();
    x
}

#[derive(Serialize, Deserialize, Debug)]
pub enum Date {
    NumDate {
        day: Option<i32>,
        month: i32,
        year: i32,
    },
    StringDate(String),
}

impl Date {
    pub fn str_date(&self) -> String {
        match self {
            Date::NumDate {
                day: None,
                month,
                year,
            } => format!("{}/{}", month, year),
            Date::NumDate {
                day: Some(daynum),
                month,
                year,
            } => format!("{}/{}/{}", month, daynum, year),
            Date::StringDate(s) => s.to_string(),
        }
    }
}

#[derive(Serialize, Deserialize, Debug)]
pub struct UserInfo {
    pub name: String,
    pub email: String,
    pub phone: String,
    pub linkedin: String,
    pub github: String,
    pub location: String,
    pub website: String,
}

#[derive(Serialize, Deserialize, Debug)]
pub enum EndingDate {
    End(Date),
    /// Current with a date indicates in progress with an expected date of completion, while
    /// a None just indicates in progress
    Current {
        expected: Option<Date>,
    },
}

#[derive(Serialize, Deserialize, Debug)]
pub struct Duration {
    pub start: Date,
    pub end: EndingDate,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct Education {
    pub education_type: String,
    pub name: String,
    pub location: String,
    pub degree: Option<String>,
    pub major: Option<String>,
    pub minor: Option<String>,
    pub gpa: f32,
    pub coursework: Option<Vec<String>>,
    pub duration: Duration,
    pub current: bool,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct Experience {
    pub title: Option<String>,
    pub title_link: Option<String>,
    pub employment_type: Option<String>,
    pub company_name: String,
    pub location: Option<String>,
    pub location_type: Option<String>,
    pub duration: Duration,
    pub description: Vec<String>,
    pub current: bool,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct Publication {
    pub title: String,
    pub authors: Vec<String>,
    pub journal: Option<String>,
    pub link: Option<String>,
    pub date: Option<Date>,
    pub status: String,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct Award {
    pub name: String,
    pub date: Date,
    pub link: Option<String>,
    pub current: bool,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct SkillGroup {
    pub group_name: String,
    pub skills: Vec<String>,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct Portfolio {
    pub info: UserInfo,
    pub education: Vec<Education>,
    pub publications: Vec<Publication>,
    pub experience: Vec<Experience>,
    pub skills: Vec<SkillGroup>,
    pub awards: Vec<Award>,
}
