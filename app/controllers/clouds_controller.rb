class CloudsController < ApplicationController
  caches_page :show

  def show
    @cloud = Cloud.find params[:id], :include => :mp
    @mp = @cloud.mp
  end
end
