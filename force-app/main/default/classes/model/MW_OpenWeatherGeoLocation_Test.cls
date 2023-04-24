/**
 * @description       : Test class for the MW_OpenWeatherGeoLocation
 * @author            : pelayochristian.dev@gmail.com
 * @last modified on  : 07-08-2022
 * @last modified by  : pelayochristian.dev@gmail.com
 **/
@IsTest
public class MW_OpenWeatherGeoLocation_Test {
    static testMethod void testParse() {
        String json =
            '[' +
            '  {' +
            '    \"name\": \"Cebu City\",' +
            '    \"lat\": 10.2931062,' +
            '    \"lon\": 123.9020773,' +
            '    \"country\": \"PH\"' +
            '  }' +
            ']';
        List<MW_OpenWeatherGeoLocation> obj = MW_OpenWeatherGeoLocation.parse(
            json
        );
        System.assert(obj != null);
    }
}
