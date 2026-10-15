#!/usr/bin/env python3
"""Render the two graphics Google Play requires but the App Store does not.

    python3 store/play/tools/play_graphics.py

  store/play/graphics/icon-512.png          512x512, RGB (no alpha)
  store/play/graphics/feature-1024x500.png  the banner at the top of the listing

Both come from poetry_stream/assets/icon.png so they cannot drift from the
launcher icon. The icon's transparent corners are flattened onto black — the
same #000000 the adaptive icon uses as its background — because Play rejects
an icon with an alpha channel and applies its own corner mask anyway.

The banner carries no screenshot: Play crops it on small screens and overlays
a play button in some placements, so only the icon and a short title survive.
Its colours are the app's own: the warm charcoal of docs/ and the in-app
background, with a soft amber glow like the animated radial gradients.
"""
import pathlib

from PIL import Image, ImageDraw, ImageFilter, ImageFont

ROOT = pathlib.Path(__file__).resolve().parents[3]
ICON = ROOT / "poetry_stream" / "assets" / "icon.png"
OUT = ROOT / "store" / "play" / "graphics"

SERIF = "/System/Library/Fonts/Supplemental/Georgia.ttf"
SERIF_ITALIC = "/System/Library/Fonts/Supplemental/Georgia Italic.ttf"
BG = (10, 8, 6)            # #0a0806, docs/ and app background
TITLE = (232, 213, 183)    # #e8d5b7
MUTED = (138, 125, 102)    # #8a7d66


def flatten(im, bg=(0, 0, 0)):
    if im.mode != "RGBA":
        return im.convert("RGB")
    out = Image.new("RGB", im.size, bg)
    out.paste(im, (0, 0), im)
    return out


def store_icon():
    icon = flatten(Image.open(ICON)).resize((512, 512), Image.LANCZOS)
    path = OUT / "icon-512.png"
    icon.save(path, "PNG")
    return path, icon.size, icon.mode


def glow(size, centre, radius, colour, alpha):
    layer = Image.new("RGBA", size, (0, 0, 0, 0))
    x, y = centre
    ImageDraw.Draw(layer).ellipse(
        [x - radius, y - radius, x + radius, y + radius], fill=colour + (alpha,))
    return layer.filter(ImageFilter.GaussianBlur(radius * 0.6))


def feature_graphic():
    w, h = 1024, 500
    canvas = Image.new("RGBA", (w, h), BG + (255,))
    canvas = Image.alpha_composite(canvas, glow((w, h), (250, 250), 260, (120, 70, 30), 90))
    canvas = Image.alpha_composite(canvas, glow((w, h), (860, 120), 220, (60, 50, 90), 70))
    canvas = canvas.convert("RGB")
    draw = ImageDraw.Draw(canvas)

    src = Image.open(ICON).convert("RGBA").resize((280, 280), Image.LANCZOS)
    canvas.paste(src, (84, (h - 280) // 2), src)

    x = 84 + 280 + 56
    draw.text((x, 150), "Poesie", font=ImageFont.truetype(SERIF, 64), fill=TITLE)
    draw.text((x, 222), "Simona Clinae", font=ImageFont.truetype(SERIF, 64), fill=TITLE)
    draw.text((x, 318), "Meditativní stream české poezie",
              font=ImageFont.truetype(SERIF_ITALIC, 30), fill=MUTED)

    path = OUT / "feature-1024x500.png"
    canvas.save(path, "PNG")
    return path, canvas.size, canvas.mode


def main():
    OUT.mkdir(parents=True, exist_ok=True)
    for path, size, mode in (store_icon(), feature_graphic()):
        print(f"{str(path.relative_to(ROOT)):<44} {size[0]}x{size[1]} {mode}")


if __name__ == "__main__":
    main()
