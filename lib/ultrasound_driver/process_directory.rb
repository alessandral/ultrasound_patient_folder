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
       next unless File.directory? folder
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
      patient.date_of_service_folders.each do |date_of_service|
        next if['.','..'].include? date_of_service
        next unless File.directory? date_of_service
        date_of_service_files(patient, date_of_service)
      end
    end

    def date_of_service_files(patient, date_of_service)
      #the final steps: see if the directory exists if not create the directory as dos/patient/
      #                 using the methods of the classes are passing in
      #                 move the files

    end


  end
end
