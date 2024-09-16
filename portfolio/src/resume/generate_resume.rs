use docx_rs::*;
use std::process::Command;
use std::{fs::canonicalize, path::Path};

use crate::{
    data::{load_portfolio, EndingDate, Portfolio},
    hyperlink_run, inches_to_twips, PTrait,
};

pub const TITLE_SIZE: usize = 20 * 2;
pub const HEADING_SIZE: usize = 14 * 2;
pub const TEXT_SIZE: usize = 11 * 2;
pub const LINE_SPACING: f32 = 1.15;
pub const LINE_SPACING_TWIPS: i32 = ((TEXT_SIZE / 2) as f32 * LINE_SPACING * 20f32) as i32;

pub fn add_info_and_links(mut doc: Docx, por: &Portfolio) -> Docx {
    let p = Paragraph::new()
        .add_tab_stop()
        .add_run(Run::new().add_text("Website: "))
        .add_hyperlink(
            Hyperlink::new(por.info.website.clone(), HyperlinkType::External)
                .add_run(hyperlink_run(por.info.website.clone())),
        )
        .add_run(Run::new().add_text("\tEmail: "))
        .add_hyperlink(
            Hyperlink::new(
                &format!("mailto:{}", por.info.email.clone()),
                HyperlinkType::External,
            )
            .add_run(hyperlink_run(por.info.email.clone()).add_break(BreakType::TextWrapping)),
        )
        .add_run(Run::new().add_text("LinkedIn: "))
        .add_hyperlink(
            Hyperlink::new(por.info.linkedin.clone(), HyperlinkType::External)
                .add_run(hyperlink_run(por.info.linkedin.clone())),
        )
        .add_run(Run::new().add_text("\tLocation: "))
        .add_run(
            Run::new()
                .add_text(por.info.location.clone())
                .add_break(BreakType::TextWrapping),
        )
        .add_run(Run::new().add_text("Github: "))
        .add_hyperlink(
            Hyperlink::new(por.info.github.clone(), HyperlinkType::External)
                .add_run(hyperlink_run(por.info.github.clone())),
        )
        .add_run(Run::new().add_text("\tPhone: "))
        .add_hyperlink(
            Hyperlink::new(
                &format!("tel:{}", por.info.phone.clone()),
                HyperlinkType::External,
            )
            .add_run(hyperlink_run(por.info.phone.clone())),
        );
    // doc = &mut doc.add_paragraph(p);
    doc = doc.add_paragraph(p);
    doc
}

fn add_education(mut doc: Docx, por: &Portfolio) -> Docx {
    doc = doc.add_paragraph(
        Paragraph::new()
            .add_run(Run::new().add_text("Education").size(HEADING_SIZE))
            .insert_hr(),
    );
    for edu in &por.education {
        if !edu.current {
            continue;
        }
        let mut body_str = String::new();
        if let Some(degree) = &edu.degree {
            body_str.push_str(degree);
        }
        if edu.major.is_some() && edu.degree.is_some() {
            body_str.push_str(" -- ");
        }
        if let Some(major) = &edu.major {
            body_str.push_str(major);
        }
        let mut p = Paragraph::new()
            .add_tab(Tab {
                val: Some(TabValueType::Right),
                leader: None,
                pos: Some(inches_to_twips(7) as usize),
            })
            .add_run(Run::new().bold().add_text(body_str))
            .add_run(
                Run::new()
                    .add_text({
                        let mut duration_str = format!("\t{}", edu.duration.start.str_date());
                        match &edu.duration.end {
                            EndingDate::End(end) => {
                                duration_str.push_str(&format!(" - {}", end.str_date()));
                            }
                            EndingDate::Current {
                                expected: Some(date),
                            } => {
                                duration_str.push_str(&format!(" - Expected {}", date.str_date()));
                            }
                            EndingDate::Current { expected: None } => {
                                duration_str.push_str(" - Present");
                            }
                        }
                        duration_str
                    })
                    .italic()
                    .add_break(BreakType::TextWrapping),
            )
            .add_run(
                Run::new()
                    .add_text(&format!("{}, {}", edu.name, edu.location))
                    .add_break(BreakType::TextWrapping),
            );
        if let Some(minor) = &edu.minor {
            p = p.add_run(
                Run::new()
                    .add_text(&format!("Minor: {}", minor))
                    .add_break(BreakType::TextWrapping),
            );
        }
        p = p
            .add_run(
                Run::new()
                    .add_text(&format!("GPA: {:.1}", edu.gpa))
                    .add_break(BreakType::TextWrapping),
            )
            .add_run(Run::new().add_text("Relevant Coursework: ").italic());
        if let Some(coursework) = &edu.coursework {
            p = p.add_run(Run::new().add_text(coursework.join(", ")));
        }
        doc = doc.add_paragraph(p);
    }
    doc
}

fn add_experiences(mut doc: Docx, por: &Portfolio) -> Docx {
    doc = doc.add_paragraph(
        Paragraph::new()
            .add_run(
                Run::new()
                    .add_text("Experience & Projects")
                    .size(HEADING_SIZE),
            )
            .insert_hr(),
    );
    for exp in &por.experience {
        if !exp.current {
            continue;
        }
        let mut p = Paragraph::new().add_tab_stop();
        let mut first_line = exp.company_name.clone();

        if let Some(location) = &exp.location {
            first_line.push_str(&format!(", {location}"));
        }
        if let Some(title_link) = &exp.title_link {
            let run = hyperlink_run(first_line).bold();
            p = p.add_hyperlink(Hyperlink::new(title_link, HyperlinkType::External).add_run(run))
        } else {
            let run = Run::new().add_text(first_line).bold().underline("single");
            p = p.add_run(run);
        }

        let mut time_str = format!("\t{} - ", exp.duration.start.str_date());
        time_str.push_str({
            match &exp.duration.end {
                EndingDate::End(end) => end.str_date(),
                EndingDate::Current {
                    expected: Some(exp),
                } => format!("Expected {}", exp.str_date()),
                EndingDate::Current { expected: None } => "Present".into(),
            }
            .as_str()
        });
        let mut r = Run::new().add_text(time_str).italic();
        if exp.title.is_some() {
            r = r.add_break(BreakType::TextWrapping);
        }
        p = p.add_run(r);

        if let Some(title) = &exp.title {
            p = p.add_run(Run::new().add_text(title));
        }

        doc = doc.add_paragraph(p);
        for line in &exp.description {
            doc = doc.add_paragraph(
                Paragraph::new()
                    .add_run(Run::new().add_text(line))
                    .numbering(NumberingId::new(8), IndentLevel::new(0)),
            );
        }
    }
    doc
}

fn add_publications(mut doc: Docx, por: &Portfolio) -> Docx {
    doc = doc.add_paragraph(
        Paragraph::new()
            .add_run(Run::new().add_text("Publications").size(HEADING_SIZE))
            .insert_hr(),
    );
    for publication in &por.publications {
        let mut p = Paragraph::new().numbering(NumberingId::new(1), IndentLevel::new(0));
        for (i, author) in publication.authors.iter().enumerate() {
            let mut r = if i < publication.authors.len() - 1 {
                Run::new().add_text(format!("{author}, "))
            } else {
                Run::new()
                    .add_text(author)
                    .add_break(BreakType::TextWrapping)
            };
            if *author == por.info.name {
                r = r.bold();
            }
            p = p.add_run(r);
        }
        let mut pub_str_r = Run::new().add_text(publication.title.clone());
        if !publication.status.to_lowercase().contains("published") {
            pub_str_r = pub_str_r.add_break(BreakType::TextWrapping);
            p = p.add_run(pub_str_r);
            p = p.add_run(Run::new().add_text(publication.status.clone()));
        } else {
            p = p.add_run(pub_str_r);
        }
        doc = doc.add_paragraph(p);
    }
    doc
}

pub fn add_skills(mut doc: Docx, por: &Portfolio) -> Docx {
    doc = doc.add_paragraph(
        Paragraph::new()
            .add_run(Run::new().add_text("Technical Skills").size(HEADING_SIZE))
            .insert_hr(),
    );
    for skills in &por.skills {
        let mut p = Paragraph::new().numbering(NumberingId::new(8), IndentLevel::new(0));
        let group = skills.group_name.clone();
        p = p.add_run(Run::new().add_text(&format!("{group}: ")).bold());
        p = p.add_run(Run::new().add_text(skills.skills.join(", ")));
        doc = doc.add_paragraph(p);
    }
    doc
}

pub fn add_awards(mut doc: Docx, por: &Portfolio) -> Docx {
    doc = doc.add_paragraph(
        Paragraph::new()
            .add_run(
                Run::new()
                    .add_text("Awards & Certifications")
                    .size(HEADING_SIZE),
            )
            .insert_hr(),
    );
    for awd in &por.awards {
        let mut p = Paragraph::new().add_tab_stop();
        if let Some(link) = &awd.link {
            p = p
                .add_hyperlink(
                    Hyperlink::new(link, HyperlinkType::External).add_run(
                        Run::new()
                            .add_text(awd.name.clone())
                            .color("0563C1")
                            .underline("single"),
                    ),
                )
                .add_run(Run::new().add_text(&format!("\t{}", awd.date.str_date())));
        } else {
            p = p.add_run(Run::new().add_text(&format!("{}\t{}", awd.name, awd.date.str_date())));
        }
        doc = doc.add_paragraph(p);
    }
    doc
}

pub fn generate_resumes(path: &Path) {
    let por = load_portfolio();
    let _ = std::fs::create_dir_all(path.parent().unwrap());
    let file = std::fs::File::create(path).unwrap();
    let p = Paragraph::new()
        .align(AlignmentType::Center)
        .add_run(Run::new().add_text(por.info.name.clone()).size(TITLE_SIZE));
    let mut doc = Docx::new()
        .page_size(inches_to_twips(8.5) as u32, inches_to_twips(11) as u32)
        .page_margin(PageMargin {
            top: inches_to_twips(0.75),
            left: inches_to_twips(0.75),
            bottom: inches_to_twips(0.75),
            right: inches_to_twips(0.75),
            header: 0,
            footer: 0,
            gutter: 0,
        })
        .default_line_spacing(LineSpacing::new().line(LINE_SPACING_TWIPS))
        .default_size(TEXT_SIZE)
        .default_fonts(RunFonts::new().ascii("Carlito"))
        .add_abstract_numbering(
            AbstractNumbering::new(8).add_level(
                Level::new(
                    0,
                    Start::new(1),
                    NumberFormat::new("bullet"),
                    LevelText::new("•"),
                    LevelJc::new("left"),
                )
                .indent(
                    Some(360),
                    Some(SpecialIndentType::Hanging(360)),
                    None,
                    None,
                ),
            ),
        )
        .add_numbering(Numbering::new(8, 8))
        .add_paragraph(p);

    doc = add_info_and_links(doc, &por);

    doc = add_education(doc, &por);
    doc = add_experiences(doc, &por);
    doc = add_publications(doc, &por);
    doc = add_skills(doc, &por);
    doc = add_awards(doc, &por);
    doc.build().pack(file).expect("Error creating docx");
    docx_to_pdf(path);
}

pub fn docx_to_pdf(path: &Path) {
    let path = canonicalize(path).unwrap();
    let _ = Command::new("libreoffice")
        .args([
            "--headless",
            "--convert-to",
            "pdf",
            path.to_str().unwrap(),
            "--outdir",
            path.parent().unwrap().to_str().unwrap(),
        ])
        .output()
        .expect("Failed to convert docx to pdf");
}
