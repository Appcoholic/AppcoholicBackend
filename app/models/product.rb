class Product < ActiveRecord::Base
    
    mount_uploader :photo, ProductPhotoUploader
end
