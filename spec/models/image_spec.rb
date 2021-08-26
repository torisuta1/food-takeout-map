require "rails_helper"

RSpec.describe Image, type: :model do
  describe "association" do
    it "belongs_to post" do
      expect(Image.reflect_on_association(:post).macro).to eq :belongs_to
    end
  end
end
