from pathlib import Path
from subprocess import run
from datetime import date
import re

from docx.document import Document
from docx import Document as CreateDocument
from docx.shared import Cm, Pt
from docx.enum.text import WD_ALIGN_PARAGRAPH, WD_TAB_ALIGNMENT

from data import WholePortfolio, Education, str_date
from docx_utils import (
    insertHR,
    set_global_font,
    get_usable_width,
    add_hyperlink,
)


def add_education(doc: Document, education: Education):
    p = doc.add_paragraph()
    if education.degree is None:
        raise ValueError("No Degree Specified for Education")
    if education.major is None:
        raise ValueError("No Major Specified for Education")
    if education.coursework is None:
        raise ValueError("No Coursework Specified for Education")
    p.add_run(
        education.degree
        + " -- "
        + education.major
        + (", " + education.minor + " Minor" if education.minor is not None else "")
        + "\n"
    ).bold = True
    p.add_run(education.name + ", " + education.location + "\n")

    if education.expected is not None:
        p.add_run(
            str_date(education.start)
            + " - Expected "
            + str_date(education.expected)
            + "\n"
        ).italic = True
    elif education.end is not None:
        p.add_run(
            str_date(education.start) + " - " + str_date(education.end) + "\n"
        ).italic = True
    p.add_run("GPA: " + str(education.GPA) + "\n")
    p.add_run("Relevant Coursework: ").italic = True
    p.add_run(", ".join(education.coursework))


def add_info_and_links(doc: Document, por: WholePortfolio):
    p = doc.add_paragraph()
    width = get_usable_width(doc)
    p.paragraph_format.tab_stops.add_tab_stop(Cm(width), WD_TAB_ALIGNMENT.RIGHT)
    email = por.info.email
    phone = por.info.phone
    linkedin = por.info.linkedin
    github = por.info.github
    website = por.info.website
    p.add_run("Website: ")
    add_hyperlink(p, website, website)
    p.add_run("\t")
    p.add_run("Email: ")
    add_hyperlink(p, f"{email}\n", f"mailto:{email}")
    p.add_run("LinkedIn: ")
    add_hyperlink(p, linkedin, linkedin)
    p.add_run(f"\tLocation: {por.info.location}\n")
    p.add_run("GitHub: ")
    add_hyperlink(p, github, github)
    p.add_run("\t")
    p.add_run("Phone: ")
    add_hyperlink(p, phone, f"tel:{phone}")


def add_experiences(doc: Document, por: WholePortfolio):
    p = doc.add_paragraph()
    p.add_run("Experience & Projects").font.size = Pt(16)
    insertHR(p)

    experiences = por.current.experience
    if experiences is not None:
        for exp in experiences:
            p = doc.add_paragraph()
            l1 = exp.company_name
            if exp.location is not None:
                l1 += ", " + exp.location
            l1 += "\n"
            if exp.title_link is not None:
                _, j = add_hyperlink(p, l1, exp.title_link)
            else:
                j = p.add_run(l1)
            j.bold = j.underline = True
            if exp.title is not None:
                p.add_run(exp.title + "\n")
            time = str_date(exp.start) + " - "
            if exp.end is None:
                time += "Present"
            else:
                time += str_date(exp.end)
            p.add_run(time).italic = True
            for line in exp.description.split("\n"):
                doc.add_paragraph(line, "List Bullet")


def add_publications(doc: Document, por: WholePortfolio):
    p = doc.add_paragraph()
    p.add_run("Publications").font.size = Pt(16)
    insertHR(p)

    if por.current.publications is not None:
        for pub in por.current.publications:
            p = doc.add_paragraph("", "List Number")
            for i, author in enumerate(pub.authors):
                if i < len(pub.authors) - 1:
                    r = p.add_run(author + ", ")
                else:
                    r = p.add_run(author + "\n")
                if author == por.info.name:
                    r.bold = True
            pub_str = pub.title
            if "published" not in pub.status.lower():
                pub_str += f"\n{pub.status}"
            p.add_run(pub_str)


def add_skills(doc: Document, por: WholePortfolio):
    p = doc.add_paragraph()
    p.add_run("Technical Skills").font.size = Pt(16)
    insertHR(p)

    p = doc.add_paragraph()
    if por.current.skills is not None:
        first = True
        for name in por.current.skills.keys():
            if not first:
                p.add_run("\n")
            skill_group = por.current.skills[name]
            name: str = re.sub("[^0-9a-zA-Z]+", " ", name).capitalize()
            name = f"{name}: "
            p.add_run(name).bold = True
            p.add_run(", ".join(skill_group))
            first = False


def add_awards(doc: Document, por: WholePortfolio):
    width = get_usable_width(doc)
    p = doc.add_paragraph()
    p.add_run("Awards & Certifications").font.size = Pt(16)
    insertHR(p)

    p = doc.add_paragraph()
    p.paragraph_format.tab_stops.add_tab_stop(Cm(width), WD_TAB_ALIGNMENT.RIGHT)
    if por.current.awards is not None:
        for award in por.current.awards:
            p.add_run(f"{award.name}\t").bold = True
            if isinstance(award.date, date):
                p.add_run(f"{str_date(award.date)}\n").italic = True
            else:
                p.add_run(f"{award.date}\n").italic = True


def create_docx(path: str | Path):
    doc = CreateDocument()
    sections = doc.sections
    for section in sections:
        section.top_margin = Cm(1)
        section.bottom_margin = Cm(1)
        section.left_margin = Cm(1)
        section.right_margin = Cm(1)

    ROOT = Path(__file__).parent.absolute()

    with open(ROOT / "portfolio.json") as f:
        por = WholePortfolio.model_validate_json(f.read())

    # Add Title
    p = doc.add_paragraph()
    p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    r = p.add_run(por.info.name)
    r.font.size = Pt(24)

    # Info and Links section at the top
    add_info_and_links(doc, por)

    # Add education section
    p = doc.add_paragraph()
    p.add_run("Education").font.size = Pt(16)
    insertHR(p)
    if por.current.education is not None:
        add_education(doc, por.current.education[0])

    # Experience Section
    add_experiences(doc, por)

    # Publications Section
    add_publications(doc, por)

    # Skills Section
    add_skills(doc, por)

    # Certs Section
    add_awards(doc, por)

    set_global_font(doc, "Calibri")
    doc.save(str(path))


def docx_to_pdf(docx_file: str | Path):
    run(
        [
            "libreoffice",
            "--headless",
            "--convert-to",
            "pdf",
            str(docx_file),
            "--outdir",
            str(Path(docx_file).parent),
        ]
    )


if __name__ == "__main__":
    ROOT = Path(__file__).parent.parent.parent.absolute()
    create_docx(ROOT / "docs/source/_static/resume.docx")
    docx_to_pdf(ROOT / "docs/source/_static/resume.docx")
