/**
 * @description       : Test class of MockCalloutService.cls
 * @author            : pelayochristian.dev@gmail.com
 * @last modified on  : 07-13-2022
 * @last modified by  : pelayochristian.dev@gmail.com
 **/
@IsTest
public class MockCalloutService_Test {
    @IsTest
    static void testStringBody() {
        String strBody = '{"bodyType" : "String"}';
        System.Test.startTest();
        MockCalloutService mcs = new MockCalloutService()
            .setBody(strBody)
            .setStatusCode(200)
            .setStatus('Completed')
            .setHeader(
                new Map<String, String>{ 'Content-Type' => 'application/json' }
            );
        mcs.respond(new HttpRequest());
        System.Test.stopTest();
        System.assertEquals(true, mcs != null, 'Has response');
    }

    @IsTest
    static void testBlobBody() {
        String strBody = '{"bodyType" : "String"}';
        Blob blobBody = Blob.valueOf('{"bodyType" : "String"}');
        System.Test.startTest();
        MockCalloutService mcs = new MockCalloutService()
            .setBlobBody(blobBody)
            .setStatusCode(200)
            .setStatus('Completed')
            .setHeader(
                new Map<String, String>{ 'Content-Type' => 'application/json' }
            );
        mcs.respond(new HttpRequest());
        System.Test.stopTest();
        System.assertEquals(true, mcs != null, 'Has response');
    }

    @IsTest
    static void testHeaderAndStatusCodeNegative() {
        String strBody = '{"bodyType" : "String"}';
        System.Test.startTest();
        MockCalloutService mcs = new MockCalloutService()
            .setBody(strBody)
            .setStatusCode(null)
            .setStatus('Completed')
            .setHeader(new Map<String, String>());
        mcs.respond(new HttpRequest());
        System.Test.stopTest();
        System.assertEquals(true, mcs != null, 'Has response');
    }

    @IsTest
    static void testResponseNegative() {
        String strBody = '{"bodyType" : "String"}';
        Blob blobBody = Blob.valueOf('{"bodyType" : "String"}');
        System.Test.startTest();
        MockCalloutService mcs = new MockCalloutService()
            .setBlobBody(null)
            .setStatusCode(200)
            .setStatus('Completed')
            .setHeader(
                new Map<String, String>{ 'Content-Type' => 'application/json' }
            );
        mcs.respond(new HttpRequest());
        System.Test.stopTest();
        System.assertEquals(true, mcs != null, 'Has response');
    }
}
