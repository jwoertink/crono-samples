module Utilities
  alias Whatever = String | Int32 | Nil
  
  def asset_path(filename : String)
    folder = case File.extname(filename)
             when /^\.(png|jpg|gif)/
               "images"
             when /^\.(ogg|mp3|wav)/
               "audio"
             when /^\.(txt)/
               "maps"
             when /^\.(ttf)/
               "fonts"
             else
               "."
             end
    File.join(__DIR__, "assets", folder, filename)
  end
end

