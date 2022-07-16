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
  def getDepartments(arreglo, idPropiedad)
    res = arreglo.map{|o| o['Identificador']}
    pos = []
    counter = 0
    while counter<res.length
      if res[counter] == idPropiedad
        pos.push(counter)
      end
      counter = counter+1
    end
    propiedad = arreglo[pos[0]]
    return propiedad
  end
  def realizedP
    @propiedad = getDepartments(cruce,params[:id])
  end

  def pendingP
    @propiedadPending = getDepartments(cruce,params[:id])
    #@pago = Pago.find_by IdAptoFK: params[:id]
    @pagos = Pago.where IdAptoFK: params[:id]
  end

  def sendPaymentInfo
    require 'rest-client'
    require 'json'
    url = 'https://543785e5f7e3a688b85a22bb74103b8c.loophole.site/api/v1/pagos/'
    res = RestClient.post url, {id: params[:id]}
    puts 'Respuesta:'
    puts res 
    redirect_to home_page_path
  end
end
