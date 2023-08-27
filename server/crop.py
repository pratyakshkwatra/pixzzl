import os
import requests
from PIL import Image


def download_image(url, temp_dir):
    response = requests.get(url)
    if response.status_code == 200:
        image_path = os.path.join(temp_dir, 'original_image.jpg')
        with open(image_path, 'wb') as f:
            f.write(response.content)
        return image_path
    else:
        print("Failed to download image.")
        return None


def divide_image(image_path, n, output_dir, code):
    urls = []
    original_image = Image.open(image_path).convert(
        "RGB")  # Convert to RGB format
    width, height = original_image.size
    tile_width = width // n
    tile_height = height // n

    for i in range(n):
        for j in range(n):
            left = j * tile_width
            upper = i * tile_height
            right = left + tile_width
            lower = upper + tile_height

            tile = original_image.crop((left, upper, right, lower))
            tile_path = os.path.join(output_dir, f'{i * n + j}.jpg')
            tile.save(tile_path)
            urls.append(
                f"http://127.0.0.1:5000/image/download?code={code}&file={i * n + j}")

    print(urls)
    return urls


def crop(url: str, tiles: int, code: str):
    temp_dir = f'{code}temp'
    output_dir = os.path.join(temp_dir, 'tiles')

    if not os.path.exists(temp_dir):
        os.mkdir(temp_dir)
    if not os.path.exists(output_dir):
        os.mkdir(output_dir)

    image_path = download_image(url, temp_dir)
    if image_path:
        urls = divide_image(image_path, tiles, output_dir, code)
        return urls
    else:
        pass
