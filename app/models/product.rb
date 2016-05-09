class Product < ActiveRecord::Base
    
    has_many :inventories
    has_many :locations, through: :inventories
        
    mount_uploader :photo, ProductPhotoUploader
end
