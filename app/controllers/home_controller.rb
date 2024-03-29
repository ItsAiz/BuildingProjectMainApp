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
    require 'openssl'
    require 'base64'
    require 'rest-client'
    require 'json'
    require 'uri'
    @propiedad = getDepartments(cruce,params[:id])
    url = URI.join("https://8e032659b60bbd90fb774136dd643f43.loophole.site/api/v1/pagos/showPagos/",@propiedad['Identificador'])
    url = url.to_s
    res = RestClient.get url
    private_key_file = "public/private.pem";
    password = "admin"
    private_key = OpenSSL::PKey::RSA.new(File.read(private_key_file),password)
    #res = JSON.parse res.gsub('=>', ':')
    res = JSON.parse res
    hash = res.to_a
    count = 0
    @descr = []
    @pagos = []
    while count < hash.length
        @descr.push(private_key.private_decrypt(Base64.decode64(hash[count])))
        @pagos.push(JSON.parse @descr[count].gsub('=>', ':'))
        count = count + 1
    end
    @count = 0
            #res = private_key.private_decrypt(Base64.decode64(res))
    #hash_res = JSON.parse res.gsub('=>', ':')
    #@pagos = hash_res.to_a
  end

  def pendingP
    @propiedadPending = getDepartments(cruce,params[:id])
    #@pago = Pago.find_by IdAptoFK: params[:id]
    @pagos = Pago.where IdAptoFK: params[:id]
  end

  def sendPaymentInfo
    require 'rest-client'
    require 'json'
    id = params[:id]
    url = 'https://8e032659b60bbd90fb774136dd643f43.loophole.site/api/v1/pagos/'
    res = RestClient.post url, {id: id}
    #redirect_to home_recibo_path(id)
  end
  def recibo
    #render layout: false
    @pago = Pago.find(params[:id])
    sendPaymentInfo
    #respond_to do |format|
     # format.pdf {send_pdf(@pago)}
    #end
    #respond_to do |f|
     # f.html{render :layout => false}
      #f.pdf do
        #render pdf: "Recibo", template: "app/views/home/recibo.html.erb"
     # end
    #end
    #redirect_to home_page_path
  end
  def validateExistence
    @propiedad = getDepartments(cruce,params[:id])
    @res = Pago.where IdAptoFK: params[:id]
    if @res.empty?
      redirect_to home_paz_salvo_path(params[:id])
    else
      redirect_to home_page_path
    end
  end
  def pazSalvo
    @propiedad = getDepartments(cruce,params[:id])
  end
  #def send_pdf(pago)
    # Render the PDF in memory and send as the response
   # send_data @charge.receipt.render,
    #  filename: "#{@pago.created_at.strftime("%Y-%m-%d")}-gorails-receipt.pdf",
     # type: "application/pdf",
      #disposition: :inline # or :attachment to download
  #end
end
