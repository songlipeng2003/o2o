class DownloadController < ApplicationController
  def android
    @app_version = AppVersion.order('id DESC').first

    redirect_to @app_version.file.url
  end
end
