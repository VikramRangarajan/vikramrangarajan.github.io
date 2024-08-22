from io import TextIOWrapper


def title(f: TextIOWrapper, t: str):
    f.write("=" * len(t) + "\n")
    f.write(t + "\n")
    f.write("=" * len(t) + "\n\n")


def subtitle(f: TextIOWrapper, t: str):
    f.write(t + "\n")
    f.write("=" * len(t) + "\n\n")


def indexes_and_tables(f: TextIOWrapper):
    f.write("* :ref:`genindex`\n\n")


def card(
    f: TextIOWrapper,
    title: str | None = None,
    body: str | None = None,
    link: str | None = None,
    indent: int = 0,
):
    indent_str = "\t" * indent
    f.write(indent_str + ".. card::")
    if title is not None:
        f.write(" " + title)
    if body is None and link is None:
        f.write("\n\n")
    else:
        if link is not None:
            f.write(f"\n\t{indent_str}:link: {link}")

            if body is None:
                f.write("\n\n")

        if body is not None:
            body = body.replace("\n", indent_str + "\n\n\t")
            f.write(f"\n\n\t{indent_str}{body}\n\n")


def card_carousel(
    f: TextIOWrapper,
    titles: list,
    bodies: list,
    links: list,
    num_show: int = 5,
):
    f.write(f".. card-carousel:: {num_show}\n\n")
    for title, body, link in zip(titles, bodies, links):
        card(f, title, body, link, indent=1)
