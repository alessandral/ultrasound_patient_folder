require 'spec_helper'

describe UltrasoundDriver::UltrasoundPatientFolder do

  context "initialize " do
    it "should accept a path on initialize"  do
      input_path = 'blah'
      mover = described_class.new(input_path)
      expect(mover.path).to eql(input_path)
    end
  end

  context "#date_of_service"do
    subject(:mover) {described_class.new('blah\blah\blah\2013July08 Study_123456789A')}
    before do

    end
    it "should return date of service"

  end

  context "#patient name" do
    it "should return patient name"
  end

   context "#destination path" do
     it "should return the new path with the DOS and patient name"
   end

   context "#files" do
     it "should return a list of the files that we are managing"
   end


end
