import json
from pathlib import Path
from docx import Document
from docx.shared import Cm, Pt, RGBColor
from docx.enum.text import WD_ALIGN_PARAGRAPH
from utils import (
    insertHR,
    set_global_font,
    set_table_border_none,
    right_align_columns,
    add_date_table,
    ddict,
    get_usable_width,
    set_column_widths,
    add_hyperlink
)


doc = Document()
sections = doc.sections
for section in sections:
    section.top_margin = Cm(1)
    section.bottom_margin = Cm(1)
    section.left_margin = Cm(1)
    section.right_margin = Cm(1)

ROOT = Path(__file__).parent.absolute()


with open(ROOT / "portfolio.json") as f:
    por = ddict(json.load(f))

width = get_usable_width(doc)

# Add Title
p = doc.add_paragraph()
p.alignment = WD_ALIGN_PARAGRAPH.CENTER
p.style.font.color.rgb = RGBColor.from_string("000000")
r = p.add_run(por.current.info.name)
r.font.size = Pt(24)

# Add Info and Links as a table
t = doc.add_table(3, 2)
set_table_border_none(t)
email = por.current.info.email
phone = por.current.info.phone
linkedin = por.current.info.linkedin
github = por.current.info.github
add_hyperlink(t.cell(0, 0).paragraphs[0], email, f"mailto:{email}")
add_hyperlink(t.cell(0, 1).paragraphs[0], phone, f"tel:{phone}")
add_hyperlink(t.cell(1, 0).paragraphs[0], linkedin, linkedin)
t.cell(1, 1).text = por.current.info.location
add_hyperlink(t.cell(2, 0).paragraphs[0], github, github)
set_column_widths(t, (width * 3 / 4, width * 1 / 4))
right_align_columns(t)

# Add education section
p = doc.add_paragraph()
p.add_run("Education").font.size = Pt(16)
insertHR(p)
p = doc.add_paragraph()
college = por.current.education[0]
p.add_run(
    college["degree"]
    + " -- "
    + college["major"]
    + (", " + college["minor"] + " Minor" if "minor" in college.keys() else "")
    + "\n"
).bold = True
p.add_run(college["name"] + ", " + college["location"] + "\n")

if college["expected"] is not None:
    p.add_run(college["start"] + " - Expected " + college["expected"] + "\n")
else:
    p.add_run(college["start"] + " - " + college["end"] + "\n")
p.add_run("GPA: " + str(college["GPA"]) + "\n")
p.add_run("Relevant Coursework: " + ", ".join(college["coursework"]))

# Experience Section
p = doc.add_paragraph()
p.add_run("Experience & Projects").font.size = Pt(16)
insertHR(p)

experiences = por.current.experience
for exp in experiences:
    p = doc.add_paragraph()
    l1 = exp["company-name"]
    if exp["location"] is not None:
        l1 += ", " + exp["location"]
    l1 += "\n"
    j = p.add_run(l1)
    j.bold = j.underline = True
    if exp["title"] is not None:
        p.add_run(exp["title"] + "\n")
    time = exp["start"] + " - "
    if exp["end"] is None:
        time += "Present"
    else:
        time += exp["end"]
    p.add_run(time)
    for line in exp["description"].split("\n"):
        doc.add_paragraph(line, "List Bullet")

# Skills Section
p = doc.add_paragraph()
p.add_run("Technical Skills").font.size = Pt(16)
insertHR(p)

p = doc.add_paragraph()
p.add_run("Programming Languages: ").bold = True
p.add_run(", ".join(por.current.skills["programming-languages"]))
p.add_run("\nTechnologies: ").bold = True
p.add_run(", ".join(por.current.skills.technologies))


# Certs Section
p = doc.add_paragraph()
p.add_run("Awards & Certifications").font.size = Pt(16)
insertHR(p)

n_awards = len(por.current.awards)
t = add_date_table(doc, n_awards)
for i, award in enumerate(por.current.awards):
    # t.cell(i, 0).add_paragraph().add_run(award["name"]).bold = True
    # t.cell(i, 1).add_paragraph().add_run(award["date"]).italic = True
    t.cell(i, 0).text = award["name"]
    t.cell(i, 1).text = award["date"]
right_align_columns(t)
# Save the document

set_global_font(doc, "Calibri")
doc.save("formatted_document.docx")
