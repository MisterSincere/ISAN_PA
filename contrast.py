import argparse


def srgb_channel_to_linear(c_8bit: int) -> float:
    c_srgb = c_8bit / 255.0
    if c_srgb <= 0.04045:
        return c_srgb / 12.92
    else:
        return ((c_srgb + 0.055) / 1.055) ** 2.4


def relative_luminance(r_8bit: int, g_8bit: int, b_8bit: int) -> float:
    r = srgb_channel_to_linear(r_8bit)
    g = srgb_channel_to_linear(g_8bit)
    b = srgb_channel_to_linear(b_8bit)

    return 0.2126 * r + 0.7152 * g + 0.0722 * b


def hex_to_rgb(hex: str) -> tuple[int, int, int]:
    hex = hex.strip().lstrip("#")

    if len(hex) == 3:
        hex = "".join(c * 2 for c in hex)
    elif len(hex) != 6:
        raise ValueError(f"Invalid hex color: ${hex}")

    r = int(hex[0:2], 16)
    g = int(hex[2:4], 16)
    b = int(hex[4:6], 16)

    return r, g, b


def contrast_ratio(color0: str, color1: str) -> float:
    r0, g0, b0 = hex_to_rgb(color0)
    r1, g1, b1 = hex_to_rgb(color1)

    l0 = relative_luminance(r0, g0, b0)
    l1 = relative_luminance(r1, g1, b1)

    lighter = max(l0, l1)
    darker = min(l0, l1)

    return (lighter + 0.05) / (darker + 0.05)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Compute contrast ratio between two hex colors"
    )
    parser.add_argument("color1", help="First color (e.g. #1e90ff)")
    parser.add_argument("color2", help="First color (e.g. #fff)")
    args = parser.parse_args()
    contrast = contrast_ratio(args.color1, args.color2)
    print(f"Contrast: {contrast:.2f}")
