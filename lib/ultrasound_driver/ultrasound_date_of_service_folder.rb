require 'date'

module UltrasoundDriver
  class UltrasoundDateOfServiceFolder

    attr_accessor :dos_path

    def initialize(path)
      @dos_path = path
    end

    def date_of_service
      Date.strptime(File.basename(@dos_path)[0,9],'%Y%b%d').to_s.gsub('-','')
    end

    def dates_of_services_files
      return folder_files
    end

    def folder_files
      Dir.glob(@dos_path + '/*')
    end
  end
end
