require_relative "ultrasound_driver/version"
require_relative "ultrasound_driver/ultrasound_patient_folder"
require_relative "ultrasound_driver/process_directory"
require "pry"

module UltrasoundDriver; end

if __FILE__ == $0
  input_folder = 'test_folders/sonoexport'
  destination_folder = 'test_folders/sono_destination'

  a = UltrasoundDriver::ProcessDirectory.new(input_folder,destination_folder)
  a.work_directory
end
