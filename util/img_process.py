import sys
import os
from PIL import Image

def resize_image(src, width, height):
    dst = src.resize((width, height), Image.LANCZOS)
    return dst

def add_padding(src, width, height):
    src_width, src_height = src.size
    pad_top  = (height - src_height) // 2
    pad_left = (width  - src_width ) // 2

    dst = Image.new('RGB', (width, height), color='white')
    dst.paste(src, (pad_left, pad_top))
    return dst

def main():
    operations = {
        'resize': resize_image,
        'padding': add_padding
    }

    if len(sys.argv) != 5:
        sys.exit(f"Usage: python {sys.argv[0]} <input_path> <width> <height> <operation>")

    src_path, width, height, operation = sys.argv[1], int(sys.argv[2]), int(sys.argv[3]), sys.argv[4]
    
    if operation not in operations:
        sys.exit(f"Error: Invalid operation")

    src = Image.open(src_path) or sys.exit(f"Error: Cannot read {src_path}")
    
    dst = operations[operation](src, width, height)

    base_name, ext = os.path.splitext(src_path)
    dst_path = f"{base_name}_{width}x{height}_{operation}{ext}"

    dst.save(dst_path) or sys.exit(f"Error: Cannot save to {dst_path}")
    print(f"Success: Image saved to {dst_path}")

if __name__ == "__main__":
    main()