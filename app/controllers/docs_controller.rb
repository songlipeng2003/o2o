class DocsController < ApplicationController
  def show
    @doc = Doc.where(key: params[:id]).first
    render layout: false
  end
end
