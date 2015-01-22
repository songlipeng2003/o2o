class AreasController < ApplicationController
  # caches_page :index

  def index
    # @areas = Area.where(:level => 0).joins(:children).all()
    @root = Area.root

    respond_to do |format|
      format.json { render :text => @root.as_tree_json }
    end
  end

  def options
    @area = Area.find(params[:id])
    render :layout => false
  end
end
