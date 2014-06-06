require "nokogiri"
require "csv"

meses = %w{foo enero febrero marzo abril mayo junio julio agosto octubre noviembre diciembre}
CSV {|csv|
  csv << ["mundial", "fecha", "equipo1", "equipo2", "equipo_gol", "jugador_gol", "minuto_gol", "fuente"]
  Dir[ARGV[0] || "./es.fifa.com/**/*/index.html"].each{|path|
    if not path.match(Regexp.new("es.fifa.com/tournaments/archive/worldcup/(.*?)/matches/round=[0-9]+/match=[0-9]+/index.html"))
      STDERR.write("Skipping #{path}\n")
      next
    end
    url = "http://" + path[path.index("es.fifa.com") .. -1]

    doc = Nokogiri::HTML.parse(open(path))
    mundial = doc.at("#fwc_mainTitle > div.content_header.lev1 > a.trnLinkName")['title'].strip
    titulo = doc.at("[text()*='Goles marcados']")
    local  = doc.at("a.teamname.left")

    if local # Este formato: http://es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches/round=249717/match=300061497/index.html
      nombre_local = local.text
      nombre_visitante = doc.at("a.teamname.right").text
      goles_locales     = doc.search("ul#shome li").map{|goles_jugador|
        jugador, goles = goles_jugador.text[0..-1].to_s.split("(",2)

        if not  goles.nil?
          goles.to_s.split(" ").map{|minuto|
            {equipo: nombre_local.strip, jugador: jugador.strip, minuto: minuto.gsub(/[',)]/,"").strip}
          }
        end
      }.flatten
      goles_visitantes  = doc.search("ul#saway li").map{|goles_jugador|
        jugador, goles = goles_jugador.text[0..-1].to_s.split("(",2)

        if not  goles.nil?
          goles.to_s.split(" ").map{|minuto|
            {equipo: nombre_visitante.strip, jugador: jugador.strip, minuto: minuto.gsub(/[',)]/,"").strip}
          }
        end
      }.flatten

      goles = goles_locales.compact + goles_visitantes.compact

      fecha = doc.at("div.weatherico>span>strong").text
      dia, mes, ano = fecha.strip.split("/", 3)

    elsif titulo # Este formato http://es.fifa.com/tournaments/archive/worldcup/uruguay1930/matches/round=201/match=1097/index.html
      nombre_local, nombre_visitante = doc.at("#bodyContentExt > div > div > div.grid_8 > div:nth-child(2) > div > div.hdTeams > div:nth-child(2) > div.bold.large.teams").text.split(" - ",2).map(&:strip)


      goles = titulo.parent.search("li").map(&:text).map{|jugador_equipo_minuto|
        # parsea 
        # PELÉ (Edson Arantes do Nascimento) (BRA) 55', 
        # y
        # VAVA (BRA) 32', 
        #
        matches = jugador_equipo_minuto.match(/(.*?) \(([A-Z]{3})\) (.*)/)
        jugador, equipo, minuto = matches[1..3]
        {equipo: equipo.strip,jugador: jugador.strip, minuto: minuto.gsub(/[',]/,"").strip}
      }
      fecha_idx = doc.search("div.hdTeams table thead tr td").map(&:text).find_index("Fecha")
      fecha = doc.search("div.hdTeams table tbody tr td")[fecha_idx].text
      dia, mes, ano = fecha.strip.split(" ", 3)
      mes = meses.index(mes)
    else
      STDERR.write("Otro formato? #{path}\n")
      next
    end

    next if goles.compact.length == 0

    goles.map{|g|
      csv << [mundial, "#{ano.strip}/#{mes}/#{dia}", nombre_local, nombre_visitante, g[:equipo], g[:jugador], g[:minuto], url]
    }.join("\n")
  }

}
