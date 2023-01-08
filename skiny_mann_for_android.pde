

//void settings(){
   
  /*fs=rez.getBoolean("full_Screen");
  if(!fs){
   vres = rez.getInt("v-res");
   hres = rez.getInt("h-res");
   Scale=rez.getFloat("scale");
  size(hres,vres);
  }else{*/
   
  //}
  
//}



void setup(){
  settings =loadJSONArray("settings.json");
  orientation(LANDSCAPE); 
  fullScreen();
   fs=true;
 frameRate(60);
 if(fs){
   hres=width;
   vres=height;
   Scale=vres/720.0;
 }
 Scale2=hres/1280.0;
 println(height);

 CBi = loadImage("CBi.png");
 CBi.resize((int)(500*Scale),(int)(500*Scale));
 tnit = loadImage("bloor.png");
 icon = loadImage("skinny mann face.PNG");
 //surface.setIcon(icon);
 tnit.resize((int)(1920*Scale),(int)(1080*Scale));
 RB = loadImage("right_button.png");
 RB.resize((int)(250*Scale2),(int)(720*Scale));
 LB = loadImage("left_button.png");
 LB.resize((int)(250*Scale2),(int)(720*Scale));
 
 JSONObject scroll=settings.getJSONObject(0);
 
 scroll_left = scroll.getInt("value_left");
 scroll_right = scroll.getInt("value_right");

 

 if(dev_mode){
  menue=false;
  inGame=true;
  level="LEVEL_2";
  player1[0] = 20094;
  player1[1] = 600;
  camPos=19000;
}

}
PImage tnit,CBi,icon,RB,LB;
//Server s;
//Client c;
boolean menue =true,inGame=false,player1_moving_right=false,player1_moving_left=false,dev_mode=false,player1_jumping=false,dead=false,level_complete=false,start_host=false,entering_port=false,entering_name=false,entering_ip=false,hosting=false,joined=false,start_join=false,reset_spawn=false,fs;
String Menue ="creds",level="n",version="0.0.0.5_BETA",ip="localhost",name="can't_be_botherd_to_chane_it",input,outher_name;
int player1 []={20,700,1,0,1,0},player2 []={20,700,0,0,1,0};
float Scale =1,Scale2=1;
/*
players by index position
0  xpos
1  ypos
2  animation state
3  animation delay count
4  size scale factor
5  jump cool down

*/

int level1_terain[]={0,700,700,20,  800,700,1000,20,  900,660,50,40,    970,600,80,20,     1100,570,80,20,    1250,575,80,20,     1390,550,80,20,         1530,510,80,20,     1650,480,80,20,    1800,450,80,20,     1950,400,1000,320,    3050,400,1000,320,    2930,320,20,80,     2910,340,20,60,     2890,360,20,40,     2870,380,20,20,    3050,320,20,80,     3070,340,20,60,      3090,360,20,40,     3110,380,20,20,   2332,270,30,30,     2392,270,30,30,     2452,270,30,30,     2392,200,30,30,      3784,300,80,20,      3984,280,80,20,      4164,260,80,20,      4340,280,80,20,
//                   0  1   2   3    4    5   6   7    8   9  10 11      12  13 14 15       16  17 18 19       20   21 22 23       24 25  26 27            28  29  30 31        32 33  34 35      36   37  38 39      40   41  42  43        44 45   46   47     48   49  50 51       52   53 54 55       56  57  58 59      60   61  62 63      64   65 66 67      68   69  70 71        72  73  74 75       76  77  78 79    80   81  82 83      84   85  86 87      88   89  90 91  9   92   93  94 95       96   97  98 99       100  101 102 103     104  105 106 107     108 109 110 111 
4490,320,80,20,      4552,700,700,20,      4650,360,80,20,      4800,340,80,20,      4950,360,80,20,      5100,400,80,20,      5250,400,80,20,      5430,390,800,330,      6280,290,80,20,      6440,320,80,20,      6620,360,80,20,      6800,390,80,20,      6980,360,80,20,      7150,390,80,20,      7300,420,80,20,      7450,450,80,20,      7600,480,80,20,      7750,520,80,20,      7900,570,80,20,      8050,600,80,20,      8300,640,80,20,      8450,660,800,80,      9250,120,800,600,      8550,420,700,20,      8450,220,700,20,      8430,100,20,400,      9000,530,80,20,
//112 113 114 115    116  117 118 119      120 121 122 123      124  125  126 127    128 129 130 131      132  133 134 135     136 137 138 139      140 141 142 143        144 145 146 147      148  149 150 151     152 153 154 155      156 157 158 159      160 161 162 163 
9170,600,80,60,      8880,530,80,20,      8760,530,80,20,      8640,530,80,20,      8520,530,80,20,      8450,460,40,20,      9000,360,80,60,      9150,330,100,90,      9200,300,50,90,      8500,150,80,20,      8650,90,80,20,      8800,90,80,20,      8950,90,80,20,      9100,90,80,20};

int camPos=0,death_cool_down,start_down,port=9367,scroll_left,scroll_right,respawnX=20,respawnY=700,spdelay=0,vres,hres;
JSONArray loaded_level, settings;

//▄
void draw(){
  /*
  if(hosting){
    String sending = "game state§"+inGame+"§"+level+"§"+name+"§spawn settings§"+reset_spawn+"§"+respawnX+"§"+respawnY+"§player§"+player1[0]+"§"+player1[1]+"§"+player1[2]+"§"+player1[3]+"§"+player1[4]+"§"+player1[5]+"§dud";
   s.write(sending); 
   c=s.available(); 
   if (c != null) {
     input = c.readString();
     String[] data =input.split("§");
     
     if(spdelay<5){
       reset_spawn=true;
       spdelay++;
     }else{
       reset_spawn=false;
     }
     
     for(int i=0;i<data.length;i++){
      if(data[i].equals("name")){
        outher_name=data[++i];
      }
      if(data[i].equals("player")){
        player2[0]=Integer.parseInt(data[++i]);
        player2[1]=Integer.parseInt(data[++i]);
        player2[2]=Integer.parseInt(data[++i]);
        player2[3]=Integer.parseInt(data[++i]);
        player2[4]=Integer.parseInt(data[++i]);
        player2[5]=Integer.parseInt(data[++i]);
      }
      
     }
   }
  }
  if(joined){
    String sending ="name§"+name+"§player§"+player2[0]+"§"+player2[1]+"§"+player2[2]+"§"+player2[3]+"§"+player2[4]+"§"+player2[5]+"§DUD";
   c.write(sending); 
   if (c.available() > 0){
      input = c.readString();
     
     String[] data =input.split("§");
    
     for(int i=0;i<data.length;i++){
      if(data[i].equals("game state")){
        inGame=data[++i].equals("true");
        level=data[++i];
        outher_name=data[++i];
      }
      if(data[i].equals("player")){
        player1[0]=Integer.parseInt(data[++i]);
        player1[1]=Integer.parseInt(data[++i]);
        player1[2]=Integer.parseInt(data[++i]);
        player1[3]=Integer.parseInt(data[++i]);
        player1[4]=Integer.parseInt(data[++i]);
        player1[5]=Integer.parseInt(data[++i]);
      }
      if(data[i].equals("spawn settings")){
        if(data[++i].equals("true")){
          respawnX=Integer.parseInt(data[++i]);
          player2[0]=Integer.parseInt(data[i]);
          respawnY=Integer.parseInt(data[++i]);
          player2[1]=Integer.parseInt(data[i]);
        }
      }
     }
     
     if(!inGame){
       if(level_complete){
         player2[0]=20;
         player2[1]=700;
         camPos=0;
       }
      level_complete=false; 
      Menue="multy_player";
     }
     
 
     }
  }
  */
  
  if(inGame&&!menue){
    boolean yes=false;
      for (int i = 0; i < touches.length; i++) {
        yes=true;
      if(touches[i].x>=0 && touches[i].x <= Scale2*250 && touches[i].y >=0 && touches[i].y <= 720*Scale){
        player1_moving_right=true;
      }
      if(touches[i].x>=hres-Scale2*250 && touches[i].x <= hres && touches[i].y >=0 && touches[i].y <= 720*Scale){
        player1_moving_left=true;
      }
      if(touches[i].x>= Scale2*250 && touches[i].x <= hres-Scale2*250 && touches[i].y >=0 && touches[i].y <= 720*Scale){
        player1_jumping=true;
      }
      println(touches[i].x+" "+touches[i].y);
      }
      if(yes){
       println("================"); 
      }
    }
    
  if(menue){//when in a menue
    if(Menue.equals("creds")){
      image(CBi,390*Scale,0*Scale);
      
      fill(74,250,0);
      textSize(200*Scale);
      text("GAMES",300*Scale,700*Scale);
      start_down++;
      if(start_down==100){
        Menue="main";
      }
    }
     if(Menue.equals("main")){//if on main menue
        background(#74ABFF);
        textSize(50*Scale);
        fill(0);
        text("skinny mann",484*Scale,154*Scale);
        textSize(35*Scale);
        fill(-16732415);
        stroke(-16732415);
        rect(0*Scale,360*Scale,1280*Scale,360*Scale);
        fill(255,25,0);
        stroke(255,249,0);
        strokeWeight(10*Scale);
        rect(540*Scale,310*Scale,200*Scale,50*Scale);//play button
        fill(0);
        text("play",600*Scale,350*Scale);
        fill(255,25,0);
       // rect(540*Scale,390*Scale,200*Scale,50*Scale);
       // rect(540*Scale,470*Scale,200*Scale,50*Scale);
        rect(540*Scale,550*Scale,200*Scale,50*Scale);
        rect(540*Scale,630*Scale,200*Scale,50*Scale);
        fill(0);
       // text("join",600*Scale,430*Scale);
       // text("exit",600*Scale,510*Scale);//exit button
        text("settings",580*Scale,590*Scale);
        text("how to play",543*Scale,670*Scale);
        fill(255);
        textSize(10*Scale);
        text(version,0*Scale,718*Scale);
        
     }
     if(Menue.equals("level select")){//if selecting level
       strokeWeight(10*Scale);
        background(#74ABFF);
        textSize(35*Scale);
        fill(-16732415);
        stroke(-16732415);
        rect(0*Scale,360*Scale,1280*Scale,360*Scale);
        textSize(50*Scale);
        fill(0);
        text("Level Select",484*Scale,54*Scale);
        fill(-15235840);
        stroke(-15208447);
        rect(40*Scale,200*Scale,130*Scale,200*Scale);
        rect(240*Scale,200*Scale,130*Scale,200*Scale);
        rect(440*Scale,200*Scale,130*Scale,200*Scale);
        rect(640*Scale,200*Scale,130*Scale,200*Scale);
        rect(840*Scale,200*Scale,130*Scale,200*Scale);
        fill(255,25,0);
        stroke(255,249,0);
        strokeWeight(10*Scale);
        rect(40*Scale,610*Scale,200*Scale,50*Scale);////////////////////////////////////////////////////////
       // rect(280*Scale,610*Scale,200*Scale,50*Scale);
        fill(0);
        text("back",60*Scale,655*Scale);
        textSize(30*Scale);
       // text("open to LAN",290*Scale,655*Scale);
        textSize(50*Scale);
        text("1-1",60*Scale,300*Scale);
        text("level_2",260*Scale,300*Scale);
        textSize(30*Scale);
        text("off the \ngrid \nmadness",450*Scale,290*Scale);
        text("coming\n soon",660*Scale,300*Scale);
        text("coming\n soon",860*Scale,300*Scale);
        
     }
     if(Menue.equals("pause")){
       player1_moving_right=false;
       player1_moving_left=false;
       player1_jumping=false;
     }
     
     if(Menue.equals("multy_player")){
       background(#00CCFC);
       fill(0);
       textSize(100);
       text("host is in menue \npleas wait",100,300);
     }
     
     if(Menue.equals("settings")){
      background(#74ABFF); 
      fill(255);
      stroke(0);
      strokeWeight(5*Scale);
      rect(1200*Scale,50*Scale,40*Scale,40*Scale);
      rect(1130*Scale,50*Scale,40*Scale,40*Scale);
      //rect(1200*Scale,120*Scale,40*Scale,40*Scale);
      //rect(1130*Scale,120*Scale,40*Scale,40*Scale);
      //rect(1060*Scale,120*Scale,40*Scale,40*Scale);
      //rect(920*Scale,120*Scale,40*Scale,40*Scale);
      //rect(990*Scale,120*Scale,40*Scale,40*Scale);
      //rect(1200*Scale,190*Scale,40*Scale,40*Scale);
      //rect(1130*Scale,190*Scale,40*Scale,40*Scale);
      //rect(1060*Scale,190*Scale,40*Scale,40*Scale);
      fill(0);
      textSize(40*Scale);
      text("screen scrolling location",40*Scale,90*Scale);
      //text("verticle screen resolution (requires restart)",40*Scale,150*Scale);
      //text("full screen (requires restart)",40*Scale,210*Scale);
      textSize(20*Scale);
      text("noob",1120*Scale,40*Scale);
      text("normal",1180*Scale,40*Scale);
      //text("2160(4K)",1190*Scale,115*Scale);
      //text("1440",1120*Scale,115*Scale);
      //text("1080",1055*Scale,115*Scale);
      //text("900",990*Scale,115*Scale);
      //text("720",920*Scale,115*Scale);
      /*
      text("32:9",1190*Scale,185*Scale);
      text("16:9",1120*Scale,185*Scale);
      text("16:10",1055*Scale,185*Scale);
      */
      //text("yes",1190*Scale,185*Scale);
      //text("no",1120*Scale,185*Scale);

     settings =loadJSONArray("settings.json");
     if(true){
       JSONObject scroll=settings.getJSONObject(0);
       scroll_left = scroll.getInt("value_left");
       scroll_right = scroll.getInt("value_right");
       String lable = scroll.getString("lable");
       stroke(255,0,0);
       if(lable.equals("normal")){
         line(1205*Scale,70*Scale,1220*Scale,85*Scale);
         line(1245*Scale,55*Scale,1220*Scale,85*Scale);
       }
       if(lable.equals("noob")){
         line(1135*Scale,70*Scale,1150*Scale,85*Scale);
         line(1175*Scale,55*Scale,1150*Scale,85*Scale);
       }
     } 
     
     /*if(true){
       JSONObject rez=settings.getJSONObject(1);
       int vres = rez.getInt("v-res");
     //  String arat = rez.getString("aspect ratio");
       boolean fus = rez.getBoolean("full_Screen");
       
       if(vres==720){
         line(925*Scale,140*Scale,940*Scale,155*Scale);
         line(965*Scale,125*Scale,940*Scale,155*Scale  );
       }
       if(vres==900){
         line(995*Scale,140*Scale,1010*Scale,155*Scale);
         line(1035*Scale,125*Scale,1010*Scale,155*Scale);
       }
       if(vres==1080){
         line(1065*Scale,140*Scale,1080*Scale,155*Scale);
         line(1105*Scale,125*Scale,1080*Scale,155*Scale);
       }
       if(vres==1440){
         line(1135*Scale,140*Scale,1150*Scale,155*Scale);
         line(1175*Scale,125*Scale,1150*Scale,155*Scale);
       }
       if(vres==2160){
         line(1205*Scale,140*Scale,1220*Scale,155*Scale);
         line(1245*Scale,125*Scale,1220*Scale,155*Scale);
       }
       /*
       if(arat.equals("16:10")){
         line(1065*Scale,210*Scale,1080*Scale,225*Scale);
         line(1105*Scale,195*Scale,1080*Scale,225*Scale);
       }
       if(arat.equals("16:9")){
         line(1135*Scale,210*Scale,1150*Scale,225*Scale);
         line(1175*Scale,195*Scale,1150*Scale,225*Scale);
       }
       if(arat.equals("32:9")){
         line(1205*Scale,210*Scale,1220*Scale,225*Scale);
         line(1245*Scale,195*Scale,1220*Scale,225*Scale);
       }
       *
       if(!fus){
         line(1135*Scale,210*Scale,1150*Scale,225*Scale);
         line(1175*Scale,195*Scale,1150*Scale,225*Scale);
       }else{
         line(1205*Scale,210*Scale,1220*Scale,225*Scale);
         line(1245*Scale,195*Scale,1220*Scale,225*Scale);
       }*/
     //}
     
         fill(255,25,0);
        stroke(255,249,0);
        strokeWeight(10*Scale);
        rect(40*Scale,610*Scale,200*Scale,50*Scale);////////////////////////////////////////////////////////
        fill(0);
        textSize(50*Scale);
        text("back",60*Scale,655*Scale);
   }
   if(Menue.equals("how to play")){
     background(#4FCEAF);
     fill(0);
     textSize(60);
     text("to move left or right press the \ncorresponding button on the screen\nto jump tap antwhere that is not a left/right \nbutton\n(the longer you hold the higher you will go)\ngoal: get the the finishline at the \nend of the level",100,100);
     fill(255,25,0);
      stroke(255,249,0);
     strokeWeight(10);
     rect(40,610,200,50);
     fill(0);
     textSize(50);
     text("back",60,655);
   }
   
  }
  if(inGame){
     if(level.equals("1-1")){
       strokeWeight(0);
        background(#74ABFF);
        fill(-16732415);
        stroke(-16732415);
        
        int itwe=0,xpos =level1_terain[itwe]-camPos,t1=level1_terain[++itwe],t2=level1_terain[++itwe],t3=level1_terain[++itwe];
        rect(xpos*Scale,t1*Scale,t2*Scale,t3*Scale);//terain
        xpos =level1_terain[++itwe]-camPos;t1=level1_terain[++itwe];t2=level1_terain[++itwe];t3=level1_terain[++itwe];
        rect(xpos*Scale,t1*Scale,t2*Scale,t3*Scale);
        fill(145,77,0);
        stroke(145,77,0);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        fill(-16732415);
        stroke(-16732415);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale); 
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        fill(145,77,0);
        stroke(145,77,0);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        fill(-16732415);
        stroke(-16732415);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        fill(145,77,0);
        stroke(145,77,0);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        fill(-16732415);
        stroke(-16732415);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        fill(145,77,0);
        stroke(145,77,0);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        fill(-16732415);
        stroke(-16732415);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        fill(145,77,0);
        stroke(145,77,0);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        xpos =level1_terain[++itwe]-camPos;
        rect(xpos*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale,level1_terain[++itwe]*Scale);
        
        fill(255);
        stroke(255);
        rect((9700-camPos)*Scale,120*Scale,50*Scale,50*Scale);
        rect((9800-camPos)*Scale,120*Scale,50*Scale,50*Scale);
        rect((9900-camPos)*Scale,120*Scale,50*Scale,50*Scale);
        rect((10000-camPos)*Scale,120*Scale,50*Scale,50*Scale);
        fill(0);
        stroke(0);
        rect((9750-camPos)*Scale,120*Scale,50*Scale,50*Scale);
        rect((9850-camPos)*Scale,120*Scale,50*Scale,50*Scale);
        rect((9950-camPos)*Scale,120*Scale,50*Scale,50*Scale);
        
        
        if(joined){
          
          if(dead){
            xpos=player2[0]-camPos;
          draw_mann(xpos*Scale,player2[1]*Scale,player2[2],player2[4]*Scale,"green");
          xpos=player1[0]-camPos;
          int top=player1[1]-78;
          textSize(10*Scale);
          fill(0);
          text(outher_name,xpos*Scale,top*Scale);
          draw_mann(xpos*Scale,player1[1]*Scale,player1[2],player1[4]*Scale,"red");
          }else{
          if(player2[0] >= 9700 && player2[0] <= 10000 && player2[1] >= 100 && player2[1] <= 200){
          level_complete=true;
        }
        
        
        xpos=player2[0]-camPos;
        draw_mann(xpos*Scale,player2[1]*Scale,player2[2],player2[4]*Scale,"green");//draw the player
        if(xpos>scroll_right){//camera scrolling
         camPos+=4; 
        }
        if(xpos<scroll_left&&camPos>0){//camera scrolling
         camPos-=4; 
        }
        
        //movement         ===========================================================================
        if(!player1_moving_left&&!player1_moving_right){
          player2[2]=1;
        }
        
        if(player1_moving_left){
          int temp=player2[0]-4,temp2=player2[1]-1;
          if(!level1_hit_box_chek(temp,temp2)){
          player2[0]-=4; //move left
          }
           
           if(player2[3]==0){//animate the leggs
             player2[2]--;
             if(player2[2]==0){
                player2[2]=12; 
             }
           }
           player2[3]++;
           if(player2[3]==4){
             player2[3]=0;
           }
           
        }
        if(player1_moving_right){
          int temp=player2[0]+4,temp2=player2[1]-1;
          if(!level1_hit_box_chek(temp,temp2)){
           player2[0]+=4;//move right
          }
           
           if(player2[3]==0){//animate the leggs
             player2[2]++;
             if(player2[2]==13){
                player2[2]=1; 
             }
           }
           player2[3]++;
           if(player2[3]==4){
             player2[3]=0;
           }
        }//==================================
        //gravity
        if(player1_jumping){
          if(player2[5]<=20){
            int tempy=player2[1]-75;
            if(level1_hit_box_chek(player2[0],tempy)){
              player2[5]=21;
            }else{
            player2[1]-=5;
            player2[5]++;
            }
          }else if(player2[5]<=25){
            player2[5]++;
          }else{
            int tempy=player2[1];//gravity
            tempy+=1;
           if(!level1_hit_box_chek(player2[0],tempy)){
             player2[1]+=5;
           }else{
            player2[5]=0; 
           }
          }
        }else{
          int tempy=player2[1];//gravity
          tempy+=1;
         if(!level1_hit_box_chek(player2[0],tempy)){
           player2[1]+=5;
           player2[5]=120;
         }else{
          player2[5]=0; 
         }
        }
        //================================================================================================
        if(player2[1]>720){
         dead=true;
         menue=false;
          // inGame=false;
           level="1-1";
           player2[0]=20;
           player2[1]=700;
         death_cool_down=0;
         player2[2]=1;
        }
          
          
         xpos=player1[0]-camPos;
         int top=player1[1]-78;
         textSize(10);
         fill(0);
          text(outher_name,xpos,top);
          draw_mann(xpos*Scale,player1[1]*Scale,player1[2],player1[4]*Scale,"red");
          }}else{
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        if(dead){
            xpos=player2[0]-camPos;
             if(hosting){
            int top=player2[1]-78;
            textSize(10*Scale);
            fill(0);
          text(outher_name,xpos*Scale,top*Scale);
             }
          draw_mann(xpos*Scale,player2[1]*Scale,player2[2],player2[4]*Scale,"green");
          xpos=player1[0]-camPos;
          draw_mann(xpos*Scale,player1[1]*Scale,player1[2],player1[4]*Scale,"red");
          }else{
        
        if(player1[0] >= 9700 && player1[0] <= 10000 && player1[1] >= 100 && player1[1] <= 200){
          level_complete=true;
        }
        
        if(hosting){
          xpos=player2[0]-camPos;
          if(outher_name!=null){
          int top=player2[1]-78;
          textSize(10);
          fill(0);
          text(outher_name,xpos,top);
          }
        draw_mann(xpos*Scale,player2[1]*Scale,player2[2],player2[4]*Scale,"green");
        }
        xpos=player1[0]-camPos;
        draw_mann(xpos*Scale,player1[1]*Scale,player1[2],player1[4]*Scale,"red");//draw the player
        if(xpos>scroll_right){//camera scrolling
         camPos+=4; 
        }
        if(xpos<scroll_left&&camPos>0){//camera scrolling
         camPos-=4; 
        }
        
        //movement         ===========================================================================
        if(!player1_moving_left&&!player1_moving_right){
          player1[2]=1;
        }
        
        if(player1_moving_left){
          int temp=player1[0]-4,temp2=player1[1]-1;
          if(!level1_hit_box_chek(temp,temp2)){
          player1[0]-=4; //move left
          }
           
           if(player1[3]==0){//animate the leggs
             player1[2]--;
             if(player1[2]==0){
                player1[2]=12; 
             }
           }
           player1[3]++;
           if(player1[3]==4){
             player1[3]=0;
           }
           
        }
        if(player1_moving_right){
          int temp=player1[0]+4,temp2=player1[1]-1;
          if(!level1_hit_box_chek(temp,temp2)){
           player1[0]+=4;//move right
          }
           
           if(player1[3]==0){//animate the leggs
             player1[2]++;
             if(player1[2]==13){
                player1[2]=1; 
             }
           }
           player1[3]++;
           if(player1[3]==4){
             player1[3]=0;
           }
        }//==================================
        //gravity
        if(player1_jumping){
          if(player1[5]<=20){
            int tempy=player1[1]-75;
            if(level1_hit_box_chek(player1[0],tempy)){
              player1[5]=21;
            }else{
            player1[1]-=5;
            player1[5]++;
            }
          }else if(player1[5]<=25){
            player1[5]++;
          }else{
            int tempy=player1[1];//gravity
            tempy+=1;
           if(!level1_hit_box_chek(player1[0],tempy)){
             player1[1]+=5;
           }else{
            player1[5]=0; 
           }
          }
        }else{
          int tempy=player1[1];//gravity
          tempy+=1;
         if(!level1_hit_box_chek(player1[0],tempy)){
           player1[1]+=5;
           player1[5]=120;
         }else{
          player1[5]=0; 
         }
        }
        //================================================================================================
        if(player1[1]>720){
         dead=true;
         menue=false;
           //inGame=false;
           level="1-1";
           player1[0]=20;
           player1[1]=700;
         death_cool_down=0;
         player1[2]=1;
        }
          }}
        
        if(level_complete){
          textSize(100*Scale);
         fill(255,255,0);
         text("LEVEL COMPLETE!!!",200*Scale,400*Scale);
         if(!joined){
         fill(255,126,0);
         stroke(255,0,0);
         strokeWeight(10*Scale);
         rect(550*Scale,450*Scale,200*Scale,40*Scale);
         fill(0);
         textSize(40*Scale);
         text("continue",565*Scale,480*Scale);
        }}
        
        
     }
     if(level.equals("test")){
        background(#74ABFF);
        // loaded_level=loadJSONArray("test.json");
         for(int i=0;i<loaded_level.size();i++){
          JSONObject block=loaded_level.getJSONObject(i); 
          String type=block.getString("type");
          int Color = block.getInt("color");
          float x = block.getFloat("x"),y = block.getFloat("y"),dx = block.getFloat("dx"),dy = block.getFloat("dy");
          fill(Color);
          stroke(Color);
          strokeWeight(0);
          if(type.equals("ground")){
           rect((x-camPos)*Scale,y*Scale,dx*Scale,dy*Scale); 
          }
         }
         float xpos;
         if(dead){
            xpos=player2[0]-camPos;
          draw_mann(xpos*Scale,player2[1]*Scale,player2[2],player2[4]*Scale,"green");
          xpos=player1[0]-camPos;
          draw_mann(xpos*Scale,player1[1]*Scale,player1[2],player1[4]*Scale,"red");
          }else{
        
        if(player1[0] >= 9700 && player1[0] <= 10000 && player1[1] >= 100 && player1[1] <= 200){
          level_complete=true;
        }
        
        if(hosting){
          xpos=player2[0]-camPos;
        draw_mann(xpos*Scale,player2[1]*Scale,player2[2],player2[4]*Scale,"green");
        }
        xpos=player1[0]-camPos;
        draw_mann(xpos*Scale,player1[1]*Scale,player1[2],player1[4]*Scale,"red");//draw the player
        if(xpos>scroll_right){//camera scrolling
         camPos+=4; 
        }
        if(xpos<scroll_left&&camPos>0){//camera scrolling
         camPos-=4; 
        }
        
        //movement         ===========================================================================
        if(!player1_moving_left&&!player1_moving_right){
          player1[2]=1;
        }
        
        if(player1_moving_left){
          int temp=player1[0]-4,temp2=player1[1]-1;
          if(!test_level_colide(temp,temp2)){
          player1[0]-=4; //move left
          }
           
           if(player1[3]==0){//animate the leggs
             player1[2]--;
             if(player1[2]==0){
                player1[2]=12; 
             }
           }
           player1[3]++;
           if(player1[3]==4){
             player1[3]=0;
           }
           
        }
        if(player1_moving_right){
          int temp=player1[0]+4,temp2=player1[1]-1;
          if(!test_level_colide(temp,temp2)){
           player1[0]+=4;//move right
          }
           
           if(player1[3]==0){//animate the leggs
             player1[2]++;
             if(player1[2]==13){
                player1[2]=1; 
             }
           }
           player1[3]++;
           if(player1[3]==4){
             player1[3]=0;
           }
        }//==================================
        //gravity
        if(player1_jumping){
          if(player1[5]<=20){
            int tempy=player1[1]-75;
            if(test_level_colide(player1[0],tempy)){
              player1[5]=21;
            }else{
            player1[1]-=5;
            player1[5]++;
            }
          }else if(player1[5]<=25){
            player1[5]++;
          }else{
            int tempy=player1[1];//gravity
            tempy+=1;
           if(!test_level_colide(player1[0],tempy)){
             player1[1]+=5;
           }else{
            player1[5]=0; 
           }
          }
        }else{
          int tempy=player1[1];//gravity
          tempy+=1;
         if(!test_level_colide(player1[0],tempy)){
           player1[1]+=5;
           player1[5]=120;
         }else{
          player1[5]=0; 
         }
        }
        //================================================================================================
        if(player1[1]>720){
         dead=true;
         menue=false;
           //inGame=false;
           level="test";
           player1[0]=20;
           player1[1]=700;
         death_cool_down=0;
         player1[2]=1;
        }
          }
     }
     
     if(level.equals("LEVEL_2")){
       background(#74ABFF);
         //loaded_level=loadJSONArray("level_2.json");
         for(int i=0;i<loaded_level.size();i++){
          JSONObject block=loaded_level.getJSONObject(i); 
          String type=block.getString("type");
          
          strokeWeight(0);
          if(type.equals("ground")){
            int Color = block.getInt("color");
            float x = block.getFloat("x"),y = block.getFloat("y"),dx = block.getFloat("dx"),dy = block.getFloat("dy");
            fill(Color);
            stroke(Color);
           rect((x-camPos)*Scale,y*Scale,dx*Scale,dy*Scale); 
          }
          if(type.equals("check point")){
            float x = block.getFloat("x"),y = block.getFloat("y");
            float playx=player1[0];
            if(playx>=x-3 && playx<= x+3 && y-50 <= player1[1] && y>=player1[1] && !joined){
              respawnX=(int)x;
             respawnY=(int)y;
            }
            playx=player2[0];
            if(playx>=x-3 && playx<= x+3 && y-50 <= player2[1] && y>=player2[1]&&joined){
              respawnX=(int)x;
             respawnY=(int)y;
            }
            
            x-=camPos;
            stroke(#B9B9B9);
            strokeWeight(5*Scale);
            line(x*Scale,y*Scale,x*Scale,(y-60)*Scale);
            fill(#EA0202);
            stroke(#EA0202);
            strokeWeight(0);
            triangle(x*Scale,(y-60)*Scale,x*Scale,(y-40)*Scale,(x+30)*Scale,(y-50)*Scale);
          }
          
          if(type.equals("goal")){
            float x = block.getFloat("x")-camPos,y = block.getFloat("y");
            fill(255);
            stroke(255);
            rect(x*Scale,y*Scale,50*Scale,50*Scale);
            rect((x+100)*Scale,y*Scale,50*Scale,50*Scale);
            rect((x+200)*Scale,y*Scale,50*Scale,50*Scale);
            fill(0);
            stroke(0);
            rect((x+50)*Scale  ,y*Scale,50*Scale,50*Scale);
            rect((x+150)*Scale,y*Scale,50*Scale,50*Scale);
            if(!joined){
               float px =player1[0],py=player1[1];
               
               if(px >= x+camPos && px <= x+camPos + 250 && py >= y - 50 && py <= y + 50){
                level_complete=true; 
               }
            }else{
             float px =player2[0],py=player2[1];
               if(px >= x+camPos && px <= x+camPos + 250 && py >= y - 50 && py <= y + 50){
                level_complete=true; 
               } 
            }
          }
         }
         int xpos;
         if(joined){
          
          if(dead){
            xpos=player2[0]-camPos;
          draw_mann(xpos*Scale,player2[1]*Scale,player2[2],player2[4]*Scale,"green");
          xpos=player1[0]-camPos;
          int top=player1[1]-78;
          textSize(10*Scale);
          fill(0);
          text(outher_name,xpos*Scale,top*Scale);
          draw_mann(xpos*Scale,player1[1]*Scale,player1[2],player1[4]*Scale,"red");
          
        }else{
          
        
        
        xpos=player2[0]-camPos;
        draw_mann(xpos*Scale,player2[1]*Scale,player2[2],player2[4]*Scale,"green");//draw the player
        if(xpos>scroll_right){//camera scrolling
         camPos+=4; 
        }
        if(xpos<scroll_left&&camPos>0){//camera scrolling
         camPos-=4; 
        }
        
        //movement         ===========================================================================
        if(!player1_moving_left&&!player1_moving_right){
          player2[2]=1;
        }
        
        if(player1_moving_left){
          int temp=player2[0]-4,temp2=player2[1]-1;
          if(!level2_colide(temp,temp2)){
          player2[0]-=4; //move left
          }
           
           if(player2[3]==0){//animate the leggs
             player2[2]--;
             if(player2[2]==0){
                player2[2]=12; 
             }
           }
           player2[3]++;
           if(player2[3]==4){
             player2[3]=0;
           }
           
        }
        if(player1_moving_right){
          int temp=player2[0]+4,temp2=player2[1]-1;
          if(!level2_colide(temp,temp2)){
           player2[0]+=4;//move right
          }
           
           if(player2[3]==0){//animate the leggs
             player2[2]++;
             if(player2[2]==13){
                player2[2]=1; 
             }
           }
           player2[3]++;
           if(player2[3]==4){
             player2[3]=0;
           }
        }//==================================
        //gravity
        if(player1_jumping){
          if(player2[5]<=20){
            int tempy=player2[1]-75;
            if(level2_colide(player2[0],tempy)){
              player2[5]=21;
            }else{
            player2[1]-=5;
            player2[5]++;
            }
          }else if(player2[5]<=25){
            player2[5]++;
          }else{
            int tempy=player2[1];//gravity
            tempy+=1;
           if(!level2_colide(player2[0],tempy)){
             player2[1]+=5;
           }else{
            player2[5]=0; 
           }
          }
        }else{
          int tempy=player2[1];//gravity
          tempy+=1;
         if(!level2_colide(player2[0],tempy)){
           player2[1]+=5;
           player2[5]=120;
         }else{
          player2[5]=0; 
         }
        }
        //================================================================================================
        if(player2[1]>720){
         dead=true;
         menue=false;
          // inGame=false;
           level="1-1";
           player2[0]=respawnX;
           player2[1]=respawnY;
         death_cool_down=0;
         player2[2]=1;
        }
          
          
         xpos=player1[0]-camPos;
         int top=player1[1]-78;
         textSize(10*Scale);
         fill(0);
          text(outher_name,xpos*Scale,top*Scale);
          draw_mann(xpos*Scale,player1[1]*Scale,player1[2],player1[4]*Scale,"red");
          }}else{
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        if(dead){
            xpos=player2[0]-camPos;
             if(hosting){
            int top=player2[1]-78;
            fill(0);
            textSize(10*Scale);
          text(outher_name,xpos*Scale,top*Scale);
             }
          draw_mann(xpos*Scale,player2[1]*Scale,player2[2],player2[4]*Scale,"green");
          xpos=player1[0]-camPos;
          draw_mann(xpos*Scale,player1[1]*Scale,player1[2],player1[4]*Scale,"red");
          }else{
        
        
        
        if(hosting){
          xpos=player2[0]-camPos;
          if(outher_name!=null){
          int top=player2[1]-78;
          textSize(10*Scale);
          fill(0);
          text(outher_name,xpos*Scale,top*Scale);
          }
        draw_mann(xpos*Scale,player2[1]*Scale,player2[2],player2[4]*Scale,"green");
        }
        xpos=player1[0]-camPos;
        draw_mann(xpos*Scale,player1[1]*Scale,player1[2],player1[4]*Scale,"red");//draw the player
        if(xpos>scroll_right){//camera scrolling
         camPos+=4; 
        }
        if(xpos<scroll_left&&camPos>0){//camera scrolling
         camPos-=4; 
        }
        
        //movement         ===========================================================================
        if(!player1_moving_left&&!player1_moving_right){
          player1[2]=1;
        }
        
        if(player1_moving_left){
          int temp=player1[0]-4,temp2=player1[1]-1;
          if(!level2_colide(temp,temp2)){
          player1[0]-=4; //move left
          }
           
           if(player1[3]==0){//animate the leggs
             player1[2]--;
             if(player1[2]==0){
                player1[2]=12; 
             }
           }
           player1[3]++;
           if(player1[3]==4){
             player1[3]=0;
           }
           
        }
        if(player1_moving_right){
          int temp=player1[0]+4,temp2=player1[1]-1;
          if(!level2_colide(temp,temp2)){
           player1[0]+=4;//move right
          }
           
           if(player1[3]==0){//animate the leggs
             player1[2]++;
             if(player1[2]==13){
                player1[2]=1; 
             }
           }
           player1[3]++;
           if(player1[3]==4){
             player1[3]=0;
           }
        }//==================================
        //gravity
        if(player1_jumping){
          if(player1[5]<=20){
            int tempy=player1[1]-75;
            if(level2_colide(player1[0],tempy)){
              player1[5]=21;
            }else{
            player1[1]-=5;
            player1[5]++;
            }
          }else if(player1[5]<=25){
            player1[5]++;
          }else{
            int tempy=player1[1];//gravity
            tempy+=1;
           if(!level2_colide(player1[0],tempy)){
             player1[1]+=5;
           }else{
            player1[5]=0; 
           }
          }
        }else{
          int tempy=player1[1];//gravity
          tempy+=1;
         if(!level2_colide(player1[0],tempy)){
           player1[1]+=5;
           player1[5]=120;
         }else{
          player1[5]=0; 
         }
        }
        //================================================================================================
        if(player1[1]>720){
         dead=true;
         menue=false;
           //inGame=false;
           level="LEVEL_2";
           player1[0]=respawnX;
           player1[1]=respawnY;
         death_cool_down=0;
         player1[2]=1;
        }
          }}
          if(level_complete){
          textSize(100*Scale);
         fill(255,255,0);
         text("LEVEL COMPLETE!!!",200*Scale,400*Scale);
         if(!joined){
         fill(255,126,0);
         stroke(255,0,0);
         strokeWeight(10*Scale);
         rect(550*Scale,450*Scale,200*Scale,40*Scale);
         fill(0);
         textSize(40*Scale);
         text("continue",565*Scale,480*Scale);
        }}
     }
     
     
     
     
     
     if(level.equals("LEVEL_3")){
       background(#74ABFF);
         //loaded_level=loadJSONArray("level_3.json");
         for(int i=1;i<loaded_level.size();i++){
          JSONObject block=loaded_level.getJSONObject(i); 
          String type=block.getString("type");
          
          strokeWeight(0);
          if(type.equals("ground")){
            int Color = block.getInt("color");
            float x = block.getFloat("x"),y = block.getFloat("y"),dx = block.getFloat("dx"),dy = block.getFloat("dy");
            fill(Color);
            stroke(Color);
           rect((x-camPos)*Scale,y*Scale,dx*Scale,dy*Scale); 
          }
          if(type.equals("check point")){
            float x = block.getFloat("x"),y = block.getFloat("y");
            float playx=player1[0];
            if(playx>=x-5 && playx<= x+5 && y-50 <= player1[1] && y>=player1[1] && !joined){
              respawnX=(int)x;
             respawnY=(int)y;
            }
            playx=player2[0];
            if(playx>=x-5 && playx<= x+5 && y-50 <= player2[1] && y>=player2[1]&&joined){
              respawnX=(int)x;
             respawnY=(int)y;
            }
            
            x-=camPos;
            stroke(#B9B9B9);
            strokeWeight(5*Scale);
            line(x*Scale,y*Scale,x*Scale,(y-60)*Scale);
            fill(#EA0202);
            stroke(#EA0202);
            strokeWeight(0);
            triangle(x*Scale,(y-60)*Scale,x*Scale,(y-40)*Scale,(x+30)*Scale,(y-50)*Scale);
          }
          
          if(type.equals("goal")){
            float x = block.getFloat("x")-camPos,y = block.getFloat("y");
            fill(255);
            stroke(255);
            rect(x*Scale,y*Scale,50*Scale,50*Scale);
            rect((x+100)*Scale,y*Scale,50*Scale,50*Scale);
            rect((x+200)*Scale,y*Scale,50*Scale,50*Scale);
            fill(0);
            stroke(0);
            rect((x+50)*Scale,y*Scale,50*Scale,50*Scale);
            rect((x+150)*Scale,y*Scale,50*Scale,50*Scale);
            if(!joined){
               float px =player1[0],py=player1[1];
               
               if(px >= x+camPos && px <= x+camPos + 250 && py >= y - 50 && py <= y + 50){
                level_complete=true; 
               }
            }else{
             float px =player2[0],py=player2[1];
               if(px >= x+camPos && px <= x+camPos + 250 && py >= y - 50 && py <= y + 50){
                level_complete=true; 
               } 
            }
          }
         }
         int xpos;
         if(joined){
          
          if(dead){
            xpos=player2[0]-camPos;
          draw_mann(xpos*Scale,player2[1]*Scale,player2[2],player2[4]*Scale,"green");
          xpos=player1[0]-camPos;
          int top=player1[1]-78;
          textSize(10*Scale);
          fill(0);
          text(outher_name,xpos*Scale,top*Scale);
          draw_mann(xpos*Scale,player1[1]*Scale,player1[2],player1[4]*Scale,"red");
          
        }else{
          
        
        
        xpos=player2[0]-camPos;
        draw_mann(xpos*Scale,player2[1]*Scale,player2[2],player2[4]*Scale,"green");//draw the player
        if(xpos>scroll_right){//camera scrolling
         camPos+=4; 
        }
        if(xpos<scroll_left&&camPos>0){//camera scrolling
         camPos-=4; 
        }
        
        //movement         ===========================================================================
        if(!player1_moving_left&&!player1_moving_right){
          player2[2]=1;
        }
        
        if(player1_moving_left){
          int temp=player2[0]-4,temp2=player2[1]-1;
          if(!level3_colide(temp,temp2)){
          player2[0]-=4; //move left
          }
           
           if(player2[3]==0){//animate the leggs
             player2[2]--;
             if(player2[2]==0){
                player2[2]=12; 
             }
           }
           player2[3]++;
           if(player2[3]==4){
             player2[3]=0;
           }
           
        }
        if(player1_moving_right){
          int temp=player2[0]+4,temp2=player2[1]-1;
          if(!level3_colide(temp,temp2)){
           player2[0]+=4;//move right
          }
           
           if(player2[3]==0){//animate the leggs
             player2[2]++;
             if(player2[2]==13){
                player2[2]=1; 
             }
           }
           player2[3]++;
           if(player2[3]==4){
             player2[3]=0;
           }
        }//==================================
        //gravity
        if(player1_jumping){
          if(player2[5]<=20){
            int tempy=player2[1]-75;
            if(level3_colide(player2[0],tempy)){
              player2[5]=21;
            }else{
            player2[1]-=5;
            player2[5]++;
            }
          }else if(player2[5]<=25){
            player2[5]++;
          }else{
            int tempy=player2[1];//gravity
            if(!level3_colide(player2[0],tempy)){
           if(!level3_colide(player2[0],tempy+1)){
             if(!level3_colide(player2[0],tempy+2)){
               if(!level3_colide(player2[0],tempy+3)){
                 if(!level3_colide(player2[0],tempy+4)){
                   player2[1]+=5;
                   player2[5]=120;
                 }else{
                 player2[1]+=4;
                 player2[5]=120;
                 }}else{
               player2[1]+=5;
               player2[5]=120;
               }}else{
             player2[1]+=2;
             player2[5]=120;
           }}else{
           player2[1]+=1;
           player2[5]=120;
           }}else{
         
          player2[5]=0; 
         }
         int temp2 =player2[1];
         temp2-=1;
         if(level3_colide(player2[0],temp2)){
           player2[1]-=1;
         }
          }
        }else{
          int tempy=player2[1];//gravity
          if(!level3_colide(player2[0],tempy)){
           if(!level3_colide(player2[0],tempy+1)){
             if(!level3_colide(player2[0],tempy+2)){
               if(!level3_colide(player2[0],tempy+3)){
                 if(!level3_colide(player2[0],tempy+4)){
                   player2[1]+=5;
                   player2[5]=120;
                 }else{
                 player2[1]+=4;
                 player2[5]=120;
                 }}else{
               player2[1]+=5;
               player2[5]=120;
               }}else{
             player2[1]+=2;
             player2[5]=120;
           }}else{
           player2[1]+=1;
           player2[5]=120;
           }}else{
         
          player2[5]=0; 
         }
         int temp2 =player2[1];
         temp2-=1;
         if(level3_colide(player2[0],temp2)){
           player2[1]-=1;
         }
        }
        //================================================================================================
        if(player2[1]>720){
         dead=true;
         menue=false;
          // inGame=false;
           level="1-1";
           player2[0]=respawnX;
           player2[1]=respawnY;
         death_cool_down=0;
         player2[2]=1;
        }
          
          
         xpos=player1[0]-camPos;
         int top=player1[1]-78;
         textSize(10*Scale);
         fill(0);
          text(outher_name,xpos*Scale,top*Scale);
          draw_mann(xpos*Scale,player1[1]*Scale,player1[2],player1[4]*Scale,"red");
          }}else{
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        if(dead){
            xpos=player2[0]-camPos;
             if(hosting){
            int top=player2[1]-78;
            fill(0);
            textSize(10*Scale);
          text(outher_name,xpos*Scale,top*Scale);
             }
          draw_mann(xpos*Scale,player2[1]*Scale,player2[2],player2[4]*Scale,"green");
          xpos=player1[0]-camPos;
          draw_mann(xpos*Scale,player1[1]*Scale,player1[2],player1[4]*Scale,"red");
          }else{
        
        
        
        if(hosting){
          xpos=player2[0]-camPos;
          if(outher_name!=null){
          int top=player2[1]-78;
          textSize(10*Scale);
          fill(0);
          text(outher_name,xpos*Scale,top*Scale);
          }
        draw_mann(xpos*Scale,player2[1]*Scale,player2[2],player2[4]*Scale,"green");
        }
        xpos=player1[0]-camPos;
        draw_mann(xpos*Scale,player1[1]*Scale,player1[2],player1[4]*Scale,"red");//draw the player
        if(xpos>scroll_right){//camera scrolling
         camPos+=4; 
        }
        if(xpos<scroll_left&&camPos>0){//camera scrolling
         camPos-=4; 
        }
        
        //movement         ===========================================================================
        if(!player1_moving_left&&!player1_moving_right){
          player1[2]=1;
        }
        
        if(player1_moving_left){
          int temp=player1[0]-4,temp2=player1[1]-1;
          if(!level3_colide(temp,temp2)){
          player1[0]-=4; //move left
          }
           
           if(player1[3]==0){//animate the leggs
             player1[2]--;
             if(player1[2]==0){
                player1[2]=12; 
             }
           }
           player1[3]++;
           if(player1[3]==4){
             player1[3]=0;
           }
           
        }
        if(player1_moving_right){
          int temp=player1[0]+4,temp2=player1[1]-1;
          if(!level3_colide(temp,temp2)){
           player1[0]+=4;//move right
          }
           
           if(player1[3]==0){//animate the leggs
             player1[2]++;
             if(player1[2]==13){
                player1[2]=1; 
             }
           }
           player1[3]++;
           if(player1[3]==4){
             player1[3]=0;
           }
        }//==================================
        //gravity
        if(player1_jumping){
          if(player1[5]<=20){
            int tempy=player1[1]-75;
            if(level3_colide(player1[0],tempy)){
              player1[5]=21;
            }else{
            player1[1]-=5;
            player1[5]++;
            }
          }else if(player1[5]<=25){
            player1[5]++;
          }else{
            int tempy=player1[1];//gravity
            if(!level3_colide(player1[0],tempy)){
           if(!level3_colide(player1[0],tempy+1)){
             if(!level3_colide(player1[0],tempy+2)){
               if(!level3_colide(player1[0],tempy+3)){
                 if(!level3_colide(player1[0],tempy+4)){
                   player1[1]+=5;
                   player1[5]=120;
                 }else{
                 player1[1]+=4;
                 player1[5]=120;
                 }}else{
               player1[1]+=5;
               player1[5]=120;
               }}else{
             player1[1]+=2;
             player1[5]=120;
           }}else{
           player1[1]+=1;
           player1[5]=120;
           }}else{
         
          player1[5]=0; 
         }
         
         int temp2 =player1[1];
         temp2-=1;
         if(level3_colide(player1[0],temp2)){
           player1[1]-=1;
         }
          }
        }else{
          int tempy=player1[1];//gravity
          if(!level3_colide(player1[0],tempy)){
           if(!level3_colide(player1[0],tempy+1)){
             if(!level3_colide(player1[0],tempy+2)){
               if(!level3_colide(player1[0],tempy+3)){
                 if(!level3_colide(player1[0],tempy+4)){
                   player1[1]+=5;
                   player1[5]=120;
                 }else{
                 player1[1]+=4;
                 player1[5]=120;
                 }}else{
               player1[1]+=5;
               player1[5]=120;
               }}else{
             player1[1]+=2;
             player1[5]=120;
           }}else{
           player1[1]+=1;
           player1[5]=120;
           }}else{
         
          player1[5]=0; 
         }
         
         int temp2 =player1[1];
         temp2-=1;
         if(level3_colide(player1[0],temp2)){
           player1[1]-=1;
         }
        }
        //================================================================================================
        if(player1[1]>720){
         dead=true;
         menue=false;
           //inGame=false;
           level="LEVEL_3";
           player1[0]=respawnX;
           player1[1]=respawnY;
         death_cool_down=0;
         player1[2]=1;
        }
          }}
          if(level_complete){
          textSize(100*Scale);
         fill(255,255,0);
         text("LEVEL COMPLETE!!!",200*Scale,400*Scale);
         if(!joined){
         fill(255,126,0);
         stroke(255,0,0);
         strokeWeight(10*Scale);
         rect(550*Scale,450*Scale,200*Scale,40*Scale);
         fill(0);
         textSize(40*Scale);
         text("continue",565*Scale,480*Scale);
        }}
     }
     
     
       
      
     image(LB,0,0);
     image(RB,hres-250*Scale2,0);
     
     
     
     
     
  }
  if(menue){
    if(Menue.equals("pause")){//when paused
      tint(50,50,50);
      image(tnit, 0, 0);
      noTint();
      fill(0);
      textSize(100*Scale);
      text("GAME PAUSED",300*Scale,100*Scale);
      fill(255,25,0);
       stroke(255,249,0);
       strokeWeight(10*Scale);
       rect(500*Scale,200*Scale,300*Scale,60*Scale);
     //  rect(500*Scale,300*Scale,300*Scale,60*Scale);
       rect(500*Scale,400*Scale,300*Scale,60*Scale);
       fill(0);
       textSize(50*Scale);
       text("resume",550*Scale,250*Scale);
    //   text("open to lan",510*Scale,350*Scale);
       text("quit",600*Scale,450*Scale);
       
    }
  }
  if(dead){
    fill(255,0,0);
    textSize(50*Scale);
    text("you died",500*Scale,360*Scale);
     death_cool_down++;
     if(death_cool_down>200){
       dead=false;
       inGame=true;
       if(respawnX < 400){
        camPos=0; 
       }else{
       camPos=respawnX-400;
       }
       player1_moving_right=false;
       player1_moving_left=false;
       player1_jumping=false;
     }
  }
  
  if(start_host){
     background(#FA7D00);
     fill(#009CFA);
     stroke(#0040FA);
     strokeWeight(10*Scale);
     rect(500*Scale,600*Scale,300*Scale,40*Scale);
     fill(0);
     textSize(50*Scale);
     text("start",600*Scale,635*Scale);
     text("enter name",40*Scale,200*Scale);
     if(name!=null){
     text(name,40*Scale,250*Scale);
     }
     stroke(0);
     strokeWeight(1*Scale);
     line(40*Scale,250*Scale,900*Scale,250*Scale);
     text("enter port",40*Scale,400*Scale);
     text(port,40*Scale,450*Scale);
     line(40*Scale,450*Scale,300*Scale,450*Scale);
  }
  
  if(start_join){
     background(#FA7D00);
     fill(#009CFA);
     stroke(#0040FA);
     strokeWeight(10*Scale);
     rect(500*Scale,660*Scale,300*Scale,40*Scale);
     fill(0);
     textSize(50*Scale);
     text("start",600*Scale,695*Scale);
     text("enter name",40*Scale,200*Scale);
     if(name!=null){
     text(name,40*Scale,250*Scale);
     }
     stroke(0);
     strokeWeight(1*Scale);
     line(40*Scale,250*Scale,900*Scale,250*Scale);
     text("enter port",40*Scale,400*Scale);
     text(port,40*Scale,450*Scale);
     line(40*Scale,450*Scale,300*Scale,450*Scale);
     text("enter ip",40*Scale,600*Scale);
     if(ip!=null){
      text(ip,40*Scale,650*Scale);
     }
      line(40*Scale,650*Scale,900*Scale,650*Scale);
     
  }
  fill(255);
  textSize(10*Scale);
  text("fps: "+ frameRate,1200*Scale,10*Scale);
  
  player1_moving_right=false;
  player1_moving_left=false;
  player1_jumping=false;
  
}

void mousePressed(){
  if(menue){
     if(Menue.equals("main")){
       if(mouseX >= 540*Scale && mouseX <= 740*Scale && mouseY >= 310*Scale && mouseY <= 360*Scale){
         Menue = "level select";
       }
       if(mouseX >= 540*Scale && mouseX <= 740*Scale && mouseY >= 470*Scale && mouseY <= 510*Scale){
         //exit();
       }
       //if((mouseX >= 540*Scale && mouseX <= 740*Scale && mouseY >= 390*Scale && mouseY <= 440*Scale)&&!hosting&&!joined){
       //  start_join=true;
       //}
       if((mouseX >= 540*Scale && mouseX <= 740*Scale && mouseY >= 550*Scale && mouseY <= 600*Scale)&&!hosting&&!joined){
         Menue="settings";
       }
       if((mouseX >= 540*Scale && mouseX <= 740*Scale && mouseY >= 630*Scale && mouseY <= 680*Scale)&&!hosting&&!joined){
         Menue="how to play";
       }
     }
    if(Menue.equals("level select")&&!start_host){
         if(mouseX >= 40*Scale && mouseX <= 150*Scale && mouseY >= 200*Scale && mouseY <= 400*Scale){
           menue=false;
           inGame=true;
           level="1-1";
           player1[0]=20;
           player1[1]=700;
           player2[0]=20;
           player2[1]=700;
           respawnX=20;
           respawnY=700;
           camPos=0;
           level_complete=false;
           spdelay=0;
         }
         if(mouseX >= 240*Scale && mouseX <= 350*Scale && mouseY >= 200*Scale && mouseY <= 400*Scale){
           menue=false;
           inGame=true;
           level="LEVEL_2";
           player1[0]=20;
           player1[1]=700;
           player2[0]=20;
           player2[1]=700;
           respawnX=20;
           respawnY=700;
           camPos=0;
           level_complete=false;
           spdelay=0;
           loaded_level=loadJSONArray("level_2.json");
         }
         if(mouseX >= 440*Scale && mouseX <= 550*Scale && mouseY >= 200*Scale && mouseY <= 400*Scale){
           loaded_level=loadJSONArray("level_3.json");
           JSONObject head_data=loaded_level.getJSONObject(0); 
           menue=false;
           inGame=true;
           level="LEVEL_3";
           player1[0]=head_data.getInt("spawnX");
           player1[1]=head_data.getInt("spawnY");
           player2[0]=head_data.getInt("spawnX");
           player2[1]=head_data.getInt("spawnY");
           respawnX=head_data.getInt("spawn pointX");
           respawnY=head_data.getInt("spawn pointY");
           camPos=0;
           level_complete=false;
           spdelay=0;
         }
         if(mouseX >= 40*Scale && mouseX <= 240*Scale && mouseY >= 610*Scale && mouseY <= 660*Scale){
           Menue ="main";
         }
         //if((mouseX >= 280*Scale && mouseX <= 480*Scale && mouseY >= 610*Scale && mouseY <= 660*Scale)&&!hosting&&!joined){
         //  start_host =true;
         //}
     }
     
     if(Menue.equals("pause")&&!start_host){
       if(mouseX >= 500*Scale && mouseX <= 800*Scale && mouseY >= 200*Scale && mouseY <= 260*Scale){
         menue=false;
       }
       if(mouseX >= 500*Scale && mouseX <= 800*Scale && mouseY >= 400*Scale && mouseY <= 460*Scale){
         menue=true;
         inGame=false;
         Menue="level select";
       }
       if((mouseX >= 500*Scale && mouseX <= 800*Scale && mouseY >= 300*Scale && mouseY <= 360*Scale)&&!hosting&&!joined){
         start_host=true;
       }
     }
     
     if(Menue.equals("settings")){     
    
        if((mouseX >= 1200*Scale && mouseX <= 1240*Scale && mouseY >= 50*Scale && mouseY <= 90*Scale)&&!hosting&&!joined){
           JSONObject scrolling = new JSONObject();
          scrolling.setString("lable", "normal");
          scrolling.setFloat("value_right", 1100);
          scrolling.setFloat("value_left", 100);
          settings.setJSONObject(0,scrolling);
          saveJSONArray(settings, "settings.json");
       }
       
       if((mouseX >= 1130*Scale && mouseX <= 1170*Scale && mouseY >= 50*Scale && mouseY <= 90*Scale)&&!hosting&&!joined){
           JSONObject scrolling = new JSONObject();
          scrolling.setString("lable", "noob");
          scrolling.setFloat("value_right", 650);
          scrolling.setFloat("value_left", 630);
          settings.setJSONObject(0,scrolling);
          saveJSONArray(settings, "settings.json");
       }
       
       /*
       JSONObject rez=settings.getJSONObject(1);
      // int vres = rez.getInt("v-res");
       String arat = rez.getString("aspect ratio");
       if((mouseX >= 1200*Scale && mouseX <= 1240*Scale && mouseY >= 120*Scale && mouseY <= 160*Scale)&&!hosting&&!joined){
           rez.setInt("v-res",2160);
           if(arat.equals("16:9")){
             rez.setInt("h-res",2160*16/9);
           }
           if(arat.equals("16:10")){
             rez.setInt("h-res",2160*16/10);
           }
           if(arat.equals("32:9")){
             rez.setInt("h-res",2160*32/9);
           }
          rez.setFloat("scale",2160/720.0);
          
          settings.setJSONObject(1,rez);
          saveJSONArray(settings, "settings.json");
       }
       
       if((mouseX >= 1130*Scale && mouseX <= 1170*Scale && mouseY >= 120*Scale && mouseY <= 160*Scale)&&!hosting&&!joined){
           rez.setInt("v-res",1440);
           if(arat.equals("16:9")){
             rez.setInt("h-res",1440*16/9);
           }
           if(arat.equals("16:10")){
             rez.setInt("h-res",1440*16/10);
           }
           if(arat.equals("32:9")){
             rez.setInt("h-res",1440*32/9);
           }
          rez.setFloat("scale",1440/720.0);
          
          settings.setJSONObject(1,rez);
          saveJSONArray(settings, "data/settings.json");
       }
       
       if((mouseX >= 1060*Scale && mouseX <= 1100*Scale && mouseY >= 120*Scale && mouseY <= 160*Scale)&&!hosting&&!joined){
           rez.setInt("v-res",1080);
           if(arat.equals("16:9")){
             rez.setInt("h-res",1080*16/9);
           }
           if(arat.equals("16:10")){
             rez.setInt("h-res",1080*16/10);
           }
           if(arat.equals("32:9")){
             rez.setInt("h-res",1080*32/9);
           }
          rez.setFloat("scale",1080/720.0);
          
          settings.setJSONObject(1,rez);
          saveJSONArray(settings, "data/settings.json");
       }
       
       if((mouseX >= 990*Scale && mouseX <= 1030*Scale && mouseY >= 120*Scale && mouseY <= 160*Scale)&&!hosting&&!joined){
           rez.setInt("v-res",900);
           if(arat.equals("16:9")){
             rez.setInt("h-res",900*16/9);
           }
           if(arat.equals("16:10")){
             rez.setInt("h-res",900*16/10);
           }
           if(arat.equals("32:9")){
             rez.setInt("h-res",900*32/9);
           }
          rez.setFloat("scale",900/720.0);
          
          settings.setJSONObject(1,rez);
          saveJSONArray(settings, "data/settings.json");
       }
       
       if((mouseX >= 920*Scale && mouseX <= 960*Scale && mouseY >= 120*Scale && mouseY <= 160*Scale)&&!hosting&&!joined){
           rez.setInt("v-res",720);
           if(arat.equals("16:9")){
             rez.setInt("h-res",720*16/9);
           }
           if(arat.equals("16:10")){
             rez.setInt("h-res",720*16/10);
           }
           if(arat.equals("32:9")){
             rez.setInt("h-res",720*32/9);
           }
          rez.setFloat("scale",720/720.0);
          
          settings.setJSONObject(1,rez);
          saveJSONArray(settings, "data/settings.json");
       }
       /*
       if((mouseX >= 1200*Scale && mouseX <= 1240*Scale && mouseY >= 190*Scale && mouseY <= 230*Scale)&&!hosting&&!joined){
           rez.setString("aspect ratio","32:9");
           if(vres==2160){
             rez.setInt("h-res",2160*32/9);
           }
           if(vres==1440){
             rez.setInt("h-res",1440*32/9);
           }
           if(vres==1080){
             rez.setInt("h-res",1080*32/9);
           }
           if(vres==900){
             rez.setInt("h-res",900*32/9);
           }
           if(vres==720){
             rez.setInt("h-res",720*32/9);
           }
          settings.setJSONObject(1,rez);
          saveJSONArray(settings, "data/settings.json");
       }
       
       if((mouseX >= 1130*Scale && mouseX <= 1170*Scale && mouseY >= 190*Scale && mouseY <= 230*Scale)&&!hosting&&!joined){
           rez.setString("aspect ratio","16:9");
           if(vres==2160){
             rez.setInt("h-res",2160*16/9);
           }
           if(vres==1440){
             rez.setInt("h-res",1440*16/9);
           }
           if(vres==1080){
             rez.setInt("h-res",1080*16/9);
           }
           if(vres==900){
             rez.setInt("h-res",900*16/9);
           }
           if(vres==720){
             rez.setInt("h-res",720*16/9);
           }
          settings.setJSONObject(1,rez);
          saveJSONArray(settings, "data/settings.json");
       }
       
       if((mouseX >= 1060*Scale && mouseX <= 1100*Scale && mouseY >= 190*Scale && mouseY <= 230*Scale)&&!hosting&&!joined){
           rez.setString("aspect ratio","16:10");
           if(vres==2160){
             rez.setInt("h-res",2160*16/10);
           }
           if(vres==1440){
             rez.setInt("h-res",1440*16/10);
           }
           if(vres==1080){
             rez.setInt("h-res",1080*16/10);
           }
           if(vres==900){
             rez.setInt("h-res",900*16/10);
           }
           if(vres==720){
             rez.setInt("h-res",720*16/10);
           }
          settings.setJSONObject(1,rez);
          saveJSONArray(settings, "data/settings.json");
       }
       
       
       if((mouseX >= 1200*Scale && mouseX <= 1240*Scale && mouseY >= 190*Scale && mouseY <= 230*Scale)&&!hosting&&!joined){
           rez.setBoolean("full_Screen",true);
           
          settings.setJSONObject(1,rez);
          saveJSONArray(settings, "data/settings.json");
       }
       
       if((mouseX >= 1130*Scale && mouseX <= 1170*Scale && mouseY >= 190*Scale && mouseY <= 230*Scale)&&!hosting&&!joined){
           rez.setBoolean("full_Screen",false);
          
          settings.setJSONObject(1,rez);
          saveJSONArray(settings, "data/settings.json");
       }
       
       
       */
       
       
       if(mouseX >= 40*Scale && mouseX <= 240*Scale && mouseY >= 610*Scale && mouseY <= 660*Scale){
           Menue ="main";
         }
     }
     if(Menue.equals("how to play")){
      if(mouseX >= 40 && mouseX <= 240 && mouseY >= 610 && mouseY <= 660){
           Menue ="main";
         } 
     }
  }
  if(level_complete&!joined){
    if(mouseX >= 550*Scale && mouseX <= 750*Scale && mouseY >= 450*Scale && mouseY <= 490*Scale){
           menue=true;
           inGame=false;
           Menue="level select";
         }
    }
    //if(start_host){
    //  if(mouseX >= 40*Scale && mouseX <= 900*Scale && mouseY >= 210*Scale && mouseY <= 250*Scale){
    //   entering_name=true;
    //   entering_port=false;
    //  }
    //  if(mouseX >= 40*Scale && mouseX <= 300*Scale && mouseY >= 410*Scale && mouseY <= 450*Scale){
    //   entering_name=false;
    //   entering_port=true;
    //  }
    //  //if(mouseX >= 500*Scale && mouseX <= 800*Scale && mouseY >= 600*Scale && mouseY <= 640*Scale){
    //  // entering_name=false;
    //  // entering_port=false;
    //  // s = new Server(this, port);
    //  // hosting=true;
    //  // start_host=false;
    //  //}
    //}
    
    //if(start_join){
    //  if(mouseX >= 40*Scale && mouseX <= 900*Scale && mouseY >= 210*Scale && mouseY <= 250*Scale){
    //   entering_name=true;
    //   entering_port=false;
    //   entering_ip=false;
    //  }
    //  if(mouseX >= 40*Scale && mouseX <= 300*Scale && mouseY >= 410*Scale && mouseY <= 450*Scale){
    //   entering_name=false;
    //   entering_port=true;
    //   entering_ip=false;
    //  }
    //  if(mouseX >= 40*Scale && mouseX <= 900*Scale && mouseY >= 610*Scale && mouseY <= 650*Scale){
    //   entering_name=false;
    //   entering_port=false;
    //   entering_ip=true;
    //  }
    //  if(mouseX >= 500*Scale && mouseX <= 800*Scale && mouseY >= 660*Scale && mouseY <= 700*Scale){
    //   entering_name=false;
    //   entering_port=false;
    //   entering_ip=false;
    //   c=new Client(this,ip,port);
    //   joined=true;
    //   start_join=false;
    //   Menue="multy_player";
    //  }
    //}
    
    
  }
  
  void onBackPressed() {
    if(inGame){
    menue=true;
    Menue="pause";
    }
  }


void keyPressed(){
  if(inGame){
  if(keyCode==65){
    player1_moving_left=true;
  }
  if(keyCode==68){
    player1_moving_right=true;
  }
  if(keyCode==32){
    player1_jumping=true;
  }
  if(keyCode==192){
    menue=true;
    Menue="pause";
  }
  if(dev_mode){
   if(keyCode==81){
    System.out.println(player1[0]+" "+player1[1]);
  }}
}
if(entering_ip){
    if(keyCode>=48&&keyCode<=57||keyCode==46){
 
   if(ip==null){
     ip=key+"";
 }else{
   ip+=key;
 }
 
 }
 if(keyCode==8){
   if(ip==null){}
   else{
     if(ip.length()==1){
      ip=null; 
     }else{
    ip=ip.substring(0,ip.length()-1); 
     } 
   }
 }
  }
  
  
  if(entering_port){
 if(keyCode>=48&&keyCode<=57){
 
   if(port==0){
     port=Integer.parseInt(key+"");
 }else{
   port=Integer.parseInt(key+"")+port*10;
 }
 
 }
 if(keyCode==8){
   if(port==0){}
   else{
    port=port/10; 
   }
 }
  }
  
  if(entering_name){
    if(keyCode>=48&&keyCode<=57||keyCode==46||keyCode==32||(keyCode>=65&&keyCode<=90)&&keyCode!=32){
   if(keyCode==32){
    return; 
   }
   if(name==null){
     name=key+"";
 }else{
   name+=key;
 }
 
 }
 if(keyCode==8){
   if(name==null){}
   else{
     if(name.length()==1){
      name=null; 
     }else{
    name=name.substring(0,name.length()-1); 
     } 
   }
 }
  }
  
//System.out.println(keyCode);
}

void keyReleased(){
  if(inGame){
    if(keyCode==65){
      player1_moving_left=false;
    }
    if(keyCode==68){
      player1_moving_right=false;
    }
    if(keyCode==32){
    player1_jumping=false;
  }
  }
}
