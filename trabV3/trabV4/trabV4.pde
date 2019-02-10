/*
TRABALHO DI
 cp5 chart, canvas, menuList
 */

import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.utils.*;
import java.util.*;

UnfoldingMap map;
SimplePointMarker maleMarker, femaleMarker;

boolean mouseMoved = false;
import java.util.Map;    // importar os hashmaps do JAVA
import java.util.*;
import java.io.*;
import controlP5.*;
import processing.sound.*;
SoundFile[] file;
Textarea myTextareaMale, myTextareaFemale, myTextlabelSum;

int numsounds = 5;

ControlP5 cp5;

//lista dos varios icones
List countryMarkers = new ArrayList();

//declaração hashmap paises
HashMap<String, Pais> paises = new HashMap<String, Pais>();

int numeroPaises = 0;
Button inicio, dataDescr, dataSexMascGraph, dataSexFemGraph, 
  dataSexGeneral, dataStatistics, dataVertical, dataFilter, dataInit, dataMap, infoPais, summaryMale, summaryFemale, exit;
PFont semiBoldItalic, semiBold, regular, lightItalic, light, 
  italic, extraBoldItalic, extraBold, boldItalic, bold;
int seccaogeral = 0;
String paiseSeleccionado;
String paisCandidato="";
boolean iniciouDrag = false;
int x = 50; //dados para divisão por sexo
int y = 50;


public void setup() {
  size(1400, 1080, P2D);
  map = new UnfoldingMap(this);
  cp5 = new ControlP5(this);
  MapUtils.createDefaultEventDispatcher(this, map);
  map.setTweening(true);
  map.zoomToLevel(4);

  smooth();  // instrucao para suavisar graficos em todo o programa
  semiBoldItalic = createFont("OpenSans-SemiboldItalic.ttf", 12);
  semiBold = createFont("OpenSans-Semibold.ttf", 12);
  regular = createFont("OpenSans-Regular.ttf", 12);
  lightItalic = createFont("OpenSans-LightItalic.ttf", 12);
  light = createFont("OpenSans-Italic.ttf", 12);
  extraBoldItalic = createFont("OpenSans-ExtraBoldItalic.ttf", 12);
  extraBold = createFont("OpenSans-ExtraBold.ttf", 12);
  boldItalic = createFont("OpenSans-BoldItalic.ttf", 12);
  bold = createFont("OpenSans-Bold.ttf", 12);

  inicio = new Button(10, 73, 130, 30, 12, "Inicio");
  dataSexFemGraph = new Button(150, 73, 130, 30, 12, "Dados por sexo M");
  dataSexMascGraph = new Button(290, 73, 130, 30, 12, "Dados por sexo F");
  dataSexGeneral = new Button(430, 73, 130, 30, 12, "Dados por sexo Geral");
  dataStatistics = new Button(570, 73, 130, 30, 12, "Estatisticas");
  dataVertical = new Button(710, 73, 130, 30, 12, "Areas");
  dataFilter = new Button(850, 73, 130, 30, 12, "Filter (Male by default)");
  dataMap = new Button(0, 0, 130, 30, 12, "Mapa");
  summaryMale = new Button(10, 500, 130, 30, 12, "Male");
  summaryFemale = new Button(10, 600, 130, 30, 12, "Female");
  exit = new Button(1270, 0, 130, 30, 12, "Sair");
  //infoPais = new Button(850, 73, 130, 30, 12, "Mapa");





  String[] linhas = loadStrings("teste.csv");  // vamos ler o ficheiro de texto e guardar num array de Strings (cada indice tem uma linha do texto)

  numeroPaises = linhas.length; // quantas linhas temos
  //println(numeroPaises);

  for (int i=0; i<numeroPaises; i++) { // percorremos as linhas

    String linha = linhas[i];   /// //obtemos os dados de uma linha. Ex: "Portugal,10,91"

    String[] elementos = split(linha, ","); // dividimos a string pelo delimitador

    String nome = elementos[0]; // obtemos o nome do pais
    String primaryMale = elementos[6]; //descrição de cada elementos
    String primaryFemale = elementos[4]; //primario, secondario e terciario
    String secondaryMale = elementos[12]; //para masculino e feminino
    String secondaryFemale = elementos[10];
    String tertiaryMale = elementos[18];
    String tertiaryFemale = elementos[16];

    float primaryMaleValue = parseInt(elementos[7]); //valores de cada descrição acima
    float primaryFemaleValue = parseInt(elementos[5]);
    float secondaryMaleValue = parseInt(elementos[13]);
    float secondaryFemaleValue = parseInt(elementos[11]);
    float tertiaryMaleValue = parseInt(elementos[19]);
    float tertiaryFemaleValue = parseInt(elementos[17]);
    float lat = parseInt(elementos[20]); // obtemos a LATITUDE GPS
    float lon = parseInt(elementos[21]); // obtemos a LONGITUDE GPS

    PImage iconBandeira;
    iconBandeira = loadImage(elementos[22]);
    iconBandeira.resize(12, 12);

    Pais P = new Pais(nome, lat, lon, iconBandeira, primaryMale, secondaryMale, tertiaryMale, primaryMaleValue, secondaryMaleValue, tertiaryMaleValue, primaryFemale, secondaryFemale, tertiaryFemale, primaryFemaleValue, secondaryFemaleValue, tertiaryFemaleValue);

    Location mapMarker = new Location(lat, lon);
    // Add markers to the map
    ImageMarker imgMarker = new ImageMarker(mapMarker, iconBandeira);
    map.addMarkers(imgMarker);

    Location ellipseMarker = new Location(lat, lon);
    maleMarker = new SimplePointMarker(ellipseMarker);
    femaleMarker = new SimplePointMarker(ellipseMarker);


    float malValuesMasc = primaryMaleValue + secondaryMaleValue + tertiaryMaleValue;
    float mapSalMasc = map(malValuesMasc, 0, 10000, 0, 100);


    float malValuesFem = primaryFemaleValue + secondaryFemaleValue + tertiaryFemaleValue;
    float mapSalFem = map(malValuesFem, 0, 10000, 0, 100);
    //noStroke();
    // circulo de salario
    fill(150, 20, 10, 100);
    ellipse (lat, lon, mapSalMasc, mapSalMasc); 
    fill(100, 20, 10, 100);
    ellipse (lat, lon, mapSalFem, mapSalFem);    //for (Map.Entry p : paises.entrySet() ) {    // percorremos o hashmap dos paises     
    //  Pais pais = (Pais) p.getValue();
    //  pais.desenhaInfo();
    //  pais.desenhaRato();
    //}

    paises.put(nome, P);
    //for (Map.Entry p : paises.entrySet()) {
    //      Pais pais = paises.get(paiseSeleccionado);
    //}
  }

  file = new SoundFile[numsounds];
  for (int i = 0; i < numsounds; i++) {
    file[i] = new SoundFile(this, (i+1) + ".aif");
  }
}



public void draw() {
  background(240);
  //println(seccaogeral);

  switch(seccaogeral) {
  case 0:
    background(240);
    PImage ipca;
    ipca = loadImage("ipca-logo-web.jpg");
    ipca.resize(400, 225);
    image(ipca, 500, 160);
    //Pais p = paises.get(paiseSeleccionado);

    textSize(12);
    fill(50);
    textFont(semiBoldItalic);
    text("Informação do trabalho", 70, 160);
    //text(pais.nome, 70, 184);
    textFont(lightItalic);
    text("Desenho Interfaces Aplicacionais", 70, 200);
    text("MEI (Pós-Laboral), DIA", 70, 230);
    text("Trabalho elaborado por:", 70, 260);
    text("Fernando Correia Nº a11199", 70, 300);
    text("Tema: \nElaboração de representação gráfica de registos \nno ensino por pais no ano de 2016. ", 70, 330);

    textFont(regular);
    dataMap.update();
    if (dataMap.clicked) seccaogeral = 1;

    break;
  case 1:

    map.draw();


    paisCandidato="";
    for (Map.Entry p : paises.entrySet() ) {    // percorremos o hashmap dos paises     
      Pais pais = (Pais) p.getValue();
      pais.desenhaInfo();
      pais.desenhaRato();
      pais.desenhaMapa();
      //Location loc = new Location(pais.lat, pais.lon);
      //ScreenPosition pos = map.getScreenPosition(loc);
      //strokeWeight(16);
      //stroke(67, 211, 227, 100);
      //noFill();
      //ellipse(pos.x, pos.y, 20, 20);
    }


    //println(paisCandidato);


    // map.draw();    // desenha o mapa interactivo
    // //// Create point markers for locations


    // background(240);
    // textSize(16);



    break;

  case 2:

    background(240);
    textFont(regular);
    buttonClick();
    dataMap.update();
    if (dataMap.clicked) seccaogeral = 1;
    Pais pais = paises.get(paiseSeleccionado);
    textSize(16);
    textFont(extraBoldItalic);
    fill(0);
    text(pais.nome, width/2, 140);
    image(pais.iconBandeira, width/2+80, 130);
    println(paiseSeleccionado);


    /*text(pais.nome, 50, 50);
     PFont mono;
     
     mono = createFont("OpenSans-Regular.ttf", 12);
     
     textFont(mono);
     
     background(240);
     ipca = loadImage("ipca-logo-web.jpg");
     ipca.resize(400, 225);
     image(ipca, 500, 160);
     //Pais p = paises.get(paiseSeleccionado);
     
     textSize(12);
     fill(50);
     textFont(semiBoldItalic);
     text("Informação do trabalho", 70, 160);
     text(pais.nome, 70, 184);
     textFont(lightItalic);
     text("Desenho Interfaces Aplicacionais", 500, 510);
     text("MEI (Pós-Laboral), DIA", 500, 530);
     text("Trabalho elaborado por:", 500, 550);
     text("Fernando Correia Nº a11199", 500, 570);
     // textSize(16);
     
     // text("Dados por sexo masculino", 70, 160);
     
     // float maximo = 0;
     
     // //Pais paisF = paises.get(paiseSeleccionado);
     
     // textFont(regular);
     // text("(thousands)", 280, 250);
     // textSize(12);
     // fill(40, 50, 60, 200);
     // text(pais.primaryFemale, 10, 295);  if (pais.primaryFemaleValue>maximo) maximo = pais.primaryFemaleValue;
     // fill(40, 50, 60, 200);
     // text(pais.secondaryFemale, 10, 395); if (pais.secondaryFemaleValue>maximo) maximo = pais.secondaryFemaleValue;
     // fill(40, 50, 60, 200);
     // text(pais.tertiaryFemale, 10, 495); if (pais.tertiaryFemaleValue>maximo) maximo = pais.tertiaryFemaleValue;
     
     
     
     //  // salario pais selecionado
     //float q = map(pais.primaryFemaleValue, 0, maximo, 0, width-400);
     
     //fill(13,39,255,200);
     //rect(280, 280, q, 20, 12);
     //fill(255);
     //text(pais.primaryFemaleValue, 280, 295);
     
     //// salario medio
     //float r = map(pais.secondaryFemaleValue, 0, maximo, 0, width-400);
     //fill(12,94,232,150);
     //rect(280, 380, r, 20, 12);
     //fill(255);
     //text(pais.secondaryFemaleValue, 280, 395);
     
     //// salario mais alto
     //float s = map(pais.tertiaryFemaleValue, 0, maximo, 0, width-400);
     //fill(0,162,255,100);
     //rect(280, 480, s, 20, 12);
     //fill(255);
     //text(pais.tertiaryFemaleValue, 280, 495);
     
     //fill(13,39,255,200);
     //rect(100, 650, 20, 20, 12);
     //fill(12,94,232,150);
     //rect(100, 700, 20, 20, 12);
     //fill(0,162,255,100);
     //rect(100, 750, 20, 20, 12);
     
     //fill(40, 50, 60, 200);
     // noStroke();
     // text(pais.primaryFemale, 200, 660);
     // fill(40, 50, 60, 200);
     // text(pais.secondaryFemale, 200, 710);
     // fill(40, 50, 60, 200);
     // text(pais.tertiaryFemale, 200, 760);
     
     
     
     textFont(regular);
     
     inicio.update();
     
     if (inicio.clicked) seccaogeral = 0;
     
     dataSexMascGraph.update();
     dataSexFemGraph.update();
     dataStatistics.update();
     dataSexGeneral.update();
     dataVertical.update();
     dataFilter.update();
     
     break;
     
     //primeiro ecra após escolher o pais */
    break;
  case 3:
    PImage masc;
    masc = loadImage("masc2.png");
    masc.resize(16, 16);

    Pais countrySexMasc = paises.get(paiseSeleccionado);

    textFont(regular);
    buttonClick();

    textSize(16);
    fill(0);
    text(countrySexMasc.nome, width/2, 160);
    image(countrySexMasc.iconBandeira, width/2+80, 150);
    text("Dados por sexo masculino", 70, 160);
    image(masc, 280, 145);
    float maximo = 0;

    textFont(regular);
    text("(thousands)", 280, 250);
    textSize(12);
    fill(40, 50, 60, 200);
    if (countrySexMasc.primaryMaleValue>maximo) maximo = countrySexMasc.primaryMaleValue;
    text(countrySexMasc.primaryMale, 10, 295);
    fill(40, 50, 60, 200);
    if (countrySexMasc.secondaryMaleValue>maximo) maximo = countrySexMasc.secondaryMaleValue;
    text(countrySexMasc.secondaryMale, 10, 395);
    fill(40, 50, 60, 200);
    if (countrySexMasc.tertiaryMaleValue>maximo) maximo = countrySexMasc.tertiaryMaleValue;
    text(countrySexMasc.tertiaryMale, 10, 495);

    // salario pais selecionado
    float m = map(countrySexMasc.primaryMaleValue, 0, maximo, 0, width-400);

    fill(318, 36, 15, 200);
    rect(280, 280, m, 20, 12);
    fill(255);
    text(countrySexMasc.primaryMaleValue, 280, 295);

    // salario medio
    float n = map(countrySexMasc.secondaryMaleValue, 0, maximo, 0, width-400);
    fill(331, 67, 25, 150);
    rect(280, 380, n, 20, 12);
    fill(255);
    text(countrySexMasc.secondaryMaleValue, 280, 395);

    // salario mais alto
    float o = map(countrySexMasc.tertiaryMaleValue, 0, maximo, 0, width-400);
    fill(343, 81, 45, 100);
    rect(280, 480, o+5, 20, 12);
    fill(255);
    text(countrySexMasc.tertiaryMaleValue, 280, 495);  

    fill(318, 36, 15, 200);
    rect(100, 650, 20, 20, 12);
    fill(331, 67, 25, 150);
    rect(100, 700, 20, 20, 12);
    fill(343, 81, 45, 100);
    rect(100, 750, 20, 20, 12);

    fill(40, 50, 60, 200);
    noStroke();
    text(countrySexMasc.primaryMale, 200, 660);
    fill(40, 50, 60, 200);
    text(countrySexMasc.secondaryMale, 200, 710);
    fill(40, 50, 60, 200);
    text(countrySexMasc.tertiaryMale, 200, 760);
    //String[] fontList = PFont.list();
    //println(fontList);
    //PFont mono;

    //mono = createFont("OpenSans-Regular.ttf", 12);

    //textFont(mono);

    //background(240);
    //PImage ipca;
    //ipca = loadImage("ipca-logo-web.jpg");
    //ipca.resize(400,225);
    //image(ipca, 500, 160);
    ////Pais p = paises.get(paiseSeleccionado);

    //textSize(12);
    //fill(50);
    //textFont(semiBoldItalic);
    //text("Informação do trabalho", 70, 160);
    //text(pais.nome, 70, 184);
    //textFont(lightItalic);
    //text("Desenho Interfaces Aplicacionais", 500, 510);
    //text("MEI (Pós-Laboral), DIA", 500, 530);
    //text("Trabalho elaborado por:", 500, 550);
    //text("Fernando Correia Nº a11199", 500, 570);
    break;

  case 4:
    Pais countrySexFem = paises.get(paiseSeleccionado);
    PImage fem;
    fem = loadImage("fem.png");
    fem.resize(16, 16);
    float maximoF = 0;
    textFont(regular);
    buttonClick();
    textFont(regular);
    textSize(16);
    fill(0);
    text(countrySexFem.nome, width/2, 160);
    image(countrySexFem.iconBandeira, width/2+80, 150);
    text("Dados por sexo feminino", 70, 160);
    image(fem, 280, 145);
    text("(thousands)", 280, 250);
    textSize(12);


    fill(40, 50, 60, 200);
    text(countrySexFem.primaryFemale, 10, 295);  
    if (countrySexFem.primaryFemaleValue>maximoF) maximoF = countrySexFem.primaryFemaleValue;
    fill(40, 50, 60, 200);
    text(countrySexFem.secondaryFemale, 10, 395); 
    if (countrySexFem.secondaryFemaleValue>maximoF) maximoF = countrySexFem.secondaryFemaleValue;
    fill(40, 50, 60, 200);
    text(countrySexFem.tertiaryFemale, 10, 495); 
    if (countrySexFem.tertiaryFemaleValue>maximoF) maximoF = countrySexFem.tertiaryFemaleValue;



    // salario pais selecionado
    float q = map(countrySexFem.primaryFemaleValue, 0, maximoF, 0, width-400);

    fill(13, 39, 255, 200);
    rect(280, 280, q, 20, 12);
    fill(255);
    text(countrySexFem.primaryFemaleValue, 280, 295);

    // salario medio
    float r = map(countrySexFem.secondaryFemaleValue, 0, maximoF, 0, width-400);
    fill(12, 94, 232, 150);
    rect(280, 380, r, 20, 12);
    fill(255);
    text(countrySexFem.secondaryFemaleValue, 280, 395);

    // salario mais alto
    float s = map(countrySexFem.tertiaryFemaleValue, 0, maximoF, 0, width-400);
    fill(0, 162, 255, 100);
    rect(280, 480, s, 20, 12);
    fill(255);
    text(countrySexFem.tertiaryFemaleValue, 280, 495);

    fill(13, 39, 255, 200);
    rect(100, 650, 20, 20, 12);
    fill(12, 94, 232, 150);
    rect(100, 700, 20, 20, 12);
    fill(0, 162, 255, 100);
    rect(100, 750, 20, 20, 12);

    fill(40, 50, 60, 200);
    noStroke();
    text(countrySexFem.primaryFemale, 200, 660);
    fill(40, 50, 60, 200);
    text(countrySexFem.secondaryFemale, 200, 710);
    fill(40, 50, 60, 200);
    text(countrySexFem.tertiaryFemale, 200, 760);

    break;

  case 5:
    background(240);
    textFont(regular);
    buttonClick();

    Pais generalCountry = paises.get(paiseSeleccionado);
    textSize(16);
    fill(0);
    text(generalCountry.nome, width/2, 160);
    image(generalCountry.iconBandeira, width/2+80, 150);
    text("Dados gerais", width/2, 200);
    text("(thousands)", width/2, 250);
    textSize(12);
    float mg = map(generalCountry.primaryFemaleValue, 0, width, 0, width);

    fill(13, 39, 255, 200);
    rect(100, 280, mg, 20, 12);
    fill(255);
    text(generalCountry.primaryFemaleValue, 100, 295);

    // salario medio
    float ng = map(generalCountry.secondaryFemaleValue, 0, width, 0, width);
    fill(12, 94, 232, 150);
    rect(100, 380, ng, 20, 12);
    fill(255);
    text(generalCountry.secondaryFemaleValue, 100, 395);

    // salario mais alto
    float og = map(generalCountry.tertiaryFemaleValue, 0, width, 0, width);
    fill(0, 162, 255, 100);
    rect(100, 480, og+5, 20, 12);
    fill(255);
    text(generalCountry.tertiaryFemaleValue, 100, 495);     



    // salario pais selecionado
    float qg = map(generalCountry.primaryMaleValue, 0, width, 0, width);

    fill(318, 36, 15, 200);
    rect(1250, 280, -qg, 20, 12);
    fill(255);
    text(generalCountry.primaryMaleValue, 1190, 295);

    // salario medio
    float rg = map(generalCountry.secondaryMaleValue, 0, width, 0, width);
    fill(331, 67, 25, 150);
    rect(1250, 380, -rg, 20, 12);
    fill(255);
    text(generalCountry.secondaryMaleValue, 1190, 395);

    // salario mais alto
    float sg = map(generalCountry.tertiaryMaleValue, 0, width, 0, width);
    fill(343, 81, 45, 100);
    rect(1250, 480, -sg, 20, 12);
    fill(255);
    text(generalCountry.tertiaryMaleValue, 1190, 495);

    fill(318, 36, 15, 200);
    rect(100, 650, 20, 20, 12);
    fill(331, 67, 25, 150);
    rect(100, 700, 20, 20, 12);
    fill(343, 81, 45, 100);
    rect(100, 750, 20, 20, 12);

    fill(13, 39, 255, 200);
    rect(100, 800, 20, 20, 12);
    fill(12, 94, 232, 150);
    rect(100, 850, 20, 20, 12);
    fill(0, 162, 255, 100);
    rect(100, 900, 20, 20, 12); 

    textFont(regular);
    fill(40, 50, 60, 200);
    noStroke();
    text(generalCountry.primaryMale, 200, 660);
    fill(40, 50, 60, 200);
    text(generalCountry.secondaryMale, 200, 710);
    fill(40, 50, 60, 200);
    text(generalCountry.tertiaryMale, 200, 760);

    fill(40, 50, 60, 200);
    text(generalCountry.primaryFemale, 200, 810);
    fill(40, 50, 60, 200);
    text(generalCountry.secondaryFemale, 200, 860);
    fill(40, 50, 60, 200);
    text(generalCountry.tertiaryFemale, 200, 910);
    /*
     
     
     
     //*/
    break;

  case 6:
    background(240);
    textFont(regular);
    buttonClick();

    textSize(16);
    fill(0);
    Pais statisticCountry = paises.get(paiseSeleccionado);

    text(statisticCountry.nome, width/2, 160);
    image(statisticCountry.iconBandeira, width/2+80, 150);
    text("Estatistica", width/2, 200);
    textSize(12);
    textFont(regular);
    float mediaMale = (statisticCountry.primaryMaleValue + statisticCountry.secondaryMaleValue + statisticCountry.tertiaryMaleValue)/3;
    float maiorValorMale = max(statisticCountry.primaryMaleValue, statisticCountry.secondaryMaleValue, statisticCountry.tertiaryMaleValue);
    float menorValorMale = min(statisticCountry.primaryMaleValue, statisticCountry.secondaryMaleValue, statisticCountry.tertiaryMaleValue);
    float somatorioValorMale;

    somatorioValorMale = statisticCountry.primaryMaleValue + statisticCountry.secondaryMaleValue + statisticCountry.tertiaryMaleValue;


    float mediaFemale = (statisticCountry.primaryFemaleValue + statisticCountry.secondaryFemaleValue + statisticCountry.tertiaryFemaleValue)/3;
    float maiorValorFemale = max(statisticCountry.primaryFemaleValue, statisticCountry.secondaryFemaleValue, statisticCountry.tertiaryFemaleValue);
    float menorValorFemale = min(statisticCountry.primaryFemaleValue, statisticCountry.secondaryFemaleValue, statisticCountry.tertiaryFemaleValue);
    float somatorioValorFemale;


    somatorioValorFemale = statisticCountry.primaryFemaleValue + statisticCountry.secondaryFemaleValue + statisticCountry.tertiaryFemaleValue;
    //float distanciaMedia = dist(250, height/4+200, mouseX, mouseY);
    //float distanciaMaior = dist(300, height/4+200, mouseX, mouseY);
    //float distanciaMenor = dist(350, height/4+200, mouseX, mouseY);
    //float distanciaSomatorio = dist(400, height/4+200, mouseX, mouseY);


    stroke(0, 80);
    fill(0, 56, 64);
    rect(250, 800, 20, -mediaMale, 12);
    fill(0, 90, 91);
    rect(300, 800, 20, -maiorValorMale, 12);
    fill(0, 115, 105);
    rect(350, 800, 20, -menorValorMale, 12);
    fill(0, 140, 114);
    rect(400, 800, 20, -somatorioValorMale, 12);
    fill(40, 50, 60, 200);
    text("Male", 350, 859);


    fill(0, 56, 64);
    rect(1000, 800, 20, -mediaFemale, 12);
    fill(0, 90, 91);
    rect(1050, 800, 20, -maiorValorFemale, 12);
    fill(0, 115, 105);
    rect(1100, 800, 20, -menorValorFemale, 12);
    fill(0, 140, 114);
    rect(1150, 800, 20, -somatorioValorFemale, 12);
    fill(40, 50, 60, 200);
    text("Female", 1100, 859);


    fill(100);
    text("Media: " + mediaMale, 20, 200);      
    text("Maior valor: " + maiorValorMale, 20, 230);      
    text("Menor Valor: " + menorValorMale, 20, 260);      
    text("Somatório: " + somatorioValorMale, 20, 290);      

    text("Media: " + mediaFemale, 1260, 200);      
    text("Maior valor: " + maiorValorFemale, 1260, 230);      
    text("Menor Valor: " + menorValorFemale, 1260, 260);      
    text("Somatório: " + somatorioValorFemale, 1260, 290);   

    fill(0, 80);
    rect(1250, 185, 125, 110);
    rect(10, 185, 125, 110);


    fill(0, 56, 64);
    rect(400, 950, 20, 20, 12);
    fill(0, 115, 105);
    rect(650, 950, 20, 20, 12);
    fill(0, 140, 114);
    rect(900, 950, 20, 20, 12);
    fill(40, 50, 60, 200);
    rect(1150, 950, 20, 20, 12);

    fill(40, 50, 60, 200);
    text("Media", 430, 965);
    text("Maior Valor", 680, 965);
    text("Menor Valor", 930, 965);
    text("Somatório", 1180, 965);
    /*
    //Pais paisA = paises.get(paiseSeleccionado);
     
     
     
     background(240);
     */
    break;

  case 7:
    background(240);
    textFont(regular);
    buttonClick();

    textSize(16);
    fill(0);
    Pais countryArea = paises.get(paiseSeleccionado);

    text(countryArea.nome, width/2, 160);
    image(countryArea.iconBandeira, width/2+80, 150);
    text("Area", width/2, 200);
    textSize(12);

    float distanciaP = dist(100 + 155, height/2, mouseX, mouseY);
    float distanciaS = dist(100+1000, height/2, mouseX, mouseY);
    stroke(0, 80);
    fill(255, 165, 0, 200);
    ellipse(100 + 155, height/2, countryArea.primaryMaleValue*2, countryArea.primaryMaleValue*2);
    fill(255, 165, 0, 150);
    ellipse(100 + 155, height/2, countryArea.secondaryMaleValue*2, countryArea.secondaryMaleValue*2);
    fill(255, 100, 0, 50);
    ellipse(100 + 155, height/2, countryArea.tertiaryMaleValue*2, countryArea.tertiaryMaleValue*2);

    text("Male", 255, height/2-1);

    if (distanciaP < 40) {
      fill(100);
      text(countryArea.nome+"\nPrimary value: " + countryArea.primaryMaleValue + "\nSecondary Value: " + countryArea.secondaryMaleValue + "\nTertiary Value: " + countryArea.tertiaryMaleValue, 100 + 155 + 10, height/2 - 150);
      line(100 + 155, height/2, 100 + 155, height/2 - 150);
    }
    stroke(0, 80);
    fill(255, 69, 0, 200);
    ellipse(100 + 1000, height/2, countryArea.primaryFemaleValue*2, countryArea.primaryFemaleValue*2);
    fill(255, 69, 0, 150);
    ellipse(100 + 1000, height/2, countryArea.secondaryFemaleValue*2, countryArea.secondaryFemaleValue*2);
    fill(255, 10, 0, 50);
    ellipse(100 + 1000, height/2, countryArea.tertiaryFemaleValue*2, countryArea.tertiaryFemaleValue*2);  
    text("Female", 1100, height/2-1);

    if (distanciaS < 40) {
      fill(100);
      text(countryArea.nome+"\nPrimary value: " + countryArea.primaryFemaleValue + "\nSecondary Value: " + countryArea.secondaryFemaleValue + "\nTertiary Value: " + countryArea.tertiaryFemaleValue, 100 + 1000 + 10, height/2 - 150);
      line(1100, height/2, 1100, height/2 - 150);
    }

    fill(255, 165, 0, 200);
    rect(100, 700, 20, 20, 12);
    fill(255, 165, 0, 150);
    rect(100, 750, 20, 20, 12);
    fill(255, 100, 0, 50);
    rect(100, 800, 20, 20, 12);

    fill(255, 69, 0, 200);
    rect(100, 850, 20, 20, 12);
    fill(255, 69, 0, 150);
    rect(100, 900, 20, 20, 12);
    fill(255, 10, 0, 50);
    rect(100, 950, 20, 20, 12); 

    fill(40, 50, 60, 200);
    noStroke();
    text(countryArea.primaryMale, 200, 710);
    fill(40, 50, 60, 200);
    text(countryArea.secondaryMale, 200, 760);
    fill(40, 50, 60, 200);
    text(countryArea.tertiaryMale, 200, 810);

    fill(40, 50, 60, 200);
    text(countryArea.primaryFemale, 200, 860);
    fill(40, 50, 60, 200);
    text(countryArea.secondaryFemale, 200, 910);
    fill(40, 50, 60, 200);
    text(countryArea.tertiaryFemale, 200, 960);

    break;

  case 8:

    background(240);
    textFont(regular);
    buttonClick();
    summary();
    textSize(16);
    fill(0);
    Pais countrySummaryMale = paises.get(paiseSeleccionado);
    float sumMale = (countrySummaryMale.primaryMaleValue + countrySummaryMale.primaryMaleValue + countrySummaryMale.secondaryMaleValue);
    float maxMale = max(countrySummaryMale.primaryMaleValue, countrySummaryMale.primaryMaleValue, countrySummaryMale.secondaryMaleValue);
    float minMale = min(countrySummaryMale.primaryMaleValue, countrySummaryMale.primaryMaleValue, countrySummaryMale.secondaryMaleValue);
    float avgMale = (countrySummaryMale.primaryMaleValue + countrySummaryMale.primaryMaleValue + countrySummaryMale.secondaryMaleValue)/3;

    text(countrySummaryMale.nome, width/2, 160);
    image(countrySummaryMale.iconBandeira, width/2+80, 150);
    text("Sumário", width/2, 200);
    textSize(12);
    
    
                    
    myTextareaMale = cp5.addTextarea("txt")
      .setPosition(width/2, 500)
      .setSize(400, 200)
      .setFont(createFont("arial", 12))
      .setLineHeight(14)
      .setColor(color(128))
      .setColorBackground(color(255, 100))
      .setColorForeground(color(255, 100));
    ;
    myTextareaMale.setText(" Pais: " +  paiseSeleccionado + 
    "\n Latitude: " + countrySummaryMale.lat + "\n Longitude: " + countrySummaryMale.lon +
    "\n Ensino Primário: " + countrySummaryMale.primaryMaleValue +
    "\n Ensino secondário: " + countrySummaryMale.secondaryMaleValue +
    "\n Terceiro Ciclo: " + countrySummaryMale.tertiaryMaleValue +
    "\n Somatorio valores masculino: " + sumMale + 
    "\n Maior valor masculino: " + maxMale +
    "\n Menor valor masculino: " + minMale +
    "\n Media três ciclos: " + avgMale
      );

    if (keyPressed && key==' ') {
      myTextareaMale.scroll((float)mouseX/(float)width);
    }

    break;

  case 9:
    background(240);
    textFont(regular);
    buttonClick();
    summary();
    textSize(16);
    fill(0);
    Pais countrySummaryFemale = paises.get(paiseSeleccionado);
    float sumFemale = (countrySummaryFemale.primaryFemaleValue + countrySummaryFemale.primaryFemaleValue + countrySummaryFemale.secondaryFemaleValue);
    float maxFemale = max(countrySummaryFemale.primaryFemaleValue, countrySummaryFemale.primaryFemaleValue, countrySummaryFemale.secondaryFemaleValue);
    float minFemale = min(countrySummaryFemale.primaryFemaleValue, countrySummaryFemale.primaryFemaleValue, countrySummaryFemale.secondaryFemaleValue);
    float avgFemale = (countrySummaryFemale.primaryFemaleValue + countrySummaryFemale.primaryFemaleValue + countrySummaryFemale.secondaryFemaleValue)/3;
    text(countrySummaryFemale.nome, width/2, 160);
    image(countrySummaryFemale.iconBandeira, width/2+80, 150);
    text("Sumário", width/2, 200);
    textSize(12);
    
    myTextareaFemale = cp5.addTextarea("txt")
      .setPosition(width/2, 500)
      .setSize(400, 200)
      .setFont(createFont("arial", 12))
      .setLineHeight(14)
      .setColor(color(128))
      .setColorBackground(color(255, 100))
      .setColorForeground(color(255, 100));
    ;
    myTextareaFemale.setText(" Pais: " +  paiseSeleccionado + 
    "\n Latitude: " + countrySummaryFemale.lat + "\n Longitude: " + countrySummaryFemale.lon +
    "\n Ensino Primário: " + countrySummaryFemale.primaryFemaleValue +
    "\n Ensino secondário: " + countrySummaryFemale.secondaryFemaleValue +
    "\n Terceiro Ciclo: " + countrySummaryFemale.tertiaryFemaleValue +
    "\n Somatorio valores masculino: " + sumFemale + 
    "\n Maior valor masculino: " + maxFemale +
    "\n Menor valor masculino: " + minFemale +
    "\n Media três ciclos: " + avgFemale
      );

    if (keyPressed && key==' ') {
      myTextareaFemale.scroll((float)mouseX/(float)width);
    }
    
    break;

  case 10:
    exit();
    break;
  }
}

void buttonClick() {
  if (inicio.clicked) seccaogeral = 0;
  inicio.update();
  if (dataSexFemGraph.clicked) seccaogeral = 3;
  dataSexFemGraph.update();
  if (dataSexMascGraph.clicked) seccaogeral = 4;
  dataSexMascGraph.update();
  if (dataSexGeneral.clicked) seccaogeral = 5;
  dataSexGeneral.update();
  if (dataStatistics.clicked) seccaogeral = 6;
  dataStatistics.update();
  if (dataVertical.clicked) seccaogeral = 7;
  dataVertical.update();
  if (dataFilter.clicked) seccaogeral = 8;
  dataFilter.update();
  if (exit.clicked) seccaogeral = 9;
  exit.update();
}

void summary() {
  summaryMale.update(); 
  if (summaryMale.clicked) seccaogeral = 8;
  summaryFemale.update(); 
  if (summaryFemale.clicked) seccaogeral = 9;
}

void mouseDragged() {
  file[0].play(4.0, 1.0);
  if (seccaogeral==1) {
    iniciouDrag = true;
  }
}

void mouseReleased() {
  file[1].play(4.0, 1.0);
  if (seccaogeral==1 && !paisCandidato.equals("") && !iniciouDrag) {
    paiseSeleccionado = paisCandidato;
    seccaogeral = 2;
  }
  iniciouDrag=false;
}

void mousePressed() {
  file[0].play(3.0, 1.0);
}

void keyPressed() {
  if (key=='c') {
    myTextareaMale.setColor(0xffffffff);
    myTextareaFemale.setColor(0xffffffff);
  }
}
