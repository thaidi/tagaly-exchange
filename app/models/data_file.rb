class DataFile < ActiveRecord::Base
  def self.save(upload,ctime)
    name =  ctime.to_s + upload['datafile'].original_filename
		Dir.mkdir("#{Rails.root}/public/uploads/") unless Dir.exist? "#{Rails.root}/public/uploads/"
    directory = "#{Rails.root}/public/uploads/"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
  end
  def self.savefont(upload,url)
    name =  url
		Dir.mkdir("#{Rails.root}/public/fonts/") unless Dir.exist? "#{Rails.root}/public/fonts/"
    directory = "#{Rails.root}/public/fonts/"
    path = File.join(directory, name)
    File.open(path, "wb") { |f| f.write(upload.read) }
  end
  
  def self.savetmp(upload,ctime)
    name =  ctime.to_s + upload['datafile'].original_filename
		Dir.mkdir("#{Rails.root}/public/uploads/tmp") unless Dir.exist? "#{Rails.root}/public/uploads/tmp"
    directory = "#{Rails.root}/public/uploads/tmp"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
  end
end
