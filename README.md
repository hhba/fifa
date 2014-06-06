fifa
====

scrapper para fifa.com

---

Primero, bajar todos los HTMLs 

```
$ sh download.sh                                                                                                     
--2014-06-05 23:17:07--  http://es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches/index.html
Resolving es.fifa.com (es.fifa.com)... 190.98.167.168, 190.98.167.187
Connecting to es.fifa.com (es.fifa.com)|190.98.167.168|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: unspecified [text/html]
Saving to: ‘es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches/index.html’

    [ <=>                                                                                                          ] 114,760     --.-K/s   in 0.1s    

2014-06-05 23:17:08 (758 KB/s) - ‘es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches/index.html’ saved [114760]

Loading robots.txt; please ignore errors.
--2014-06-05 23:17:08--  http://es.fifa.com/robots.txt
Reusing existing connection to es.fifa.com:80.
HTTP request sent, awaiting response... 200 OK
Length: 84 [text/plain]
Saving to: ‘es.fifa.com/robots.txt’

```
[....]


Esto va a crear un árbol de directorios así

```
$ find es.fifa.com                                                                                                   
es.fifa.com
es.fifa.com/tournaments
es.fifa.com/tournaments/archive
es.fifa.com/tournaments/archive/worldcup
es.fifa.com/tournaments/archive/worldcup/southafrica2010
es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches
es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches/round=249722
es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches/round=249722/match=300061454
es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches/round=249722/match=300061454/index.html
es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches/round=249722/match=300061453
es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches/round=249722/match=300061453/index.html
es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches/round=249722/match=300061452
es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches/round=249722/match=300061452/index.html
es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches/index.html
```

Para chequear:
```
$ find es.fifa.com | wc -l                                                                                           
1701
```

Después, correr el parser, sobre los archivos bajados:

```
$ ruby parse.rb                                                                                                      
mundial,fecha,equipo1,equipo2,equipo_gol,jugador_gol,jugador_minuto,fuente
Copa Mundial de la FIFA 2010,2010/06/22,Francia,Sudáfrica,Francia,Florent MALOUDA,70,http://es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches/round=249722/match=300061449/index.html
Copa Mundial de la FIFA 2010,2010/06/22,Francia,Sudáfrica,Sudáfrica,Bongani KHUMALO,20,http://es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches/round=249722/match=300061449/index.html
Copa Mundial de la FIFA 2010,2010/06/22,Francia,Sudáfrica,Sudáfrica,Katlego MPHELA,37,http://es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches/round=249722/match=300061449/index.html
Copa Mundial de la FIFA 2010,2010/06/14,Japón,Camerún,Japón,Keisuke HONDA,39,http://es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches/round=249722/match=300061477/index.html
Copa Mundial de la FIFA 2010,2010/06/17,Francia,México,México,Javier HERNANDEZ,64,http://es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches/round=249722/match=300061451/index.html
Copa Mundial de la FIFA 2010,2010/06/17,Francia,México,México,Cuauhtemoc BLANCO,79,http://es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches/round=249722/match=300061451/index.html
Copa Mundial de la FIFA 2010,2010/06/17,Francia,México,México,Cuauhtemoc BLANCO,GP,http://es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches/round=249722/match=300061451/index.html
Copa Mundial de la FIFA 2010,2010/06/18,Alemania,Serbia,Serbia,Milan JOVANOVIC,38,http://es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches/round=249722/match=300061470/index.html
Copa Mundial de la FIFA 2010,2010/06/14,Países Bajos,Dinamarca,Países Bajos,Daniel AGGER,46,http://es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches/round=249722/match=300061478/index.html
Copa Mundial de la FIFA 2010,2010/06/14,Países Bajos,Dinamarca,Países Bajos,Daniel AGGER,GPM,http://es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches/round=249722/match=300061478/index.html
Copa Mundial de la FIFA 2010,2010/06/14,Países Bajos,Dinamarca,Países Bajos,Dirk KUYT,85,http://es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches/round=249722/match=300061478/index.html
Copa Mundial de la FIFA 2010,2010/06/13,Serbia,Ghana,Ghana,Asamoah GYAN,85,http://es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches/round=249722/match=300061471/index.html
Copa Mundial de la FIFA 2010,2010/06/13,Serbia,Ghana,Ghana,Asamoah GYAN,GP,http://es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches/round=249722/match=300061471/index.html
Copa Mundial de la FIFA 2010,2010/06/19,Camerún,Dinamarca,Camerún,Samuel ETOO,10,http://es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches/round=249722/match=300061475/index.html
Copa Mundial de la FIFA 2010,2010/06/19,Camerún,Dinamarca,Dinamarca,Nicklas BENDTNER,33,http://es.fifa.com/tournaments/archive/worldcup/southafrica2010/matches/round=249722/match=300061475/index.html
```

Si lo tiro a un archivo, me da así:
```
$ wc -l /tmp/goles.csv                                                                                               
2220 /tmp/goles.csv
```



