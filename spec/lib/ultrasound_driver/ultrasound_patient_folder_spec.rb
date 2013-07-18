require 'spec_helper'
require 'tmpdir'

describe UltrasoundDriver::UltrasoundPatientFolder do

    subject(:patient_folder) { described_class.new 'this_is_my_initial_path' }

    before(:each) do
      initital_path = File.join(__FILE__, '/fixtures/test_folders/sonoexport/')
    end

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
        input_path = 'Name, Lastname, M__[5443584rif]'
        patient_folder = described_class.new(input_path)
        temp_directory = Dir.mktmpdir(subject.path)

        expect(patient_folder.patient_name).to eql(input_path)

        FileUtils.remove_entry_secure temp_directory
      end
    end

    context "date_of_service_folders" do

      it "should call a method to return an array " do
        dos_mock = double

        patient_folder.date_of_service_folders(dos_mock)

        expect(dos_mock).to have_received(:new).with('some_folder_path')
        expect(dos_mock).to have_received(:new).with('some_other_folder_path')
      end

      it "returns an array with dates of service object" do
        Dir.mktmpdir do |path|
          dos_paths = [File.join(path,'2013Jul09 blah'), File.join(path,'2013Jul10 blah')]

          FileUtils.mkdir(dos_paths)
          patient_folder = described_class.new(path)
          dos_mock = double

          patient_folder.date_of_service_folders(dos_mock)

          dos_paths.each do |dos_path|
            expect(dos_mock).to have_received(:new).with(dos_path)
          end
        end
      end

    end

end
