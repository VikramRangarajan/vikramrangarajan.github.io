use docx_rs::*;

pub fn inches_to_twips<T: Into<f64>>(inches: T) -> i32 {
    (inches.into() * 1440.0) as i32
}

pub trait PTrait {
    fn insert_hr(self) -> Self;
}

impl PTrait for Paragraph {
    fn insert_hr(mut self) -> Paragraph {
        self.property = self.property.set_borders(
            ParagraphBorders::with_empty()
                .set(ParagraphBorder::new(ParagraphBorderPosition::Bottom)),
        );
        self
    }
}
