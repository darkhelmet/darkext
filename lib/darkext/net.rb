require 'net/http'

module Net
  def self.download(url)
    Net::HTTP.get_response(URI.parse(url))
  end

  def self.download_and_save(url,path = nil)
    if path.nil?
      path = File.expand_path(url.split('/').last)
    else
      path = File.expand_path(path)
    end
    open(path,'w') { |file| file.write(download(url)) }
  end
end
