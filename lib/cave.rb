class Cave
  attr_reader :cave_state, :target_units

  def initialize(input)
    @target_units = input.readline.to_i
    @cave_state = Array.new
    setup_cave(input)
    pump(target_units)
  end

  def current_units
    cave_state.map { |row| row.count("~") }.reduce(:+)
  end

  def pump(units)
    units_left = units - current_units

    current_pos = starting_pos

    until units_left == 0
      current_pos = next_gap(current_pos[0], current_pos[1])

      @cave_state[current_pos[0]][current_pos[1]] = "~"

      units_left -= 1
    end
  end

  def depths
    cave_state.transpose.map do |col|
      if (col.include?(" ") && col.include?("~")) && (col.rindex(" ") > col.rindex("~"))
        "~"
      else
        col.count("~")
      end
    end
    .join(" ")
  end

  private

  def setup_cave(input)
    input.each_line do |line|
      cave_state << Array(line.strip.split("")) unless line.strip.empty?
    end
  end

  def starting_pos
    cave_state.each_with_index do |row, rindex|
      row.each_with_index do |col, cindex|
        if cave_state[rindex][cindex] == "~"
          return [rindex, cindex]
        end
      end
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
