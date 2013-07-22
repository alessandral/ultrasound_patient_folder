module UltrasoundDriver
  class ProcessDirectory

    attr_accessor :source_path, :destination_path

    def initialize (source_path, destination_path)
       self.source_path     = source_path
       self.destination_path = destination_path
    end

    def patient_folders(patient_folder_class = UltrasoundPatientFolder)
      patients = []
      Dir.entries(source_path).each do |folder|
       next if ['.','..'].include? folder
       next unless File.directory? File.join(source_path,folder)
       patients << patient_folder_class.new(File.join(source_path, folder))
      end
      patients
    end

    def patient_date_of_service_folders
      patient_folders.each do |patient|
        date_of_service_folders(patient)
      end
    end

    def date_of_service_folders(patient)
      patient.date_of_service_folders.each do |date_of_service_folder|
        next if['.','..'].include? date_of_service_folder.dos_path
        next unless File.directory? date_of_service_folder.dos_path
        date_of_service_files(patient, date_of_service_folder)
      end
    end

    def date_of_service_files(patient, date_of_service_folder)
      full_path = destination_full_path(date_of_service_folder, patient)
      create_directory(full_path)
      move_files_final_destination(date_of_service_folder, full_path)
    end

    def destination_full_path(date_of_service_folder, patient)
      return File.join(destination_path, date_of_service_folder.date_of_service, patient.patient_name)
    end

    def create_directory(full_path)
      if !File.directory? full_path
        FileUtils.mkdir_p full_path
      end
    end

    def move_files_final_destination(date_of_service_folder, full_path)
      date_of_service_folder.folder_files.each do |filename|
        FileUtils.cp(filename, full_path)
      end
    end

  end
end
