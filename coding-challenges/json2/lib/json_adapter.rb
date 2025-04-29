require 'json'
require 'uri'
require 'open-uri'

class JsonAdapter
  def load_from(uri)
    URI.open(uri) do |file|
      file_content = file.read

      JSON.parse(file_content)
    end
  rescue OpenURI::HTTPError => e
    []
  end
end