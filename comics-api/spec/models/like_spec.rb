require 'rails_helper'

RSpec.describe Like, type: :model do

  context "validations" do
    it { should validate_uniqueness_of(:comic_id).case_insensitive }
  end

  context "search for comics ids" do
    
    before do
      (1..10).each { |i| Like.create( comic_id: i, count: 1 ).id  }
    end

    it "returns the list of likes found" do
      expect(Like.from_comics_ids(comics_ids: [1,2,3,4,5]).size).to eq(5)
    end

    it "returns empty" do
      expect(Like.from_comics_ids(comics_ids: [11,12,13,14,15])).to be_empty
    end
  end
end
