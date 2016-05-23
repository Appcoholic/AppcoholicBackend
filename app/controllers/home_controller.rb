class HomeController < ApplicationController
    layout '/home/home', only: [:home]
    
    def home
    end
end
