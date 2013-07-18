require 'spec_helper'
require 'tempfile'

describe UltrasoundDriver::UltrasoundDateOfServiceFolder do
  context "initialize" do

    it "accepts a path on initialize" do

      path = 'blah/blah'
      dos_folder = described_class.new(path)
      expect(dos_folder.dos_path).to eql(path)
    end
  end

  context "#date_of_service" do
    subject(:date_of_service_folder) {described_class.new('blah\blah\blah\patient_name')}

    it "has a method to return date of service" do
      date_of_service_folder.should respond_to(:date_of_service)
    end

    it "returns date of service from path as year month day" do
      date_of_service_folder = '2013Jul08text_around_the_path_xxxxx'

     Dir.mktmpdir(date_of_service_folder) do |temp_directory|

       date_of_service_folder = described_class.new(temp_directory)

       date_of_service_folder.date_of_service.should eql('20130708')
     end
    end

  end


  context "#date of service files" do

    it "has method patient_dates_of_services files" do
      described_class.new('bahl').should respond_to(:dates_of_services_files)
    end

    it "returns a list of files" do
      Dir.mktmpdir do |temp_directory|
        file = File.join(temp_directory, 'random_filename.jpg')
        FileUtils.touch file

        dos_folder = described_class.new(temp_directory)
        expect(dos_folder.dates_of_services_files).to eql([file])
      end
    end
  end
end

