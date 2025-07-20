pub trait RstUtils {
    fn add_title(&mut self, title: String) -> &mut Self;
    fn add_subtitle(&mut self, subtitle: String) -> &mut Self;
    fn add_card(
        &mut self,
        title: Option<String>,
        body: Option<String>,
        link: Option<String>,
        indent: i32,
    ) -> &mut Self;
    fn add_card_carousel(
        &mut self,
        titles: Vec<Option<String>>,
        bodies: Vec<Option<String>>,
        links: Vec<Option<String>>,
        num_show: i32,
    ) -> &mut Self;
}

impl RstUtils for String {
    fn add_title(&mut self, title: String) -> &mut Self {
        let bars = "=".repeat(title.len());
        self.push_str(format!("{bars}\n{title}\n{bars}\n\n").as_str());
        self
    }

    fn add_subtitle(&mut self, subtitle: String) -> &mut Self {
        let bars = "=".repeat(subtitle.len());
        self.push_str(format!("{subtitle}\n{bars}\n\n").as_str());
        self
    }

    fn add_card(
        &mut self,
        title: Option<String>,
        body: Option<String>,
        link: Option<String>,
        indent: i32,
    ) -> &mut Self {
        let indent_str = "\t".repeat(indent as usize);
        self.push_str(format!("{indent_str}.. card::").as_str());
        if title.is_some() {
            self.push_str(format!(" {}", title.unwrap()).as_str());
        }
        if body.is_none() && link.is_none() {
            self.push_str("\n\n");
        } else {
            if link.is_some() {
                self.push_str(format!("\n\t{indent_str}:link: {}", link.unwrap()).as_str());

                if body.is_none() {
                    self.push_str("\n\n");
                }
            }

            if body.is_some() {
                let body2 = body
                    .unwrap()
                    .replace("\n", format!("{indent_str}\n\n\t").as_str());
                self.push_str(format!("\n\n\t{indent_str}{body2}\n\n").as_str())
            }
        }
        self
    }

    fn add_card_carousel(
        &mut self,
        titles: Vec<Option<String>>,
        bodies: Vec<Option<String>>,
        links: Vec<Option<String>>,
        num_show: i32,
    ) -> &mut String {
        self.push_str(format!(".. card-carousel:: {num_show}\n\n").as_str());
        for ((title, body), link) in titles.into_iter().zip(bodies).zip(links) {
            self.add_card(title, body, link, 1);
        }
        self
    }
}
