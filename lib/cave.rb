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

    starting_pos = [0, 0]

    cave_state.each_with_index do |row, rindex|
      row.each_with_index do |col, cindex|
        if cave_state[rindex][cindex] == "~"
          starting_pos = [rindex, cindex]
        end
      end
    end

    until units_left == 0
      next_gap_to_fill = next_gap(starting_pos[0], starting_pos[1])

      @cave_state[next_gap_to_fill[0]][next_gap_to_fill[1]] = "~"

      starting_pos = next_gap_to_fill

      units_left -= 1
    end
  end

  def print_state
    cave_state.map { |row| row.join("") + "\n" }
  end

  def depths
    cave_state.transpose.map do |col|
      if col.include?(" ") && col.include?("~")
        if col.rindex(" ") > col.rindex("~")
          "~"
        else
          col.count("~")
        end
      else
        col.count("~")
      end
    end
  end

  def save_depths(filename)
    File.open(filename, "w") do |file|
      file.puts depths.join(" ")
    end
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
    elsif cave_state[row][col+1] == " "
      [row, col+1]
    else
      (0..col).to_a.each do |col_above|
        if cave_state[row-1][col_above] == " "
          return [row-1, col_above]
        end
      end
    end
  end
end
