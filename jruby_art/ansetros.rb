# coding: utf-8
class MaAnsetro < Processing::App
load_library :sound
include_package 'processing.sound'
attr_reader :FFT, :AudioIn

  def settings
    full_screen P2D
    smooth 4
    @bands = 1024
    @apura = 0
    iloza
  end
  
  def setup
    sketch_title 'MA ANSETRO'

    @fft = FFT.new(self,@bands)
    entrada = AudioIn.new(self, 0) 
    entrada.start
    @fft.input(entrada)

    monobold = create_font("Noto Sans Bold", 32)
    text_font(monobold)
    
    background 0
  end
   
  def draw
    @fft.analyze(@fft.spectrum)
    nsulu 0,0,0,255
    lusingas
    #jolon 700
    #sungulee
    #loza
  end
 
  #Loza
  def iloza
    @rotacion = 0
    @circulo = 180
    @frecuencia = 7e-6
    @color = 0
    @tamaño = 0
  end

  def loza
    push
      translate width/2, height/2
      rotate @rotacion/10000
      ellipse_mode RADIUS
  
      for a in 1..1000 do
        @circulo = 130 + (height/3)*sin(frame_count*@frecuencia*a)
        @color = p5map @circulo, 255, 0, 255, 70
        @tamaño = p5map @circulo, 150, 100, 2, 1
  
        no_stroke
        fill @color, (sin(millis*1e-4)*255).abs, (cos(frame_count*1e-2)*255).abs
        ellipse @circulo*sin(a),@circulo*cos(a),@tamaño, @tamaño
        @rotacion += 3e-4
      end
    pop

  end
  #fin

  #Sunguleé
  def sungulee
    push
      translate width/2, height/2

      for p in 1..15 do
        stroke 255# (sin(frame_count*0.04)*255).abs,(sin(frame_count*0.03)*255).abs,(sin(frame_count*0.02)*255).abs
        strokeWeight 15
        point x1(@apura+p),y1(@apura+p)
      end
      @apura += 2e-2
    pop
  end
  def x1 arg
    cos(arg/2)*350 
  end
  def y1 arg
    sin(arg/3)*350
  end
  #fin
  
  #Jolon
  def jolon arg
    push
      no_fill
      stroke_weight 5# 2*osilacion(@bands/2+cos(millis)*@bands/2)    
      stroke 255# (sin(frame_count*0.04)*255).abs,(sin(frame_count*3e-3)*255).abs,(sin(frame_count*2e-2)*255).abs
      ellipse width/2, height/2, arg*sin(frame_count*10e-3),arg# *sin(frame_count*10e-2)
    pop
  end
  #fin
  
  #Ma Lusinga
  def lusingas
    push #Lumbá
      text_size 90
      text_align CENTER
      fill 255# (sin(frame_count*0.04)*255).abs, 222, (cos(frame_count*0.04)*255).abs
      text "MA ANSETRO",width/2, 200
      text_size 45
      text "PRIMITIVAS", width/2, 250 
    pop
    push #Punto
      fill 255# 234, 35, 90, 85
      stroke 255# (cos(millis*5e-2)*255).abs,(sin(frame_count*3e-2)*255).abs,(cos(frame_count*2e-2)*255).abs
      strokeWeight 5
      for k in 1..5 do
        ellipse width/2,(height/2)+70,(80/k)+osilacion(@bands/2+sin(frame_count/k)*@bands/2),(80/k)+osilacion(@bands/2+sin(frame_count/k)*@bands/2)
      end
    pop
    push #Reboliá
      for i in 0...@bands do
        stroke 255# cos(i*0.05)*255,cos(frame_count*0.03)*255,cos(frame_count*0.02)*255
        strokeWeight 2# 5 + sin(i)*5
        point width/2 + i, (height/2)+70#- @fft.spectrum[i]*height*100
        point width/2 - i, (height/2)+70#- @fft.spectrum[i]*height*100
        point width/2 + i, (height/2)+70#+ @fft.spectrum[i]*height*100
        point width/2 - i, (height/2)+70#+ @fft.spectrum[i]*height*100
      end
    pop
  end
  #fin

  def osilacion arg
    @fft.spectrum[arg]*15e3
  end
  def nsulu r,g,b,a
    fill r,g,b,a
    rect 0, 0, width, height
  end
end
