class Music < ActiveRecord::Base
  attr_accessible :name, :size, :file_type, :audio
  mount_uploader :audio, AudioUploader
  

end
