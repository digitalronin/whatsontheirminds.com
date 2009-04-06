class MpsController < ApplicationController
  caches_page :index, :show

  def index
    @mps = Mp.fetch_list
  end

  def show
    @mp = Mp.from_person_id params[:id]
    @cloud = @mp.get_cloud
  end
end

