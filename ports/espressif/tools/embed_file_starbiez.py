from pathlib import Path
import sys

input_path = Path(sys.argv[1])
output_path = Path(sys.argv[2])
symbol = sys.argv[3]

data = input_path.read_bytes()

with output_path.open("w", encoding="utf-8") as f:
    f.write("#include <stdint.h>\n")
    f.write("#include <stddef.h>\n")
    f.write("\n")
    f.write(f"const uint8_t {symbol}[] = {{\n")

    for i in range(0, len(data), 16):
        chunk = data[i:i + 16]
        f.write("    ")
        f.write(", ".join(f"0x{byte:02x}" for byte in chunk))
        f.write(",\n")

    f.write("};\n")
    f.write(f"const size_t {symbol}_size = {len(data)};\n")