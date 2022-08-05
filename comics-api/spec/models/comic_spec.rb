require 'rails_helper'

RSpec.describe Comic, type: :model do

  context "factory" do
    let(:json) { 
      { 
        id: 1, 
        title: "title 1", 
        thumbnail: { 
            path: "thumb_path", 
            extension: "ext" 
        } 
      } 
    }
    
    it "should merge thumbnail path and id" do
      expect(Comic.from_json(json).thumbnail).to eq('thumb_path.ext')
    end
  end
end
