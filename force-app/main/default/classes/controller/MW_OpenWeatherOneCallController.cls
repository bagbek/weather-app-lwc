/**
 * @description       : Controller used for exposing Open Weather data
 *                      to the front-end component.
 * @author            : pelayochristian.dev@gmail.com
 * @last modified on  : 07-08-2022
 * @last modified by  : pelayochristian.dev@gmail.com
 **/
public with sharing class MW_OpenWeatherOneCallController {
    /**
     * @description Method used for exposing current and daily
     *              forecast of the week.
     * @author pelayochristian.dev@gmail.com | 07-08-2022
     * @param longitude
     * @param latitude
     * @param unitType
     * @return MW_OpenWeatherOneCall
     **/
    @AuraEnabled(cacheable=true)
    public static MW_OpenWeatherOneCall getWeatherForecastService(
        Decimal longitude,
        Decimal latitude,
        String unitType
    ) {
        return MW_OpenWeatherOneCallService.getWeatherForecast(
            longitude,
            latitude,
            unitType
        );
    }

    /**
     * @description Method used for exposing goe locations
     *              data to the front end by providing location/city
     *              name as a parameter.
     * @author pelayochristian.dev@gmail.com | 07-08-2022
     * @param query
     * @return List<MW_OpenWeatherGeoLocation>
     **/
    @AuraEnabled(cacheable=true)
    public static List<MW_OpenWeatherGeoLocation> getGeoLocationsService(
        String query
    ) {
        return MW_OpenWeatherOneCallService.getGeoLocations(query);
    }
}
