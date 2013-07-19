require 'spec_helper'

#Moves the files into a temp directory to verify the test ran
#
describe UltrasoundDriver::ProcessDirectory do

  let(:source_path)     { 'spec/fixtures/test_folders/sonoexport/' }
  let(:destination_path) { @destination_path }

  before do
    @destination_path = Dir.mktmpdir
  end

  after do
    FileUtils.remove_entry_secure @destination_path
  end

  subject(:process_directory) { described_class.new(source_path, destination_path) }

  context "initialize" do

    context "parameters" do
      it "must be present " do
        expect {described_class.new}.to raise_exception ArgumentError
      end

      it "takes two parameters" do
        expect(described_class).to respond_to(:new).with(2).arguments
      end

      it "initial path, destination path" do
        process_directory = described_class.new('blah', 'move_blah_here')

        expect(process_directory.source_path).to eql ('blah')
        expect(process_directory.destination_path).to eql ('move_blah_here')
      end
    end
  end

  context "work directory" do

    it "calls method to read folders" do
      expect(process_directory).to respond_to(:patient_folders)
    end

    it "returns and array with patients object" do
      patient_double = double(new: source_path)

      process_directory.patient_folders(patient_double)

      expect(patient_double).to have_received(:new).with(File.join(source_path, 'april_showers_5678/'))
      expect(patient_double).to have_received(:new).with(File.join(source_path, 'august_hot_1234/'))
    end

    it "returns and array with patients object" do
      allow(UltrasoundDriver::UltrasoundPatientFolder).to receive(:new)

      process_directory.patient_folders

      expect(UltrasoundDriver::UltrasoundPatientFolder).to have_received(:new).with(File.join(source_path, 'april_showers_5678'))
      expect(UltrasoundDriver::UltrasoundPatientFolder).to have_received(:new).with(File.join(source_path, 'august_hot_1234'))
    end


    it "responds to the method to process every patient folder" do
      patient_double = double(:date_of_service_folders => nil)

      expect(patient_double).to respond_to(:date_of_service_folders)

    end

    it "returns an array when reading a patient folder" do
      patient_double = double(:date_of_service_folders => [])

      expect(patient_double.date_of_service_folders).to eql([])
    end

    context "#patient date of service folders" do
      it "method exists" do
        expect(process_directory).to respond_to(:patient_date_of_service_folders)
      end

      it "calls a method to process its date of service" do
        patient = double(:patient_folders => [])

        process_directory.patient_date_of_service_folders do
          expect(patient.patient_folders).to eql([])
        end
      end

    end

     context "#date of service folders" do
       it "method exists" do
         expect(process_directory).to respond_to(:date_of_service_folders)

       end

     end

     context "#date of service files" do
       it "method exists" do
         expect(process_directory).to respond_to(:date_of_service_files)
       end
     end

  end


end
