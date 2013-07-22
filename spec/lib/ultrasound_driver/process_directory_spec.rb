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

  context "directory" do

    it "calls work directory" do
      expect(process_directory).to respond_to(:work_directory)
    end

    it "calls patient date of folders" do
      process_directory.work_directory do |action|
         expect(action).to respond_to(:patient_date_of_service_folders)
      end
    end

    it "calls method to read folders" do
      expect(process_directory).to respond_to(:patient_folders)
    end

    it "returns and array with patients object" do

      patient_double = double("patient_folder")
      allow(patient_double).to receive(:new).with(File.join(source_path, 'april_showers_5678')) {Array}

      process_directory.patient_folders

      expect(patient_double.new(File.join(source_path, 'april_showers_5678'))).to eql(Array)

    end

    it "returns patient object for each folder found in directory" do
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

       it "takes a patient object parameter" do

         patient = double(:date_of_service_folders => [])

         process_directory.date_of_service_folders(patient) do
          expect(patient.date_of_service_folders).to eql([])
         end

       end

     end

     context "#date of service files" do
       it "method exists" do
         expect(process_directory).to respond_to(:date_of_service_files)
       end

       it "takes two parameters" do
        expect(process_directory).to respond_to(:date_of_service_files).with(2).arguments
       end

       it "calls a sequence of methods to copy the final files" do
         patient         = double(:patient_name    => 'april_showers_5678')
         date_of_service = double(:date_of_service => '20130410', :folder_files => ["#{source_path}" + 'april_showers_5678' + '/2013Apr10xblah/april_file.txt'] )

          process_directory.date_of_service_files(patient,date_of_service) do |files|
            expect(files).to respond_to(:full_path)
            expect(files).to respond_to(:create_directory)
            expect(files).to respond_to(:move_files_final_destination)
          end

       end

     end

     context "#destination full path" do
        it "returns a full path as destination path + date of service + patient name" do
          dos_double     = double(:date_of_service => '20130202')
          patient_double = double(:patient_name    => 'april_showers_are_great')

          final_path = File.join(process_directory.destination_path, dos_double.date_of_service, patient_double.patient_name)

          expect(dos_double.date_of_service).to eql ('20130202')
          expect(patient_double.patient_name).to eql ('april_showers_are_great')
          expect(process_directory.destination_full_path(dos_double, patient_double)).to eql(final_path)

        end
     end

     context "#create directory" do
        it "creates directory if doesn't exist" do
          whole_path = destination_path + 'april/showers_5678/20130410'
          expect(process_directory.create_directory(whole_path)).to eql([whole_path])
        end

        it "doesn't create the directory if exists" do
          whole_path = destination_path + 'april_Showers_5678/20130410'
          process_directory.create_directory(whole_path)

          expect(process_directory.create_directory(whole_path)).to eql(nil)
        end
     end

  end


end
