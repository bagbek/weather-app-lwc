/**
 * @description       : Open Weather One Call DAO
 * @author            : pelayochristian.dev@gmail.com
 * @last modified on  : 07-08-2022
 * @last modified by  : pelayochristian.dev@gmail.com
 **/
public with sharing class MW_OpenWeatherOneCall {
    public class Weather {
        @AuraEnabled
        public Integer id;
        @AuraEnabled
        public String main;
        @AuraEnabled
        public String description;
        @AuraEnabled
        public String icon;
    }

    public class Rain {
        @AuraEnabled
        public Double oneHour;
    }

    public class Daily {
        @AuraEnabled
        public Integer dt;
        @AuraEnabled
        public Integer sunrise;
        @AuraEnabled
        public Integer sunset;
        @AuraEnabled
        public Integer moonrise;
        @AuraEnabled
        public Integer moonset;
        @AuraEnabled
        public Double moon_phase;
        @AuraEnabled
        public Temp temp;
        @AuraEnabled
        public Feels_like feels_like;
        @AuraEnabled
        public Integer pressure;
        @AuraEnabled
        public Integer humidity;
        @AuraEnabled
        public Double dew_point;
        @AuraEnabled
        public Double wind_speed;
        @AuraEnabled
        public Integer wind_deg;
        @AuraEnabled
        public Double wind_gust;
        @AuraEnabled
        public List<Weather> weather;
        @AuraEnabled
        public Integer clouds;
        @AuraEnabled
        public Double pop;
        @AuraEnabled
        public Double rain;
        @AuraEnabled
        public Double uvi;
    }

    public class Temp {
        @AuraEnabled
        public Double day;
        @AuraEnabled
        public Double min;
        @AuraEnabled
        public Double max;
        @AuraEnabled
        public Double night;
        @AuraEnabled
        public Double eve;
        @AuraEnabled
        public Double morn;
    }

    public class Feels_like_Z {
        @AuraEnabled
        public Integer day;
        @AuraEnabled
        public Double night;
        @AuraEnabled
        public Double eve;
        @AuraEnabled
        public Double morn;
    }

    @AuraEnabled
    public Double lat;
    @AuraEnabled
    public Double lon;
    @AuraEnabled
    public String timezone;
    @AuraEnabled
    public Integer timezone_offset;
    @AuraEnabled
    public Current current;
    @AuraEnabled
    public List<Daily> daily;

    public class Current {
        @AuraEnabled
        public Integer dt;
        @AuraEnabled
        public Integer sunrise;
        @AuraEnabled
        public Integer sunset;
        @AuraEnabled
        public Double temp;
        @AuraEnabled
        public Double feels_like;
        @AuraEnabled
        public Integer pressure;
        @AuraEnabled
        public Integer humidity;
        @AuraEnabled
        public Double dew_point;
        @AuraEnabled
        public Double uvi;
        @AuraEnabled
        public Integer clouds;
        @AuraEnabled
        public Integer visibility;
        @AuraEnabled
        public Double wind_speed;
        @AuraEnabled
        public Integer wind_deg;
        @AuraEnabled
        public List<Weather> weather;
        @AuraEnabled
        public Rain rain;
    }

    public class Feels_like {
        @AuraEnabled
        public Double day;
        @AuraEnabled
        public Double night;
        @AuraEnabled
        public Double eve;
        @AuraEnabled
        public Double morn;
    }

    public static MW_OpenWeatherOneCall parse(String json) {
        return (MW_OpenWeatherOneCall) System.JSON.deserialize(
            json,
            MW_OpenWeatherOneCall.class
        );
    }
}
