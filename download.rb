mundiales = %w{southafrica2010
germany2006
koreajapan2002
france1998
usa1994
italy1990
mexico1986
spain1982
argentina1978
germany1974
mexico1970
england1966
chile1962
sweden1958
switzerland1954
brazil1950
france1938
italy1934
uruguay1930}.each{|mundial|
  index = "http://es.fifa.com/tournaments/archive/worldcup/#{mundial}/matches/index.html"
  puts "wget -l1 -A 'index.html' -np -r #{index}"

}
