import SimpleOpenNI.*;
SimpleOpenNI kinect;

void setup(){
  
size(640,480);
kinect = new SimpleOpenNI(this);
kinect.enableDepth();
kinect.enableRGB();
}

void draw(){
  kinect.update();
  //background(0);
  //image(kinect.depthImage(),0,0);
  image(kinect.rgbImage(),0,0);
  
  
  int[] depthValues = kinect.depthMap();
  //println("Array lengte: "+depthValues.length); /*=307200 =>640.480*/
  ArrayList<int[]> leftSector = new ArrayList<int[]>();
  ArrayList<int[]> middleSector = new ArrayList<int[]>();
  ArrayList<int[]> rightSector = new ArrayList<int[]>();
  ArrayList<int[]> sector1 = new ArrayList<int[]>();
  ArrayList<int[]> sector2 = new ArrayList<int[]>();
  ArrayList<int[]> sector3 = new ArrayList<int[]>();
  ArrayList<int[]> sector4 = new ArrayList<int[]>();
  ArrayList<int[]> sector5 = new ArrayList<int[]>();
  ArrayList<int[]> sector6 = new ArrayList<int[]>();
  ArrayList<int[]> sector7 = new ArrayList<int[]>();
  ArrayList<int[]> sector8 = new ArrayList<int[]>();
  ArrayList<int[]> sector9 = new ArrayList<int[]>();
  
  //voor iedere lijn op de X-as
  //int yAxisPosition=0;
  for(int i = 0;i<=depthValues.length;i=i+639){
    
      //de lijn gaan splitsen en voor links midden rechts totale breedte is 640px hoogte 480px
      //dan dit stuk uit de array halen en toevoegen aan een array lijst
      //deze arraylijst is dan de linker midden of rechter sector van het beeld
      int[] tempLeftArr = java.util.Arrays.copyOfRange(depthValues,i,(i+213));
      leftSector.add(tempLeftArr); 
      
      int[] tempMiddleArr = java.util.Arrays.copyOfRange(depthValues,(i+213),i+(213+214));
      middleSector.add(tempMiddleArr);
      
      int[] tempRightArr = java.util.Arrays.copyOfRange(depthValues,i+(213+214),i+(213+214+213));
      rightSector.add(tempRightArr);
      
   
    //println("X-as lijn: "+yAxisPosition);
    //yAxisPosition++;
  }
  
  
  for(int i =0;i <= leftSector.size()-1;i++){
  
    if(i < 160){ 
      
      sector1.add(leftSector.get(i));
    
  }else if(i >= 160 && i <= 319){
    
      sector4.add(leftSector.get(i));
    
    }else{
    
      sector7.add(leftSector.get(i));
    
    }
  
  }
  
  
    for(int i =0;i <= middleSector.size()-1;i++){
  
    if(i < 160){ 
      
      sector2.add(middleSector.get(i));
    
  }else if(i >= 160 && i <= 319){
    
      sector5.add(middleSector.get(i));
    
    }else{
    
      sector8.add(middleSector.get(i));
    
    }
  
  }
  
  
    for(int i =0;i <= rightSector.size()-1;i++){
  
    if(i < 160){ 
      
      sector3.add(rightSector.get(i));
    
  }else if(i >= 160 && i <= 319){
    
      sector6.add(rightSector.get(i));
    
    }else{
    
      sector9.add(rightSector.get(i));
    
    }
  
  }




  println("Distances per sector:\n"
  +getAverageOfSector(sector1)+"  "+getAverageOfSector(sector2)+"  "+getAverageOfSector(sector3)+"\n"
  +getAverageOfSector(sector4)+"  "+getAverageOfSector(sector5)+"  "+getAverageOfSector(sector6)+"\n"
  +getAverageOfSector(sector7)+"  "+getAverageOfSector(sector8)+"  "+getAverageOfSector(sector9)+"\n"
  );

  drawRectangles(
  calculateOpacityBasedOnDistance(getAverageOfSector(sector1)),
  calculateOpacityBasedOnDistance(getAverageOfSector(sector2)),
  calculateOpacityBasedOnDistance(getAverageOfSector(sector3)),
  calculateOpacityBasedOnDistance(getAverageOfSector(sector4)),
  calculateOpacityBasedOnDistance(getAverageOfSector(sector5)),
  calculateOpacityBasedOnDistance(getAverageOfSector(sector6)),
  calculateOpacityBasedOnDistance(getAverageOfSector(sector7)),
  calculateOpacityBasedOnDistance(getAverageOfSector(sector8)),
  calculateOpacityBasedOnDistance(getAverageOfSector(sector9))
  );
}



void drawRectangles(
              int opacity1,
              int opacity2,
              int opacity3,
              int opacity4,
              int opacity5,
              int opacity6,
              int opacity7,
              int opacity8,
              int opacity9
              ){
  
  
  
  //1 2 3
  fill(255,0,0,opacity1);
  rect(0, 0, 213, 160);
  
  fill(0,255,0,opacity2);
  rect(213, 0, 214, 160);
  
  fill(0,0,255,opacity3);
  rect(427, 0, 213, 160);
  
  //4 5 6 
  fill(255,255,0,opacity4);
  rect(0,160, 213, 160);
  
  fill(208,32,144,opacity5);
  rect(213, 160, 214, 160);
  
  fill(255,165,0,opacity6);
  rect(427, 160, 213, 160);
  
  //7 8 9 
  fill(255,105,180,opacity7);
  rect(0, 320, 213, 160);
  
  fill(127,255,0,opacity8);
  rect(213, 320, 214, 160);
  
  fill(0,192,255,opacity9);
  rect(427, 320, 213, 480);
  

}

int calculateOpacityBasedOnDistance(int distance){
  
  if(distance < 1000){
    return 255;
  }else if(distance >= 1000 && distance < 2500){
    return 125;
  }else{
    return 0;
  }
  
}


//gaat alle arrays in array lijst overlopen en alle waarden in iedere array optellen 
//en dan de sommen optellen heel de boel delen door het aantal waardes
int getAverageOfSector(ArrayList<int[]> sector){

  int sumOfSector =0;
  for(int i=0;i<=sector.size()-1;i++){
  
    int sumOfLine = 0;
    for(int j=0;j<=sector.get(0).length-1;j++){
      sumOfLine = sumOfLine + sector.get(i)[j];
    }
    sumOfSector = sumOfSector + sumOfLine;
  
  }
  
  return sumOfSector/ (((sector.size())*(sector.get(0).length)));
}



