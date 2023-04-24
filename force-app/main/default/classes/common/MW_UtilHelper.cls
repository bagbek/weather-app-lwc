/**
 * @description       : Utility class for the My Weather App.
 * @author            : pelayochristian.dev@gmail.com
 * @last modified on  : 07-11-2022
 * @last modified by  : pelayochristian.dev@gmail.com
 **/
public with sharing class MW_UtilHelper {
    /**
     * @description Util method used for retrieving Open Weather
     *              API Key from custom metadata.
     * @author pelayochristian.dev@gmail.com | 07-11-2022
     * @return String
     **/
    public static String getOpenWeatherAPIKey() {
        String apiKey = '';

        try {
            My_Weather_Config__mdt openConf = [
                SELECT Label, Value__c, QualifiedApiName
                FROM My_Weather_Config__mdt
                WHERE QualifiedApiName = 'Open_Weather_API_Key'
                WITH SECURITY_ENFORCED
            ];

            if (openConf != null && openConf.Value__c != '') {
                apiKey = openConf.Value__c;
            }
        } catch (Exception ex) {
            System.debug(
                'Error : MW_OpenWeatherOneCallService.getOpenWeatherAPIKey() with message ' +
                ex.getMessage()
            );
        }
        return apiKey;
    }
}
