require 'hexapdf'
require_relative 'parts_list'
# Usage:
# : `ruby string_boxes.rb INPUT.PDF`
#

class StringBoxesProcessor < HexaPDF::Content::Processor
  include SectionParts

  attr_accessor :page_parts, :text_box_parts, :str_boxes, :used_colors, :current_page_parts, :color_key

  def initialize(page, color_key = {})
    super()
    @canvas = page.canvas(type: :overlay)

    @colors = %w[cyan deeppink olivedrab red blue orange darksalmon darkslateblue lime tomato hp-teal-dark2 springgreen
                 goldenrod magenta maroon]
    @used_colors = []
    @parts = getParts
    @str_boxes = {}
    @page_parts = {}
    @color_key = color_key
    @current_page_parts = []
  end

  def show_text(str)
    @str_boxes[str] = decode_text_with_positioning(str)
  end
  alias show_text_with_positioning show_text

  def match(string_boxes)
    string_boxes.each do |string, value|
      begin
        part = string.select.with_index { |_, i| i.even? }.join
      rescue StandardError
        nil
      end

      @parts.each do |part_number|
        # positions = part&.enum_for(:scan, /#{part_number}/)&.map {
        # Regexp.last_match.begin(0) }
        positions = part&.enum_for(:match, part_number)&.map { Regexp.last_match.begin(0) }

        next if positions.nil? || positions.empty?

        positions.each do |pos|
          @page_parts[string] = {} unless @page_parts.key?(string)
          @page_parts[string][part_number] = [] unless @page_parts[string].key?(part_number)

          @page_parts[string][part_number].push(value.cut(pos, (pos + part_number.length)))
          @current_page_parts << part_number
        end
      end

      left_part = part&.enum_for(:match, '-L')&.map { Regexp.last_match.begin(0) }
      left_part&.each do |pos|
        boxes = value.cut(pos, (pos + 2))
        @canvas.line_width = 2.0
        @canvas.stroke_color(150, 20, 20)
        @canvas.polyline(*boxes[0].lower_left, *boxes[1].lower_right,
                         *boxes[1].upper_right, *boxes[0].upper_left).close_subpath.stroke
      end
      right_part = part&.enum_for(:match, '-R')&.map { Regexp.last_match.begin(0) }
      right_part&.each do |pos|
        boxes = value.cut(pos, (pos + 2))
        @canvas.line_width = 2.0
        @canvas.stroke_color(30, 100, 30)
        @canvas.polyline(*boxes[0].lower_left, *boxes[1].lower_right,
                         *boxes[1].upper_right, *boxes[0].upper_left).close_subpath.stroke
      end
    end
  end

  def assign_color(list, both_pages)
    @color_key.keep_if { |key, _value| both_pages.include?(key) }
    p = []

    list.each do |_key, value|
      value.each do |k, _v|
        p << k
      end
    end
    unique_parts = p.uniq
    unique_parts.each do |part|
      n = @color_key.values
      n.each_with_index do |color, _index|
        # next if index == 0 # this was for skipping the page number if implemented
        next if color.nil?

        @used_colors << color unless @used_colors.include?(color)
      end
      next if @color_key.has_key?(part)

      color = @used_colors.empty? ? @colors.sample : (@colors - @used_colors).sample

      @color_key[part] = color
    end
  end

  def color(encodes)
    encodes.each do |_string, boxes|
      boxes.each_with_index do |a, _ai|
        # next if ai.zero?

        a.each_with_index do |b, bi|
          next if bi.zero?

          b.each do |c|
            c.each do |box|
              x, y = *box.lower_left
              tx, ty = *box.upper_right
              color = @color_key.dig(a[0]).nil? ? 'yellow' : @color_key.dig(a[0])
              @canvas.fill_color(color).opacity(fill_alpha: 0.5)
                     .rectangle(x, y, tx - x, ty - y).fill
            end
          end
        end
      end
    end
  end
end

@color_key = {}
@prev_page_parts = nil

doc = HexaPDF::Document.open(ARGV.shift)
# doc = HexaPDF::Document.open('06_10.pdf')

doc.pages.each_with_index do |page, index|
  puts "Processing page #{index + 1}"
  processor = if index == 0
                StringBoxesProcessor.new(page)
              else
                StringBoxesProcessor.new(page, @color_key)
              end
  page.process_contents(processor)
  str_boxes = processor.str_boxes
  processor.match(str_boxes)
  page_parts = processor.page_parts

  both_pages = @prev_page_parts & processor.current_page_parts.uniq

  processor.assign_color(page_parts, both_pages)
  processor.color(page_parts)
  @color_key = processor.color_key
  @prev_page_parts = processor.current_page_parts.uniq
end
doc.write('show_char_boxes.pdf', optimize: true)
