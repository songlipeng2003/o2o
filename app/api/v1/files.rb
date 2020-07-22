module V1
  class Files < Grape::API
    resource :files do
      desc "上传文件", {
        headers: {
          "X-File-Name" => {
            description: "二进制上传时的文件名",
            required: false
          }
        }
      }
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
        optional :file, type: Rack::Multipart::UploadedFile, desc: "文件,也可以直接使用二进制流上传,在header中添加X-File-Name作为文件名"
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
        upload_file.application = current_application
        upload_file.save
        {
          file:  upload_file.file.filename,
          filesize: upload_file.filesize
        }
      end
    end
  end
end
