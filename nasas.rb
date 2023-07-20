#requerimientos
require 'uri'
require 'net/http'
require 'json'

#conexión
def request(url_requested)
    url = URI(url_requested)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url)
    request["cache-control"] = 'no-cache'

    #respuesta
    response = http.request(request)
    return JSON.parse(response.body)
end

#solicitado
def  buid_web_page(data)
    photos = data.map{|x| x['img_src']}
    html = ""

    #recorrido
    photos.each do |i|
        html += "<img src=\"#{i}\">\n"
    end

    #estructura
    code = "<html>\n
    <head>\n
    </head>\n
    <body>\n
    <ul>\n
    #{html}
    </ul>\n
    </body>\n
    </html>
    "
    #escritura
    File.write('index.html', code)
end

#contador
def photos_count(data)
    photos = data.map { |x| x['camera'] }
    contador = data.map{|x| x['camera']['full_name']}.each_with_object({}) {|name, hash| hash[name] = 0 }

    #recorrido
    photos.each do |photo|
      contador[photo['full_name']] += 1
    end

    #cantidad
    puts "Total de fotografías por cada cámara-->"

    #texto
    contador.each do |name, count|
      puts " #{name}: #{count} fotografías"
    end
  end

#fuente
data = request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=6GsoPBD9ajLU6gZSz3ZqESjOb2gXbxgn1byEXAbz').

#total
values[0][1..10]

#requerido
buid_web_page(data)
photos_count(data)