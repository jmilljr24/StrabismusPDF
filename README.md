# README

Ruby on Rails website to process PDF files.

Kitplane manufacturer Van's Aircraft provides customers with PDF instructional
files for building the kit plane. Numerous part numbers are reference between
the written steps and a graphical representation of the parts being put
together.

The backend processing of the pdf's are done in python. My repo at <https://github.com/jmilljr24/HighlightParts>

The site uses a mix of Tailwind CSS, Turbo Frames/Streams and a PostgreSQL
database.

python3 version 3.12

pip install -r requirements.txt

Deploy to heroku with postgresl db

buildpack for libvips (photos from activestorage)
