from flask import Flask, request, send_file
import crop

app = Flask(__name__)

app.debug = True


@app.route('/image/crop')
def crop_image():
    url: str = request.get_json()["url"]
    code: str = request.args.get("code")
    tiles: str = request.args.get("tiles")

    urls = crop.crop(url, int(tiles), code)
    return {
        "urls": urls
    }


@app.route('/image/download')
def download_image():
    code: str = request.args.get("code")
    file: str = request.args.get("file")

    return send_file(f"{code}temp/tiles/{file}.jpg")


if __name__ == '__main__':
    app.run()
