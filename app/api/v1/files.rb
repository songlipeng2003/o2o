module V1
  class Files < Grape::API
    resource :files do
      desc "上传文件", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        }
      }
      params do
        optional :file, type: Rack::Multipart::UploadedFile, desc: "文件"
      end
      post do
        authenticate!
        filedata = params[:file]
        filedata_hash = {
          :filename => filedata[:filename],
          :orginal_filename => filedata[:filename],
          :type     => filedata[:type],
          :headers  => filedata[:head],
          :tempfile => filedata[:tempfile]
        }
        file = ActionDispatch::Http::UploadedFile.new(filedata_hash)
        upload_file = UploadFile.new
        upload_file.file = file
        upload_file.filesize = file.size
        upload_file.save
        upload_file.file.filename
      end
    end
  end
end
