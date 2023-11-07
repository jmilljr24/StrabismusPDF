require 'csv'

module PartsList
  # file = CSV.read('rv10section4parts.csv')
  # file = CSV.read('./lib/emp_part_list.csv')
  file = %w[test one]
  parts = []
  file.each { |c| parts << c[0] }
  define_method(:getParts) { parts }
end

# documenting for later use
# copy hash or array without modifying the original
def deep_copy(o)
  Marshal.load(Marshal.dump(o))
end
