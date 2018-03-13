
Arme_principale[] arme_principale = new Arme_principale[50];
Arme_grenade[] arme_grenade = new Arme_grenade[50];

Meteorite[] meteorite = new Meteorite[1000];
Balle[] balle = new Balle[2000];
Grenade[] grenade = new Grenade[2000];

Bouclier[] bouclier = new Bouclier[20];

class Arme_principale {
  int x;
  int y;
  int type;
  float vie = 100;
  float angle_tir = 0;
  long tmp_tir = 0;
}

class Arme_grenade {
  int x;
  int y;
  int type;
  float vie = 100;
  float angle_tir = 0;
  long tmp_tir = 0;
}


class Meteorite{
  int x;
  int y;
  float vie = 2;
  float vie_max = 2;
  
}

class Balle{
  int x;
  float direction = 0;
  int arme_principale;
  int active = 0;
  
}

class Grenade{
  int x;
  float direction = 0;
  int arme_grenade;  
  int active = 0;
  int cercle_explose = -1;
  
}

class Bouclier{
  int x1;
  int y1;
  
  int x2;
  int y2;
  
  int vie = 0;
  
}

int nb_balle = 0;

int nb_arme_principale = 0;

int selection_arme_principale = 0;

int nb_arme_grenade = 0;

int selection_arme_grenade = 0;

int nb_meteorite = 2;

int point = 50;

int score = 0;

int level = 0;

int vie_ville = 700;
int cree_bouclier = 0;
int nb_bouclier = 0;
int n_bouclier = 0;

int clique_inventaire = 0;

String message = "Commencer par placer un canon pour vous défendre";

int bouclier_mis_tuto = 0;

int tmp_message = -1;

int game_over = -1;

int menu_inventaire = 0;


void setup(){
  size(500,550);
  
  
  
  for (int i = 0; i < 50; i++) {
    arme_principale[i] = new Arme_principale();
  }  
  
  for (int i = 0; i < 50; i++) {
    arme_grenade[i] = new Arme_grenade();
  } 
  
  for (int i = 0; i < 1000; i++) {
    meteorite[i] = new Meteorite();
    meteorite[i].y = 0 - round(random(50,500));
    meteorite[i].x = round(random(10,490));
    meteorite[i].vie = 2;
    meteorite[i].vie_max = 2;
  } 
  
  for (int i = 0; i < 2000; i++) {
    balle[i] = new Balle();
    
  } 
  
  for (int i = 0; i < 2000; i++) {
    grenade[i] = new Grenade();
    
  } 
  
  for (int i = 0; i < 20; i++) {
    bouclier[i] = new Bouclier();
    
  }
  
  
}


void draw(){
  background(200); 
  
  affiche_barre_arme_principale();
  affiche_vie_ville();
  affiche_inventaire();
  
  selectionne_arme_principale();
  selectionne_arme_grenade();
  
  affiche_arme();
   
  affiche_meteorite();
  mv_meteorite();
  
  regene_arme_principale();
  
  disp_meteorite();
  orientation_canon_arme_principale();
  orientation_canon_arme_grenade();
  
  tir_arme_principale();
  tir_arme_grenade();
  
  affiche_balle();
  affiche_grenade();
  
  mv_balle();
  mv_grenade();
  
  
  
  creation_bouclier();
  affiche_bouclier();
  affiche_message();
  
  fill(0);
  textSize(20);
  text(point,10,20);
  
  /*for(int i = 0; i < nb_arme_principale;i++){
    float x = mouseX - arme_principale[i].x;
    float y = mouseY - arme_principale[i].y + 1;
    
    if(mouseY <= arme_principale[i].y){
      arme_principale[i].angle_tir = 360 - atan(x/y) * 180 / PI;
    }
    else{
      arme_principale[i].angle_tir = 180 - atan(x/y) * 180 / PI;  
    }
    
    line(arme_principale[i].x,arme_principale[i].y,arme_principale[i].x,mouseY);
    line(arme_principale[i].x,arme_principale[i].y,mouseX,mouseY);
    line(arme_principale[i].x,mouseY,mouseX,mouseY);
  }*/
  
  
  if(vie_ville <= 0){
    println("Vous avez perdu");
    print("score: ");
    println(score);
    if(game_over == -1){
      game_over = 3;
    }
  }
  
  delay(1);
}

void affiche_inventaire(){
  fill(255);
  stroke(0);
  
  rect(0,500,500,50);
  if(menu_inventaire == 0){
    line(100,500,100,550);
    line(200,500,200,550);
    
    fill(0);
    text("1",40,520);
    text("2",140,520);
    if(mousePressed == true && mouseY > 500){
      int caseX = mouseX / 100 + 1;
      if(caseX == 1){
        menu_inventaire = 1;  
        mousePressed = false;
      }
      if(caseX == 2){
        menu_inventaire = 2;  
        mousePressed = false;
      }
    }
    
  }
  if(menu_inventaire == 1){
      
    fill(255,0,0);
    rect(0,500,166,50);
    
    fill(0,255,0);
    rect(167,500,166,50);
    
    fill(0,0,255);
    rect(333,500,500,50);
    
    fill(0);
    text("30",20,520);
    text("75",186,520);
    text("400",352,520);
    
    fill(255);
    rect(0,475,75,25);
    textSize(15);
    fill(0);
    
    text("<-Retour",3,492);
    
    if(mousePressed == true && mouseX <= 75 && mouseY >= 475 && mouseY <= 500){
      menu_inventaire = 0;
      //delay(500);
    }
  }
  
  if(menu_inventaire == 2){
      
    fill(255,0,0);
    rect(0,500,166,50);
    
    fill(0,255,0);
    rect(167,500,166,50);
    
    fill(0,0,255);
    rect(333,500,500,50);
    
    fill(0);
    text("60",20,520);
    text("100",186,520);
    text("600",352,520);
    
    fill(255);
    rect(0,475,75,25);
    textSize(15);
    fill(0);
    
    text("<-Retour",3,492);
    
    if(mousePressed == true && mouseX <= 75 && mouseY >= 475 && mouseY <= 500){
      menu_inventaire = 0;
      //delay(500);
    }
  }
  
}

void selectionne_arme_principale(){
  if(mousePressed == false)clique_inventaire = 0;
  if(mousePressed == true){
    if(selection_arme_principale == 0 && mouseY >= 500 && menu_inventaire == 1){
      clique_inventaire = 1;
      selection_arme_principale = mouseX / 166 + 1;
      if(selection_arme_principale == 1 && point < 30){
        selection_arme_principale = 0;
        message = "Mince!!!, vous n'avez pas assez de sous, détruiser les\nmétéorites pour en gagner ;)";
        tmp_message = 1000;
      }
      
      if(selection_arme_principale == 2 && point < 75){
        selection_arme_principale = 0;
        message = "Mince!!!, vous n'avez pas assez de sous, détruiser les\nmétéorites pour en gagner ;)";
        tmp_message = 1000;
      }
      
      
      
      if(selection_arme_principale == 3 && point < 400){
        selection_arme_principale = 0;
        message = "Mince!!!, vous n'avez pas assez de sous, détruiser les\nmétéorites pour en gagner ;)";
        tmp_message = 1000;
      }
      
      
    }
    else if(selection_arme_principale != 0){
        
      stroke(0);
      fill(50);
      rect(mouseX-5,mouseY,10,500-mouseY);  
      
      if(selection_arme_principale == 1)fill(255,0,0);  
      if(selection_arme_principale == 2)fill(0,255,0); 
      if(selection_arme_principale == 3)fill(0,0,255); 
      
      for(int i = 0; i < nb_arme_principale;i++){
        if(mouseX + 25 > arme_principale[i].x - 25 && mouseX - 25 < arme_principale[i].x + 25){
          if(mouseY + 25 > arme_principale[i].y - 25 && mouseY - 25 < arme_principale[i].y + 25){
            stroke(255,0,0);
          }
        }
      }
      for(int i = 0; i < nb_arme_grenade;i++){
        if(mouseX + 25 > arme_grenade[i].x - 25 && mouseX - 25 < arme_grenade[i].x + 25){
          if(mouseY + 25 > arme_grenade[i].y - 25 && mouseY - 25 < arme_grenade[i].y + 25){
            stroke(255,0,0);
          }
        }
      }
      
      ellipse(mouseX,mouseY,50,50);
      
      stroke(0);
    }
  }
  
  if(mousePressed == false && selection_arme_principale != 0 && mouseY < 470){
    clique_inventaire = 0; 
    int libre = 1;
    for(int i = 0; i < nb_arme_principale;i++){
      if(mouseX + 25 > arme_principale[i].x - 25 && mouseX - 25 < arme_principale[i].x + 25){
        if(mouseY + 25 > arme_principale[i].y - 25 && mouseY - 25 < arme_principale[i].y + 25){
          libre = 0;
        }
      }
    }
    for(int i = 0; i < nb_arme_grenade;i++){
      if(mouseX + 25 > arme_grenade[i].x - 25 && mouseX - 25 < arme_grenade[i].x + 25){
        if(mouseY + 25 > arme_grenade[i].y - 25 && mouseY - 25 < arme_grenade[i].y + 25){
          libre = 0;
        }
      }
    }
    if(libre == 1){
      if(selection_arme_principale == 1 && point >= 30){
        point -= 30;  
      }
      if(selection_arme_principale == 2 && point >= 75){
        point -= 75;  
      }
      if(selection_arme_principale == 3 && point >= 400){
        point -= 400;  
      }
      arme_principale[nb_arme_principale].x = mouseX;
      arme_principale[nb_arme_principale].y = mouseY;
    
      arme_principale[nb_arme_principale].type = selection_arme_principale;
      nb_arme_principale++;
      //println(mouseX);
    }
    
    selection_arme_principale = 0;
  }  
}


void selectionne_arme_grenade(){
  if(mousePressed == false)clique_inventaire = 0;
  if(mousePressed == true){
    if(selection_arme_grenade == 0 && mouseY >= 500 && menu_inventaire == 2){
      clique_inventaire = 1;
      selection_arme_grenade = mouseX / 166 + 1;
      if(selection_arme_grenade == 1 && point < 60){
        selection_arme_grenade = 0;
        message = "Mince!!!, vous n'avez pas assez de sous, détruiser les\nmétéorites pour en gagner ;)";
        tmp_message = 1000;
      }
      
      if(selection_arme_grenade == 2 && point < 100){
        selection_arme_grenade = 0;
        message = "Mince!!!, vous n'avez pas assez de sous, détruiser les\nmétéorites pour en gagner ;)";
        tmp_message = 1000;
      }
      
      
      
      if(selection_arme_grenade == 3 && point < 600){
        selection_arme_grenade = 0;
        message = "Mince!!!, vous n'avez pas assez de sous, détruiser les\nmétéorites pour en gagner ;)";
        tmp_message = 1000;
      }
      
      
    }
    else if(selection_arme_grenade != 0){
        
      stroke(0);
      fill(50);
      rect(mouseX-5,mouseY,10,500-mouseY);  
      
      if(selection_arme_grenade == 1)fill(255,0,0);  
      if(selection_arme_grenade == 2)fill(0,255,0); 
      if(selection_arme_grenade == 3)fill(0,0,255); 
      
      for(int i = 0; i < nb_arme_grenade;i++){
        if(mouseX + 25 > arme_grenade[i].x - 25 && mouseX - 25 < arme_grenade[i].x + 25){
          if(mouseY + 25 > arme_grenade[i].y - 25 && mouseY - 25 < arme_grenade[i].y + 25){
            stroke(255,0,0);
          }
        }
      }
      for(int i = 0; i < nb_arme_principale;i++){
        if(mouseX + 40 > arme_principale[i].x - 25 && mouseX < arme_principale[i].x + 25){
          if(mouseY + 40 > arme_principale[i].y - 25 && mouseY < arme_principale[i].y + 25){
            stroke(255,0,0);
          }
        }
      }
      
      rect(mouseX-20,mouseY-20,40,40);
      
      stroke(0);
    }
  }
  
  if(mousePressed == false && selection_arme_grenade != 0 && mouseY < 470){
    clique_inventaire = 0; 
    int libre = 1;
    for(int i = 0; i < nb_arme_grenade;i++){
      if(mouseX + 25 > arme_grenade[i].x - 25 && mouseX - 25 < arme_grenade[i].x + 25){
        if(mouseY + 25 > arme_grenade[i].y - 25 && mouseY - 25 < arme_grenade[i].y + 25){
          libre = 0;
        }
      }
    }
    for(int i = 0; i < nb_arme_principale;i++){
      if(mouseX + 40 > arme_principale[i].x - 25 && mouseX < arme_principale[i].x + 25){
        if(mouseY + 40 > arme_principale[i].y - 25 && mouseY < arme_principale[i].y + 25){
          libre = 0;
        }
      }
    }
    if(libre == 1){
      if(selection_arme_grenade == 1 && point >= 30){
        point -= 60;  
      }
      if(selection_arme_grenade == 2 && point >= 75){
        point -= 100;  
      }
      if(selection_arme_grenade == 3 && point >= 400){
        point -= 600;  
      }
      arme_grenade[nb_arme_grenade].x = mouseX;
      arme_grenade[nb_arme_grenade].y = mouseY;
    
      arme_grenade[nb_arme_grenade].type = selection_arme_grenade;
      nb_arme_grenade++;
      //println(mouseX);
    }
    
    selection_arme_grenade = 0;
  }  
}

void affiche_arme(){
  for(int i = 0; i < nb_arme_principale;i++){
    
    stroke(0);
    fill(0);
    
    rect(arme_principale[i].x - 50,arme_principale[i].y - 10,20,5);
    
    fill(0,255,0);
    if(arme_principale[i].vie < 0)arme_principale[i].vie = 0;
    
    rect(arme_principale[i].x - 50,arme_principale[i].y - 10,map(arme_principale[i].vie,0,100,0,20),5); 
    
    fill(0);
    
    pushMatrix();
    translate(arme_principale[i].x,arme_principale[i].y);
    rotate(PI * arme_principale[i].angle_tir / 180);
    rect(-10,0,20,-40);
    popMatrix();
    
    
        
    if(arme_principale[i].type == 1)fill(255,0,0);  
    if(arme_principale[i].type == 2)fill(0,255,0); 
    if(arme_principale[i].type == 3)fill(0,0,255); 
    
    if(arme_principale[i].vie < 10)fill(50,50,50);
    
    ellipse(arme_principale[i].x,arme_principale[i].y,50,50);
    
       
     
    
  }
  
  for(int i = 0; i < nb_arme_grenade;i++){
    
    stroke(0);
    fill(0);
    
    rect(arme_grenade[i].x - 50,arme_grenade[i].y - 10,20,5);
    
    fill(0,255,0);
    if(arme_grenade[i].vie < 0)arme_grenade[i].vie = 0;
    
    rect(arme_grenade[i].x - 50,arme_grenade[i].y - 10,map(arme_grenade[i].vie,0,100,0,20),5); 
    
    fill(0);
    
    pushMatrix();
    translate(arme_grenade[i].x,arme_grenade[i].y);
    rotate(PI * arme_grenade[i].angle_tir / 180);
    rect(-10,0,20,-40);
    popMatrix();
    
    if(arme_grenade[i].type == 1)fill(255,0,0);  
    if(arme_grenade[i].type == 2)fill(0,255,0); 
    if(arme_grenade[i].type == 3)fill(0,0,255); 
    
    if(arme_grenade[i].vie < 10)fill(50,50,50);
    
    rect(arme_grenade[i].x-20,arme_grenade[i].y-20,40,40);
  } 
}

void regene_arme_principale(){
  for(int i = 0; i < nb_arme_principale;i++){
    if(arme_principale[i].vie < 100){
      arme_principale[i].vie += 0.05;  
    }
    
  }
  
}

void affiche_meteorite(){
  for(int i = 0; i < nb_meteorite;i++){
    fill(0);
    stroke(0);
    
    if(meteorite[i].vie < meteorite[i].vie_max){
      rect(meteorite[i].x - 25,meteorite[i].y - 10,20,5);
      
      fill(0,255,0);
      if(meteorite[i].vie < 0)meteorite[i].vie = 0;
      
      rect(meteorite[i].x - 25,meteorite[i].y - 10,map(meteorite[i].vie,0,meteorite[i].vie_max,0,20),5);
    }
    
    fill(0);
    stroke(0);
    ellipse(meteorite[i].x,meteorite[i].y,20,20);
    
  }
  
  
}

void mv_meteorite(){
  for(int i = 0; i < nb_meteorite;i++){
    meteorite[i].y+=2;  
    
    for(int j = 0; j < nb_arme_principale;j++){
      if(meteorite[i].x > arme_principale[j].x - 25 && meteorite[i].x < arme_principale[j].x + 25){
        if(meteorite[i].y > arme_principale[j].y - 25 && meteorite[i].y < arme_principale[j].y + 25){
          if(arme_principale[j].vie > 10){
            arme_principale[j].vie -= 25;  
            meteorite[i].y = 0 - round(random(50,500));
            meteorite[i].x = round(random(10,490));
          }
        }
      }
    }
    
    for(int j = 0; j < nb_arme_grenade;j++){
      if(meteorite[i].x > arme_grenade[j].x - 20 && meteorite[i].x < arme_grenade[j].x + 20){
        if(meteorite[i].y > arme_grenade[j].y - 20 && meteorite[i].y < arme_grenade[j].y + 20){
          if(arme_grenade[j].vie > 10){
            arme_grenade[j].vie -= 20;  
            meteorite[i].y = 0 - round(random(50,500));
            meteorite[i].x = round(random(10,490));
          }
        }
      }
    }
    
  }
  
}

void disp_meteorite(){
  //println(level);
  for(int i = 0; i < nb_meteorite;i++){
    if(meteorite[i].y >= 480 || meteorite[i].vie <= 0){
      if(meteorite[i].y >= 480){
        vie_ville -= 25;
      }
      
      meteorite[i].y = 0 - round(random(50,500));
      meteorite[i].x = round(random(10,490));  
      
      
      meteorite[i].vie = round(random(1*(level+1),3*(level+1)));
      meteorite[i].vie_max = meteorite[i].vie;
     }
     
     for(int j = 0; j < 20;j++){
       if(meteorite[i].x > bouclier[j].x1 && meteorite[i].x < bouclier[j].x2 && meteorite[i].y > bouclier[j].y1-2 && meteorite[i].y < bouclier[j].y1+10){
         if(bouclier[j].vie > 0){
           meteorite[i].y = 0 - round(random(50,500));
           meteorite[i].x = round(random(10,490));  
        
        
           meteorite[i].vie = round(random(1*(level+1),3*(level+1)));
           meteorite[i].vie_max = meteorite[i].vie;  
           bouclier[j].vie -= 5;
           score++;
         }
       }
       
     }
    
  }  
  
  
}

void orientation_canon_arme_principale(){
  for(int i = 0; i < nb_arme_principale;i++){
    if(arme_principale[i].vie > 10){
      float distance_min = 10000; 
      int meteorite_proche = -1;
      for(int j = 0; j < nb_meteorite;j++){
        float distance = 0;
        
        float x = meteorite[j].x - arme_principale[i].x;
        float y = meteorite[j].y - arme_principale[i].y;  
        
        distance = sqrt(x*x+y*y);
        
        if(distance < distance_min){
          distance_min = distance;  
          meteorite_proche = j;
        }
      } 
      
      float x = meteorite[meteorite_proche].x - arme_principale[i].x;
      float y = (meteorite[meteorite_proche].y + 50) - arme_principale[i].y + 1;
      
      if(meteorite[meteorite_proche].y < arme_principale[i].y){
        arme_principale[i].angle_tir = 360 - atan(x/y) * 180 / PI;
      }
      else{
        arme_principale[i].angle_tir = 180 - atan(x/y) * 180 / PI;  
      }
    }
  }
}

void orientation_canon_arme_grenade(){
  for(int i = 0; i < nb_arme_grenade;i++){
    if(arme_grenade[i].vie > 10){
      float distance_min = 10000; 
      int meteorite_proche = -1;
      for(int j = 0; j < nb_meteorite;j++){
        float distance = 0;
        
        float x = meteorite[j].x - arme_grenade[i].x;
        float y = meteorite[j].y - arme_grenade[i].y;  
        
        distance = sqrt(x*x+y*y);
        
        if(distance < distance_min){
          distance_min = distance;  
          meteorite_proche = j;
        }
      } 
      
      float x = meteorite[meteorite_proche].x - arme_grenade[i].x;
      float y = (meteorite[meteorite_proche].y + 50) - arme_grenade[i].y + 1;
      
      if(meteorite[meteorite_proche].y < arme_grenade[i].y){
        arme_grenade[i].angle_tir = 360 - atan(x/y) * 180 / PI;
      }
      else{
        arme_grenade[i].angle_tir = 180 - atan(x/y) * 180 / PI;  
      }
    }
  }
}

void tir_arme_principale(){
  for(int i = 0; i < nb_arme_principale;i++){
    int cadence = 0;
    switch(arme_principale[i].type){
      case 1:
        cadence = 750;
        break;
      case 2:
        cadence = 450;
         break;
      case 3:
        cadence = 150;
        break;
      
    }
    if(millis() - arme_principale[i].tmp_tir > cadence && arme_principale[i].vie > 10){
      arme_principale[i].tmp_tir = millis();
      int nballe;
      for(nballe = 0; balle[nballe].active == 1;nballe++);  
      balle[nballe].x = 50;
      balle[nballe].direction = arme_principale[i].angle_tir + 270;
      balle[nballe].arme_principale = i;
      balle[nballe].active = 1;
      //tir_son.play();
      //tir_son.rewind();
    }
    
  } 
}

void tir_arme_grenade(){
  for(int i = 0; i < nb_arme_grenade;i++){
    int cadence = 0;
    switch(arme_grenade[i].type){
      case 1:
        cadence = 1500;
        break;
      case 2:
        cadence = 750;
         break;
      case 3:
        cadence = 500;
        break;
      
    }
    if(millis() - arme_grenade[i].tmp_tir > cadence && arme_grenade[i].vie > 10){
      arme_grenade[i].tmp_tir = millis();
      int ngrenade;
      for(ngrenade = 0; grenade[ngrenade].active == 1;ngrenade++);  
      grenade[ngrenade].x = 50;
      grenade[ngrenade].direction = arme_grenade[i].angle_tir + 270;
      grenade[ngrenade].arme_grenade = i;
      grenade[ngrenade].active = 1;
      //tir_son.play();
      //tir_son.rewind();
    }
    
  } 
}

void affiche_balle(){
  for(int i = 0; i < 2000;i++){
    if(balle[i].active == 1){
      pushMatrix();
      translate(arme_principale[balle[i].arme_principale].x,arme_principale[balle[i].arme_principale].y);
      rotate(PI * balle[i].direction / 180);
      fill(255,255,0);
      stroke(0);
      ellipse(balle[i].x,0,10,10);
      popMatrix(); 
      
      float x = balle[i].x * sin(PI * (balle[i].direction - 270) / 180);
      float y = sqrt(balle[i].x * balle[i].x - x * x);
      
      fill(255,0,0);
      
      x = arme_principale[balle[i].arme_principale].x + x;
      
      if((balle[i].direction-270 > 0 && balle[i].direction-270 < 270)){
        y = arme_principale[balle[i].arme_principale].y + y;
      }
      else{
        y = arme_principale[balle[i].arme_principale].y - y; 
      }
      
      //test_collision
      
      for(int j = 0; j < nb_meteorite;j++){
        if(meteorite[j].y > 10){
          if(x > meteorite[j].x - 15 && x < meteorite[j].x + 15){
            if(y > meteorite[j].y - 15 && y < meteorite[j].y + 15){ 
              balle[i].active = 0; 
              if(arme_principale[balle[i].arme_principale].type == 1){
                meteorite[j].vie -= 3;
              }
              if(arme_principale[balle[i].arme_principale].type == 2){
                meteorite[j].vie -= 8;
              }
              if(arme_principale[balle[i].arme_principale].type == 3){
                meteorite[j].vie -= 20;
              }
              point++;
              score++;
              if(score%75 == 0){
                nb_meteorite += 2;
                level++;
               
              }
            }
          }  
        }
      }    
    }
  }
}

void affiche_grenade(){
  for(int i = 0; i < 2000;i++){
    if(grenade[i].active == 1){
      if(grenade[i].cercle_explose == -1){
        pushMatrix();
        translate(arme_grenade[grenade[i].arme_grenade].x,arme_grenade[grenade[i].arme_grenade].y);
        rotate(PI * grenade[i].direction / 180);
        fill(255,0,0);
        stroke(0);
        ellipse(grenade[i].x,0,10,10);
        popMatrix(); 
      }
      
      float x = grenade[i].x * sin(PI * (grenade[i].direction - 270) / 180);
      float y = sqrt(grenade[i].x * grenade[i].x - x * x);
            
      x = arme_grenade[grenade[i].arme_grenade].x + x;
      
      if((grenade[i].direction-270 > 0 && grenade[i].direction-270 < 270)){
        y = arme_grenade[grenade[i].arme_grenade].y + y;
      }
      else{
        y = arme_grenade[grenade[i].arme_grenade].y - y; 
      }
      
      if(grenade[i].cercle_explose >= 0){
        fill(255,0,0,20);
        stroke(255,0,0);
        
        ellipse(x,y,grenade[i].cercle_explose*2,grenade[i].cercle_explose*2);
        stroke(0);
        grenade[i].cercle_explose+=5;
        int taille = 0;
        
        if(arme_grenade[grenade[i].arme_grenade].type == 1){
          taille = 50;  
        }
        if(arme_grenade[grenade[i].arme_grenade].type == 2){
          taille = 100;  
        }
        if(arme_grenade[grenade[i].arme_grenade].type == 3){
          taille = 150;  
        }
        
        for(int k = 0; k < nb_meteorite;k++){
          float distance = 0;
  
          float x_dist = meteorite[k].x - x;
          float y_dist = meteorite[k].y - y;  
  
          distance = sqrt(x_dist*x_dist+y_dist*y_dist);
          
          if(distance <= grenade[i].cercle_explose){
            if(arme_grenade[grenade[i].arme_grenade].type == 1){
              meteorite[k].vie -= 5;
  
            }
            if(arme_grenade[grenade[i].arme_grenade].type == 2){
              meteorite[k].vie -= 12;
              
            }
            if(arme_grenade[grenade[i].arme_grenade].type == 3){
                meteorite[k].vie -= 30; 
            }
          }
        }
        
        if(grenade[i].cercle_explose > taille){
          grenade[i].cercle_explose = -1;
          grenade[i].active = 0;
        }

        
      }
      
      fill(255,0,0);      
      //test_collision
      
      for(int j = 0; j < nb_meteorite;j++){
        if(meteorite[j].y > 10){
          if(x > meteorite[j].x - 15 && x < meteorite[j].x + 15){
            if(y > meteorite[j].y - 15 && y < meteorite[j].y + 15){ 
              grenade[i].cercle_explose = 0; 
              point++;
              score++;
              if(score%75 == 0){
                nb_meteorite += 2;
                level++;
               
              }
            }
          }  
        }
      } 
    }
  }
}

void mv_balle(){
  for(int i = 0; i < 2000;i++){
    if(balle[i].active == 1){
      balle[i].x+=4;  
      if(balle[i].x > 500){
        balle[i].active = 0;
        
      }
    }
  }
  
}

void mv_grenade(){
  for(int i = 0; i < 2000;i++){
    if(grenade[i].active == 1 && grenade[i].cercle_explose == -1){
      grenade[i].x+=4;  
      if(grenade[i].x > 500){
        grenade[i].active = 0;
        
      }
    }
  }
  
}

void affiche_vie_ville(){
  fill(0);
  stroke(0);
  
  rect(0,475,500,25);
  
  fill(0,255,0);
  rect(0,475,map(vie_ville,0,700,0,500),25);
  
}

void affiche_barre_arme_principale(){
  for(int i = 0; i < nb_arme_principale;i++){
    stroke(0);
    fill(50);
    rect(arme_principale[i].x-5,arme_principale[i].y,10,500-arme_principale[i].y);  
    
  }
  for(int i = 0; i < nb_arme_grenade;i++){
    stroke(0);
    fill(50);
    rect(arme_grenade[i].x-5,arme_grenade[i].y,10,500-arme_grenade[i].y);  
    
  }
}

void creation_bouclier(){
  if(mousePressed == true && mouseY < 470 && selection_arme_principale == 0 && clique_inventaire == 0){
    if(cree_bouclier == 0){
      for(int i = 0; i < 20;i++){
        if(bouclier[i].vie <= 0){
          n_bouclier = i;
          i = 21;
        } 
      }
      bouclier[n_bouclier].x1 = mouseX;  
      bouclier[n_bouclier].y1 = mouseY;
      cree_bouclier = 1;
    }
    else if(cree_bouclier == 1){
      stroke(10,120,175);
      int prix = abs(mouseX/10 - bouclier[n_bouclier].x1/10);
      if(prix > point){
        stroke(255,0,0);  
      }
      
      textSize(20);
      fill(0);
      text("-"+prix,mouseX - 10,bouclier[n_bouclier].y1 - 10);
      strokeWeight(7);
      line(bouclier[n_bouclier].x1,bouclier[n_bouclier].y1,mouseX,bouclier[n_bouclier].y1);
      strokeWeight(1);
      
    }      
  }
  
  if(mousePressed == false && cree_bouclier == 1 && mouseY < 470){
    
    int prix = abs(mouseX/10 - bouclier[n_bouclier].x1/10);
    
    if(prix <= point){
      
      if(mouseX < bouclier[n_bouclier].x1){
        bouclier[n_bouclier].x2 = bouclier[n_bouclier].x1;
        bouclier[n_bouclier].x1 = mouseX;
      }
      else{
        bouclier[n_bouclier].x2 = mouseX;  
      }
      bouclier[n_bouclier].y2 = bouclier[n_bouclier].y1;  
      bouclier[n_bouclier].vie = 50; 
    
    
      point -= prix;
      if(bouclier_mis_tuto == 0){
        bouclier_mis_tuto = 1;
      }
    
      
    }
    else{
      bouclier[n_bouclier].vie = 0;   
      
    }
    cree_bouclier = 0;
  }
  
}

void affiche_bouclier(){
  for(int i = 0; i < 20;i++){
    if(bouclier[i].vie > 0){
      stroke(10,120,175);
      strokeWeight(7);
      line(bouclier[i].x1,bouclier[i].y1,bouclier[i].x2,bouclier[i].y2);
      strokeWeight(1);
      
      fill(0);
      stroke(0);
      
      if(bouclier[i].vie < 50){
        rect(bouclier[i].x1 - 10,bouclier[i].y1 - 10,20,5);
        
        fill(0,255,0);
        if(bouclier[i].vie < 0)bouclier[i].vie = 0;
        
        rect(bouclier[i].x1 - 10,bouclier[i].y1 - 10,map(bouclier[i].vie,0,50,0,20),5);
      }
    }
    
  }
  
  
}

void affiche_message(){
  fill(255,255,255,150);
  rect(100,0,400,50);  
  textSize(15);
  fill(0);
  text(message,105,18);
  if(nb_arme_principale > 0 && bouclier_mis_tuto == 0){
    message = "Bravo!!! Vous pouvez aussi créer des boucliers en\ncliquant la ou vous voulez et en glissant le curseur";  
    
  }  
  if(bouclier_mis_tuto == 1){
    bouclier_mis_tuto = 2;  
    message = "Vous êtes un As!!!, mais prenez garde,\nla difficultée augmente!!! Bonne chance!!!";
    tmp_message = 3000;
  }
  if(tmp_message > 0){
    tmp_message--;
    if(tmp_message == 0){
      int n = round(random(1,5));
      switch(n){
        case 1:
          message = "C'est super, les habitants de la ville croit en vous!!!\nVous allez sauver la terre!!!";
          break;
        case 2:
          message = "Courage, vous y êtes presque.";
          break;
        case 3:
          message = "Pensez à sécuriser vos canon les plus précieux";
          break;
        case 4:
          message = "Il vaux mieux mettre plusieurs petit bouclier\nque un seul grand.";
          break;
        case 5:
          message = "Le canon bleu est plus efficace. \nEconomiser votre argent pour en acheter un.";
          break;
      }
        
      tmp_message = -1;
    }
    
  }
  if(game_over > 0){
    game_over--;
    message = "Mince, vous avez perdu, la ville est détruite.\nScore: "+score;
    
  }
  if(game_over == 0){

    while(true);  
  }
  
}