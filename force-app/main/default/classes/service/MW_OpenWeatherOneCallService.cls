/**
 * @description       : Service class for the business login of the
 *                      Open Weather API.
 * @author            : pelayochristian.dev@gmail.com
 * @last modified on  : 07-14-2022
 * @last modified by  : pelayochristian.dev@gmail.com
 **/
public with sharing class MW_OpenWeatherOneCallService {
    private static final String OW_CURRENT_WEATHER_API = 'data/2.5/onecall?exclude=hourly,minutely,alerts';
    private static final String OW_GEOLOCATION_API = 'geo/1.0/direct';
    private static final Integer OW_GEOLOCATION_LIMIT = 7;
    private static final Integer DEFAULT_LATITUDE = 13;
    private static final Integer DEFAULT_LONGITUDE = 122;
    private static final String UNIT_METRIC = 'METRIC';
    private static final String UNIT_IMPLERIAL = 'IMPLERIAL';

    /**
     * @description Service method use for retrieveing the
     *              current and daily forecast in a one single
     *              call.
     * @author pelayochristian.dev@gmail.com | 07-04-2022
     * @param longitude
     * @param latitude
     * @param unitType
     * @return MW_OpenWeather
     **/
    public static MW_OpenWeatherOneCall getWeatherForecast(
        Decimal longitude,
        Decimal latitude,
        String unitType
    ) {
        MW_OpenWeatherOneCall weatherForecast = null;
        try {
            longitude = longitude == null ? DEFAULT_LONGITUDE : longitude;
            latitude = latitude == null ? DEFAULT_LATITUDE : latitude;
            unitType = unitType == null ? UNIT_METRIC : unitType;

            String endPoint =
                'callout:Open_Weather_Service/' +
                OW_CURRENT_WEATHER_API +
                '&lat=' +
                latitude +
                '&lon=' +
                longitude +
                '&units=' +
                unitType +
                '&appId=' +
                MW_UtilHelper.getOpenWeatherAPIKey();

            Http http = new Http();
            HttpRequest httpRequest = new HttpRequest();
            httpRequest.setEndpoint(endPoint);
            httpRequest.setMethod('GET');
            HttpResponse httpResponse = http.send(httpRequest);
            if (httpResponse.getStatusCode() == 200) {
                // Replace rain 1h attribute to oneHour
                String responseBody = httpResponse.getBody()
                    .replace('1h', 'oneHour');
                weatherForecast = MW_OpenWeatherOneCall.parse(responseBody);
            }
        } catch (Exception ex) {
            System.debug(
                'Error : MW_OpenWeatherOneCallService.getWeatherForecast() with message ' +
                ex.getMessage()
            );
        }

        return weatherForecast;
    }

    /**
     * @description  Service method use for retrieving Geo
     *               location(s).
     * @author pelayochristian.dev@gmail.com | 07-08-2022
     * @param longitude
     * @param latitude
     * @param query
     * @return List<MW_OpenWeatherGeoLocation>
     **/
    public static List<MW_OpenWeatherGeoLocation> getGeoLocations(
        String query
    ) {
        List<MW_OpenWeatherGeoLocation> geoLocations = new List<MW_OpenWeatherGeoLocation>();

        try {
            String endPoint =
                'callout:Open_Weather_Service/' +
                OW_GEOLOCATION_API +
                '?q=' +
                EncodingUtil.urlEncode(query, 'UTF-8') +
                '&limit=' +
                OW_GEOLOCATION_LIMIT +
                '&appid=' +
                MW_UtilHelper.getOpenWeatherAPIKey();

            Http http = new Http();
            HttpRequest httpRequest = new HttpRequest();
            httpRequest.setEndpoint(endPoint);
            httpRequest.setMethod('GET');
            HttpResponse httpResponse = http.send(httpRequest);
            if (httpResponse.getStatusCode() == 200) {
                geoLocations = MW_OpenWeatherGeoLocation.parse(
                    httpResponse.getBody()
                );
            }
        } catch (Exception ex) {
            System.debug(
                'Error : MW_OpenWeatherOneCallService.getGeoLocations() with message ' +
                ex.getMessage()
            );
        }

        return geoLocations;
    }
}
