require 'spec_helper'
require 'tmpdir'

describe UltrasoundDriver::UltrasoundPatientFolder do

    before(:each) do
      @initial_path  =  'spec/fixtures/test_folders/sonoexport/'
    end

    subject(:patient_folder) { described_class.new(@initial_path) }

    context "#new " do
      it "returns a new instance of ultrasound patient folder " do
        expect(patient_folder).to be_an_instance_of described_class
      end

      it "should take a parameter " do
        expect { described_class.new }.to raise_exception ArgumentError
      end

      it "should accept a path on initialize"  do
        input_path = 'blah'
        patient_folder = described_class.new(input_path)
        expect(patient_folder.path).to eql(input_path)
      end

    end

    context "#patient name" do
      it "has method patient name" do
        expect(patient_folder).to respond_to(:patient_name)
      end

      it "should return patient name" do
        test_folder =  'april_showers_5678'
        patient_folder = described_class.new(File.join(@initial_path, test_folder))

        expect(patient_folder.patient_name).to eql(test_folder)

      end
    end

    context "date_of_service_folders" do

      it "should call a method to return an array " do
        test_folder = File.join(@initial_path, 'april_showers_5678')
        dos_mock = double(new: test_folder)

        patient_folder.date_of_service_folders(dos_mock)

        expect(dos_mock).to have_received(:new).with(test_folder)
      end

      it "returns an array with dates of service object" do
        test_folder = File.join(@initial_path, 'august_hot_1234')
        dos_mock = double(new: test_folder)

        dos_paths = [File.join(test_folder, '2013Aug13zblah'), File.join(test_folder, '2013Aug16yblah')]

        patient_folder = described_class.new(test_folder)
        patient_folder.date_of_service_folders(dos_mock)

        dos_paths.each do |dos_path|
          expect(dos_mock).to have_received(:new).with(dos_path)
        end
      end

    end

end
