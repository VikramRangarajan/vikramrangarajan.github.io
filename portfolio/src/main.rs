mod data;
mod resume;
mod website;
use resume::{docx_utils::*, generate_resume::generate_resumes};
use website::generate_website::generate_website;

pub fn main() {
    let path = std::path::Path::new("test.docx");
    generate_resumes(path);
    generate_website();
}
