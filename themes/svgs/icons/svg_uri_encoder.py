#! /usr/bin/env python3
"""
A tiny svg encoder.

This little tool encodes the given svg files to uri
"""

import urllib.parse

svgs = ["abstract.svg",
        "bug.svg",
        "danger.svg",
        "example.svg",
        "failure.svg",
        "info.svg",
        "note.svg",
        "question.svg",
        "quote.svg",
        "success.svg",
        "tip.svg",
        "todo.svg",
        "warning2.svg",
        "warning.svg",
        ]

__CSS_OUT__ = ""

for svg_in in svgs:
    __DROP__ = 0
    print(f"Processing: {svg_in}")
    with open(svg_in, "r", encoding="utf-8") as svg_file:
        svg_data = svg_file.readlines()

        while svg_data[__DROP__].find("svg") < 0:
            __DROP__ += 1

        svg_bytes = bytes(''.join(svg_data[__DROP__:]), "utf-8")

        # encoded_svg = urllib.parse.quote(svg_bytes, safe=':/')
        encoded_svg = urllib.parse.quote(svg_bytes, safe="")
        url = 'data:image/svg+xml,' + encoded_svg

        __CSS_OUT__ += f"/* {svg_in} */\n"
        __CSS_OUT__ += f"content: url(\"{url}\");\n"

with open("uri_encoded_icons.css", "w", encoding="utf-8") as css_file:
    css_file.write(__CSS_OUT__)
