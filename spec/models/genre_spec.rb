require "rails_helper"

RSpec.describe Genre, type: :model do
  describe "association" do
    it "has_many posts" do
      expect(Genre.reflect_on_association(:posts).macro).to eq :has_many
    end
  end
end
