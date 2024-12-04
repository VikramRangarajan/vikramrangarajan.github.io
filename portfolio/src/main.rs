mod data;
mod resume;
mod website;
use resume::{docx_utils::*, generate_resume::generate_resumes};
use website::generate_website::{generate_html, generate_website};

pub fn main() {
    let path = std::path::Path::new("../docs/source/_static/resume.docx");
    generate_resumes(path);
    generate_website();
    generate_html();
}
