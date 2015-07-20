require "pry"

class Cave
  attr_reader :target_water_units, :current_water_units, :cave_state

  def initialize(input)
    @target_water_units = input.readline.to_i
    @cave_state = Array.new
    setup_cave(input)
  end

  def current_water_units
    cave_state.map { |row| row.count("~") }.reduce(:+)
  end

  def pump(target_units)
    units_left = target_units - current_water_units
    #binding.pry

    new_cave_state = cave_state.transpose.map do |col|
      col.map do |char|
        if char.strip.empty? && units_left > 0
          units_left -= 1
          "~"
        else
          char
        end
      end
    end

    @cave_state = new_cave_state.transpose
  end

  def print_state
    cave_state.map { |row| row.join("") + "\n" }
  end

  private

  def setup_cave(input)
    input.each_line do |line|
      cave_state << Array(line.strip.split("")) unless line.strip.empty?
    end
  end

  def next_gap(row, col)
    if cave_state[row+1][col] == " "
      [row+1, col]
      # gap below
    elsif cave_state[row][col+1] == " "
      # gap to the right
      [row, col+1]
    end
  end
end
