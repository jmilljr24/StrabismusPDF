import fitz
import re
from io import BytesIO
import random
import argparse

#Color list for highlights
cl = ['deeppink', 'pink3', 'magenta', 'darkorchid2', 'maroon',
      'slateblue', 'steelblue', 'deepskyblue', 'cyan', 'cyan3', 'aquamarine3',  'royalblue2',
      'green', 'limegreen', 'chartreuse1', 'yellowgreen', 
       'khaki4', 
      'gold2', 'darkgoldenrod3', 
      'orange', 'darkorange1', 'orangered','orangered3', 'salmon3',
      'red3', 'indianred3',
      'snow4']


# input_file = "pdfs/27_10.pdf"
# output_file = "test.pdf"
parts_re = re.compile(r"[A-Z]{1,2}-\d{3,5}[A-Z]?(-[LR])?")  # need to exclude "(" at beginning tried ^[^\(] but did not work on 07_10. 06_10 was was successfully
#Command line arguments
argParser = argparse.ArgumentParser()
argParser.add_argument("-i", "--input", help="Input file path")
argParser.add_argument("-o", "--output", help="Output file path")
args = argParser.parse_args()
input_file = args.input
output_file = args.output

# Add key/value pair for unique parts
def colorize(part):
    if part not in color_dict:
        color_dict[part] = cl[uniq_parts] if len(color_dict) < len(cl) else 'yellow'
        return 1
    return 0

def lr_highlight(matched_values, border_color):
    for val in matched_values:
        shape = page.new_shape()
        matching_val_area = page.search_for(val, quads=True)
        for quad in matching_val_area:
            #Adjust border position/size due to OCR alignment inaccuracy
            ul = quad.ul
            ul_big = fitz.Point(ul[0] + 1, ul[1] - 1)
            ll = quad.ll
            ll_big = fitz.Point(ll[0] + 1, ll[1] + 1)
            lr = quad.lr
            lr_big = fitz.Point(lr[0] + 4, lr[1] + 1)
            ur = quad.ur
            ur_big = fitz.Point(ur[0] + 4, ur[1] - 1)
            big_quad = fitz.Quad(ul_big, ll_big, ur_big, lr_big)
            #Draw colored border around '-L' and '-R'
            page.draw_quad(big_quad, color= fitz.utils.getColor(border_color))
            shape.commit()


def highlight_left(left_parts):
    lr_highlight(left_parts, 'darkred')
    
def highlight_right(right_parts):
    lr_highlight(right_parts, 'chartreuse4')

#Setup for pdf scan
pdfDoc = fitz.open(input_file)
#Print page count of input PDF
num_pages = pdfDoc.page_count
print( str(num_pages) + " pages to process...")

# Iterate through pages
count = 0
output_buffer = BytesIO()

for pg in range(pdfDoc.page_count):
    # Select the page
    page = pdfDoc[pg]

    page_lines = page.get_text("text").split('\n')
    for line in page_lines:
        left_result = re.findall("-L", line)
        highlight_left(left_result)
        right_result = re.findall("-R", line)
        highlight_right(right_result)
    #Randomize color list
    random.shuffle(cl)

    #Process page for parts
    words = page.get_text("words")
    matches = [w for w in words if parts_re.findall(w[4])]

    for m in matches:
        print(m[4])
    
    count += len(matches)

    color_dict = {}
    uniq_parts = 0
    for val in matches:
        part_num = val[4]
        uniq_parts += colorize(part_num)
        matching_val_area = page.search_for(part_num, quads=True)

        highlight = None
        highlight = page.add_highlight_annot(matching_val_area)
        highlight.set_colors(stroke= fitz.utils.getColor(color_dict[part_num]))
        highlight.update(opacity= 0.3)

print(str(count) + ' Matches found')
# Save to output
pdfDoc.save(output_buffer)
pdfDoc.close()
# Save the output buffer to the output file
with open(output_file, mode='wb') as f:
    f.write(output_buffer.getbuffer())