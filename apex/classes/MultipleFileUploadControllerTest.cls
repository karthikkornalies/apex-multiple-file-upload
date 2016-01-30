@isTest
private class MultipleFileUploadControllerTest {
    
    private static User testAdminUser = new User(Id = UserInfo.getUserId());
    
    /**
     * コンストラクタ
     */
    static testMethod void MultipleFileUploadControllerTest1() {
        
        System.runAs(testAdminUser) {

            Test.startTest();
            
            MultipleFileUploadController cls = new MultipleFileUploadController();
            
            Test.stopTest();
        }
    }
    
    /**
     * 取引先情報の登録
     */
    static testMethod void doSaveAccountTest1() {
        
        System.runAs(testAdminUser) {

            // 取引先テストデータの準備
            Account account = new Account(Name = 'sForce');
            
            // Wrapperテストデータの準備
            MultipleFileUploadWrapper wrapper = new MultipleFileUploadWrapper();
            wrapper.account = account;
            MultipleFileUploadWrapper.FileInfo fileInfo = new MultipleFileUploadWrapper.FileInfo();
            fileInfo.fileName = 'sample.xls';
            fileInfo.uploadFile = Blob.valueOf('Test File');
            wrapper.attachments.add(fileInfo);

            Test.startTest();
            
            MultipleFileUploadResult result = MultipleFileUploadController.doSaveAccount(wrapper);
            
            Test.stopTest();
            
            // 戻り値結果の確認
            System.assertEquals(String.isNotEmpty(result.recordId), true);
            System.assertEquals(result.errorMessages.isEmpty(), true);

            // 取引先作成結果の確認
            Account resultAccount = getResultAccount(result);
            System.assertEquals(String.isNotEmpty(resultAccount.Id), true);
            System.assertEquals(resultAccount.Attachments.size(), 1);
        }
    }

    /**
     * 取引先登録結果の確認
     */
    private static Account getResultAccount(MultipleFileUploadResult result) {
        return [
            SELECT
                 Id
                ,(SELECT Id FROM Attachments LIMIT 200)
            FROM
                Account
            WHERE
                Id =: result.recordId
            LIMIT 1
        ];
    }
}