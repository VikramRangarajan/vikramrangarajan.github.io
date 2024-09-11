use docx_rs::*;
use std::path::Path;

use crate::{
    data::{load_portfolio, Portfolio},
    inches_to_twips, PTrait,
};

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
                .add_run(Run::new().add_text(por.info.website.clone()).add_text("\t")),
        )
        .add_run(Run::new().add_text("Email: "))
        .add_hyperlink(
            Hyperlink::new(por.info.email.clone(), HyperlinkType::External).add_run(
                Run::new()
                    .add_text(por.info.email.clone())
                    .add_break(BreakType::TextWrapping),
            ),
        )
        .add_run(Run::new().add_text("LinkedIn: "))
        .add_hyperlink(
            Hyperlink::new(por.info.linkedin.clone(), HyperlinkType::External).add_run(
                Run::new()
                    .add_text(por.info.linkedin.clone())
                    .add_text("\t"),
            ),
        )
        .add_run(Run::new().add_text("Location: "))
        .add_hyperlink(
            Hyperlink::new(por.info.location.clone(), HyperlinkType::External).add_run(
                Run::new()
                    .add_text(por.info.location.clone())
                    .add_break(BreakType::TextWrapping),
            ),
        )
        .add_run(Run::new().add_text("Github: "))
        .add_hyperlink(
            Hyperlink::new(por.info.github.clone(), HyperlinkType::External)
                .add_run(Run::new().add_text(por.info.github.clone()).add_text("\t")),
        )
        .add_run(Run::new().add_text("Phone: "))
        .add_hyperlink(
            Hyperlink::new(por.info.phone.clone(), HyperlinkType::External).add_run(
                Run::new()
                    .add_text(por.info.phone.clone())
                    .add_break(BreakType::TextWrapping),
            ),
        );
    // doc = &mut doc.add_paragraph(p);
    doc = doc.add_paragraph(p);
    doc
}

pub fn generate_resumes(path: &Path) {
    let por = load_portfolio();
    let file = std::fs::File::create(path).unwrap();
    let p = Paragraph::new()
        .align(AlignmentType::Center)
        .add_run(Run::new().add_text(por.info.name.clone()).size(40));
    // p = p.insert_hr();
    let mut doc = Docx::new()
        .page_size(inches_to_twips(8.5) as u32, inches_to_twips(11) as u32)
        .page_margin(PageMargin {
            top: inches_to_twips(1),
            left: inches_to_twips(1),
            bottom: inches_to_twips(1),
            right: inches_to_twips(1),
            header: 0,
            footer: 0,
            gutter: 0,
        })
        .default_size(22)
        .default_fonts(RunFonts::new().ascii("Calibri"))
        .add_paragraph(p);

    doc = add_info_and_links(doc, &por).add_paragraph(
        Paragraph::new()
            .add_run(Run::new().add_text("Education").size(28))
            .insert_hr(),
    );
    doc.build().pack(file).expect("Error creating docx");
}
