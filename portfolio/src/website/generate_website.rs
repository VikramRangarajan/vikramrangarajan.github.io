use crate::data::*;
use crate::website::rst_utils::*;
use std::fs::{canonicalize, write};
use std::io::Write;
use std::path::Path;
use std::process::Command;

pub fn add_education(mut s: String, p: &Portfolio) -> String {
    s.add_subtitle("Education".into());
    for edu in &p.education {
        if !edu.current {
            continue;
        }
        let mut time = edu.duration.start.str_date();
        match &edu.duration.end {
            EndingDate::End(end) => {
                time.push_str(" to ");
                time.push_str(&end.str_date());
            }
            EndingDate::Current {
                expected: Some(exp),
            } => {
                time.push_str(" to Present, Expected ");
                time.push_str(&exp.str_date());
            }
            EndingDate::Current { expected: None } => {}
        }

        let mut body_str = String::new();

        if let Some(degree) = &edu.degree {
            body_str.push_str(format!("Degree: {degree}\n").as_str())
        }
        if let Some(major) = &edu.major {
            body_str.push_str(format!("Major: {major}\n").as_str())
        }
        if let Some(minor) = &edu.minor {
            body_str.push_str(format!("Minor: {minor}\n").as_str())
        }
        if let Some(courses) = &edu.coursework {
            body_str.push_str(format!("Relevant Coursework: {}\n", courses.join(", ")).as_str());
        }
        body_str.push_str(format!("GPA: {:.1}", edu.gpa).as_str());
        s.add_card(
            Some(format!("{} - {time}", edu.name)),
            Some(body_str),
            None,
            0,
        );
    }
    s
}

pub fn add_experiences(mut s: String, p: &Portfolio) -> String {
    s.add_subtitle("Experience & Projects".into());
    for exp in &p.experience {
        if !exp.current {
            continue;
        }
        let mut time = exp.duration.start.str_date();
        match &exp.duration.end {
            EndingDate::End(end) => {
                time.push_str(" to ");
                time.push_str(&end.str_date());
            }
            EndingDate::Current {
                expected: Some(exp),
            } => {
                time.push_str(" to Present, Expected ");
                time.push_str(&exp.str_date());
            }
            EndingDate::Current { expected: None } => {}
        }

        let mut body_str = String::new();

        if let Some(title) = &exp.title {
            body_str.push_str(title)
        }
        body_str.push_str(format!("\n{}", exp.description.join("\n")).as_str());

        let end_str = match &exp.duration.end {
            EndingDate::End(end) => end.str_date(),
            EndingDate::Current { expected: _ } => "Present".into(),
        };
        s.add_card(
            Some(format!(
                "{} - {} to {}",
                exp.company_name,
                exp.duration.start.str_date(),
                end_str
            )),
            Some(body_str),
            exp.title_link.clone(),
            0,
        );
    }
    s
}

pub fn add_skills(mut s: String, p: &Portfolio) -> String {
    s.add_subtitle("Technical Skills".into());
    for SkillGroup { group_name, skills } in &p.skills {
        s.push_str(format!("{group_name}\n\n").as_str());
        s.add_card_carousel(
            skills.iter().map(|x| Some(x.to_string())).collect(),
            vec![None; skills.len()],
            vec![None; skills.len()],
            2,
        );
    }
    s
}

pub fn add_awards(mut s: String, p: &Portfolio) -> String {
    s.add_subtitle("Awards & Certifications".into());
    for awd in &p.awards {
        if !awd.current {
            continue;
        }
        s.add_card(
            Some(format!("{} - {}", awd.name, awd.date.str_date(),)),
            None,
            awd.link.clone(),
            0,
        );
    }
    s
}

pub fn create_index_file(p: &Portfolio) {
    let mut s = String::with_capacity(10000);
    s.add_title("Portfolio".into());

    s = add_education(s, p);

    s = add_experiences(s, p);

    s = add_skills(s, p);

    s = add_awards(s, p);

    let binding = canonicalize(Path::new(".")).unwrap();
    let root = binding.parent().unwrap();
    let index_filepath = root.join("docs").join("source").join("portfolio.rst");
    write(index_filepath, s).expect("Error Writing File");
}

pub fn create_publications_file(p: &Portfolio) {
    let mut s = String::with_capacity(10000);
    s.add_title("Publications".into());

    for publication in &p.publications {
        let mut authors_str = publication.authors.join(", ");
        authors_str = authors_str.replace(&p.info.name, format!("**{}**", p.info.name).as_str());
        if let Some(journal) = &publication.journal {
            authors_str.push_str(format!("\nIn {}\n", journal).as_str());
        }
        if !publication.status.to_lowercase().contains("published") {
            authors_str.push_str(format!("\n{}", publication.status).as_str());
        }
        if let Some(date) = &publication.date {
            authors_str.push_str(date.str_date().as_str());
        }
        s.add_card(
            Some(publication.title.clone()),
            Some(authors_str),
            publication.link.clone(),
            0,
        );
    }
    let binding = canonicalize(Path::new(".")).unwrap();
    let root = binding.parent().unwrap();
    let index_filepath = root.join("docs").join("source").join("publications.rst");
    write(index_filepath, s).expect("Error Writing File");
}

pub fn create_resumes_file() {
    let mut s = String::with_capacity(10000);
    s.add_title("Resume Downloads".into())
        .push_str("\n:download:`PDF <_static/resume.pdf>`\n");
    s.push_str("\n:download:`DOCX <_static/resume.docx>`\n\n");

    // Add the pdf previewer as an embedded iframe
    s.push_str(".. raw:: html\n\n\t<iframe id=\"pdf-viewer\" ");
    s.push_str("src=\"_static/resume.pdf\" ");
    s.push_str("type=\"application/pdf\" ");
    s.push_str(
        "style=\"height: 60vh; width: 100%\" allowfullscreen scrolling=\"auto\"></iframe>\n",
    );

    let binding = canonicalize(Path::new(".")).unwrap();
    let root = binding.parent().unwrap();
    let index_filepath = root.join("docs").join("source").join("resumes.rst");
    write(index_filepath, s).expect("Error Writing File");
}

pub fn generate_website() {
    let p = load_portfolio();
    create_index_file(&p);
    create_publications_file(&p);
    create_resumes_file();
}

pub fn generate_html() {
    let output = Command::new("make")
        .args(["-C", "../docs", "html"])
        .output()
        .expect("Failed to generate html");
    let _ = std::io::stdout().write_all(&output.stdout);
    let _ = std::io::stderr().write_all(&output.stderr);
}
