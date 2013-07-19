module UltrasoundDriver
  class UltrasoundPatientFolder

    attr_accessor :path, :services

    def initialize (initial_path)
      self.path = initial_path
    end


    def patient_name
      File.basename(path)
    end

    def date_of_service_folders(date_of_service_folder_class = UltrasoundDriver::UltrasoundDateOfServiceFolder)
      @services = []
      Dir.entries(path).each do |dos|
        next if ['.','..'].include? dos
        next unless File.directory? File.join(path, dos)

        @services << date_of_service_folder_class.new(File.join(path, dos))
      end

      return @services
    end

  end
end
