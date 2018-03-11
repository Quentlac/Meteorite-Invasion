
Arme[] arme = new Arme[50];
Meteorite[] meteorite = new Meteorite[1000];
Balle[] balle = new Balle[2000];
Bouclier[] bouclier = new Bouclier[20];

class Arme {
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
  int arme;
  int active = 0;
  
}

class Bouclier{
  int x1;
  int y1;
  
  int x2;
  int y2;
  
  int vie = 0;
  
}

int nb_balle = 0;

int nb_arme = 0;

int selection_arme = 0;

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

void setup(){
  size(500,550);
  
  for (int i = 0; i < 50; i++) {
    arme[i] = new Arme();
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
  
  for (int i = 0; i < 20; i++) {
    bouclier[i] = new Bouclier();
    
  }
  
  
}


void draw(){
  background(200); 
  
  affiche_barre_arme();
  affiche_inventaire();
  
  selectionne_arme();
  affiche_arme();
  
  affiche_meteorite();
  mv_meteorite();
  
  regene_arme();
  
  disp_meteorite();
  orientation_canon_arme();
  
  tir_arme();
  affiche_balle();
  
  mv_balle();
  
  affiche_vie_ville();
  
  creation_bouclier();
  affiche_bouclier();
  affiche_message();
  
  fill(0);
  textSize(20);
  text(point,10,20);
  
  /*for(int i = 0; i < nb_arme;i++){
    float x = mouseX - arme[i].x;
    float y = mouseY - arme[i].y + 1;
    
    if(mouseY <= arme[i].y){
      arme[i].angle_tir = 360 - atan(x/y) * 180 / PI;
    }
    else{
      arme[i].angle_tir = 180 - atan(x/y) * 180 / PI;  
    }
    
    line(arme[i].x,arme[i].y,arme[i].x,mouseY);
    line(arme[i].x,arme[i].y,mouseX,mouseY);
    line(arme[i].x,mouseY,mouseX,mouseY);
  }*/
  
  
  if(vie_ville <= 0){
    println("Vous avez perdu");
    print("score: ");
    println(score);
    if(game_over == -1){
      game_over = 3;
    }
  }
}

void affiche_inventaire(){
  fill(255);
  stroke(0);
  
  rect(0,500,500,50);
  
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
  
}

void selectionne_arme(){
  if(mousePressed == false)clique_inventaire = 0;
  if(mousePressed == true){
    if(selection_arme == 0 && mouseY >= 500){
      clique_inventaire = 1;
      selection_arme = mouseX / 166 + 1;
      if(selection_arme == 1 && point < 30){
        selection_arme = 0;
        message = "Mince!!!, vous n'avez pas assez de sous, détruiser les\nmétéorites pour en gagner ;)";
        tmp_message = 1000;
      }
      
      if(selection_arme == 2 && point < 75){
        selection_arme = 0;
        message = "Mince!!!, vous n'avez pas assez de sous, détruiser les\nmétéorites pour en gagner ;)";
        tmp_message = 1000;
      }
      
      
      
      if(selection_arme == 3 && point < 400){
        selection_arme = 0;
        message = "Mince!!!, vous n'avez pas assez de sous, détruiser les\nmétéorites pour en gagner ;)";
        tmp_message = 1000;
      }
      
      
    }
    else if(selection_arme != 0){
        
      stroke(0);
      fill(50);
      rect(mouseX-5,mouseY,10,500-mouseY);  
      
      if(selection_arme == 1)fill(255,0,0);  
      if(selection_arme == 2)fill(0,255,0); 
      if(selection_arme == 3)fill(0,0,255); 
      
      for(int i = 0; i < nb_arme;i++){
        if(mouseX + 25 > arme[i].x - 25 && mouseX - 25 < arme[i].x + 25){
          if(mouseY + 25 > arme[i].y - 25 && mouseY - 25 < arme[i].y + 25){
            stroke(255,0,0);  
          }
        }
      }
      
      ellipse(mouseX,mouseY,50,50);
      
      stroke(0);
    }
  }
  
  if(mousePressed == false && selection_arme != 0){
    clique_inventaire = 0; 
    int libre = 1;
    for(int i = 0; i < nb_arme;i++){
      if(mouseX + 25 > arme[i].x - 25 && mouseX - 25 < arme[i].x + 25){
        if(mouseY + 25 > arme[i].y - 25 && mouseY - 25 < arme[i].y + 25){
          libre = 0;
        }
      }
    }
    if(libre == 1){
      if(selection_arme == 1 && point >= 30){
        point -= 30;  
      }
      if(selection_arme == 2 && point >= 75){
        point -= 75;  
      }
      if(selection_arme == 3 && point >= 400){
        point -= 400;  
      }
      arme[nb_arme].x = mouseX;
      arme[nb_arme].y = mouseY;
    
      arme[nb_arme].type = selection_arme;
      nb_arme++;
      //println(mouseX);
    }
    
    selection_arme = 0;
  }  
}

void affiche_arme(){
  for(int i = 0; i < nb_arme;i++){
    
    stroke(0);
    fill(0);
    
    rect(arme[i].x - 50,arme[i].y - 10,20,5);
    
    fill(0,255,0);
    if(arme[i].vie < 0)arme[i].vie = 0;
    
    rect(arme[i].x - 50,arme[i].y - 10,map(arme[i].vie,0,100,0,20),5); 
    
    fill(0);
    
    pushMatrix();
    translate(arme[i].x,arme[i].y);
    rotate(PI * arme[i].angle_tir / 180);
    rect(-10,0,20,-40);
    popMatrix();
    
    
        
    if(arme[i].type == 1)fill(255,0,0);  
    if(arme[i].type == 2)fill(0,255,0); 
    if(arme[i].type == 3)fill(0,0,255); 
    
    if(arme[i].vie < 10)fill(50,50,50);
    
    ellipse(arme[i].x,arme[i].y,50,50);
    
       
     
    
  } 
}

void regene_arme(){
  for(int i = 0; i < nb_arme;i++){
    if(arme[i].vie < 100){
      arme[i].vie += 0.05;  
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
    
    for(int j = 0; j < nb_arme;j++){
      if(meteorite[i].x > arme[j].x - 25 && meteorite[i].x < arme[j].x + 25){
        if(meteorite[i].y > arme[j].y - 25 && meteorite[i].y < arme[j].y + 25){
          if(arme[j].vie > 10){
            arme[j].vie -= 25;  
            meteorite[i].y = 0 - round(random(50,500));
            meteorite[i].x = round(random(10,490));
          }
        }
      }
    }
    
  }
  
}

void disp_meteorite(){
  println(level);
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

void orientation_canon_arme(){
  for(int i = 0; i < nb_arme;i++){
    if(arme[i].vie > 10){
      float distance_min = 10000; 
      int meteorite_proche = -1;
      for(int j = 0; j < nb_meteorite;j++){
        float distance = 0;
        
        float x = meteorite[j].x - arme[i].x;
        float y = meteorite[j].y - arme[i].y;  
        
        distance = sqrt(x*x+y*y);
        
        if(distance < distance_min){
          distance_min = distance;  
          meteorite_proche = j;
        }
      } 
      
      float x = meteorite[meteorite_proche].x - arme[i].x;
      float y = (meteorite[meteorite_proche].y + 50) - arme[i].y + 1;
      
      if(meteorite[meteorite_proche].y < arme[i].y){
        arme[i].angle_tir = 360 - atan(x/y) * 180 / PI;
      }
      else{
        arme[i].angle_tir = 180 - atan(x/y) * 180 / PI;  
      }
    }
  }
}

void tir_arme(){
  for(int i = 0; i < nb_arme;i++){
    int cadence = 0;
    switch(arme[i].type){
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
    if(millis() - arme[i].tmp_tir > cadence && arme[i].vie > 10){
      arme[i].tmp_tir = millis();
      int nballe;
      for(nballe = 0; balle[nballe].active == 1;nballe++);  
      balle[nballe].x = 50;
      balle[nballe].direction = arme[i].angle_tir + 270;
      balle[nballe].arme = i;
      balle[nballe].active = 1;
    }
    
  } 
}

void affiche_balle(){
  for(int i = 0; i < 50;i++){
    if(balle[i].active == 1){
      pushMatrix();
      translate(arme[balle[i].arme].x,arme[balle[i].arme].y);
      rotate(PI * balle[i].direction / 180);
      fill(255,255,0);
      stroke(0);
      ellipse(balle[i].x,0,10,10);
      popMatrix(); 
      
      float x = balle[i].x * sin(PI * (balle[i].direction - 270) / 180);
      float y = sqrt(balle[i].x * balle[i].x - x * x);
      
      fill(255,0,0);
      
      x = arme[balle[i].arme].x + x;
      
      if((balle[i].direction-270 > 0 && balle[i].direction-270 < 270)){
        y = arme[balle[i].arme].y + y;
      }
      else{
        y = arme[balle[i].arme].y - y; 
      }
      
      //test_collision
      
      for(int j = 0; j < nb_meteorite;j++){
        if(meteorite[j].y > 10){
          if(x > meteorite[j].x - 15 && x < meteorite[j].x + 15){
            if(y > meteorite[j].y - 15 && y < meteorite[j].y + 15){ 
              balle[i].active = 0; 
              if(arme[balle[i].arme].type == 1){
                meteorite[j].vie -= 3;
              }
              if(arme[balle[i].arme].type == 2){
                meteorite[j].vie -= 8;
              }
              if(arme[balle[i].arme].type == 3){
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

void mv_balle(){
  for(int i = 0; i < 50;i++){
    if(balle[i].active == 1){
      balle[i].x+=4;  
      if(balle[i].x > 500){
        balle[i].active = 0;
        
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

void affiche_barre_arme(){
  for(int i = 0; i < nb_arme;i++){
    stroke(0);
    fill(50);
    rect(arme[i].x-5,arme[i].y,10,500-arme[i].y);  
    
  }
}

void creation_bouclier(){
  if(mousePressed == true && mouseY < 500 && selection_arme == 0 && clique_inventaire == 0){
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
  
  if(mousePressed == false && cree_bouclier == 1){
    
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
  if(nb_arme > 0 && bouclier_mis_tuto == 0){
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