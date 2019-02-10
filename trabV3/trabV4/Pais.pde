
//  exemplo de visualizacao de informacao
//  definicao da classe Pais

class Pais { 
  String primaryFemale;
  String secondaryFemale;
  String tertiaryFemale;

  float primaryFemaleValue;
  float secondaryFemaleValue;
  float tertiaryFemaleValue;

  String primaryMale;
  String secondaryMale;
  String tertiaryMale;

  float primaryMaleValue;
  float secondaryMaleValue;
  float tertiaryMaleValue;

  String nome;
  float lat;
  float lon;
  PImage iconBandeira;

  Pais (String n, float la, float lo, PImage ic, 
    String pf, String sf, String tf, 
    float pfv, float sfv, float tfv, 
    String pm, String sm, String tm, 
    float pmv, float smv, float tmv
    ) {
    nome = n;
    lat = la;
    lon = lo;
    iconBandeira = ic;

    primaryMale = pm;
    secondaryMale = sm;
    tertiaryMale = tm;

    primaryMaleValue = pmv;
    secondaryMaleValue = smv;
    tertiaryMaleValue = tmv;

    primaryFemale = pf;
    secondaryFemale = sf;
    tertiaryFemale = tf;

    primaryFemaleValue = pfv;
    secondaryFemaleValue = sfv;
    tertiaryFemaleValue = tfv;
  }
  void desenhaMapa() {
    Location loc = new Location(lat, lon);
    ScreenPosition pos = map.getScreenPosition(loc);
    float malValuesMasc = primaryMaleValue + secondaryMaleValue + tertiaryMaleValue;
    float mapSalMasc = map(malValuesMasc, 0, 5000, 0, 100);


    float malValuesFem = primaryFemaleValue + secondaryFemaleValue + tertiaryFemaleValue;
    float mapSalFem = map(malValuesFem, 0, 5000, 0, 100);
    //noStroke();
    // circulo de salario
    fill(100, 140, 114, 100);
    ellipse (pos.x, pos.y, mapSalMasc, mapSalMasc); 
    fill(0, 140, 114,100);
    ellipse (pos.x, pos.y, mapSalFem, mapSalFem);
  }

  void desenhaInfo() {
    Location localizacaoMapa = new Location(lat, lon);

    ScreenPosition posicaoMapa = map.getScreenPosition(localizacaoMapa);

    float escala = map.getZoom();

    // vamos detectar se o mouse esta perto de um pais
    boolean estaSobRato = false;
    if (dist(mouseX, mouseY, posicaoMapa.x, posicaoMapa.y)<2*escala) {
      estaSobRato = true;

      //if (mousePressed) {    // se houver click na area da bola, guardamos ref do pais (nome) e alteramos seccao

      //println("rato");

      paisCandidato = nome;
      //seccaogeral = 2;
    }


    // se ocorrer mouseOver num pais, entao os circulos terao contorno
    if (estaSobRato) {
      stroke(0);
      strokeWeight(1);
    } else {
      noStroke();
    }

    if (estaSobRato) {
      noStroke();

      fill(0);
      text(nome + "\nLat: " + lat + "\nLon: " + lon, mouseX+25, mouseY-5);
    }
  }

  void desenhaRato() {    
    fill(0);
    text("Coordenadas: " + mouseX + " " + mouseY, 650, 10);
  }

  void desenhaEdu(int x, int y) {
    text(nome+"\n", x+150, y+150);
  }
}
