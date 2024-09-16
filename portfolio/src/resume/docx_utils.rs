use crate::resume::generate_resume::LINE_SPACING_TWIPS;
use docx_rs::*;

pub fn inches_to_twips<T: Into<f64>>(inches: T) -> i32 {
    (inches.into() * 1440.0) as i32
}

pub fn hyperlink_run(s: String) -> Run {
    Run::new().add_text(s).color("0563C1").underline("single")
}

pub trait PTrait {
    fn insert_hr(self) -> Self;
    fn add_tab_stop(self) -> Paragraph;
}

impl PTrait for Paragraph {
    fn insert_hr(mut self) -> Paragraph {
        self = self.line_spacing(
            LineSpacing::new()
                .line(LINE_SPACING_TWIPS)
                .before(LINE_SPACING_TWIPS as u32 / 2u32)
                .after(LINE_SPACING_TWIPS as u32 / 2u32),
        );
        self.property = self.property.set_borders(
            ParagraphBorders::with_empty()
                .set(ParagraphBorder::new(ParagraphBorderPosition::Bottom)),
        );
        self
    }

    fn add_tab_stop(self) -> Paragraph {
        self.add_tab(Tab {
            val: Some(TabValueType::Right),
            leader: None,
            pos: Some(inches_to_twips(7) as usize),
        })
    }
}
