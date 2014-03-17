# There is much information about this problem online
# since it is in Project Euler. 
#
# After considering a brute force method, I revised
# my solution inspired by the solutions I found by
# googling aroud. 
# 
# Ruby can be very concise. Compared to other solutions
# to this problem, I intend for mine to be easy to
# understand and maintain. 
# 
# References: 
# http://www.mathblog.dk/project-euler-18/
# http://johnnycoder.com/blog/2010/07/11/project-euler-18-ruby/
# https://github.com/mlsimpson/Project-Euler/blob/master/ruby/18.rb

class TriangleSolver
  attr_accessor :maximum_total

  # parse the input file to an array of arrays
  def initialize(file_path)
    @rows = []
    file = File.open(file_path)

    file.each_with_index do |line,i|
      row = line.split

      # ["1","2","3"] => [1,2,3]
      row = row.map { |item| item.to_i }

      @rows[i] = row
    end
  end

  # Working from the bottom up, choose two adjacent numbers. 
  # Each of these pairs represents a choice from a number in
  # the row above it. The larger number in the pair is the
  # best choice, so we can ignore the worse decision and sum
  # the best choice with the number in the row above.
  #
  # Repeating this process up to the top of the triangle will 
  # place the greatest sum at the first position. 
  def solve!
    depth = @rows.size - 1
    depth.downto(0) do |row|
      0.upto(row - 1) do |col|
        # get two neighboring numbers
        pair = [@rows[row][col], @rows[row][col+1]]

        # choose the greater one
        best_choice = pair.max

        # sum with parent number on row above
        @rows[row - 1][col] += best_choice
      end
    end
    @maximum_total = @rows[0][0]
  end
end



files = ['simple','euler','yodle']
files.each do |file|
  ts = TriangleSolver.new("examples/#{file}.txt")
  ts.solve!
  puts "#{file}: #{ts.maximum_total}"
end