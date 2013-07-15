module UltrasoundDriver
  class UltrasoundPatientFolder

    attr_accessor :path, :date_of_services

    def initialize(input_path)
      @path = input_path
      @date_of_services = []
    end

    def date_of_service(dos)
      Date.strptime(File.basename(dos)[0,9],'%Y%b%d').to_s
    end

    def patient_name
       File.basename(@path)
    end

    def folder_date_of_services
       Dir.entries(@path).each do |dos|
          next if ['.','..'].include? dos
          next unless File.directory? File.join(@path, dos)
          date_of_services << File.join(@path, dos)
       end

       date_of_services
    end

    def destination_path(partial_destination_path, dos)
      return File.join(partial_destination_path, date_of_service(dos), patient_name)
    end

  end
end
