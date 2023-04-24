/**
 * @description       : Test class of MW_UtilHelper.cls
 * @author            : pelayochristian.dev@gmail.com
 * @last modified on  : 07-13-2022
 * @last modified by  : pelayochristian.dev@gmail.com
 **/
@IsTest
public class MW_UtilHelper_Test {
    @IsTest
    static void getOpenWeatherAPIKeyTestPositive() {
        System.Test.startTest();
        String apiKey = MW_UtilHelper.getOpenWeatherAPIKey();
        System.Test.stopTest();
        System.assertEquals(true, apiKey != '', 'Return OW API Key');
    }

    @IsTest
    static void getOpenWeatherAPIKeyTestNegative() {
        User usr = [
            SELECT Id
            FROM User
            WHERE Name = 'Integration User'
            LIMIT 1
        ];
        System.runAs(usr) {
            System.Test.startTest();
            String apiKey = MW_UtilHelper.getOpenWeatherAPIKey();
            System.Test.stopTest();
            System.assertEquals(true, apiKey == '', 'No Return OW API Key');
        }
    }
}
