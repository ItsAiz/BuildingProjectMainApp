class HomeController < ApplicationController
  def cruce
    puts 'entro'
    require 'json'
    require 'open-uri'
    
    uri = URI.parse 'https://github.com/Lokolab666/FileAppartament/blob/main/data.json?raw=true'
    json =
      begin
        json_file = uri.open.read
      rescue OpenURI::HTTPError => e
        puts "Encountered error pulling the file: #{e}"
      else
        JSON.parse json_file
      end
    va = current_user.documentNumber
    puts va
    json = json['apartament'].to_a
    #@prueba = json[9]['Identificador'] == '2849888227'
    res = json.map{|o| o['CedulaPropietario']}
    #pos = res.each_with_index.select{|o| o == va}
    pos = []
    counter = 0
    while counter<res.length
      if res[counter] == va
        pos.push(counter)
      end
      counter = counter+1
    end
    propiedades = []
    for i in pos
      propiedades.push(json[i])
    end
    return propiedades
    #@prueba = @json.detect { |e| e['Identificador'] == '6704820938' }
  end
  
  def homepage
    @count = 0
    @propiedades = cruce
  end

  def realizedP
  end
  
end
