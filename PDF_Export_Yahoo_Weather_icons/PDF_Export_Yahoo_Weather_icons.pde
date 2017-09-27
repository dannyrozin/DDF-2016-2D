/*
 DDF 2017
 Get weather data as XML from Yahoo API , and draw icons according to 10 day forecast
 Press R to save as PDF
 */

import processing.pdf.*;
PShape sunny, cloudy, breezy, rainy, question;                     // shapes to hold the icons 


void setup() {
  size(1000, 100);
  background (255);
  // loading icons as SVG from web
  sunny = loadShape("http://simpleicon.com/wp-content/uploads/sunny.svg");
  cloudy = loadShape("http://simpleicon.com/wp-content/uploads/cloud-11.svg");
  rainy = loadShape("http://simpleicon.com/wp-content/uploads/rain.svg");
  breezy = loadShape("http://image.flaticon.com/icons/svg/69/69694.svg");
  question = loadShape("http://simpleicon.com/wp-content/uploads/question_mark.svg");

  beginRecord(PDF, "output.pdf");     

  // this URL calls the API and requests weather for New York, change the woeid code for other place
  String url = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%3D2459115";

  XML xml = loadXML(url);                                                         // Load the XML document

  XML forecast[] = xml.getChildren("results/channel/item/yweather:forecast");     // place the elements into array
  println(forecast);
  for (int i = 0; i< forecast.length; i++) {
    String thisForecast=  forecast[i].getString("text");                                    
    if (thisForecast.contains("Showers") || thisForecast.contains("Thunderstorms") || thisForecast.contains("Rain")) shape(rainy, i*100, 0, 100, 100);
    else if (thisForecast.contains("Sunny")) shape(sunny, i*100, 0, 100, 100);
    else if (thisForecast.contains("Cloudy")) shape(cloudy, i*100, 0, 100, 100);
    else if (thisForecast.contains("Breezy")) shape(breezy, i*100, 0, 100, 100);
    else shape(question, i*100, 0, 100, 100);
  }
  endRecord();
}

void draw() {
}