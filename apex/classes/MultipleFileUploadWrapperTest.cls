@isTest
private class MultipleFileUploadWrapperTest {
    
    private static User testAdminUser = new User(Id = UserInfo.getUserId());
    
    /**
     * コンストラクタ
     */
    static testMethod void EntryWrapperTest() {
        
        System.runAs(testAdminUser) {

            Test.startTest();
            
            MultipleFileUploadWrapper cls = new MultipleFileUploadWrapper();
            
            Test.stopTest();

            System.assertEquals(String.isEmpty(cls.account.Id), true);
            System.assertEquals(cls.attachments.isEmpty(), true);
        }
    }
}