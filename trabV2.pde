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


import java.util.Map;    // importar os hashmaps do JAVA
import java.util.*;
import java.io.*;

//lista dos varios icones
List countryMarkers = new ArrayList();

//declaração hashmap paises
HashMap<String, Pais> paises = new HashMap<String, Pais>();
int numeroPaises;
Button inicio, dataDescr, dataSexMascGraph, dataSexFemGraph, 
dataSexGeneral, dataStatistics, dataVertical, dataFilter, dataInit, dataMap, infoPais;
PFont semiBoldItalic, semiBold, regular, lightItalic, light, 
italic, extraBoldItalic, extraBold, boldItalic, bold;
int seccaogeral;
String paiseSeleccionado;
int x = 50; //dados para divisão por sexo
int y = 50;
import controlP5.*;
ControlP5 cp5;
Textfield targetField;
Pais pais = paises.get(paiseSeleccionado);


public void setup() {

  size(1400, 1080, P2D);
  map = new UnfoldingMap(this);
  MapUtils.createDefaultEventDispatcher(this, map);
  map.setTweening(true);
  map.zoomToLevel(4);

  smooth();  // instrucao para suavisar graficos em todo o programa
  semiBoldItalic = createFont("OpenSans-SemiboldItalic.ttf", 12);
  semiBold = createFont("OpenSans-Semibold.ttf",12);
  regular = createFont("OpenSans-Regular.ttf",12);
  lightItalic = createFont("OpenSans-LightItalic.ttf", 12);
  light = createFont("OpenSans-Italic.ttf", 12);
  extraBoldItalic = createFont("OpenSans-ExtraBoldItalic.ttf", 12);
  extraBold = createFont("OpenSans-ExtraBold.ttf", 12);
  extraBoldItalic = createFont("OpenSans-BoldItalic.ttf", 12);
  bold = createFont("OpenSans-Bold.ttf", 12);
  
  inicio = new Button(10, 73, 130, 30, 12, "Inicio");
  dataSexFemGraph = new Button(150, 73, 130, 30, 12, "Dados por sexo F");
  dataSexMascGraph = new Button(290, 73, 130, 30, 12, "Dados por sexo M");
  dataSexGeneral = new Button(430, 73, 130, 30, 12, "Dados por sexo Geral");
  dataStatistics = new Button(570, 73, 130, 30, 12, "Estatisticas");
  dataVertical = new Button(710, 73, 130, 30, 12, "Areas");
  dataFilter = new Button(850, 73, 130, 30, 12, "Filtro");
  dataMap = new Button(850, 73, 130, 30, 12, "Mapa");
  //infoPais = new Button(850, 73, 130, 30, 12, "Mapa");

  
  
  

  String[] linhas = loadStrings("teste.csv");  // vamos ler o ficheiro de texto e guardar num array de Strings (cada indice tem uma linha do texto)
  
  numeroPaises = linhas.length; // quantas linhas temos
  println(numeroPaises);
  
  for (int i=0; i<numeroPaises; i++) { // percorremos as linhas

    String linha = linhas[i];   /// //obtemos os dados de uma linha. Ex: "Portugal,10,91"
    
    String[] elementos = split(linha, ","); // dividimos a string pelo delimitador

    String nome = elementos[0]; // obtemos o nome do pais
    String primaryMale = elementos[4]; //descrição de cada elementos
    String primaryFemale = elementos[6]; //primario, secondario e terciario
    String secondaryMale = elementos[10]; //para masculino e feminino
    String secondaryFemale = elementos[12];
    String tertiaryMale = elementos[16];
    String tertiaryFemale = elementos[18];
    
    float primaryMaleValue = parseInt(elementos[5]); //valores de cada descrição acima
    float primaryFemaleValue = parseInt(elementos[7]);
    float secondaryMaleValue = parseInt(elementos[11]);
    float secondaryFemaleValue = parseInt(elementos[13]);
    float tertiaryMaleValue = parseInt(elementos[17]);
    float tertiaryFemaleValue = parseInt(elementos[19]);
    float lat = parseInt(elementos[20]); // obtemos a LATITUDE GPS
    float lon = parseInt(elementos[21]); // obtemos a LONGITUDE GPS

    PImage iconBandeira;
    iconBandeira = loadImage(elementos[22]);
    iconBandeira.resize(12,12);

    Pais P = new Pais(nome, lat, lon, iconBandeira, primaryMale, secondaryMale, tertiaryMale, primaryMaleValue, secondaryMaleValue, tertiaryMaleValue, primaryFemale, secondaryFemale, tertiaryFemale, primaryFemaleValue, secondaryFemaleValue, tertiaryFemaleValue);
    
    Location mapMarker = new Location(lat,lon);
    // Add markers to the map
    ImageMarker imgMarker = new ImageMarker(mapMarker, iconBandeira);
    map.addMarkers(imgMarker);
     //for (Map.Entry p : paises.entrySet() ) {    // percorremos o hashmap dos paises     
     //  Pais pais = (Pais) p.getValue();
     //  pais.desenhaInfo();
     //  pais.desenhaRato();
     //}

    paises.put(nome, P);
    //for (Map.Entry p : paises.entrySet()) {
    //       pais = paises.get(paiseSeleccionado);
    //}
  }
}



public void draw() {
  background(240);

  switch(seccaogeral) {
   case 0:
      background(240);
         PImage ipca;
         ipca = loadImage("ipca-logo-web.jpg");
         ipca.resize(400,225);
         image(ipca, 500, 160);

         textSize(12);
         fill(50);
         textFont(semiBoldItalic);
         text("Informação do trabalho", 70, 160);
         //text(pais.nome, 70, 184);
         textFont(lightItalic);
         text("Desenho Interfaces Aplicacionais", 500, 510);
         text("MEI (Pós-Laboral), DIA", 500, 530);
         text("Trabalho elaborado por:", 500, 550);
         text("Fernando Correia Nº a11199", 500, 570);
   break;
   case 1:
       
       map.draw();
       for (Map.Entry p : paises.entrySet() ) {    // percorremos o hashmap dos paises     
         Pais pais = (Pais) p.getValue();
         //pais = paises.get(paiseSeleccionado);
         pais.desenhaInfo();
         pais.desenhaRato();
       }
     mouseMoved();
     println(paiseSeleccionado);
     println(seccaogeral);
       

    // map.draw();    // desenha o mapa interactivo
    // //// Create point markers for locations
    
     
    // background(240);
    // textSize(16);

    // text("Dados por sexo feminino", 70, 160);
     
     
    // //Pais paisM = paises.get(paiseSeleccionado);
     
    // textFont(regular);
    // text("(thousands)", 280, 250);
    // textSize(12);
    // fill(40, 50, 60, 200);
    // text(pais.primaryMale, 10, 295);
    // fill(40, 50, 60, 200);
    // text(pais.secondaryMale, 10, 395);
    // fill(40, 50, 60, 200);
    // text(pais.tertiaryMale, 10, 495);
     
    //  // salario pais selecionado
    //float m = map(pais.primaryMaleValue, 0, width, 0, width);

    //fill(318,36,15,200);
    //rect(280, 280, m, 20, 12);
    //fill(255);
    //text(pais.primaryMaleValue, 280, 295);

    //// salario medio
    //float n = map(pais.secondaryMaleValue, 0, width, 0, width);
    //fill(331,67,25,150);
    //rect(280, 380, n, 20, 12);
    //fill(255);
    //text(pais.secondaryMaleValue, 280, 395);

    //// salario mais alto
    //float o = map(pais.tertiaryMaleValue, 0, width, 0, width);
    //fill(343,81,45,100);
    //rect(280, 480, o+5, 20, 12);
    //fill(255);
    //text(pais.tertiaryMaleValue, 280, 495);  
    
    //fill(318,36,15,200);
    //rect(100, 650, 20, 20, 12);
    //fill(331,67,25,150);
    //rect(100, 700, 20, 20, 12);
    //fill(343,81,45,100);
    //rect(100, 750, 20, 20, 12);
    
    //fill(40, 50, 60, 200);
    // noStroke();
    // text(pais.primaryMale, 200, 660);
    // fill(40, 50, 60, 200);
    // text(pais.secondaryMale, 200, 710);
    // fill(40, 50, 60, 200);
    // text(pais.tertiaryMale, 200, 760);

   break;
   
   case 2:
     background(240);
     text(pais.nome,50,50);
     
         PFont mono;

         mono = createFont("OpenSans-Regular.ttf", 12);

         textFont(mono);
         
         background(240);
         ipca = loadImage("ipca-logo-web.jpg");
         ipca.resize(400,225);
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
     
   break;
   
   //primeiro ecra após escolher o pais
   case 3:
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
     background(240);
     textSize(16);

     //Pais paisG = paises.get(paiseSeleccionado);
     
     text("(thousands)", width/2, 250);
     textSize(12);
     //fill(40, 50, 60, 200);
     //text(paisG.primaryMale, 10, 295);
     //fill(40, 50, 60, 200);
     //text(paisG.secondaryMale, 10, 395);
     //fill(40, 50, 60, 200);
     //text(paisG.tertiaryMale, 10, 495);
     
     //fill(40, 50, 60, 200);
     //text(paisG.primaryFemale, 1350, 295);
     //fill(40, 50, 60, 200);
     //text(paisG.secondaryFemale, 1350, 395);
     //fill(40, 50, 60, 200);
     //text(paisG.tertiaryFemale, 1350, 495);
     
      // salario pais selecionado
    float mg = map(pais.primaryMaleValue, 0, width, 0, width);

    fill(13,39,255,200);
    rect(100, 280, mg, 20, 12);
    fill(255);
    text(pais.primaryMaleValue, 100, 295);

    // salario medio
    float ng = map(pais.secondaryMaleValue, 0, width, 0, width);
    fill(12,94,232,150);
    rect(100, 380, ng, 20, 12);
    fill(255);
    text(pais.secondaryMaleValue, 100, 395);

    // salario mais alto
    float og = map(pais.tertiaryMaleValue, 0, width, 0, width);
    fill(0,162,255,100);
    rect(100, 480, og+5, 20, 12);
    fill(255);
    text(pais.tertiaryMaleValue, 100, 495);     
     
     
     
      // salario pais selecionado
    float qg = map(pais.primaryFemaleValue, 0, width, 0, width);

    fill(318,36,15,200);
    rect(1250, 280, -qg, 20, 12);
    fill(255);
    text(pais.primaryFemaleValue, 1190, 295);

    // salario medio
    float rg = map(pais.secondaryFemaleValue, 0, width, 0, width);
    fill(331,67,25,150);
    rect(1250, 380, -rg, 20, 12);
    fill(255);
    text(pais.secondaryFemaleValue, 1190, 395);

    // salario mais alto
    float sg = map(pais.tertiaryFemaleValue, 0, width, 0, width);
    fill(343,81,45,100);
    rect(1250, 480, -sg, 20, 12);
    fill(255);
    text(pais.tertiaryFemaleValue, 1190, 495);
    
    fill(318,36,15,200);
    rect(100, 650, 20, 20, 12);
    fill(331,67,25,150);
    rect(100, 700, 20, 20, 12);
    fill(343,81,45,100);
    rect(100, 750, 20, 20, 12);

    fill(13,39,255,200);
    rect(100, 800, 20, 20, 12);
    fill(12,94,232,150);
    rect(100, 850, 20, 20, 12);
    fill(0,162,255,100);
    rect(100, 900, 20, 20,12); 
    
     textFont(regular);
     fill(40, 50, 60, 200);
     noStroke();
     text(pais.primaryMale, 200, 660);
     fill(40, 50, 60, 200);
     text(pais.secondaryMale, 200, 710);
     fill(40, 50, 60, 200);
     text(pais.tertiaryMale, 200, 760);
     
     fill(40, 50, 60, 200);
     text(pais.primaryFemale, 200, 810);
     fill(40, 50, 60, 200);
     text(pais.secondaryFemale, 200, 860);
     fill(40, 50, 60, 200);
     text(pais.tertiaryFemale, 200, 910);
    
   break;
   
   case 5:
     background(240);
     //Pais paisS = paises.get(paiseSeleccionado);
     float mediaMale = (pais.primaryMaleValue + pais.secondaryMaleValue + pais.tertiaryMaleValue)/3;
     float maiorValorMale = max(pais.primaryMaleValue, pais.secondaryMaleValue, pais.tertiaryMaleValue);
     float menorValorMale = min(pais.primaryMaleValue, pais.secondaryMaleValue, pais.tertiaryMaleValue);
     float somatorioValorMale;
     
     somatorioValorMale = pais.primaryMaleValue + pais.secondaryMaleValue + pais.tertiaryMaleValue;
     
     
     float mediaFemale = (pais.primaryFemaleValue + pais.secondaryFemaleValue + pais.tertiaryFemaleValue)/3;
     float maiorValorFemale = max(pais.primaryFemaleValue, pais.secondaryFemaleValue, pais.tertiaryFemaleValue);
     float menorValorFemale = min(pais.primaryFemaleValue, pais.secondaryFemaleValue, pais.tertiaryFemaleValue);
     float somatorioValorFemale;
     
     
     somatorioValorFemale = pais.primaryFemaleValue + pais.secondaryFemaleValue + pais.tertiaryFemaleValue;
     float distanciaMedia = dist(250, height/4+200, mouseX, mouseY);
     float distanciaMaior = dist(300, height/4+200, mouseX, mouseY);
     float distanciaMenor = dist(350, height/4+200, mouseX, mouseY);
     float distanciaSomatorio = dist(400, height/4+200, mouseX, mouseY);


     stroke(0,80);
     fill(0,56,64);
     rect(250, 800, 50, -mediaMale);
     fill(0,90,91);
     rect(300, 800, 50, -maiorValorMale);
     fill(0,115,105);
     rect(350,800, 50, -menorValorMale);
     fill(0,140,114);
     rect(400, 800, 50, -somatorioValorMale);
     fill(40, 50, 60, 200);
     text("Male", 350, 859);
     
     
     fill(0,56,64);
     rect(1000, 800, 50, -mediaFemale);
     fill(0,90,91);
     rect(1050, 800, 50, -maiorValorFemale);
     fill(0,115,105);
     rect(1100,800, 50, -menorValorFemale);
     fill(0,140,114);
     rect(1150, 800, 50, -somatorioValorFemale);
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
      
      fill(0,80);
      rect(1250, 185, 125, 110);
      rect(10, 185, 125, 110);

      
      fill(0,56,64);
      rect(400, 950, 20, 20, 12);
      fill(0,115,105);
      rect(650, 950, 20, 20, 12);
      fill(0,140,114);
      rect(900, 950, 20, 20, 12);
      fill(40, 50, 60, 200);
      rect(1150, 950, 20, 20, 12);
      
      fill(40, 50, 60, 200);
      text("Media", 430, 965);
      text("Maior Valor", 680, 965);
      text("Menor Valor", 930, 965);
      text("Somatório", 1180, 965);



     //
   break;
   
   case 6:
      //Pais paisA = paises.get(paiseSeleccionado);
      float distanciaP = dist(100 + 155, height/2, mouseX, mouseY);
      float distanciaS = dist(100+1000, height/2, mouseX, mouseY);


      background(240);
      stroke(0,80);
      fill(255,165,0,200);
      ellipse(100 + 155, height/2, pais.primaryMaleValue*2, pais.primaryMaleValue*2);
      fill(255,165,0,150);
      ellipse(100 + 155, height/2, pais.secondaryMaleValue*2, pais.secondaryMaleValue*2);
      fill(255,100,0,50);
      ellipse(100 + 155, height/2, pais.tertiaryMaleValue*2, pais.tertiaryMaleValue*2);
      
      text("Male", 255, height/2-1);
      
      if(distanciaP < 40) {
      fill(100);
      text(pais.nome+"\nPrimary value: " + pais.primaryMaleValue + "\nSecondary Value: " + pais.secondaryMaleValue + "\nTertiary Value: " + pais.tertiaryMaleValue, 100 + 155 + 10, height/2 - 150);
      line(100 + 155, height/2, 100 + 155, height/2 - 150);
      }
      stroke(0,80);
      fill(255,69,0,200);
      ellipse(100 + 1000, height/2, pais.primaryFemaleValue*2, pais.primaryFemaleValue*2);
      fill(255,69,0,150);
      ellipse(100 + 1000, height/2, pais.secondaryFemaleValue*2, pais.secondaryFemaleValue*2);
      fill(255,10,0,50);
      ellipse(100 + 1000, height/2, pais.tertiaryFemaleValue*2, pais.tertiaryFemaleValue*2);  
      text("Female", 1100, height/2-1);

      if(distanciaS < 40) {
      fill(100);
      text(pais.nome+"\nPrimary value: " + pais.primaryFemaleValue + "\nSecondary Value: " + pais.secondaryFemaleValue + "\nTertiary Value: " + pais.tertiaryFemaleValue, 100 + 1000 + 10, height/2 - 150);
      line(1100, height/2, 1100, height/2 - 150);
      }
      
      fill(255,165,0,200);
      rect(100, 700, 20, 20, 12);
      fill(255,165,0,150);
      rect(100, 750, 20, 20, 12);
      fill(255,100,0,50);
      rect(100, 800, 20, 20, 12);
  
      fill(255,69,0,200);
      rect(100, 850, 20, 20, 12);
      fill(255,69,0,150);
      rect(100, 900, 20, 20, 12);
      fill(255,10,0,50);
      rect(100, 950, 20, 20,12); 
    
      fill(40, 50, 60, 200);
      noStroke();
      text(pais.primaryMale, 200, 710);
      fill(40, 50, 60, 200);
      text(pais.secondaryMale, 200, 760);
      fill(40, 50, 60, 200);
      text(pais.tertiaryMale, 200, 810);
     
      fill(40, 50, 60, 200);
      text(pais.primaryFemale, 200, 860);
      fill(40, 50, 60, 200);
      text(pais.secondaryFemale, 200, 910);
      fill(40, 50, 60, 200);
      text(pais.tertiaryFemale, 200, 960);
   break;
   
   case 7:
     background(240);
     textFont(bold);
     text("Filtros de valores", 70, 160);

   break;
  }
  
  if (seccaogeral == 2) {
    textFont(regular);
     
    inicio.update();
    dataSexMascGraph.update();
    dataSexFemGraph.update();
    dataStatistics.update();
    dataSexGeneral.update();
    dataVertical.update();
    dataFilter.update();
  } 
  
  if(seccaogeral == 0) {
    dataMap.update();
  }
  
  //if(dataInit.clicked) seccaogeral = 0;
  if(dataMap.clicked) seccaogeral = 1;
  //if(inicio.clicked) seccaogeral = 0;
  //if(dataSexFemGraph.clicked) seccaogeral = 1;
  //if(dataSexMascGraph.clicked) seccaogeral = 2;
  //if(dataSexGeneral.clicked) seccaogeral = 4;
  //if(dataStatistics.clicked) seccaogeral = 5;
  //if(dataVertical.clicked) seccaogeral = 6;
  //if(dataFilter.clicked) seccaogeral = 7;
}

void mouseMoved() {
  // Deselect all marker
  for (Marker marker : map.getMarkers()) {
    marker.setSelected(false);
  }

  // Select hit marker
  // Note: Use getHitMarkers(x, y) if you want to allow multiple selection.
  Marker marker = map.getFirstHitMarker(mouseX, mouseY);
  if (marker != null) {
    marker.setSelected(true);
  }
}
