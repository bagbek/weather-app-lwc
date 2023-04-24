/**
 * @description       : Open Weather Geo Location DAO
 * @author            : pelayochristian.dev@gmail.com
 * @last modified on  : 07-08-2022
 * @last modified by  : pelayochristian.dev@gmail.com
 **/
public with sharing class MW_OpenWeatherGeoLocation {
    @AuraEnabled
    public String name;
    @AuraEnabled
    public Double lat;
    @AuraEnabled
    public Double lon;
    @AuraEnabled
    public String state;
    @AuraEnabled
    public String country;

    public static List<MW_OpenWeatherGeoLocation> parse(String json) {
        return (List<MW_OpenWeatherGeoLocation>) System.JSON.deserialize(
            json,
            List<MW_OpenWeatherGeoLocation>.class
        );
    }
}
