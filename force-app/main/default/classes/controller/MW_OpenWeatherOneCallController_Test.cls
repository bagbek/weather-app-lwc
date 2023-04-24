/**
 * @description       : Test class of MW_OpenWeatherOneCallController
 * @author            : pelayochristian.dev@gmail.com
 * @last modified on  : 07-13-2022
 * @last modified by  : pelayochristian.dev@gmail.com
 **/
@IsTest
public class MW_OpenWeatherOneCallController_Test {
    @IsTest
    static void getWeatherForecastServiceTest() {
        String json =
            '{' +
            '   \"lat\":10.317,' +
            '   \"lon\":123.891,' +
            '   \"timezone\":\"Asia/Manila\",' +
            '   \"timezone_offset\":28800,' +
            '   \"current\":{' +
            '      \"dt\":1657623965,' +
            '      \"sunrise\":1657574955,' +
            '      \"sunset\":1657620620,' +
            '      \"temp\":27.79,' +
            '      \"feels_like\":31.44,' +
            '      \"pressure\":1007,' +
            '      \"humidity\":79,' +
            '      \"dew_point\":23.81,' +
            '      \"uvi\":0,' +
            '      \"clouds\":100,' +
            '      \"visibility\":10000,' +
            '      \"wind_speed\":0.97,' +
            '      \"wind_deg\":245,' +
            '      \"wind_gust\":1.48,' +
            '      \"weather\":[' +
            '         {' +
            '            \"id\":804,' +
            '            \"main\":\"Clouds\",' +
            '            \"description\":\"overcast clouds\",' +
            '            \"icon\":\"04n\"' +
            '         }' +
            '      ]' +
            '   },' +
            '   \"daily\":[' +
            '      {' +
            '         \"dt\":1657594800,' +
            '         \"sunrise\":1657574955,' +
            '         \"sunset\":1657620620,' +
            '         \"moonrise\":1657615440,' +
            '         \"moonset\":1657567680,' +
            '         \"moon_phase\":0.44,' +
            '         \"temp\":{' +
            '            \"day\":29.69,' +
            '            \"min\":26.05,' +
            '            \"max\":30.14,' +
            '            \"night\":27.08,' +
            '            \"eve\":28.14,' +
            '            \"morn\":26.05' +
            '         },' +
            '         \"feels_like\":{' +
            '            \"day\":34.07,' +
            '            \"night\":30.22,' +
            '            \"eve\":32.13,' +
            '            \"morn\":26.05' +
            '         },' +
            '         \"pressure\":1009,' +
            '         \"humidity\":69,' +
            '         \"dew_point\":23.26,' +
            '         \"wind_speed\":4.2,' +
            '         \"wind_deg\":229,' +
            '         \"wind_gust\":5.93,' +
            '         \"weather\":[' +
            '            {' +
            '               \"id\":501,' +
            '               \"main\":\"Rain\",' +
            '               \"description\":\"moderate rain\",' +
            '               \"icon\":\"10d\"' +
            '            }' +
            '         ],' +
            '         \"clouds\":99,' +
            '         \"pop\":1,' +
            '         \"rain\":3.6,' +
            '         \"uvi\":12.08' +
            '      }' +
            '   ]' +
            '}';

        System.Test.startTest();
        // Set the Test Mock using MW_OpenWeatherOneCallServiceMock
        System.Test.setMock(
            HttpCalloutMock.class,
            new MockCalloutService()
                .setBody(json)
                .setStatus('Completed')
                .setStatusCode(200)
                .setHeader(
                    new Map<String, String>{
                        'Content-Type' => 'application/json'
                    }
                )
        );
        // Call the getWeatherForecast
        MW_OpenWeatherOneCall ow = MW_OpenWeatherOneCallController.getWeatherForecastService(
            123.891,
            10.317,
            'metric'
        );
        System.Test.stopTest();

        // Assert ow should not be null
        System.assertEquals(
            true,
            ow != null,
            'MW_OpenWeatherOneCall has response from mock'
        );
    }

    @IsTest
    static void getGeoLocationsServiceTest() {
        String json =
            '[' +
            '   {' +
            '      \"name\":\"Cebu\",' +
            '      \"lat\":10.34953135,' +
            '      \"lon\":123.7816926670584,' +
            '      \"country\":\"PH\"' +
            '   },' +
            '   {' +
            '      \"name\":\"Cebu\",' +
            '      \"lat\":10.333333,' +
            '      \"lon\":123.75,' +
            '      \"country\":\"PH\",' +
            '      \"state\":\"Cebu\"' +
            '   },' +
            '   {' +
            '      \"name\":\"El Cebu\",' +
            '      \"lat\":-14.4637619,' +
            '      \"lon\":-67.4506659,' +
            '      \"country\":\"BO\",' +
            '      \"state\":\"Beni\"' +
            '   }' +
            ']';
        System.Test.startTest();
        System.Test.setMock(
            HttpCalloutMock.class,
            new MockCalloutService()
                .setBody(json)
                .setStatus('Completed')
                .setStatusCode(200)
                .setHeader(
                    new Map<String, String>{
                        'Content-Type' => 'application/json'
                    }
                )
        );

        List<MW_OpenWeatherGeoLocation> locations = MW_OpenWeatherOneCallController.getGeoLocationsService(
            'Cebu'
        );
        System.Test.stopTest();
        System.assertEquals(
            true,
            locations.size() > 0,
            'Locations is not empty'
        );
    }
}
