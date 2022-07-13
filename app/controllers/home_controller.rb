class HomeController < ApplicationController
  def cruce
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
    json = json['apartament'].to_a
    res = json.map{|o| o['CedulaPropietario']}
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
    @propiedades = cruce
    @propiedad = params[:id]
  end

  def pendingP
    @propiedades = cruce
    @propiedadPending = params[:id]
  end
  
end
