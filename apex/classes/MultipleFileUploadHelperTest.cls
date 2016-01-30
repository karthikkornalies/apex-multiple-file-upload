@isTest
private class MultipleFileUploadHelperTest {
    
    private static MultipleFileUploadHelper helper = new MultipleFileUploadHelper();
    private static User testAdminUser = new User(Id = UserInfo.getUserId());
    
    /**
     * 登録用の添付ファイル情報取得
     * 値なし
     */
    static testMethod void getAttachmentsTest1() {
        
        System.runAs(testAdminUser) {

            Test.startTest();

            MultipleFileUploadWrapper wrapper = new MultipleFileUploadWrapper();
            wrapper.account = new Account();

            MultipleFileUploadWrapper.FileInfo fileInfo = new MultipleFileUploadWrapper.FileInfo();
            fileInfo.fileName = 'sample.xls';
            fileInfo.uploadFile = Blob.valueOf('Test File');
            wrapper.attachments.add(fileInfo);
            
            Id parentId = null;
            List<Attachment> results = helper.getAttachments(wrapper, parentId);
            
            Test.stopTest();

            System.assertEquals(results.isEmpty(), true);
        }
    }

    /**
     * 登録用の添付ファイル情報取得
     * 値あり
     */
    static testMethod void getAttachmentsTest2() {
        
        System.runAs(testAdminUser) {

            Account account = new Account(Name = 'sForce - Tokyo');
            insert account;
            System.assertEquals(String.isNotEmpty(account.Id), true);

            Test.startTest();
            
            MultipleFileUploadWrapper wrapper = new MultipleFileUploadWrapper();
            wrapper.account = account;

            MultipleFileUploadWrapper.FileInfo fileInfo = new MultipleFileUploadWrapper.FileInfo();
            fileInfo.fileName = 'sample.xls';
            fileInfo.uploadFile = Blob.valueOf('Test File');
            wrapper.attachments.add(fileInfo);

            Id parentId = account.Id;
            List<Attachment> results = helper.getAttachments(wrapper, parentId);
            
            Test.stopTest();

            System.assertEquals(results.size(), 1);
            System.assertEquals(results[0].Name, fileInfo.fileName);
            System.assertEquals(results[0].ParentId, account.Id);
        }
    }
}