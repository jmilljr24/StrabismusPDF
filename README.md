# README

Ruby on Rails website to process PDF files.

Kitplane manufacturer Van's Aircraft provides customers with PDF instructional
files for building the kit plane. Numerous part numbers are reference between
the written steps and a graphical representation of the parts being put
together.

This program will find matching parts on a given page add matching highlight
annotations. It will also remember the color of a given part if it was on the
previous page. There is only one page lookback due to the large number of parts
and the limit on number of different colors that are contrasting.

The site uses a mix of Tailwind CSS, Turbo Frames/Streams and a PostgreSQL database.

Deploy to heroku. No additional configuration needed.
