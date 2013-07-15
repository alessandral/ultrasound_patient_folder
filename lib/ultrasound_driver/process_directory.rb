module UltrasoundDriver
  class ProcessDirectory

    def initialize(input_path, destination_path)
      @input_path, @destination_path = input_path, destination_path
      @patients = []
    end

    def work_directory
      read_main_folder
      process_folders
    end

    def read_main_folder
      Dir.entries(@input_path).each do |folder|
        next if ['.','..'].include? folder
        next unless File.directory? File.join(@input_path, folder)
        @patients << UltrasoundDriver::UltrasoundPatientFolder.new(File.join(@input_path, folder))
      end
    end

    def process_folders
      @patients.each do |patient|
        patient.folder_date_of_services.each do |dos|
          full_path = patient.destination_path(@destination_path, dos)
          create_directory(full_path)
          copy_files(dos,full_path)
        end
      end
    end

    def create_directory(full_path)
      if !File.directory? full_path
        FileUtils.mkdir_p full_path
      end
    end

    def copy_files(dos_path, full_path)
        Dir.glob(dos_path + '/*.*' ).each do |filename|
          FileUtils.cp(filename, full_path)
        end
    end

  end
end
