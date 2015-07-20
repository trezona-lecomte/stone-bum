require "spec_helper"
require "cave"
require "pry"

RSpec.describe Cave do
  let(:cave)         { Cave.new(input) }
  let(:input)        { StringIO.new(simple_cave) }
  let(:target_units) { 100 }

  context "when given an input file with 100 water units" do
    it "sets the target water units" do
      expect(cave.target_water_units).to eq(100)
    end

    it "sets the current water units" do
      expect(cave.current_water_units).to eq(1)
    end

    context "when pumped" do
      before { cave.pump(target_units) }

      it "has current water units == target_water_units" do
        expect(cave.current_water_units).to eq(cave.target_water_units)
      end
    end

    context "when pumped with 3 units" do
      before { cave.pump(3) }

      it "pumps the first available column" do
        expect(cave.print_state).to eq(cave_pumped_with_3_units)
      end
    end
  end

  def simple_cave
"100

################################
~                              #
#         ####                 #
###       ####                ##
###       ####              ####
#######   #######         ######
#######   ###########     ######
################################
"
  end

  def cave_pumped_with_3_units
"
################################
~~                             #
#~        ####                 #
###       ####                ##
###       ####              ####
#######   #######         ######
#######   ###########     ######
################################
"
  end
end
