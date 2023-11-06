require 'csv'

module SectionParts
  # file = CSV.read('rv10section4parts.csv')
  file = CSV.read('emp_part_list.csv')

  parts = []
  file.each { |c| parts << c[0] }
  define_method(:getParts) { parts }
end

# documenting for later use
# copy hash or array without modifying the original
def deep_copy(o)
  Marshal.load(Marshal.dump(o))
end
