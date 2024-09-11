use docx_rs::*;
use std::path::Path;

use crate::{
    data::{load_portfolio, EndingDate, Portfolio},
    inches_to_twips, PTrait,
};

pub const TITLE_SIZE: usize = 40;
pub const HEADING_SIZE: usize = 28;
pub const TEXT_SIZE: usize = 22;

pub fn add_info_and_links(mut doc: Docx, por: &Portfolio) -> Docx {
    let p = Paragraph::new()
        .add_tab(Tab {
            val: Some(TabValueType::Right),
            leader: None,
            pos: Some(inches_to_twips(6.5) as usize),
        })
        .add_run(Run::new().add_text("Website: "))
        .add_hyperlink(
            Hyperlink::new(por.info.website.clone(), HyperlinkType::External)
                .add_run(
                    Run::new()
                        .add_text(por.info.website.clone())
                        .color("0563C1")
                        .underline("single"),
                )
                .add_run(Run::new().add_text("\t")),
        )
        .add_run(Run::new().add_text("Email: "))
        .add_hyperlink(
            Hyperlink::new(por.info.email.clone(), HyperlinkType::External).add_run(
                Run::new()
                    .add_text(por.info.email.clone())
                    .color("0563C1")
                    .underline("single")
                    .add_break(BreakType::TextWrapping),
            ),
        )
        .add_run(Run::new().add_text("LinkedIn: "))
        .add_hyperlink(
            Hyperlink::new(por.info.linkedin.clone(), HyperlinkType::External)
                .add_run(
                    Run::new()
                        .add_text(por.info.linkedin.clone())
                        .color("0563C1")
                        .underline("single"),
                )
                .add_run(Run::new().add_text("\t")),
        )
        .add_run(Run::new().add_text("Location: "))
        .add_run(
            Run::new()
                .add_text(por.info.location.clone())
                .add_break(BreakType::TextWrapping),
        )
        .add_run(Run::new().add_text("Github: "))
        .add_hyperlink(
            Hyperlink::new(por.info.github.clone(), HyperlinkType::External)
                .add_run(
                    Run::new()
                        .add_text(por.info.github.clone())
                        .color("0563C1")
                        .underline("single"),
                )
                .add_run(Run::new().add_text("\t")),
        )
        .add_run(Run::new().add_text("Phone: "))
        .add_hyperlink(
            Hyperlink::new(por.info.phone.clone(), HyperlinkType::External).add_run(
                Run::new()
                    .add_text(por.info.phone.clone())
                    .color("0563C1")
                    .underline("single"),
            ),
        );
    // doc = &mut doc.add_paragraph(p);
    doc = doc.add_paragraph(p);
    doc
}

fn add_education(mut doc: Docx, por: &Portfolio) -> Docx {
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
        if let Some(minor) = &edu.minor {
            body_str.push_str(&format!(", {} Minor", minor));
        }
        let mut p = Paragraph::new()
            .add_run(
                Run::new()
                    .bold()
                    .add_text(body_str)
                    .add_break(BreakType::TextWrapping),
            )
            .add_run(
                Run::new()
                    .add_text(&format!("{}, {}", edu.name, edu.location))
                    .add_break(BreakType::TextWrapping),
            )
            .add_run(
                Run::new()
                    .add_text({
                        let mut duration_str = edu.duration.start.str_date();
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
                    .add_text(&format!("GPA: {}", edu.gpa))
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
        let mut p = Paragraph::new();
        let mut first_line = exp.company_name.clone();

        if let Some(location) = &exp.location {
            first_line.push_str(&format!(", {location}"));
        }
        let mut run = Run::new()
            .add_text(first_line)
            .bold()
            .underline("single")
            .add_break(BreakType::TextWrapping);
        if let Some(title_link) = &exp.title_link {
            run = run.color("0563C1").underline("single");
            p = p.add_hyperlink(Hyperlink::new(title_link, HyperlinkType::External).add_run(run))
        } else {
            p = p.add_run(run);
        }

        if let Some(title) = &exp.title {
            p = p.add_run(
                Run::new()
                    .add_text(title)
                    .add_break(BreakType::TextWrapping),
            );
        }

        let mut time_str = format!("{} - ", exp.duration.start.str_date());
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
        p = p.add_run(Run::new().add_text(time_str).italic());
        doc = doc.add_paragraph(p);
        for line in &exp.description {
            doc = doc.add_paragraph(
                Paragraph::new()
                    .add_run(Run::new().add_text(line))
                    .numbering(NumberingId::new(8), IndentLevel::new(0)),
            );
        }
    }
    doc.add_abstract_numbering(
        AbstractNumbering::new(8).add_level(
            Level::new(
                0,
                Start::new(1),
                NumberFormat::new("bullet"),
                LevelText::new("•"),
                LevelJc::new("left"),
            )
            .indent(Some(360), Some(SpecialIndentType::Hanging(360)), None, None),
        ),
    )
    .add_numbering(Numbering::new(8, 8))
}

pub fn generate_resumes(path: &Path) {
    let por = load_portfolio();
    let file = std::fs::File::create(path).unwrap();
    let p = Paragraph::new()
        .align(AlignmentType::Center)
        .add_run(Run::new().add_text(por.info.name.clone()).size(TITLE_SIZE));
    // p = p.insert_hr();
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
        .default_size(TEXT_SIZE)
        .default_fonts(RunFonts::new().ascii("Calibri"))
        .add_paragraph(p);

    doc = add_info_and_links(doc, &por).add_paragraph(
        Paragraph::new()
            .add_run(Run::new().add_text("Education").size(HEADING_SIZE))
            .insert_hr(),
    );

    doc = add_education(doc, &por);
    doc = add_experiences(doc, &por);
    doc.build().pack(file).expect("Error creating docx");
}
