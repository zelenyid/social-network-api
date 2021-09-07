require 'carrierwave/test/matchers'
require 'rails_helper'

describe AvatarUploader do
  include CarrierWave::Test::Matchers

  let(:user) { create(:user) }
  let(:uploader) { AvatarUploader.new(user, :avatar) }

  before do
    AvatarUploader.enable_processing = true
    File.open(Rails.root.join('spec/fixtures/files/avatar.png')) { |f| uploader.store!(f) }
  end

  after do
    AvatarUploader.enable_processing = false
    uploader.remove!
  end

  context 'the thumb version' do
    it "scales down a landscape image to be exactly 100 by 100 pixels" do
      expect(uploader.thumb).to have_dimensions(100, 100)
    end
  end

  context 'the default version' do
    it "scales down a landscape image to fit within 200 by 200 pixels" do
      expect(uploader).to be_no_larger_than(400, 400)
    end
  end

  it "makes the image readable only to the owner and not executable" do
    expect(uploader).to have_permissions(0600)
  end

  it "has the correct format" do
    expect(uploader).to be_format('png')
  end
end
