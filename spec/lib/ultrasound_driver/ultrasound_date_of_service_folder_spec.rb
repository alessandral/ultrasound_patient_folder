require 'spec_helper'
require 'tempfile'

describe UltrasoundDriver::UltrasoundDateOfServiceFolder do

  let(:initial_path) {'spec/fixtures/test_folders/sonoexport/'}


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
      expect(date_of_service_folder).to respond_to(:date_of_service)
    end

    it "returns date of service from path as year month day" do
      test_folder = File.join(initial_path, 'august_hot_1234/2013Aug16yblah')

      date_of_service_folder = described_class.new(test_folder)

      expect(date_of_service_folder.date_of_service).to eql('20130816')
    end

  end


  context "#date of service files" do

    it "has method patient_dates_of_services files" do
     expect(described_class.new('bahl')).to respond_to(:dates_of_services_files)
    end

    it "returns a list of files" do
      test_folder = File.join(initial_path, 'august_hot_1234/2013Aug13zblah')
      file = [test_folder + '/august_file_2.txt']

      date_of_service_folder = described_class.new(test_folder)

      expect(date_of_service_folder.dates_of_services_files).to eql(file)
    end
  end
end

